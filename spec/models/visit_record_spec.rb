require 'rails_helper'

RSpec.describe 'VisitRecordモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:belong) { create(:belong, user: user) }
  let(:sales_end) { create(:sales_end, belong: belong, user: user) }
  let(:key_person) { create(:key_person, user: user) }
  let(:customer) { create(:customer, key_person: key_person, sales_end: sales_end, user: user) }
  let(:visit_record) do
    build(
      :visit_record,
      customer: customer,
      key_person: key_person,
      belong: belong,
      sales_end: sales_end,
      user: user
    )
  end

  context 'validationのテスト' do
    subject { visit_record.valid? }

    it '訪問日カラムが空欄でないこと' do
      visit_record.visit_datetime = ''
      is_expected.to eq false
    end
  end
end
