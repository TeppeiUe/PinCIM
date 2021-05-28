require 'rails_helper'

describe '[STEP2] ログイン後のヘッダー' do
  let(:user) { create(:user) }

  before do
    visit '/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  context '表示内容の確認' do
    it 'トップページが存在' do
      expect(page).to have_selector 'header', text: 'トップページ'
    end
    it 'マップが存在' do
      expect(page).to have_selector 'header', text: 'マップ'
    end
    it '訪問記録が存在' do
      expect(page).to have_selector 'header', text: '訪問記録'
    end
    it 'タスクが存在' do
      expect(page).to have_selector 'header', text: 'タスク'
    end
    it '顧客が存在' do
      expect(page).to have_selector 'header', text: '顧客'
    end
    it '窓口担当者が存在' do
      expect(page).to have_selector 'header', text: '窓口担当者'
    end
    it '所属が存在' do
      expect(page).to have_selector 'header', text: '所属'
    end
    it '営業担当者が存在' do
      expect(page).to have_selector 'header', text: '営業担当者'
    end
    it '活動種別が存在' do
      expect(page).to have_selector 'header', text: '活動種別'
    end
    it 'ログアウトが存在' do
      expect(page).to have_selector 'header', text: 'ログアウト'
    end
  end

  context 'リンクの内容を確認' do
    it 'トップページを押すとトップ画面に遷移する' do
      within(:css, 'header') do
        click_on 'トップページ'
        expect(current_path).to eq '/'
      end
    end
    it 'マップを押すと顧客一覧マップ画面に遷移する' do
      within(:css, 'header') do
        click_on 'マップ'
        expect(current_path).to eq '/map'
      end
    end
    it '訪問記録を押すと訪問記録一覧画面に遷移する' do
      within(:css, 'header') do
        click_on '訪問記録'
        expect(current_path).to eq '/visit_records'
      end
    end
    it 'タスクを押すとタスク一覧画面に遷移する' do
      within(:css, 'header') do
        click_on 'タスク'
        expect(current_path).to eq '/tasks'
      end
    end
    it '顧客を押すと顧客一覧画面に遷移する' do
      within(:css, 'header') do
        click_on '顧客'
        expect(current_path).to eq '/customers'
      end
    end
    it '窓口担当者を押すと窓口担当者一覧画面に遷移する' do
      within(:css, 'header') do
        click_on '窓口担当者'
        expect(current_path).to eq '/key_people'
      end
    end
    it '所属を押すと所属一覧画面に遷移する' do
      within(:css, 'header') do
        click_on '所属'
        expect(current_path).to eq '/belongs'
      end
    end
    it '営業担当者を押すと営業担当者一覧画面に遷移する' do
      within(:css, 'header') do
        click_on '営業担当者'
        expect(current_path).to eq '/sales_ends'
      end
    end
    it '活動種別を押すと活動種別一覧画面に遷移する' do
      within(:css, 'header') do
        click_on '活動種別'
        expect(current_path).to eq '/activities'
      end
    end
    it 'ログアウトを押すとログイン画面に遷移する' do
      within(:css, 'header') do
        click_on 'ログアウト'
        expect(current_path).to eq '/sign_in'
      end
    end
  end
end
