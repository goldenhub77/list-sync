require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "unauthenticated" do

    before(:each) do
      user = FactoryGirl.create(:user)
      list = FactoryGirl.create(:list, user_id: user.id)
      FactoryGirl.create(:item, user_id: user.id, list_id: list.id)
    end

    #CURRENTLY NO ROUTE FOR INDEX ACTION
    # describe "GET index" do
    #   it "assigns @lists" do
    #     items = Item.order('created_at DESC')
    #     get :index
    #
    #     expect(assigns(:items)).not_to eq(items)
    #   end
    #
    #   it "renders the index template" do
    #     get :index
    #
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(new_user_session_path)
    #   end
    # end

    describe "GET new" do
      it "assigns @item, @list, @user" do
        user = User.first
        list = List.first
        item = Item.new

        get :new, params: { user_id: user.id, list_id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:user)).not_to eq(user)
        expect(assigns(:item)).not_to be_a_new(Item)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "creates a item" do
        user = User.first
        list = List.first
        item_params = FactoryGirl.attributes_for(:item, user_id: user.id, list_id: list.id)

        post :create, params: { list_id: list.id, item: item_params }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET show" do
      it "assigns @list, @user, @items" do
        user = User.first
        list = List.first
        item = Item.first

        get :show, params: { id: item.id, list_id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:user)).not_to eq(user)
        expect(assigns(:item)).not_to eq(item)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "assigns @list, @user" do
        user = User.first
        list = List.first
        item = Item.first

        get :edit, params: { id: item.id, list_id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:item)).not_to eq(item)
        expect(assigns(:user)).not_to eq(user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST update" do
      it "updates a item" do
        user = User.first
        list = List.first
        item = Item.first
        item_params = FactoryGirl.attributes_for(:item, list_id: list.id, user_id: user.id)

        post :update, params: { list_id: list.id, id: item.id, item: item_params }
        item.reload

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:item)).not_to eq(item)
        expect(assigns(:user)).not_to eq(user)
        expect(item.title).not_to eq(item_params[:title])
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "deletes a item" do
        user = User.first
        list = List.first
        item = Item.first

        delete :destroy, params: { id: item.id, list_id: list.id }

        expect(assigns(:list)).not_to eq(list)
        expect(assigns(:item)).not_to eq(item)
        expect(assigns(:user)).not_to eq(user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    #PENDING
    # describe "PUT complete" do
    #   it "completes an item" do
    #     user = User.first
    #     list = List.first
    #     item = Item.first
    #
    #     put :complete, params: { id: item.id, list_id: list.id, completed: 1, date_completed: DateTime.now.utc, user_id: user.id }
    #
    #     expect(assigns(:list)).not_to eq(list)
    #     expect(assigns(:item)).not_to eq(item)
    #     expect(assigns(:user)).not_to eq(user)
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(new_user_session_path)
    #   end
    # end
  end

  describe "authenticated" do

    before(:each) do
      user = FactoryGirl.create(:user)
      list = FactoryGirl.create(:list, user_id: user.id)
      FactoryGirl.create(:item, user_id: user.id, list_id: list.id)
      sign_in user
    end

    #CURRENTLY NO ROUTE FOR INDEX ACTION
    # describe "GET index" do
    #   it "assigns @lists" do
    #     items = Item.order('created_at DESC')
    #     get :index
    #
    #     expect(assigns(:items)).not_to eq(items)
    #   end
    #
    #   it "renders the index template" do
    #     get :index
    #
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(new_user_session_path)
    #   end
    # end

    describe "GET new" do
      it "assigns @item, @list, @user" do
        user = User.first
        list = List.first
        item = Item.new

        get :new, params: { user_id: user.id, list_id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:user)).to eq(user)
        expect(assigns(:item)).to be_a_new(Item)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("new")
      end
    end

    describe "POST create" do
      it "creates a item" do
        user = User.first
        list = List.first
        item_params = FactoryGirl.attributes_for(:item, list_id: list.id, user_id: user.id)

        post :create, params: { list_id: list.id, item: item_params }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(list_path(list))
      end
    end

    describe "GET show" do
      it "assigns @list, @user, @items" do
        user = User.first
        list = List.first
        item = Item.first

        get :show, params: { id: item.id, list_id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:user)).to eq(user)
        expect(assigns(:item)).to eq(item)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("show")
      end
    end

    describe "GET edit" do
      it "assigns @list, @user" do
        user = User.first
        list = List.first
        item = Item.first

        get :edit, params: { id: item.id, list_id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:item)).to eq(item)
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template("edit")
      end
    end

    describe "POST update" do
      it "updates a item" do
        user = User.first
        list = List.first
        item = Item.first
        item_params = FactoryGirl.attributes_for(:item, list_id: list.id, user_id: user.id)

        post :update, params: { list_id: list.id, id: item.id, item: item_params }
        item.reload

        expect(assigns(:list)).to eq(list)
        expect(assigns(:item)).to eq(item)
        expect(assigns(:user)).to eq(user)
        expect(item.title).to eq(item_params[:title])
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(list_path(list))
      end
    end

    describe "DELETE destroy" do
      it "deletes a item" do
        user = User.first
        list = List.first
        item = Item.first

        delete :destroy, params: { id: item.id, list_id: list.id }

        expect(assigns(:list)).to eq(list)
        expect(assigns(:item)).to eq(item)
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(list_path(list))
      end
    end
    #PENDING
    # describe "PUT complete" do
    #   it "completes an item" do
    #     user = User.first
    #     list = List.first
    #     item = Item.first
    #     binding.pry
    #     put :complete, params: { id: item.id, list_id: list.id, completed: 1, date_completed: DateTime.now.utc, user_id: user.id }
    #
    #     expect(assigns(:list)).to eq(list)
    #     expect(assigns(:item)).to eq(item)
    #     expect(assigns(:user)).to eq(user)
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(list_path(list))
    #   end
    # end
  end
end
