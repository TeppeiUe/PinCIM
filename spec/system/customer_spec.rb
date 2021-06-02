require 'rails_helper'

describe '顧客画面' do
  let(:user) { create(:user) }

  before do
    FactoryBot.create_list(:key_person, 3, user: user)
    FactoryBot.create_list(:belong, 3, user: user)
    FactoryBot.create_list(:sales_end, 3, belong_id: rand(1..3), user: user)

    visit 'sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '顧客一覧ページ' do
    before do
      visit '/customers'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「顧客一覧」と表示される' do
        is_expected.to have_selector 'h2', text: '顧客一覧'
      end

      it '検索項目が表示される' do
        is_expected.to have_select 'how'
      end

      it '検索項目の内容が正しいか' do
        is_expected.to have_select('how', options: ['顧客名', '住所'])
      end

      it '検索フォームが表示さる' do
        is_expected.to have_field 'value'
      end

      it '検索ボタンが表示される' do
        is_expected.to have_button '検索'
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_link '新規登録', href: "/customers/new"
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create_list(
          :customer,
          5,
          key_person_id: rand(1..3),
          sales_end_id: rand(1..3),
          user: user
        )
        visit '/customers'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          Customer.all.each_with_index do |customer, i|
            expect(all('tbody tr')[i]).to have_content(
              customer.name &&
              # customer.address &&
              customer.key_person.name &&
              customer.sales_end.belong.name &&
              customer.sales_end.name
            )
          end
        end

        it "各詳細ページへのリンクは正しいか" do
          Customer.all.each_with_index do |customer, i|
            expect(all('tbody tr')[i]).
              to have_link customer.name, href: "/customers/#{i + 1}"
            expect(all('tbody tr')[i]).
              to have_link customer.key_person.name, href: "/key_people/#{customer.key_person.id}"
            expect(all('tbody tr')[i]).
              to have_link customer.sales_end.belong.name, href: "/belongs/#{customer.sales_end.belong.id}"
            expect(all('tbody tr')[i]).
              to have_link customer.sales_end.name, href: "/sales_ends/#{customer.sales_end.id}"
          end
        end
      end

      describe '検索機能の確認' do
        subject { page }

        before do
          @sample = Customer.last
        end

        context '[顧客名]を選択時の検索機能の確認' do
          before do
            select '顧客名', from: 'how'
            fill_in 'value', with: @sample.name
            click_button "検索"
          end

          # indexにrenderしているため(一覧表示内容でテスト済)、
          # 検索対象のcustomer.nameがあればOK
          it "検索結果は正しいか" do
            within(:css, "tbody tr") do
              is_expected.to have_content @sample.name

              Customer.all.each do |customer|
                unless customer.id == @sample.id
                  is_expected.not_to have_content customer.name
                end
              end
            end
          end
        end

        # Google api使用節約のため
        # context '[住所]を選択時の検索機能の確認' do
        #   before do
        #     select '住所', from: 'how'
        #     fill_in 'value', with: @sample.address
        #     click_button "検索"
        #   end

        #   it "検索結果は正しいか" do
        #     within(:css, "table") do
        #       Customer.where("address LIKE ?", "%#{@sample.address}%").each do |customer|
        #         is_expected.to have_content customer.name
        #       end

        #       Customer.all.each do |customer|
        #         unless customer.id == @sample.id
        #           is_expected.not_to have_content customer.name
        #         end
        #       end
        #     end
        #   end
        # end
      end
    end
  end
end
