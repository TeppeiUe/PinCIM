require 'rails_helper'

describe '[STEP3] 活動種別画面' do
  let(:user) { create(:user) }

  before do
    visit 'sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '活動種別一覧ページ' do
    before do
      visit '/activities'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/activities'
      end

      it '「活動種別一覧」と表示される' do
        expect(page).to have_selector 'h2', text: '活動種別一覧'
      end

      it '検索フォームが表示さる' do
        expect(page).to have_field 'value'
      end

      it '検索ボタンが表示される' do
        expect(page).to have_button '検索'
      end

      it 'カテゴリーフォームが表示される' do
        expect(page).to have_field 'activity[category]'
      end

      it '活動種別名フォームが表示される' do
        expect(page).to have_field 'activity[name]'
      end

      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    describe '登録内容の確認' do
      before do
        (1..5).each do |i|
          Activity.create(
            category: rand(0..3),
            name: "hoge" + i.to_s,
            user_id: user.id
          )
        end

        visit '/activities'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          Activity.all.each do |activity|
            expect(page).to have_content activity.category
            expect(page).to have_content activity.name
          end
        end

        it "各編集ページへのリンクは存在するか" do
          within(:css, 'table') do
            Activity.all.each_with_index do |activity, i|
              expect(page).to have_link '編集', href: "/activities/#{i + 1}/edit"
            end
          end
        end
      end

      context '検索機能の確認' do
        before do
          (1..5).each do |i|
            Activity.create(
              category: rand(0..3),
              name: "fuga" + i.to_s,
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
            expect(page).to have_content "fuga2"

            Activity.all.each do |activity|
              unless activity.name.include?("2")
                expect(page).not_to have_content activity.name
              end
            end
          end
        end
      end
    end
  end
end
