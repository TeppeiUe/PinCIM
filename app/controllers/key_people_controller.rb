class KeyPeopleController < ApplicationController
  def index
    @key_people = KeyPerson.all
    @key_person = KeyPerson.new
  end

  def create
    @key_person = KeyPerson.new(params_key_person)
    if @key_person.save
      redirect_to key_people_path
    else
      @key_people = KeyPerson.all
      render "index"
    end
  end

  def show
    @key_person = KeyPerson.find(params[:id])
  end

  def edit
    @key_person = KeyPerson.find(params[:id])
  end

  def update
    @key_person = KeyPerson.find(params[:id])
    if @key_person.update(params_key_person)
      redirect_to key_person_path(@key_person.id)
    else
      render "edit"
    end
  end

  def search
    @key_people = KeyPerson.search_name(params[:value])
    render "index"
  end

  private

  def params_key_person
    params.require(:key_person).permit(:name, :career, :note)
  end
end
