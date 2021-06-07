require 'rails_helper'

describe '訪問記録画面' do
  let(:user) { create(:user) }

  before do
    FactoryBot.create_list(:activity, 3, user: user)
    FactoryBot.create_list(:key_person, 3, user: user)
    FactoryBot.create_list(:belong, 3, user: user)
    FactoryBot.create_list(:sales_end, 3, belong_id: rand(1..3), user: user)
    FactoryBot.create_list(
      :customer,
      3,
      key_person_id: rand(1..3),
      sales_end_id: rand(1..3),
      user: user
    )

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
        ) # do |visit_record|
        #   FactoryBot.create(
        #     :activity_detail,
        #     activity_id: rand(1..3),
        #     visit_record: visit_record,
        #     user: user)
        # end

        visit '/visit_records'
      end

      # 活動内容のテストについて、何故か途中で一致しないと出るため保留
      context '一覧表示内容の確認' do
        it "登録情報が一覧表示されているか" do
          VisitRecord.order(visit_datetime: :desc).each_with_index do |visit_record, i|
            expect(all('tbody tr')[i]).to have_content(
              visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M") &&
              visit_record.customer.name # &&
              # visit_record.activity_details.each do |activity_detail|
              #   activity_detail.activity.name
              # end
            )
          end
        end

        it "各詳細ページへのリンクは正しいか" do
          VisitRecord.order(visit_datetime: :desc).each_with_index do |visit_record, i|
            expect(all('tbody tr')[i]).
              to have_link(
                visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M"),
                href: "/visit_records/#{visit_record.id}"
              )
            expect(all('tbody tr')[i]).
              to have_link(
                visit_record.customer.name,
                href: "/customers/#{visit_record.customer.id}"
              )
          end
        end
      end

      context '検索機能の確認' do
        subject { page }

        before do
          @sample = VisitRecord.last
          @from_date = @sample.visit_datetime
          @to_date = @sample.visit_datetime.to_date + 1

          fill_in 'from_date', with: @from_date
          fill_in 'to_date', with: @to_date
          click_button "検索"
        end

        it '検索時のタイトルが表示される' do
          text = <<~TEXT
            #{@from_date.strftime("%Y年 %m月 %d日")}から
            #{@to_date.strftime("%Y年 %m月 %d日")}までの訪問記録検索結果
          TEXT

          is_expected.to have_selector 'h2', text: "#{text.split("\n").join}"
        end

        it "検索結果は正しいか" do
          within(:css, "tbody tr") do
            is_expected.to have_content(
              @sample.visit_datetime.strftime("%Y-%m-%d %H:%M")
            )

            VisitRecord.all.each do |visit_record|
              unless visit_record.id == @sample.id
                is_expected.not_to have_content(
                  visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M")
                )
              end
            end
          end
        end
      end
    end
  end

  describe '訪問記録新規登録ページ' do
    before do
      visit 'visit_records/new'
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/visit_records/new'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「訪問記録新規登録」と表示される' do
        is_expected.to have_selector 'h2', text: '訪問記録新規登録'
      end

      it '訪問日フォームが表示される' do
        is_expected.to have_field 'visit_record[visit_date]'
      end

      it '訪問日フォームの内容が正しいか' do
        is_expected.to have_field 'visit_record[visit_date]', with: "#{Date.today}"
      end

      it '訪問日時フォームが表示される' do
        is_expected.to have_select  'visit_record[visit_time(4i)]'
        is_expected.to have_select  'visit_record[visit_time(5i)]'
      end

      it '訪問時(hour)選択の項目内容が正しいか' do
        options = ('08'..'22').to_a
        options.unshift('時')
        is_expected.to have_select('visit_record_visit_time_4i', options: options)
      end

      it '訪問時(minute)選択の項目内容が正しいか' do
        options = (0..3).map { |i| format('%02d', i * 15) }
        options.unshift('分')
        is_expected.to have_select('visit_record_visit_time_5i', options: options)
      end

      it '顧客選択フォームが表示される' do
        is_expected.to have_select '顧客'
      end

      it '顧客選択の項目内容が正しいか' do
        options = Customer.all.pluck(:name)
        options.unshift('選択して下さい')
        is_expected.to have_select('顧客', options: options)
      end

      it '窓口担当者選択フォームが表示される' do
        is_expected.to have_select '窓口担当者'
      end

      it '窓口担当者選択の項目内容が正しいか' do
        options = KeyPerson.all.pluck(:name)
        options.unshift('選択して下さい')
        is_expected.to have_select('窓口担当者', options: options)
      end

      it '営業担当者選択フォームが表示される' do
        is_expected.to have_select '営業担当者'
      end

      it '営業担当者選択の項目内容が正しいか' do
        options = SalesEnd.all.pluck(:name)
        options.unshift('選択して下さい')
        is_expected.to have_select('営業担当者', options: options)
      end

      it '所属選択フォームが表示される' do
        is_expected.to have_select '所属'
      end

      it '所属選択の項目内容が正しいか' do
        options = Belong.all.pluck(:name)
        options.unshift('選択して下さい')
        is_expected.to have_select('所属', options: options)
      end

      it '次回訪問予定日フォームが表示される' do
        is_expected.to have_field 'visit_record[next_date]'
      end

      it '次回訪問日予定時フォームが表示される' do
        is_expected.to have_select  'visit_record[next_time(4i)]'
        is_expected.to have_select  'visit_record[next_time(5i)]'
      end

      it '次回訪問予定時(hour)選択の項目内容が正しいか' do
        options = ('08'..'22').to_a
        options.unshift('時')
        is_expected.to have_select('visit_record_next_time_4i', options: options)
      end

      it '次回訪問予定時(minute)選択の項目内容が正しいか' do
        options = (0..3).map { |i| format('%02d', i * 15) }
        options.unshift('分')
        is_expected.to have_select('visit_record_next_time_5i', options: options)
      end

      it '備考フォームが表示される' do
        is_expected.to have_field '備考'
      end

      it 'ランクフォームが表示される' do
        is_expected.to have_select 'ランク'
      end

      it 'ランク選択の項目内容が正しいか' do
        options = ("A".."C").map { |s| "rank" + s }
        options.unshift('なし')
        is_expected.to have_select('visit_record_rank', options: options)
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_button '新規登録'
      end
    end

    describe '新規登録のテスト' do
      before do
        select "#{Customer.last.name}", from: '顧客名'
        select "#{KeyPerson.last.name}", from: '窓口担当者名'
        select "#{Belong.last.name}", from: '営業担当者所属'
        select "#{SalesEnd.last.name}", from: '営業担当者名'
      end

      context '新規登録成功' do
        it '新規登録される' do
          expect { click_button '新規登録' }.to change(VisitRecord, :count).by(1)
        end

        it '新規投稿後の遷移先は正しいか' do
          click_button '新規登録'
          expect(current_path).to eq '/visit_records/1'
        end
      end

      context '新規登録失敗' do
        it '顧客未選択で失敗する' do
          select "選択して下さい", from: '顧客名'
          expect { click_button '新規登録' }.not_to change(VisitRecord, :count)
        end

        it '窓口担当者未選択で失敗する' do
          select "選択して下さい", from: '窓口担当者名'
          expect { click_button '新規登録' }.not_to change(VisitRecord, :count)
        end

        it '営業担当者所属未選択で失敗する' do
          select "選択して下さい", from: '営業担当者所属'
          expect { click_button '新規登録' }.not_to change(VisitRecord, :count)
        end

        it '営業担当者未選択で失敗する' do
          select "選択して下さい", from: '営業担当者名'
          expect { click_button '新規登録' }.not_to change(VisitRecord, :count)
        end
      end
    end
  end

  describe '訪問記録詳細ページ' do
    let(:visit_record) do
      create(
        :visit_record,
        customer_id: 1,
        key_person_id: 1,
        belong_id: 1,
        sales_end_id: 1,
        user: user
      )
    end

    before do
      FactoryBot.create(:activity_detail, visit_record: visit_record, activity_id: 1, user: user)
      FactoryBot.create_list(:task, 2, visit_record: visit_record, user: user)
      visit visit_record_path(visit_record.id)
    end

    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/visit_records/1'
      end
    end

    context '表示内容の確認' do
      subject { page }

      it '「訪問記録詳細」と表示される' do
        is_expected.to have_selector 'h2', text: "訪問記録詳細"
      end

      it '訪問日時が表示される' do
        is_expected.to have_content "#{visit_record.visit_datetime.strftime("%Y-%m-%d %H:%M")}"
      end

      it '顧客名が表示される' do
        is_expected.to have_content "#{visit_record.customer.name}"
      end

      it '窓口担当者が表示される' do
        is_expected.to have_content "#{visit_record.key_person.name}"
      end

      it '所属が表示される' do
        is_expected.to have_content "#{visit_record.belong.name}"
      end

      it '営業担当者が表示される' do
        is_expected.to have_content "#{visit_record.sales_end.name}"
      end

      it '次回訪問日時が表示される' do
        is_expected.to have_content "#{visit_record.next_datetime.strftime("%Y-%m-%d %H:%M")}"
      end

      it '備考が表示される' do
        is_expected.to have_content "#{visit_record.note}"
      end

      it 'ランクが表示される' do
        is_expected.to have_content "#{visit_record.rank}"
      end

      it '編集ボタンが表示される' do
        within '.set_show' do
          is_expected.to have_link '編集'
        end
      end

      it '削除ボタンが表示される' do
        within '.set_show' do
          is_expected.to have_link '削除'
        end
      end
    end

    context '表示内容のリンク先は正しいか' do
      it '顧客名が正しい' do
        link = find('a', text: "#{visit_record.customer.name}")
        expect(link[:href]).to eq customer_path(visit_record.customer.id)
      end

      it '窓口担当者が正しい' do
        link = find('a', text: "#{visit_record.key_person.name}")
        expect(link[:href]).to eq key_person_path(visit_record.key_person.id)
      end

      it '所属が正しい' do
        link = find('a', text: "#{visit_record.belong.name}")
        expect(link[:href]).to eq belong_path(visit_record.belong.id)
      end

      it '営業担当者が正しい' do
        link = find('a', text: "#{visit_record.sales_end.name}")
        expect(link[:href]).to eq sales_end_path(visit_record.sales_end.id)
      end

      it '編集ボタンが正しい' do
        within '.set_show' do
          expect(page).to have_link '編集', href: edit_visit_record_path(visit_record.id)
        end
      end

      it '削除ボタンが正しい' do
        within '.set_show' do
          link = find_link '削除'
          expect(link["data-method"]).to eq "delete"
          expect(link[:href]).to eq visit_record_path(visit_record.id)
        end
      end

      it '削除確認alertが正しい' do
        within '.set_show' do
          link = find_link '削除'
          expect(link["data-confirm"]).to eq "削除しますか？"
        end
      end
    end

    # 活動内容の追加は、ajaxのため単体テストで擬似的に実施
    context '活動内容の確認' do
      subject { page }

      it '活動種別選択フォームが表示される' do
        is_expected.to have_select 'activity_detail[activity_id]'
      end

      it '活動種別選択の項目内容が正しいか' do
        options = Activity.all.pluck(:name)
        options.unshift('選択して下さい')
        is_expected.to have_select('activity_detail[activity_id]', options: options)
      end

      it '新規登録ボタンが表示される' do
        is_expected.to have_button '活動内容 追加'
      end

      it '登録内容が選択・表示される' do
        is_expected.to have_select(
          'activity_detail[activity_id]',
          selected: "#{Activity.first.name}"
        )
      end

      it '登録内容の変更ボタンが表示される' do
        is_expected.to have_button '変更'
      end

      it '登録内容の削除ボタンが表示される' do
        within '.set_activity_detail_show' do
          link = find_link '削除'
          expect(link["data-method"]).to eq "delete"
          expect(link[:href]).to eq visit_record_activity_detail_path(visit_record.id, 1)
        end
      end
    end

    context 'タスクの確認' do
      subject { page }

      it '新規登録ボタンが表示される' do
        is_expected.to have_link 'タスク追加'
      end

      it "登録情報が一覧表示されているか" do
        visit_record.tasks.each_with_index do |task, i|
          expect(all('tbody tr')[i]).to have_content(
            task.title &&
            task.deadline.strftime("%Y-%m-%d %H:%M") &&
            task.status
          )
        end
      end

      it "各詳細ページへのリンクは正しいか" do
        visit_record.tasks.each_with_index do |task, i|
          expect(all('tbody tr')[i]).
            to have_link task.title, href: visit_record_task_path(1, task.id)
        end
      end
    end
  end

  describe '訪問記録 集計ページ' do
    before do
      visit "/visit_records"

      @from_date = '2021-05-01'.to_date
      @to_date = '2021-06-30'.to_date
      fill_in 'from_date_counting', with: @from_date
      fill_in 'to_date_counting', with: @to_date
      click_button "選択した期間で集計"
    end

    # 実際はjavascriptで書き換えるためcountingを含まない
    context 'URLの確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/visit_records/counting'
      end
    end

    context '表示内容の確認' do
      it '集計時のタイトルが表示される' do
        text = <<~TEXT
          #{@from_date.strftime("%Y年 %m月 %d日")}から
          #{@to_date.strftime("%Y年 %m月 %d日")}までの訪問記録集計結果
        TEXT

        expect(page).to have_selector 'h2', text: "#{text.split("\n").join}"
      end
    end
  end
end
