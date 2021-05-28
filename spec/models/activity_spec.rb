require 'rails_helper'

RSpec.describe 'Activityモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:activity) { build(:activity, user_id: user.id) }

  context 'validationのテスト' do
    it 'nameカラムが空欄でないこと' do
      activity.name = ''
      activity.valid?
      expect(activity.errors.full_messages).to include("活動種別名を入力してください")
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      duplicate_activity = activity.dup
      activity.save!
      expect(duplicate_activity).to be_invalid
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替としてそれぞれ実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { activity.save }.to change(Activity, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    before do
      activity.save
      @activity_old_name = activity.name
      @activity_old_category = activity.category
      activity.name = Faker::Lorem.characters(number: 10)
      activity.category = rand(0..3)
      activity.save
    end

    it 'nameカラムが更新できる' do
      expect(activity.name).not_to eq @activity_old_name
    end

    it 'categoryカラムが更新できる' do
      expect(activity.category).not_to eq @activity_old_category
    end
  end
end
