require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let(:user) { FactoryGirl.create(:user, email: 'admin@xyz-email.com', password: 'password2016', password_confirmation: 'password2016') }

    # before(:each) do
    #   @user = FactoryGirl.create(:user, password: 'password2016', password_confirmation: 'password2016')
    #   puts "++++++++++++++++++ User +++++++++++++++++++++++++"
    #   p @user
    # end

    context "when the credentials are correct" do
      before(:each) do
        credentials = { user: {email: user.email, password: "password2016" }}
        post :create, params: credentials
      end

      it "returns the user record corresponding to the given credentials" do
        user.reload

        expect(json_response[:token]).to eq user.auth_token
      end

      it { should respond_with 201 }
    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { user: {email: user.email, password: "invalidpassword" }}
        post :create, params: credentials
      end

      it "returns a json with an error" do
        expect(json_response[:errors]).to eq "Invalid email or password"
      end

      it { should respond_with 422 }
    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @user = FactoryGirl.create :user
      delete :destroy, params: { id: @user.auth_token }
    end

    it { should respond_with 204 }

  end
end
