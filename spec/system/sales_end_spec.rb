require 'rails_helper'

describe '営業担当者画面' do
  let(:user) { create(:user) }

  before do
    FactoryBot.create_list(:belong, 3, user: user)

    visit 'sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '営業担当者一覧ページ' do
    before do
      visit '/sales_ends'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/sales_ends'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「営業担当者一覧」と表示される' do
        is_expected.to have_selector 'h2', text: '営業担当者一覧'
      end

      it '検索項目が表示される' do
        is_expected.to have_select 'how'
      end

      it '検索項目の内容が正しいか' do
        is_expected.to have_select('how', options: ['担当者名', '所属名'])
      end

      it '検索フォームが表示さる' do
        is_expected.to have_field 'value'
      end

      it '検索ボタンが表示される' do
        is_expected.to have_button '検索'
      end

      it '営業担当者名フォームが表示される' do
        is_expected.to have_field 'sales_end[name]'
      end

      it '所属選択フォームが表示される' do
        is_expected.to have_select 'sales_end[belong_id]'
      end

      it '所属選択の項目内容は正しいか' do
        options = Belong.all.pluck(:name)
        options.unshift("選択して下さい")
        is_expected.to have_select('sales_end_belong_id', options: options)
      end

      it '役職フォームが表示される' do
        is_expected.to have_field 'sales_end[post]'
      end

      it '電話番号フォームが表示される' do
        is_expected.to have_field 'sales_end[telephone_number]'
      end

      it '備考フォームが表示される' do
        is_expected.to have_field 'sales_end[note]'
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_button '新規登録'
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create_list(:sales_end, 5, belong_id: rand(1..3), user: user)
        visit '/sales_ends'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          SalesEnd.all.each_with_index do |sales_end, i|
            expect(all('tbody tr')[i]).to have_content(
              sales_end.name &&
              sales_end.post &&
              sales_end.belong.name &&
              sales_end.telephone_number
            )
          end
        end

        it "各詳細ページへのリンクは正しいか" do
          SalesEnd.all.each_with_index do |sales_end, i|
            expect(all('tbody tr')[i]).
              to have_link sales_end.name, href: "/sales_ends/#{i + 1}"
            expect(all('tbody tr')[i]).
              to have_link sales_end.belong.name, href: "/belongs/#{sales_end.belong.id}"
          end
        end
      end

      describe '検索機能の確認' do
        subject { page }

        before do
          @sample = SalesEnd.last
        end

        context '[担当者名]を選択時の検索機能の確認' do
          before do
            select '担当者名', from: 'how'
            fill_in 'value', with: @sample.name
            click_button "検索"
          end

          it "検索結果は正しいか" do
            within(:css, "tbody tr") do
              is_expected.to have_content(
                @sample.name &&
                @sample.post &&
                @sample.belong.name &&
                @sample.telephone_number
              )

              SalesEnd.all.each do |sales_end|
                unless sales_end.id == @sample.id
                  is_expected.not_to have_content(
                    sales_end.name &&
                    sales_end.post &&
                    sales_end.belong.name &&
                    sales_end.telephone_number
                  )
                end
              end
            end
          end
        end

        context '[所属名]を選択時の検索機能の確認' do
          before do
            select '所属名', from: 'how'
            fill_in 'value', with: @sample.belong.name
            click_button "検索"
          end

          it "検索結果は正しいか" do
            # tbody trの内での確認ではエラーが発生
            within(:css, "table") do
              SalesEnd.where(belong_id: @sample.belong_id).each do |sales_end|
                is_expected.to have_content(
                  sales_end.name &&
                  sales_end.post &&
                  sales_end.belong.name &&
                  sales_end.telephone_number
                )
              end

              SalesEnd.all.each do |sales_end|
                unless sales_end.belong_id == @sample.belong_id
                  is_expected.not_to have_content(
                    sales_end.name &&
                    sales_end.post &&
                    sales_end.belong.name &&
                    sales_end.telephone_number
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
