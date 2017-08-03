require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe "unauthenticated" do

    before(:each) do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:list, user_id: user.id)
    end

    describe "GET welcome" do
      it "displays welcome page" do
        get :welcome

        expect(response).to have_http_status(:ok)
        expect(request.path).to eq(root_path)
      end
    end

    describe "GET autocomplete" do
      it "returns JSON search results" do
        list = List.first

        get :autocomplete, params: { q: list.title }

        expect(response.content_type).to eq "text/html"
        expect(request.path).to eq("/unauthenticated")
      end
    end

    describe "GET search" do
      it "return html search results" do
        list = List.first

        get :search, params: { q: list.title }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "authenticated" do

    before(:each) do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:list, public: true, user_id: user.id)
      sign_in user
    end

    describe "GET welcome" do
      it "displays welcome page" do
        get :welcome

        expect(response).to have_http_status(:ok)
        expect(request.path).to eq(root_path)
      end
    end

    describe "GET autocomplete" do
      it "returns JSON search results" do
        list = List.first

        get :autocomplete, params: { q: list.title }

        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET search" do
      it "return html search results" do
        list = List.first

        get :search, params: { q: list.title }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
