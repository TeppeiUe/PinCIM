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
  end

  def update
  end

  def search
  end

  private

  def params_key_person
    params.require(:key_person).permit(:name, :career, :note)
  end
end
