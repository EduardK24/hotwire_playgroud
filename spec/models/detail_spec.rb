require 'rails_helper'

RSpec.describe Detail, type: :model do
  let(:person) { Person.create(name: 'Jane Doe') }
  let(:detail) { person.details.build(title: 'Some Title', age: 30, phone: '123-456-7890', email: 'example@example.com') }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(detail).to be_valid
    end

    it 'is not valid without an email' do
      detail.email = nil
      expect(detail).not_to be_valid
    end
  end
end
