Feature: Control Center: The system shall support the option to limit adding or modifying repeatable instruments while in production to administrators

  As a REDCap end user
  I want to see that repeatable function is functioning as expected

  Scenario: A.6.4.500.100 User's ability to add or modify repeatable instrument while in production mode
            #SETUP_PROJECT
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.500.100"
            #SETUP_USER
    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown

    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

            #SETUP_PRODUCTION
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status

    Then I should see Project status: "Production"

            #FUNCTIONAL REQUIREMENT - Only admins can modify repeating instance setup in production
            #SETUP_CONTROL_CENTER
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"

    Then I should see "System-level User Settings"

    When I select "No, only Administrators can modify the repeating instance setup in production" on the dropdown field labeled "Allow normal users to modify the 'Repeating Instruments & Events' settings for projects while in production status?"
    And I click on the button labeled "Save Changes"

    Then I should see "Your system configuration values have now been changed!"

    Given I logout

            #FUNCTIONAL REQUIREMENT
            #User unable to see repeatable instruments
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.500.100"
    And I click on the link labeled "Project Setup"

    Then I should see a button labeled "Modify" on the field labeled "Repeating instruments and events"
            #And I should see that I am unable to click on Modify

    Given I logout

            #FUNCTIONAL REQUIREMENT - normal users can modify the repeating instance setup in production
            #SETUP_CONTROL_CENTER
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.500.100"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"

    Then I should see "System-level User Settings"

    When I select "Yes, normal users can modify the repeating instance setup in production" on the dropdown field labeled "Allow normal users to modify the 'Repeating Instruments & Events' settings for projects while in production status?"
    And I click on the button labeled "Save Changes"

    Then I should see "Your system configuration values have now been changed!"

    Given I logout

            #FUNCTIONAL REQUIREMENT
            #User modifies repeat instrument
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.500.100"
    And I click on the link labeled "Project Setup"

    Then I should see "Repeating instruments and events"

    When I open the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    And I select "-- not repeating --" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
    And I check the checkbox labeled "Survey"
    And I click on the button labeled "Save"

    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."

    Given I click on the button labeled "Close" in the dialog box

            ##VERIFY_LOG
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | test_user1 | Manage/Design | Set up repeating instruments/events    |

            #Verify record home page
    When I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
    And I enter "MyName" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Add New Instance" on the Data Collection Instrument
    And I enter "MyOtherName" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

            ##VERIFY_DE
    Given I click on the link labeled "Data Exports, Reports, and Stats"

    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"

    Then I should see table rows containing the following values in the report data table:
      | Record ID | Event Name                 | Repeat Instrument | Repeat Instance | name_survey      |
      | 1         | Event Three (Arm 1: Arm 1) | Survey            | 1               | Name MyName      |
      | 1         | Event Three (Arm 1: Arm 1) | Survey            | 2               | Name MyOtherName |
    And I should NOT see "Data Types"

            #FUNCTIONAL REQUIREMENT
            #User deletes repeatable instance
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three" instance "2"
    And I click on the button labeled "Delete data for THIS FORM only"

    Then I should see a dialog containing the following text: "Delete all data on this form"

    Given I click on the button labeled "Delete data for THIS FORM only" in the dialog box

    Then I should NOT see "(#2)"

            #FUNCTIONAL REQUIREMENT
            #User modifies repeat instrument to capture orphaned data
    Given I click on the link labeled "Project Setup"

    Then I should see "Repeating instruments and events"

    When I open the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I check the checkbox labeled "Data Types"
    And I select "-- not repeating --" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
    And I click on the button labeled "Save"

    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."

    When I click on the button labeled "Close" in the dialog box

            ##VERIFY_LOG
    When I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | test_user1 | Manage/Design | Set up repeating instruments/events    |

            #Verify record home page
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"

    Then I should NOT see "Current instance:"

    When I click on the button labeled "Cancel"
    And I click on the button labeled "OK" in the dialog box

    Then I see "data entry cancelled - not saved"

    When I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"

    Then I see "Current instance:"

            ##VERIFY_DE
    Given I click on the link labeled "Data Exports, Reports, and Stats"

    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"

    Then I should see a table row containing the following values in the report data table:
      | Event 2 (Arm 1: Arm 1) |  | 1 |  |  | Name | email@test.edu | Unverified |
    And I should NOT see "MyOtherName"

            #FUNCTIONAL REQUIREMENT
            #User modifies repeat event
    When I click on the link labeled "Project Setup"
    And I open the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    And I select "-- not repeating --" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)"
    And I select "Repeat Entire Event (repeat all instruments together)" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
    And I click on the button labeled "Save"

    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."

    Given I click on the button labeled "Close" in the dialog box

            ##VERIFY_LOG
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | test_user1 | Manage/Design | Set up repeating instruments/events    |


            #Verify record home page
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page

    Then I should NOT see "(#2)"

    When I click on the button labeled "Add new"
    And I click the bubble to add a record for the "Survey" longitudinal instrument on event "(#3)"

    Then I should see "Editing existing Record ID 1"

    When I clear field and enter "My repeat event name" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    Then I should see "(#2)"

            ##VERIFY_DE
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |
    And I click on the button labeled "View Report"
    Then I should see a table row containing the following values in the report data table:
      | Event Three (Arm 1: Arm 1) | My repeat event name |

            #FUNCTIONAL REQUIREMENT
            #User modifies repeat event to see orphaned event
    When I click on the link labeled "Project Setup"
    And I open the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    And I select "Repeat Entire Event (repeat all instruments together)" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)"
    And I select "-- not repeating --" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
    And I click on the button labeled "Save"

    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."

    Given I click on the button labeled "Close" in the dialog box

            ##VERIFY_DE
    When I click on the link labeled "Data Exports, Reports, and Stats"

    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"

    Then I should see a "1" within the "Event 2 (Arm 1: Arm 1)" row of the column labeled "Repeat Instance" of the Reports table
    And I should see "" within the "Event Three (Arm 1: Arm 1)" row of the column labeled "Repeat Instance" of the Reports table
    And I should NOT see "My repeat event name"

            #FUNCTIONAL REQUIREMENT
            #User deletes repeatable event
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click the X to delete all data related to the event named "Event 2"
    And I click on the button labeled "Delete this instance of this event" in the dialog box

    Then I should see "successfully deleted entire event of data"
    And I should NOT see "(#2)"
#End