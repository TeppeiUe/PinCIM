require 'rails_helper'

describe '[STEP4] 所属画面' do
  let(:user) { create(:user) }

  before do
    visit 'sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '所属一覧ページ' do
    before do
      visit '/belongs'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/belongs'
      end

      it '「所属一覧」と表示される' do
        expect(page).to have_selector 'h2', text: '所属一覧'
      end

      it '検索フォームが表示さる' do
        expect(page).to have_field 'value'
      end

      it '検索ボタンが表示される' do
        expect(page).to have_button '検索'
      end

      it '所属名フォームが表示される' do
        expect(page).to have_field 'belong[name]'
      end

      it '住所フォームが表示される' do
        expect(page).to have_field 'belong[address]'
      end

      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    describe '登録内容の確認' do
      before do
        (1..5).each do |i|
          Belong.create(
            name: "hoge" + i.to_s,
            address: Faker::Lorem.characters(number: 10),
            user_id: user.id
          )
        end

        visit '/belongs'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          Belong.all.each do |belong|
            expect(page).to have_content belong.name
            expect(page).to have_content belong.address
          end
        end

        it "各編集ページへのリンクは存在するか" do
          within(:css, 'table') do
            Belong.all.each_with_index do |belong, i|
              expect(page).to have_link belong.name, href: "/belongs/#{i + 1}"
            end
          end
        end
      end

      context '検索機能の確認' do
        before do
          (1..5).each do |i|
            Belong.create(
              name: "fuga" + i.to_s,
              address: Faker::Lorem.characters(number: 10),
              user_id: user.id
            )
          end
          # "2"を含むデータを検索
          fill_in 'value', with: "2"
          click_button "検索"
        end

        it "検索結果は正しいか" do
          within(:css, "table") do
            expect(page).to have_content "hoge2"
            expect(page).to have_content Belong.find_by(name: "hoge2").address
            expect(page).to have_content "fuga2"
            expect(page).to have_content Belong.find_by(name: "fuga2").address

            Belong.all.each do |belong|
              unless belong.name.include?("2")
                expect(page).not_to have_content belong.name
                expect(page).not_to have_content belong.address
              end
            end
          end
        end
      end
    end
  end
end
