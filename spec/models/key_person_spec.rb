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
      @key_person_old_post = key_person.post
      @key_person_old_email = key_person.email
      @key_person_old_note = key_person.note

      @key_person_new_name = Faker::Name.name
      @key_person_new_post = Faker::Lorem.characters(number: 10)
      @key_person_new_email = Faker::Internet.email
      @key_person_new_note = Faker::Lorem.characters(number: 50)

      key_person.name = @key_person_new_name
      key_person.post = @key_person_new_post
      key_person.email = @key_person_new_email
      key_person.sex = "男性" # factorybotでは"女性"を選択中
      key_person.note = @key_person_new_note
      key_person.save
    end

    it 'nameカラムが更新できる' do
      expect(key_person.name).not_to eq @key_person_old_name
      expect(key_person.name).to eq @key_person_new_name
    end

    it 'postカラムが更新できる' do
      expect(key_person.post).not_to eq @key_person_old_post
      expect(key_person.post).to eq @key_person_new_post
    end

    it 'emailカラムが更新できる' do
      expect(key_person.email).not_to eq @key_person_old_email
      expect(key_person.email).to eq @key_person_new_email
    end

    it 'sexカラムが更新できる' do
      expect(key_person.sex).not_to eq "女性"
      expect(key_person.sex).to eq "男性"
    end

    it 'noteカラムが更新できる' do
      expect(key_person.note).not_to eq @key_person_old_note
      expect(key_person.note).to eq @key_person_new_note
    end
  end
end
