require 'rails_helper'

describe '訪問記録画面' do
  let(:user) { create(:user) }

  before do
    FactoryBot.create_list(:key_person, 3, user: user)
    FactoryBot.create_list(:belong, 3, user: user)
    FactoryBot.create_list(:sales_end, 3, belong_id: rand(1..3), user: user)
    FactoryBot.create_list(:customer, 3, key_person_id: rand(1..3), sales_end_id: rand(1..3), user: user)

    visit 'sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '訪問記録一覧ページ' do
    before do
      visit '/visit_records'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/visit_records'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「訪問記録一覧」と表示される' do
        is_expected.to have_selector 'h2', text: '訪問記録一覧'
      end

      it '[検索]期間の開始日フォームが表示さる' do
        is_expected.to have_field 'from_date'
      end

      it '[検索]期間の最終日フォームが表示さる' do
        is_expected.to have_field 'to_date'
      end

      it '[検索]検索ボタンが表示される' do
        is_expected.to have_button '検索'
      end

      it '[集計]期間の開始日フォームが表示さる' do
        is_expected.to have_field 'from_date_counting'
      end

      it '[集計]期間の最終日フォームが表示さる' do
        is_expected.to have_field 'to_date_counting'
      end

      it '[集計]検索ボタンが表示される' do
        is_expected.to have_button '選択した期間で集計'
      end
      it '新規登録ボタンが表示される' do
        is_expected.to have_link '新規登録', href: "/visit_records/new"
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create_list(
          :visit_record,
          5,
          customer_id: rand(1..3),
          key_person_id: rand(1..3),
          belong_id: rand(1..3),
          sales_end_id: rand(1..3),
          user: user
        )
        visit '/visit_records'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          VisitRecord.order(visit_datetime: :desc).each_with_index do |visit_record, i|
            expect(all('tbody tr')[i]).to have_content(
              visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M") &&
              visit_record.customer.name
            )
          end
        end

        it "各詳細ページへのリンクは正しいか" do
          VisitRecord.order(visit_datetime: :desc).each_with_index do |visit_record, i|
            expect(all('tbody tr')[i]).
              to have_link visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M"), href: "/visit_records/#{visit_record.id}"
            expect(all('tbody tr')[i]).
              to have_link visit_record.customer.name, href: "/customers/#{visit_record.customer.id}"
          end
        end
      end
    end
  end
end
