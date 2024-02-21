require 'rails_helper'

RSpec.describe "People", type: :request do
  describe "GET /people" do
    it "renders the index view" do
      get people_path
      expect(response).to render_template(:index)
    end

    it "responds with JSON" do
      get people_path, headers: { "ACCEPT" => "application/json" }
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /people" do
    let(:valid_attributes) { { person: { name: 'John Doe'} } }
    let(:invalid_attributes) { { person: { name: '' } } }

    context "with valid parameters" do
      it "creates a new Person and redirects to the people index view" do
        expect {
          post people_path, params: valid_attributes
        }.to change(Person, :count).by(1)
        expect(response).to redirect_to(people_path)
      end

      it "responds with JSON including the new person" do
        post people_path, params: valid_attributes, headers: { "ACCEPT" => "application/json" }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
        expect(json_body).to include("name" => "John Doe")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Person and re-renders the new view" do
        expect {
          post people_path, params: invalid_attributes
        }.not_to change(Person, :count)
        expect(response).to render_template(:new)
      end

      it "responds with JSON error message" do
        post people_path, params: invalid_attributes, headers: { "ACCEPT" => "application/json" }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body).to eq({"name"=>["can't be blank"]})
      end
    end
  end
end
