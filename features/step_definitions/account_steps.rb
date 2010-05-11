# Scenario: Create an account
When /^I create a new account for "([^\"]*)"$/ do |name|
  visit accounts_path
  click_link "New Account"
  fill_in "Name", :with => name
  click_button "Submit"
end

Then /^I should see "([^\"]*)" in the list of accounts$/ do |expected|
  visit accounts_path
  response.should contain(expected)
end

# Scenario: Add myself to a Group
Given /^a user "([^\"]*)"$/ do |name|
  @user = Account.create!( :name => name )
  @user.save
end

When /^I edit my account and select the Group "([^\"]*)"$/ do |group|
  visit account_path @user.id
  click_link "Edit"
  select group
  click_button "Submit"

  visit groups_path
  # save_and_open_page
end

Then /^I should see "([^\"]*)" in "([^\"]*)" group$/ do |expected_user, expected_grp|
  visit groups_path
  click_link "Show"
#  save_and_open_page
  response.should contain(expected_grp)
  response.should contain(expected_user)
end

# Scenario: Remove myself from my Group
Given /^a user "([^\"]*)" that is a member of "([^\"]*)"$/ do |user, group_name|
  Given "a user \"#{user}\""
  Given "a group named \"#{group_name}\""
  @user.group = @group
  @user.save
end

When /^I remove myself from "([^\"]*)"$/ do |group|
  @user.group = nil
  @user.save
  visit groups_path
  click_link "Show"
#  save_and_open_page
end

Then /^I should not see "([^\"]*)" in "([^\"]*)" group$/ do |expected_user, expected_group|
  response.should contain(expected_group)
  response.should_not contain(expected_user)
end

# Scenario: Designate a proxy

Given /^a user "([^\"]*)" with an email "([^\"]*)" that is a member of "([^\"]*)"$/ do |user, email, group_name|
  Given "a user \"#{user}\""
  Given "a group named \"#{group_name}\""
  @user.email = email
  @user.save
end

When /^"([^\"]*)" designates "([^\"]*)" as a proxy for the next "([^\"]*)" days$/ do |owner, proxy, num_days|
  @user = Account.find_by_name(owner)
  designee = Account.find_by_name(proxy)
  SECONDS_PER_DAY = 60 * 60 * 24
  number_days = num_days.to_i * SECONDS_PER_DAY
  proxy = Proxy.create!(:proxy => designee, :from => Time.now()-SECONDS_PER_DAY, :to => Time.now+number_days )
  proxy.save
  @user.proxies << proxy
  @user.save
end

Then /^the notification list should include "([^\"]*)" email$/ do |expected_user|
  user = Account.find_by_name( expected_user )
  user.notify_me = true
  expected_email = user.email
  p user
  @user.notify_me = true
  @user.save
  p @user
  p @user.proxies
  @user.notification_list.should include(expected_email)
end

# Scenario: User can indicate they want to be notified
And /^an email "([^\"]*)"$/ do |user_email|
  @user.email = user_email
  @user.save
end

When /^NotifyMe is checked$/ do
  @user.notify_me = true
  @user.save
end

