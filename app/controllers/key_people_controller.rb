class KeyPeopleController < ApplicationController
  def index
    @key_people = KeyPerson.all
    @key_person = KeyPerson.new
  end

  def create
    @key_person = KeyPerson.new(params_key_person)
    @key_person.save
    redirect_to key_people_path
  end

  def show
    @key_person = KeyPerson.find(params[:id])
  end

  def edit
    @key_person = KeyPerson.find(params[:id])
  end

  def update
    @key_person = KeyPerson.find(params[:id])
    @key_person.update(params_key_person)
    redirect_to key_person_path(@key_person.id)
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
