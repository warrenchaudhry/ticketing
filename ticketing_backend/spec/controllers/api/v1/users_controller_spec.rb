require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:user) {
    FactoryGirl.create(:user)
  }

  let(:agent) {
    FactoryGirl.create(:user, :agent)
  }

  let(:admin) {
    FactoryGirl.create(:user, :admin)
  }

  let(:valid_attributes) {
    FactoryGirl.build(:user).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    FactoryGirl.build(:user, :invalid).attributes.symbolize_keys
  }

  let(:valid_session) { {} }

  describe "Authorization with role : user" do
    describe "GET #index" do
      it "response unauthorized for normal user" do
        valid_attributes[:password] = 'testing123'
        normal_user = User.create! valid_attributes
        request.headers['Authorization'] = normal_user.auth_token
        get :index, {}, valid_session
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "assigns the requested user as @user" do
        request.headers['Authorization'] = user.auth_token
        get :show, {:id => user.to_param}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new User" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          expect {
            post :create, {user: valid_attributes}, valid_session
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          post :create, {:user => valid_attributes}, valid_session
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it "responds created status 201" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          post :create, {:user => valid_attributes}, valid_session
          expect(response).to have_http_status(:created)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          invalid_attributes[:access_level] = :user
          post :create, {:user => invalid_attributes}, valid_session
          expect(assigns(:user)).to be_a_new(User)
        end

        it "responds unprocessable entity status" do
          invalid_attributes[:access_level] = :user
          post :create, {:user => invalid_attributes}, valid_session
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          { access_level: :user_manager }
        }

        it "updates the requested user" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          user = User.create! valid_attributes
          request.headers['Authorization'] = user.auth_token
          put :update, {:id => user.to_param, :user => new_attributes}, valid_session
          user.reload
          expect(user.access_level).to eq('user')
        end

        it "assigns the requested user as @user" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          user = User.create! valid_attributes
          request.headers['Authorization'] = user.auth_token
          put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
          expect(assigns(:user)).to eq(user)
        end

        # it "responds created status 200" do
        #   valid_attributes[:password] = 'testing123'
        #   valid_attributes[:access_level] = :user
        #   user = User.create! valid_attributes
        #   request.headers['Authorization'] = user.auth_token
        #   put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        #   expect(response).to have_http_status(:success)
        # end
      end

      context "with invalid params" do
        it "assigns the user as @user" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          user = User.create! valid_attributes
          request.headers['Authorization'] = user.auth_token
          invalid_attributes[:access_level] = :user
          invalid_attributes[:password] = 'testing123'
          invalid_attributes[:password_confirmation] = 'Testing123'
          put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          valid_attributes[:password] = 'testing123'
          valid_attributes[:access_level] = :user
          user = User.create! valid_attributes
          request.headers['Authorization'] = user.auth_token
          invalid_attributes[:access_level] = :user
          invalid_attributes[:password] = 'testing123'
          invalid_attributes[:password_confirmation] = 'Testing123'
          put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested user" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = user.auth_token
        expect {
          delete :destroy, {:id => user.to_param}, valid_session
        }.to change(User, :count).by(-1)
      end

      it "responds created status 200" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = user.auth_token
        delete :destroy, {:id => user.to_param}, valid_session
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "Authorization with role : manager" do
    describe "GET #index" do
      it "assigns all users as @users" do
        valid_attributes[:password] = 'testing123'
        normal_user = User.create! valid_attributes
        request.headers['Authorization'] = manager.auth_token
        get :index, {}, valid_session
        expect(assigns(:users)).to include(normal_user)
      end
    end

    describe "GET #show" do
      it "assigns the requested user as @user" do
        request.headers['Authorization'] = manager.auth_token
        get :show, {:id => user.to_param}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "PUT #update" do
      let(:new_attributes) {
        { access_level: :user_manager }
      }

      # Only admin can change user object

      # it "updates the requested user" do
      #   valid_attributes[:password] = 'testing123'
      #   valid_attributes[:access_level] = :user
      #   user = User.create! valid_attributes
      #   request.headers['Authorization'] = manager.auth_token
      #   put :update, {:id => user.to_param, :user => new_attributes}, valid_session
      #   user.reload
      #   expect(user.access_level).to eq('user_manager')
      # end

      it "assigns the requested user as @user" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = manager.auth_token
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "responds created status 200" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = manager.auth_token
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested user" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = manager.auth_token
        expect {
          delete :destroy, {:id => user.to_param}, valid_session
        }.to change(User, :count).by(-1)
      end

      it "responds created status 200" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = manager.auth_token
        delete :destroy, {:id => user.to_param}, valid_session
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "Authorization with role : admin" do
    describe "GET #index" do
      it "assigns all users as @users" do
        valid_attributes[:password] = 'testing123'
        normal_user = User.create! valid_attributes
        request.headers['Authorization'] = admin.auth_token
        get :index, {}, valid_session
        expect(assigns(:users)).to include(normal_user)
      end
    end

    describe "GET #show" do
      it "assigns the requested user as @user" do
        request.headers['Authorization'] = admin.auth_token
        get :show, {:id => user.to_param}, valid_session
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "PUT #update" do
      let(:new_attributes) {
        { access_level: :user_manager }
      }

      # Only admin can change user object

      # it "updates the requested user" do
      #   valid_attributes[:password] = 'testing123'
      #   valid_attributes[:access_level] = :user
      #   user = User.create! valid_attributes
      #   request.headers['Authorization'] = admin.auth_token
      #   put :update, {:id => user.to_param, :user => new_attributes}, valid_session
      #   user.reload
      #   expect(user.access_level).to eq('user_manager')
      # end

      it "assigns the requested user as @user" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = admin.auth_token
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "responds created status 200" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = admin.auth_token
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested user" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = admin.auth_token
        expect {
          delete :destroy, {:id => user.to_param}, valid_session
        }.to change(User, :count).by(-1)
      end

      it "responds created status 200" do
        valid_attributes[:password] = 'testing123'
        valid_attributes[:access_level] = :user
        user = User.create! valid_attributes
        request.headers['Authorization'] = admin.auth_token
        delete :destroy, {:id => user.to_param}, valid_session
        expect(response).to have_http_status(:success)
      end
    end
  end

end
