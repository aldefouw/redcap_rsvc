Feature: User Interface: The system shall support the ability to limit access to the Record Locking Customization module through user rights.

  As a REDCap end user
  I want to see that Record locking and E-signatures is functioning as expected

  Scenario: C.2.19.900.100 Enable user rights for Record Locking Customization module
    #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    When I click on the button labeled "Save Changes"
    And I see "Your system configuration values have now been changed!"
    Then I logout

    #SETUP
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.2.19.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges" on the tooltip
    Then I should see a dialog containing the following text: "Editing existing user"

    Given I check the User Right named "Record Locking Customization"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
    Then I should see a dialog containing the following text: "NOTICE"
    And I click on the button labeled "Close" in the dialog box

    Given I check the User Right named "Lock/Unlock *Entire* Records (record level)"
    When I save changes within the context of User Rights
    Then I should see 'User "test_user1" was successfully edited'

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action                 | List of Data Changes OR Fields Exported |
      | test_user1 | Update user test_user1 | user = 'test_user1'                     |

    And I should see the link labeled "Customize & Manage Locking/E-signatures"

    ##ACTION verify Record Locking Customization module enabled in Dev
    # Open Customize & Manage Locking/E-signatures
    ##VERIFY
    When I click on the link labeled "Customize & Manage Locking/E-signatures"
    Then I should see "Customize and Manage the Record Locking and E-signature Functionality"

    ##USER_RIGHTS
    # Check Record Locking Customization module disabled
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges" on the tooltip
    Then I should see a dialog containing the following text: "Editing existing user"

    When I uncheck the User Right named "Record Locking Customization"
    And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
    And I uncheck the User Right named "Lock/Unlock *Entire* Records (record level)"

    Given I save changes within the context of User Rights
    Then I should see 'User "test_user1" was successfully edited'

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action                 | List of Data Changes OR Fields Exported |
      | test_user1 | Update user test_user1 | user = 'test_user1'                     |

    ##VERIFY
    And I should NOT see the link labeled "Customize and Manage the Record Locking and E-signature Functionality"

    ##SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_user1 | Manage/Design | Move project to Production status       |

    ##VERIFY: Look for Record Locking Customization module (not there)
    And I should NOT see the link labeled "Customize & Manage Locking/E-signatures"

    #FUNCTIONAL REQUIREMENT
    ##USER_RIGHTS
    # Check Record Locking Customization module disabled
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges" on the tooltip
    Then I should see a dialog containing the following text: "Editing existing user"

    And I should see a checkbox labeled "Record Locking Customization" that is unchecked
    And I should see the radio labeled "Lock/Unlock Records (instrument level)" with option "Disabled" selected
    And I should see a checkbox labeled "Lock/Unlock *Entire* Records (record level)" that is unchecked

    ##USER_RIGHTS
    Given I check the User Right named "Record Locking Customization"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
    Then I should see a dialog containing the following text: "NOTICE"
    And I click on the button labeled "Close" in the dialog box
    Given I check the User Right named "Lock/Unlock *Entire* Records (record level)"
    When I save changes within the context of User Rights
    Then I should see 'User "test_user1" was successfully edited'

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action                 | List of Data Changes OR Fields Exported |
      | test_user1 | Update user test_user1 | user = 'test_user1'                     |

    ##ACTION verify Record Locking Customization module enabled in prod
    # Open Customize & Manage Locking/E-signatures
    And I should see the link labeled "Customize & Manage Locking/E-signatures"