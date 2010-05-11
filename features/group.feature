Feature: Create a Group
  So that doctors can be members of a group
  As a site administrator
  I want to be able to create a group

  Scenario: Create Group
  # Given a group named "Mytown Pediatrics"
    When I create the Group "Mytown Pediatrics"
    Then I should see "Mytown Pediatrics"

  Scenario: Add member to the group
    Given a group named "Mytown Pediatrics"
    And a user named "Dr. John Smith"
    When I add "Dr. John Smith" to group "Mytown Pediatrics"
    Then I should see "Dr. John Smith" in the list of members.

	