# spec/models/person_spec.rb
require 'rails_helper'

RSpec.describe Person, type: :model do
  it 'is valid with valid attributes' do
    person = Person.new(name: 'John Doe')
    expect(person).to be_valid
  end

  it 'is not valid without a name' do
    person = Person.new(name: nil)
    expect(person).not_to be_valid
  end
end
