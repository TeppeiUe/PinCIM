class CustomerKeyPerson < ApplicationRecord
  belong_to :customer
  belong_to :key_person
  belong_to :user
end
