Given /^a group named "([^\"]*)"$/ do |group|
  @group = Group.create!( :name => group )
end

# Scenario: Create Group
When /^I create the Group "([^\"]*)"$/ do |grp|
  visit groups_path
  click_link "New Group"
  fill_in "Name", :with => grp
  fill_in "Email", :with => "admin@groupa.com"
  click_button "Submit"
end

Then /^I should see "([^\"]*)" group$/ do |expected|
  # This is known as "Direct Model Access"
  grp = Group.first( :name => expected )
  grp.should_not be_nil
  
  # This is a webrat version of the test
  visit groups_path
  response.should contain(expected)
end

# Scenario: Add member to the group

And /^a user named "([^\"]*)"$/ do |user_id|
  user = Account.create(:name => user_id)
  user.save
  @user = Account.find_by_name( user_id )
  @user.name.should == user_id
end

When /^I add "([^\"]*)" to group "([^\"]*)"$/ do |user_id, group|
  @user = Account.find_by_name( user_id )
  @grp = Group.find_by_name(group)
  @grp.should_not be_nil
  @grp.accounts << @user
end

Then /^I should see "([^\"]*)" in the list of members\.$/ do |member|
  @grp.member_names.should include(member)
end

