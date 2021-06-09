require 'rails_helper'

describe '所属画面' do
  let(:user) { create(:user) }

  before do
    visit 'sign_in'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe '所属一覧ページ' do
    before do
      visit '/belongs'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/belongs'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「所属一覧」と表示される' do
        is_expected.to have_selector 'h2', text: '所属一覧'
      end

      it '検索フォームが表示さる' do
        is_expected.to have_field 'value'
      end

      it '検索ボタンが表示される' do
        is_expected.to have_button '検索'
      end

      it '所属名フォームが表示される' do
        is_expected.to have_field '所属名'
      end

      it '住所フォームが表示される' do
        is_expected.to have_field '住所'
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_button '新規登録'
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create_list(:belong, 5, user: user)
        visit '/belongs'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          Belong.all.each_with_index do |belong, i|
            expect(all('tbody tr')[i]).to have_content belong.name && belong.address
          end
        end

        it "各詳細ページへのリンクは存在するか" do
          Belong.all.each_with_index do |belong, i|
            expect(all('tbody tr')[i]).to have_link belong.name, href: "/belongs/#{i + 1}"
          end
        end
      end

      # render先がindexであるため、所属名の有無が確認できれば良い
      context '検索機能の確認' do
        subject { page }

        before do
          @sample = Belong.last
          fill_in 'value', with: @sample.name
          click_button "検索"
        end

        it "検索結果は正しいか" do
          within(:css, "tbody tr") do
            is_expected.to have_content @sample.name

            Belong.all.each do |belong|
              unless belong.id == @sample.id
                is_expected.not_to have_content belong.name
              end
            end
          end
        end
      end
    end
  end
end
