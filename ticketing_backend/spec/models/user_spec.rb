require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }
  let(:admin) { FactoryGirl.build(:user, :admin) }
  let(:agent) { FactoryGirl.build(:user, :agent) }

  it 'responds to attributes' do
    expect(user).to respond_to(:first_name)
    expect(user).to respond_to(:last_name)
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:phone)
    expect(user).to respond_to(:password)
    expect(user).to respond_to(:password_confirmation)
    expect(user).to respond_to(:auth_token)
    expect(user).to respond_to(:role)
  end

  it 'auth token generated should not be empty' do
    user.generate_authentication_token!
    expect(user.auth_token).not_to be_empty
  end

  it { expect(user).to be_valid }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it do
    should allow_value('sample@email.com', 'admin@xyz-email.com').for(:email)
  end

  it do
    should_not allow_value('lkawe924', '&&&&&&&@').for(:email)
  end
  it { should validate_uniqueness_of(:auth_token) }

  describe "roles" do
    it 'should have the correct role as customer' do
      expect(user.role).to eq 'customer'
    end
    it 'should have the correct role as agent' do
      expect(agent.role).to eq 'agent'
    end
    it 'should have the correct role as admin' do
      expect(admin.role).to eq 'admin'
    end
  end

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      user.generate_authentication_token!
      expect(user.auth_token).to eq "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      user.generate_authentication_token!
      expect(user.auth_token).not_to eq existing_user.auth_token
    end
  end

end
