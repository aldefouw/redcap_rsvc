Feature: A.2.3.400 Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

  Scenario: A.2.3.400.100 Give and remove user maximum user privileges

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"

    When I enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Access to all projects and data with maximum user privileges" for a new administrator
    And I enable the Administrator Privilege "Access to Control Center dashboards" for a new administrator
    And I click on the button labeled "Add"
    Then I should see 'The user "Test_User1" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK" in the dialog box

    Given I logout
    And I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see a link labeled "System Statistics"
    And I should see a link labeled "Edit a Project's Settings"

    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privilege"
    Then I should see "Set administrator privileges"
    And I disable the Administrator Privilege "Access to all projects and data with maximum user privileges" for the administrator "Test_User1"

    Given I logout
    And I login to REDCap with the user "Test_User1"
    When I click on the link labeled "Control Center"
    Then I should see "Control Center Home"

    And I should see a link labeled "System Statistics"
    And I should NOT see a link labeled "Edit a Project's Settings"
    And I logout
    