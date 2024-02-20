class Person < ApplicationRecord
  has_many :details, dependent: :destroy
  validates :name, presence: true
end
