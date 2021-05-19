class KeyPeopleController < ApplicationController
  before_action :set_key_person_new, only: [:index, :search]
  before_action :set_key_person, only: [:show, :edit, :update]

  def index
    @key_people = KeyPerson.page(params[:page]).per(10)
  end

  def create
    @key_person = KeyPerson.new(params_key_person)
    if @key_person.save
      redirect_to key_people_path
    else
      @key_people = KeyPerson.page(params[:page]).per(10)
      render "index"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @key_person.update(params_key_person)
      redirect_to key_person_path(@key_person.id)
    else
      render "edit"
    end
  end

  def search
    @key_people = KeyPerson.
      search_name(params[:value]).
      page(params[:page]).per(10)
    render "index"
  end

  private

  def set_key_person_new
    @key_person = KeyPerson.new
  end

  def set_key_person
    @key_person = KeyPerson.find(params[:id])
  end

  def params_key_person
    params.require(:key_person).permit(:name, :career, :note)
  end
end
