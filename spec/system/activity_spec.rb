require 'rails_helper'

describe '活動種別画面' do
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

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/activities'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「活動種別一覧」と表示される' do
        is_expected.to have_selector 'h2', text: '活動種別一覧'
      end

      it '検索フォームが表示さる' do
        is_expected.to have_field 'value'
      end

      it '検索ボタンが表示される' do
        is_expected.to have_button '検索'
      end

      it 'カテゴリー選択フォームが表示される' do
        is_expected.to have_select 'activity[category]'
      end

      it 'カテゴリー選択の項目内容は正しいか' do
        options = Activity.categories.keys
        is_expected.to have_select('activity_category', options: options)
      end

      it '活動種別名フォームが表示される' do
        is_expected.to have_field 'activity[name]'
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_button '新規登録'
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create_list(:activity, 5, category: rand(0..3), user: user)
        visit '/activities'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          Activity.all.each_with_index do |activity, i|
            expect(all('tbody tr')[i]).to have_content activity.category && activity.name
          end
        end

        it "各編集ページへのリンクは存在するか" do
          Activity.all.each_with_index do |activity, i|
            expect(all('tbody tr')[i]).to have_link '編集', href: "/activities/#{i + 1}/edit"
          end
        end
      end

      context '検索機能の確認' do
        subject { page }

        before do
          @sample = Activity.last
          fill_in 'value', with: @sample.name
          click_button "検索"
        end

        it "検索結果は正しいか" do
          within(:css, "tbody tr") do
            # 検索結果として存在するべき内容
            is_expected.to have_content @sample.category && @sample.name

            # 検索結果として存在しない内容
            Activity.all.each do |activity|
              unless activity.id == @sample.id
                is_expected.not_to have_content activity.category && activity.name
              end
            end
          end
        end
      end
    end
  end
end
