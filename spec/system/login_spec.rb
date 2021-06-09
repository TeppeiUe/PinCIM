require 'rails_helper'

describe 'ログイン画面' do
  before do
    visit '/sign_in'
  end

  let(:user) { create(:user) }

  context 'URLの確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/sign_in'
    end
  end

  context '表示内容の確認' do
    subject { page }

    it 'タイトルの「ログイン」が表示される' do
      is_expected.to have_selector 'h2', text: 'ログイン'
    end

    it 'メールアドレスフォームが表示される' do
      is_expected.to have_field 'メールアドレス'
    end

    it 'パスワードフォームが表示される' do
      is_expected.to have_field 'パスワード'
    end

    it 'ログインボタンが表示される' do
      is_expected.to have_button 'ログイン'
    end
  end

  context 'ヘッダー表示内容の確認' do
    subject { page }

    it 'トップページが表示されない' do
      is_expected.not_to have_selector 'header', text: 'トップページ'
    end

    it 'マップが表示されない' do
      is_expected.not_to have_selector 'header', text: 'マップ'
    end

    it '訪問記録が表示されない' do
      is_expected.not_to have_selector 'header', text: '訪問記録'
    end

    it 'タスクが表示されない' do
      is_expected.not_to have_selector 'header', text: 'タスク'
    end
    it '顧客が表示されない' do
      is_expected.not_to have_selector 'header', text: '顧客'
    end

    it '窓口担当者が表示されない' do
      is_expected.not_to have_selector 'header', text: '窓口担当者'
    end

    it '所属が表示されない' do
      is_expected.not_to have_selector 'header', text: '所属'
    end

    it '営業担当者が表示されない' do
      is_expected.not_to have_selector 'header', text: '営業担当者'
    end

    it '活動種別が表示されない' do
      is_expected.not_to have_selector 'header', text: '活動種別'
    end

    it 'ログアウトが表示されない' do
      is_expected.not_to have_selector 'header', text: 'ログアウト'
    end
  end

  context 'ログイン成功のテスト' do
    before do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後のリダイレクト先が、ホーム画面になっている' do
      expect(current_path).to eq '/'
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/sign_in'
    end
  end
end
