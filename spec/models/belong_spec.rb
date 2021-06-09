require 'rails_helper'

RSpec.describe 'Belongモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:other_belong) { create(:belong, user_id: user.id) }
  let(:belong) { build(:belong, user_id: user.id) }

  context 'validationのテスト' do
    subject { belong.valid? }

    it 'nameカラムが空欄でないこと' do
      belong.name = ''
      is_expected.to eq false
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      belong.name = other_belong.name
      is_expected.to eq false
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { belong.save }.to change(Belong, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    before do
      belong.save
      @belong_old_name = belong.name
      @belong_old_address = belong.address

      @belong_new_name = Faker::Lorem.characters(number: 10)
      @belong_new_address = Faker::Address.full_address

      belong.name = @belong_new_name
      belong.address = @belong_new_address
      belong.save
    end

    it 'nameカラムが更新できる' do
      expect(belong.name).not_to eq @belong_old_name
      expect(belong.name).to eq @belong_new_name
    end

    it 'addressカラムが更新できる' do
      expect(belong.address).not_to eq @belong_old_address
      expect(belong.address).to eq @belong_new_address
    end
  end
end
