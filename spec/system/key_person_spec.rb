require 'rails_helper'

describe '窓口担当者画面' do
  let(:user) { create(:user) }

  before do
    visit 'sign_in'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '窓口担当者一覧ページ' do
    before do
      visit '/key_people'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/key_people'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「窓口担当者一覧」と表示される' do
        is_expected.to have_selector 'h2', text: '窓口担当者一覧'
      end

      it '検索フォームが表示さる' do
        is_expected.to have_field 'value'
      end

      it '検索ボタンが表示される' do
        is_expected.to have_button '検索'
      end

      it '窓口担当者名フォームが表示される' do
        is_expected.to have_field '窓口担当者名'
      end

      it '役職フォームが表示される' do
        is_expected.to have_field '役職'
      end

      it 'メールアドレスフォームが表示される' do
        is_expected.to have_field 'メールアドレス'
      end

      it '性別フォームが表示される' do
        is_expected.to have_checked_field 'key_person_sex_男性'
        is_expected.not_to have_checked_field 'key_person_sex_女性'
      end

      it '備考フォームが表示される' do
        is_expected.to have_field '備考'
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_button '新規登録'
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create(:belong, user: user)
        FactoryBot.create(:sales_end, belong_id: 1, user: user)

        FactoryBot.create_list(:key_person, 5, user: user) do |key_person|
          FactoryBot.create(:customer, key_person: key_person, sales_end_id: 1, user: user)
        end
        visit '/key_people'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          KeyPerson.all.each_with_index do |key_person, i|
            expect(all('tbody tr')[i]).to have_content(
              key_person.name &&
              key_person.customer.name
            )
          end
        end

        it "各詳細ページへのリンクは正しいか" do
          KeyPerson.all.each_with_index do |key_person, i|
            expect(all('tbody tr')[i]).
              to have_link key_person.name, href: "/key_people/#{i + 1}"
            expect(all('tbody tr')[i]).
              to have_link key_person.customer.name, href: "/customers/#{key_person.customer.id}"
          end
        end
      end

      # render先がindexであるため、窓口担当者名の有無が確認できれば良い
      context '検索機能の確認' do
        subject { page }

        before do
          @sample = KeyPerson.last
          fill_in 'value', with: @sample.name
          click_button "検索"
        end

        it "検索結果は正しいか" do
          within(:css, "tbody tr") do
            is_expected.to have_content @sample.name

            KeyPerson.all.each do |key_person|
              unless key_person.id == @sample.id
                is_expected.not_to have_content key_person.name
              end
            end
          end
        end
      end
    end
  end
end
