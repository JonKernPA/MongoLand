require 'spec_helper'

describe Account do
  before(:each) do
    @valid_attributes = {
      :name => "user name",
      :email => "user_email@somedomain.ch"
    }
  end

  it "should create a new instance given valid attributes" do
    Account.create!(@valid_attributes)
  end

  it "should be able to be a member of a group" do
    
  end

  it "should require a name" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:email => "email")
        }.should raise_error(MongoMapper::DocumentNotValid)
    rescue

    end
    acct.should be_nil
  end

  it "should reject invalid email address ('email @domain.com')" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:name => "User A", :email => "email @domain.com")
        }.should raise_error(MongoMapper::DocumentNotValid)
    rescue => oops
      puts oops
    end
    acct.should be_nil
  end

  it "should reject invalid email address ('em.il')" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:name => "User A", :email => "em.il")
        }.should raise_error(MongoMapper::DocumentNotValid)
    rescue => oops
      puts oops
    end
    acct.should be_nil
  end
  it "should reject invalid email address ('some_email@apple')" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:name => "User A", :email => "some_email@apple")
        }.should raise_error(MongoMapper::DocumentNotValid)
    rescue => oops
      puts oops
    end
    acct.should be_nil
  end
  it "should reject invalid email address ('some_email@.com')" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:name => "User A", :email => "some_email@.com")
        }.should raise_error(MongoMapper::DocumentNotValid)
    rescue => oops
      puts oops
    end
    acct.should be_nil
  end
  it "should accept a valid email address ('em.il@simile.de')" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:name => "User A", :email => "em.il@simile.de")
        }.should_not raise_error(MongoMapper::DocumentNotValid)
    rescue => oops
      puts oops
    end
    acct.should_not be_nil
  end
  it "should accept a valid email address ('user_email@somedomain.ch')" do
    acct = nil
    begin
      lambda {
        acct = Account.create!(:name => "User A", :email => "user_email@somedomain.ch")
        }.should_not raise_error(MongoMapper::DocumentNotValid)
    rescue => oops
      puts oops
    end
    acct.should_not be_nil
  end

end
