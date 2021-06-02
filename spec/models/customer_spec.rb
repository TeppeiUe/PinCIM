require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:belong) { create(:belong, user_id: user.id) }
  let(:sales_end) { create(:sales_end, belong_id: belong.id, user_id: user.id) }
  let(:key_person) { create(:key_person, user_id: user.id) }
  let!(:other_customer) do
    create(:customer, key_person_id: key_person.id, sales_end_id: sales_end.id, user_id: user.id)
  end
  let(:customer) do
    build(:customer, key_person_id: key_person.id, sales_end_id: sales_end.id, user_id: user.id)
  end

  context 'validationのテスト' do
    subject { customer.valid? }

    it 'nameカラムが空欄でないこと' do
      customer.name = ''
      is_expected.to eq false
    end

    it 'key_personカラムが空欄でないこと' do
      customer.key_person_id = ''
      is_expected.to eq false
    end

    it 'sales_endカラムが空欄でないこと' do
      customer.sales_end_id = ''
      is_expected.to eq false
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      customer.name = other_customer.name
      is_expected.to eq false
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { customer.save }.to change(Customer, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    before do
      customer.save
      @customer_old_name = customer.name
      @customer_old_key_person = customer.key_person_id
      @customer_old_sales_end = customer.sales_end
      @customer_old_note = customer.note
      @customer_old_system = customer.system

      @customer_new_name = Faker::Name.name
      @customer_new_key_person = 2
      @customer_new_sales_end = 2
      @customer_new_note = Faker::Lorem.characters(number: 50)
      @customer_new_system = Faker::Lorem.characters(number: 10)

      customer.name = @customer_new_name
      customer.key_person_id = @customer_new_key_person
      customer.sales_end_id = @customer_new_sales_end
      customer.note = @customer_new_note
      customer.system = @customer_new_system
      customer.save
    end

    it 'nameカラムが更新できる' do
      expect(customer.name).not_to eq @customer_old_name
      expect(customer.name).to eq @customer_new_name
    end

    it 'key_personカラムが更新できる' do
      expect(customer.key_person_id).not_to eq @customer_old_key_person
      expect(customer.key_person_id).to eq @customer_new_key_person
    end

    it 'sales_endカラムが更新できる' do
      expect(customer.sales_end_id).not_to eq @customer_old_sales_end
      expect(customer.sales_end_id).to eq @customer_new_sales_end
    end

    it 'noteカラムが更新できる' do
      expect(customer.note).not_to eq @customer_old_note
      expect(customer.note).to eq @customer_new_note
    end

    it 'systemカラムが更新できる' do
      expect(customer.system).not_to eq @customer_old_system
      expect(customer.system).to eq @customer_new_system
    end
  end
end
