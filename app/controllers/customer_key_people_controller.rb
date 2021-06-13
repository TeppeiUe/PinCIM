class CustomerKeyPeopleController < ApplicationController
  before_action :set_customer_key_person, only: [:edit, :update, :destroy]

  def new
    @customer = Customer.find(params[:customer_id])
    @customer_key_person = CustomerKeyPerson.new
    @key_people = current_user.key_people
    @men_checked = true # ラジオボタンの初期選択は男性
  end

  def create
    @customer_key_person = current_user.customer_key_people.new(params_customer_key_person)
    errors_message = [] # エラーメッセージ用配列
    @key_person_select = params[:customer_key_person][:key_person_select] # 窓口担当者新規登録or選択のフラグ

    @customer_key_person.transaction do
      # 窓口担当者新規登録
      if @key_person_select == "key_person_new"
        key_person = current_user.key_people.new(params_key_person_new)

        unless key_person.save
          @key_person_name = key_person.name
          @key_person_post = key_person.post
          @key_person_email = key_person.email
          @key_person_note = key_person.note
          key_person.sex == "男性" ? @men_checked = true : @female_checked = true
          errors_message << key_person.errors.full_messages
        end

        @customer_key_person.key_person_id = key_person.id
      end

      @customer_key_person.save!
    end
    render "create"

	  rescue => e
	    # トランザクション処理で評価されない場合があるため(エラーメッセージ用)
	    @customer_key_person.save

	    errors_message << if @key_person_select == "key_person_new"
	                        @customer_key_person.errors.full_messages_for(:end_period)
	                      else
	                        @customer_key_person.errors.full_messages
	    end

	    flash.now[:alert] = errors_message.join('<br/>').html_safe
	    @men_checked = true if @key_person_select == "key_person_selection"

	    @customer = @customer_key_person.customer
	    @key_people = current_user.key_people
	    render "new"
  end

  def edit
  end

  def update
    # date_selectオブジェクトの返す値が細切れであり、扱いやすい形式に変換するため定義
    dammy = CustomerKeyPerson.new(params_customer_key_person)

    if dammy.end_period.nil?
      @customer_key_person.update(params_customer_key_person)
      render "update"
    else
      # 担当期間が終了していない担当者が2人以上存在する場合に変更可能
      # →現役担当者が1人以上いる状態を保持
      if @customer_key_person.check_action_ok?
        if @customer_key_person.update(params_customer_key_person)
          render "update"
        else
          binding.pry
          flash.now[:alert] = @customer_key_person.errors.full_messages.join
          render "edit"
        end
      else
        flash.now[:alert] = "他の現役担当者がいる場合、担当期間(終了)の更新が出来ます"
        render "edit"
      end
    end
  end

  def destroy
    if @customer_key_person.end_period.nil?
      if @customer_key_person.check_action_ok?
        @customer_key_person.destroy
        render "destroy"
      else
        render js: "alert('他の現役担当者がいる場合削除可能です');"
      end
    else
      @customer_key_person.destroy
      render "destroy"
    end
  end

  private

  def set_customer_key_person
    @customer_key_person = CustomerKeyPerson.find(params[:id])
  end

  def params_customer_key_person
    params.require(:customer_key_person).permit(
      :customer_id,
      :key_person_id,
      :start_period,
      :end_period,
    )
  end

  def params_key_person_new
    params.require(:customer_key_person).permit(
      :name,
      :post,
      :email,
      :sex,
      :note,
    )
  end
end
