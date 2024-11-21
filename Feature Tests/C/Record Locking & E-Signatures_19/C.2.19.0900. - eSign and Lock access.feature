<<<<<<< HEAD
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
=======
Feature: User Interface: The system shall support the ability to limit access to the Record Locking Customization module, locking/unlocking instruments, locking/unlocking with e-signature authority and LOCK/INLOCK *Entire* Records (record level) through user rights.

    As a REDCap end user
    I want to see that Record locking and E-signatures is functioning as expected

    Scenario: C.2.19.900.100 Enable user rights for Record Locking Customization module
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.2.19.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    Scenario: ##SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

    Scenario: #SETUP
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        And for the Column Name "Also display E-signature option on instrument?", I check the checkbox within the Record Locking Customization table for the Data Collection Instrument named "Text Validation"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [✓]                                          | Text Validation            | [✓]                                            | [text box]              |
            | [✓]                                          | Data Types                 | [ ]                                            | [text box]              |
            | [✓]                                          | Survey                     | [ ]                                            | [text box]              |
            | [✓]                                          | Consent                    | [ ]                                            | [text box]              |

        And I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"
        When I click on the link labeled "Upload users (CSV)"
        Then I should see a dialog containing the following text: "Upload users (CSV)"

        Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
        And I should see a table header and rows containing the following values in a table:
            | username   |
            | test_user1 |
            | test_user2 |
            | test_user3 |
            | test_user4 |

        Given I click on the button labeled "Upload" in the dialog box
        Then I should see a dialog containing the following text: "SUCCESS!"

        When I click on the button labeled "Close" in the dialog box
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | —                       | test_user1          |
            | —                       | test_user2          |
            | —                       | test_user3          |
            | —                       | test_user4          |
            | 1_FullRights            | [No users assigned] |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

    Scenario:  #USER_RIGHTS - Assign eSign and Lock user rights to users
        ##ACTION - Assign users rights for Test_User1; Lock/Unlock *Entire* Records (record level)
        Given I click on the link labeled "Test User1"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I check the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
        Then I should see a dialog containing the following text: "NOTICE"
        And I click on the button labeled "Close" in the dialog box
        Given I check the User Right named "Lock/Unlock *Entire* Records (record level)"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user1" was successfully edited'

        ##ACTION - Assign users rights for Test_User2; Disable Lock/Unlock Records
        Given I click on the link labeled "Test User2"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I check the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user2" was successfully edited'

        ##ACTION - Assign users rights for Test_User3; Enable Locking / Unlocking records
        Given I click on the link labeled "Test User3"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I uncheck the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user3" was successfully edited'

        ##ACTION - Assign users rights for Test_User4;  Disable Lock/Unlock Records
        Given I click on the link labeled "Test User4"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I uncheck the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
        When I set Data Viewing Rights to View & Edit for the instrument "Text Validation"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user4" was successfully edited'

    Scenario: #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Update user   | test_user4                              |
            | test_admin | Update user   | test_user3                              |
            | test_admin | Update user   | test_user2                              |
            | test_admin | Update user   | test_user1                              |
            | test_admin | Manage/Design | Upload users (CSV)                      |
            | test_admin | Add User      | test_user4                              |
            | test_admin | Add User      | test_user3                              |
            | test_admin | Add User      | test_user2                              |
            | test_admin | Add User      | test_user1                              |

        Given I logout

    Scenario:  #FUNCTIONAL_REQUIREMENT Test user privileges
        #Test_User1
        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module enabled
        Then I should see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        Then I should see a link labeled "Record Locking Customization"
        And I should see a link labeled "E-signature and Locking Management"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlocking with E-signature authority is enabled
        And I should see a checkbox labeled exactly "Lock" that is unchecked
        And I should see a checkbox labeled "E-signature" that is unchecked
        And I click on the button labeled "Cancel"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is enabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should see a link labeled "Lock entire record"
        And I logout

    Scenario:  #Test_User2
        Given I login to REDCap with the user "Test_User2"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module is enabled
        Then I should see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        Then I should see a link labeled "Record Locking Customization"
        And I should NOT see a link labeled "E-signature and Locking Management"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlock is disabled
        And I should NOT see a checkbox labeled "Lock"
        And I should NOT see a checkbox labeled "E-signature"
        And I click on the button labeled "Cancel"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is disabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should NOT see a link labeled "Lock entire record"
        And I logout

    Scenario:  #Test_User3
        Given I login to REDCap with the user "Test_User3"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module is disabled but becomes enabled if you have lock/unlock privileges
        Then I should see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        Then I should NOT see a link labeled "Record Locking Customization"
        And I should see a link labeled "E-signature and Locking Management"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlock is enabled with no e-signature
        And I should see a checkbox labeled exactly "Lock" that is unchecked
        And I should NOT see a checkbox labeled "E-signature"
        When I click on the link labeled "Record Status Dashboard"
        When I click on the link labeled "3"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is disabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should NOT see a link labeled "Lock entire record"
        And I logout

        #Test_User4
        Given I login to REDCap with the user "Test_User4"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module is disabled
        Then I should NOT see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlock is disabled
        And I should NOT see a checkbox labeled "Lock"
        And I should NOT see a checkbox labeled "E-signature"
        And I click on the button labeled "Cancel"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is disabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should NOT see a link labeled "Lock entire record"
        And I logout
#END
>>>>>>> v14.7.0
