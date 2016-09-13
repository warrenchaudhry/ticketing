require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:user) { FactoryGirl.build(:user) }


  it "should not approve incorrect roles" do
    user.add_role :moderator
    expect(user.has_role?(:admin)).to be_falsey
  end

  it "should approve correct roles" do
    user.add_role :admin
    expect(user.has_role?(:admin)).to be_truthy
  end
end
