require 'rails_helper'

RSpec.describe 'KeyPersonモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:other_key_person) { create(:key_person, user_id: user.id) }
  let(:key_person) { build(:key_person, user_id: user.id) }

  context 'validationのテスト' do
    subject { key_person.valid? }

    it 'nameカラムが空欄でないこと' do
      key_person.name = ''
      is_expected.to eq false
    end

    it 'nameカラムへの登録内容が重複しないこと' do
      key_person.name = other_key_person.name
      is_expected.to eq false
    end
  end

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { key_person.save }.to change(KeyPerson, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    before do
      key_person.save
      @key_person_old_name = key_person.name
      @key_person_old_career = key_person.career
      @key_person_old_note = key_person.note

      @key_person_new_name = Faker::Name.name
      @key_person_new_career = Faker::Lorem.characters(number: 10)
      @key_person_new_note = Faker::Lorem.characters(number: 50)

      key_person.name = @key_person_new_name
      key_person.career = @key_person_new_career
      key_person.note = @key_person_new_note
      key_person.save
    end

    it 'nameカラムが更新できる' do
      expect(key_person.name).not_to eq @key_person_old_name
      expect(key_person.name).to eq @key_person_new_name
    end

    it 'careerカラムが更新できる' do
      expect(key_person.career).not_to eq @key_person_old_career
      expect(key_person.career).to eq @key_person_new_career
    end

    it 'noteカラムが更新できる' do
      expect(key_person.note).not_to eq @key_person_old_note
      expect(key_person.note).to eq @key_person_new_note
    end
  end
end
