require 'rails_helper'

RSpec.describe 'ActivityDetailモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, user: user) }
  let(:other_activity) { create(:activity, user: user) }
  let(:belong) { create(:belong, user: user) }
  let(:sales_end) { create(:sales_end, belong: belong, user: user) }
  let(:key_person) { create(:key_person, user: user) }
  let(:customer) { create(:customer, key_person: key_person, sales_end: sales_end, user: user) }
  let(:visit_record) do
    create(
      :visit_record,
      customer: customer,
      key_person: key_person,
      belong: belong,
      sales_end: sales_end,
      user: user
    )
  end

  let!(:other_activity_detail) do
    create(
      :activity_detail,
      activity: other_activity,
      visit_record: visit_record,
      user: user
    )
  end

  let(:activity_detail) do
    build(
      :activity_detail,
      activity: activity,
      visit_record: visit_record,
      user: user
    )
  end

  context 'validationのテスト' do
    subject { activity_detail.valid? }

    it '同一訪問日で活動種別が重複しないこと' do
      activity_detail.activity_id = other_activity_detail.activity_id
      is_expected.to eq false
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { activity_detail.save }.to change(ActivityDetail, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    subject { other_activity_detail.activity_id }

    before do
      @activity_detail_old_activity = other_activity_detail.activity_id # other_activityを選択中

      @activity_detail_new_activity = activity.id

      other_activity_detail.activity_id = @activity_detail_new_activity
      other_activity_detail.save
    end

    it 'activityカラムが更新できる' do
      is_expected.not_to eq @activity_detail_old_activity
      is_expected.to eq @activity_detail_new_activity
    end
  end
end
