require 'rails_helper'

RSpec.describe 'Taskモデルのテスト', type: :model do
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
  let(:task) { build(:task, visit_record: visit_record, user: user) }

  # 現aws環境ajax処理を含んだテストが出来ないため、以下を代替として実施
  context '新規登録のテスト' do
    it '新規登録できること' do
      expect { task.save }.to change(Task, :count).by(1)
    end
  end

  context '変更更新のテスト' do
    before do
      task.save
      @task_old_title = task.title
      @task_old_content = task.content
      @task_old_deadline = task.deadline

      @task_new_title = Faker::Lorem.characters(number: 10)
      @task_new_content = Faker::Lorem.characters(number: 50)
      # ↓更新前と一致しない選択をするため
      @task_new_deadline = Faker::Date.in_date_period(year: 2021, month: 8)

      task.title = @task_new_title
      task.content = @task_new_content
      task.deadline = @task_new_deadline
      task.is_active = false
      task.save
    end

    it 'titleカラムが更新できる' do
      expect(task.title).not_to eq @task_old_title
      expect(task.title).to eq @task_new_title
    end

    it 'contentカラムが更新できる' do
      expect(task.content).not_to eq @task_old_content
      expect(task.content).to eq @task_new_content
    end

    it 'deadlineカラムが更新できる' do
      expect(task.deadline).not_to eq @task_old_deadline
      expect(task.deadline).to eq "#{@task_new_deadline} 00:00:00 JST +09:00"
    end

    it 'is_activeカラムが更新できる' do
      expect(task.is_active).to eq false
    end
  end
end
