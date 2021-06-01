require 'rails_helper'

RSpec.describe 'SalesEndモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:belong) { create(:belong, user_id: user.id) }
  let(:other_belong) { create(:belong, user_id: user.id) }
  let!(:other_sales_end) { create(:sales_end, belong_id: belong.id, user_id: user.id) }
  let(:sales_end) { build(:sales_end, belong_id: belong.id, user_id: user.id) }

  context 'validationのテスト' do
    subject { sales_end.valid? }

    it 'nameカラムが空欄でないこと' do
      sales_end.name = ''
      is_expected.to eq false
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      sales_end.name = other_sales_end.name
      is_expected.to eq false
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { sales_end.save }.to change(SalesEnd, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    before do
      sales_end.save
      @sales_end_old_name = sales_end.name
      @sales_end_old_post = sales_end.post
      @sales_end_old_telephone_number = sales_end.telephone_number
      @sales_end_old_note = sales_end.note
      @sales_end_old_belong = sales_end.belong_id

      @sales_end_new_name = Faker::Name.name
      @sales_end_new_post = Faker::Lorem.characters(number:10)
      @sales_end_new_telephone_number = Faker::PhoneNumber.cell_phone
      @sales_end_new_note = Faker::Lorem.characters(number:50)
      @sales_end_new_belong = other_belong.id

      sales_end.name = @sales_end_new_name
      sales_end.post = @sales_end_new_post
      sales_end.telephone_number = @sales_end_new_telephone_number
      sales_end.note = @sales_end_new_note
      sales_end.belong_id = @sales_end_new_belong
      sales_end.save
    end

    it 'nameカラムが更新できる' do
      expect(sales_end.name).not_to eq @sales_end_old_name
      expect(sales_end.name).to eq @sales_end_new_name
    end

    it 'postカラムが更新できる' do
      expect(sales_end.post).not_to eq @sales_end_old_post
      expect(sales_end.post).to eq @sales_end_new_post
    end

    it 'telephone_numberカラムが更新できる' do
      expect(sales_end.telephone_number).not_to eq @sales_end_old_telephone_number
      expect(sales_end.telephone_number).to eq @sales_end_new_telephone_number
    end

    it 'noteカラムが更新できる' do
      expect(sales_end.note).not_to eq @sales_end_old_note
      expect(sales_end.note).to eq @sales_end_new_note
    end

    it 'belongカラムが更新できる' do
      expect(sales_end.belong_id).not_to eq @sales_end_old_belong
      expect(sales_end.belong_id).to eq @sales_end_new_belong
    end
  end
end
