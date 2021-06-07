require 'rails_helper'

describe 'タスク画面' do
  let(:user) { create(:user) }
  let(:belong) { create(:belong, user: user) }
  let(:sales_end) { create(:sales_end, belong: belong, user: user) }
  let(:key_person) { create(:key_person, user: user) }
  let(:customer) { create(:customer, key_person: key_person, sales_end: sales_end, user: user) }
  let(:visit_record) do
    create(
      :visit_record,
      customer: customer,
      key_person: key_person,
      belong: belong,
      sales_end: sales_end,
      user: user
    )
  end
  let(:task) { create(:task, visit_record: visit_record, user: user) }

  before do
    visit 'sign_in'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe 'タスク一覧ページ' do
    before do
      visit '/tasks'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/tasks'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「タスク一覧」と表示される' do
        is_expected.to have_selector 'h2', text: 'タスク一覧'
      end
    end

    describe '登録内容の確認' do
      before do
        FactoryBot.create_list(:task, 5, visit_record: visit_record, user: user)

        visit '/tasks'
      end

      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          Task.order(deadline: :desc).each_with_index do |task, i|
            expect(all('tbody tr')[i]).to have_content(
              task.title &&
              task.content &&
              task.deadline &&
              task.status &&
              task.visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M")
            )
          end
        end

        it "各詳細ページへのリンクは正しいか" do
          Task.order(deadline: :desc).each_with_index do |task, i|
            expect(all('tbody tr')[i]).
              to have_link task.title, href: visit_record_task_path(1, task.id)
            expect(all('tbody tr')[i]).
              to have_link task.visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M"),
                           href: "/visit_records/1"
          end
        end
      end
    end
  end
end
