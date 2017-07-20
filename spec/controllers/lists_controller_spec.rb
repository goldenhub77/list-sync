require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  describe "unauthenticated" do

    before(:each) do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:list, user_id: user.id)
    end

    describe "GET index" do
      it "assigns @lists" do
        lists = List.public.order("title DESC")
        get :index

        expect(assigns(:lists)).not_to eq(lists)
      end

      it "renders the index template" do
        get :index

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET new" do
      it "assigns @list, @user" do
        user = User.first
        get :new

        expect(assigns(:list)).not_to be_a_new(List)
        expect(assigns(:user)).not_to eq(user)
      end

      it "renders the new template" do
        get :new

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "creates a list" do
        user = User.first
        list_params = { list: FactoryGirl.attributes_for(:list, user_id: user.id) }

        post :create, params: list_params

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET show" do
      it "assigns @list, @user, @items" do
        user = User.first
        list = List.first
        items = FactoryGirl.create(:item, list_id: list.id, user_id: user.id)
        
        get :show, params: { id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:user)).not_to eq(user)
        expect(assigns(:items)).not_to eq([items])
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "assigns @list, @user" do
        user = User.first
        list = List.first

        get :edit, params: { id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:user)).not_to eq(user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST update" do
      it "updates a list" do
        user = User.first
        list = List.first
        list_params = FactoryGirl.attributes_for(:list, user_id: user.id)

        post :update, params: { id: list.id, list: list_params }
        list.reload

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:user)).not_to eq(user)
        expect(list.title).not_to eq(list_params[:title])
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "deletes a list" do
        user = User.first
        list = List.first

        delete :destroy, params: { id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:user)).not_to eq(user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "authenticated" do

    before(:each) do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:list, user_id: user.id)
      sign_in user
    end

    describe "GET index" do
      it "assigns @lists" do
        lists = List.public.order("title DESC")
        get :index

        expect(assigns(:lists)).to eq(lists)
      end

      it "renders the index template" do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response).to render_template("index")
      end
    end

    describe "GET new" do
      it "assigns @list, @user" do
        user = User.first
        get :new

        expect(assigns(:list)).to be_a_new(List)
        expect(assigns(:user)).to eq(user)
      end

      it "renders the new template" do
        get :new

        expect(response).to have_http_status(:ok)
        expect(response).to render_template("new")
      end
    end

    describe "POST create" do
      it "creates a list" do
        user = User.first
        list_params = { list: FactoryGirl.attributes_for(:list, user_id: user.id) }

        expect{ post :create, params: list_params }.to change(List, :count).by(1)
        list = List.last
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(list_path(list))
      end
    end

    describe "GET show" do
      it "assigns @list, @user, @items" do
        user = User.first
        list = List.first
        items = FactoryGirl.create(:item, list_id: list.id, user_id: user.id)

        get :show, params: { id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:user)).to eq(user)
        expect(assigns(:items)).to eq([items])
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("show")
      end
    end

    describe "GET edit" do
      it "assigns @list, @user" do
        user = User.first
        list = List.first

        get :edit, params: { id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("edit")
      end
    end

    describe "POST update" do
      it "updates a list" do
        user = User.first
        list = List.first
        list_params = FactoryGirl.attributes_for(:list, user_id: user.id)

        post :update, params: { id: list.id, list: list_params }
        list.reload

        expect(assigns(:list)).to eq(list)
        expect(assigns(:user)).to eq(user)
        expect(list.title).to eq(list_params[:title])
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(list_path(list))
      end
    end

    describe "DELETE destroy" do
      it "deletes a list" do
        user = User.first
        list = List.first

        delete :destroy, params: { id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(lists_path)
      end
    end
  end
end
