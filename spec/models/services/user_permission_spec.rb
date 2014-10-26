require 'spec_helper'

describe UserPermission do

  let(:user) { OpenStruct.new }

  it "should not be admin if not logged in" do
    user_permission = UserPermission.new(nil)
    expect(user_permission.is_admin?).to eq(false)
  end

  it "should tell us if user is admin" do
    user_permission = UserPermission.new(user)
    user_permission.set_admin!
    expect(user_permission.is_admin?).to eq(true)
  end

  it "should unset admin" do
    user_permission = UserPermission.new(user)
    user_permission.set_admin!
    user_permission.unset_admin!
    expect(user_permission.is_admin?).to eq(false)
  end



end