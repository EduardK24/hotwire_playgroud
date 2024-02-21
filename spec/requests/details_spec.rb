require 'rails_helper'

RSpec.describe "Details", type: :request do
  # Setup a person before running tests
  let!(:person) { Person.create(name: 'John Doe') }

  describe "GET /people/:person_id/details" do
    it "renders the person details view" do
      get person_details_path(person_id: person.id)
      expect(response).to render_template(:index)
    end

    it "responds with JSON" do
      get person_details_path(person_id: person.id), headers: { "ACCEPT" => "application/json" }
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /people/:person_id/details" do
    let(:valid_attributes) { { detail: { title: 'New Detail', age: 25, phone: '123-456-7890', email: 'new@example.com' } } }
    let(:invalid_attributes) { { detail: { title: 'New Detail', age: 25, phone: '123-456-7890', email: '' } } }

    context "with valid parameters" do
      it "creates a new Detail for the person and redirects to the person's detail view" do
        expect {
          post person_details_path(person_id: person.id), params: valid_attributes
        }.to change(person.details, :count).by(1)
        expect(response).to redirect_to(person_path(person))
      end

      it "responds with JSON including the new detail" do
        post person_details_path(person_id: person.id), params: valid_attributes, headers: { "ACCEPT" => "application/json" }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
        expect(json_body.first["email"]).to eq('new@example.com')
      end
    end

    context "with invalid parameters" do
      it "does not create a new Detail and re-renders the new view" do
        expect {
          post person_details_path(person_id: person.id), params: invalid_attributes
        }.not_to change(person.details, :count)
        expect(response).to render_template(:new)
      end

      it "responds with JSON error message" do
        post person_details_path(person_id: person.id), params: invalid_attributes, headers: { "ACCEPT" => "application/json" }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body).to eq({"email"=> ["can't be blank", "is invalid"]})
      end
    end
  end
end
