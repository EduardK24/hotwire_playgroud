namespace :import do
  desc "Import people and details from JSON file"
  task persons_details: :environment do
    file = File.read(Rails.root.join('lib', 'assets', 'data.json'))
    data = JSON.parse(file)
    data.each do |person_data|
      person = Person.create!(name: person_data['name'])
      Detail.create!(
        person: person,
        title: person_data['info']['title'],
        age: person_data['info']['age'],
        phone: person_data['info']['phone'],
        email: person_data['info']['email']
      )
    end
  end
end
