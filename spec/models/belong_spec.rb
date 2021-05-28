require 'rails_helper'

RSpec.describe 'Belongモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:belong) { build(:belong, user_id: user.id) }

  context 'validationのテスト' do
    it 'nameカラムが空欄でないこと' do
      belong.name = ''
      belong.valid?
      expect(belong.errors.full_messages).to include("所属名を入力してください")
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      duplicate_belong = belong.dup
      belong.save!
      expect(duplicate_belong).to be_invalid
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替としてそれぞれ実施
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
      belong.name = Faker::Lorem.characters(number: 10)
      belong.address = rand(0..3)
      belong.save
    end

    it 'nameカラムが更新できる' do
      expect(belong.name).not_to eq @belong_old_name
    end

    it 'addressカラムが更新できる' do
      expect(belong.address).not_to eq @belong_old_address
    end
  end
end
