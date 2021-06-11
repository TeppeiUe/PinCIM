class KeyPeopleController < ApplicationController
  before_action :set_key_person_new, only: [:index, :search]
  before_action :set_key_person, only: [:show, :edit, :update]

  def index
    @key_people = current_user.key_people.includes([:customer]).page(params[:page]).per(10)
  end

  def create
    @key_person = current_user.key_people.new(params_key_person)
    if @key_person.save
      render "create"
    else
      @key_people = current_user.key_people.page(params[:page]).per(10)
      render "error"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @key_person.update(params_key_person)
      render "update"
    else
      render "edit"
    end
  end

  def search
    @value = params[:value]

    @key_people = current_user.key_people.
      search_name(@value).
      includes([:customer]).
      page(params[:page]).per(10)

    render "index"
  end

  private

  def set_key_person_new
    @key_person = KeyPerson.new
  end

  def set_key_person
    @key_person = KeyPerson.find(params[:id])
    redirect_to root_path unless @key_person.user_id == current_user.id
  end

  def params_key_person
    params.require(:key_person).permit(:name, :career, :note)
  end
end
