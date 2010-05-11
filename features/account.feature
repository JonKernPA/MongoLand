Feature: Create and Manage Accounts
	So that users can configure their account information
	As a user
	I need to be able to create and edit my account

	Scenario: Create an account
	When I create a new account for "Dr. John Smith"
	Then I should see "Dr. John Smith" in the list of accounts
	
	Scenario: Add myself to a Group
	Given a group named "Mytown Pediatrics"
	And a user "Dr. John Smith"
	When I edit my account and select the Group "Mytown Pediatrics"
	Then I should see "Dr. John Smith" in "Mytown Pediatrics" group
	
  Scenario: Remove myself from my Group
    Given a user "Dr. John Smith" that is a member of "Mytown Pediatrics"
    When I remove myself from "Mytown Pediatrics"
	Then I should not see "Dr. John Smith" in "Mytown Pediatrics" group
