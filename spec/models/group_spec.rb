require 'spec_helper'

describe Group do
  before(:each) do
    @valid_attributes = {
      :name => "Group Name",
      :email => "email_address@abc_group.ch"
    }
  end

  it "should create a new instance given valid attributes" do
    Group.create!(@valid_attributes)
  end

  it "should require a name" do
    grp = nil
    begin
      lambda {
        grp = Group.create!(:email => "email")
        }.should raise_error(MongoMapper::DocumentNotValid)
    rescue
      
    end
    grp.should be_nil
  end

  it "should provide a list of member names" do
    grp = Group.create!(@valid_attributes)
    user_a = Account.create!(:name => "User A")
    user_b = Account.create!(:name => "User B")
    grp.accounts << [user_a, user_b]
    grp.accounts.should have_exactly(2).items
    grp.save
    grp.member_names.should include("User A")
    grp.member_names.should include("User B")
  end
end
