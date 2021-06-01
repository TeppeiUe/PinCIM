require 'rails_helper'

RSpec.describe 'Activityモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:other_activity) { create(:activity, user_id: user.id) }
  let(:activity) { build(:activity, user_id: user.id) }

  context 'validationのテスト' do
    subject { activity.valid? }

    it 'nameカラムが空欄でないこと' do
      activity.name = ''
      is_expected.to eq false
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      activity.name = other_activity.name
      is_expected.to eq false
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
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

      @activity_new_name = Faker::Lorem.characters(number: 10)
      @activity_new_category = "定期訪問" #FactoryBotで生成するcategoryは"プレゼン"

      activity.name = @activity_new_name
      activity.category = @activity_new_category
      activity.save
    end

    it 'nameカラムが更新できる' do
      expect(activity.name).not_to eq @activity_old_name
      expect(activity.name).to eq @activity_new_name
    end

    it 'categoryカラムが更新できる' do
      expect(activity.category).not_to eq @activity_old_category
      expect(activity.category).to eq @activity_new_category
    end
  end
end
