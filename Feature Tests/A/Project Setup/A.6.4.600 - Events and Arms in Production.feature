Feature: A.6.4.600 Manage project creation, deletion, and settings. Control Center: The system shall support the option to limit adding or modifying events and arms while in production to administrators. Note: user can add instrument to event in production.

    As a REDCap end user
    I want to see that manage project is functioning as expected

    Scenario: A.6.4.600.100 User's ability to add or modify events and arms while in production mode
        #SETUP_CONTROL_CENTER
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        And I select "No, only Administrators can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        #SETUP_DEV
        When I create a new project named "A.6.4.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_USER
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        When I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
        Given I logout

        #FUNCTIONAL REQUIREMENT
        ##ACTION - User Adds new arm in Development mode
        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"

        Then I should see a link labeled "Add New Arm"

        When I click on the link labeled "Add New Arm"
        And I enter "Arm 3" into the input field labeled "Arm name:"
        And I click on the button labeled "Save"

        Then I should see "Arm name: Arm 3"

        When I add an event named "Event 1" with offset of 0 days into the currently selected arm

        Then I should see "Event 1" in the define events table

        ##VERIFY_LOG
        When I click on the link labeled "Logging"

        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported                                        |
            | test_user1 | Manage/Design | Create event (Event: Event 1, Arm: Arm 3, Days Offset: 0, Offset Range: -0/+0) |
            | test_user1 | Manage/Design | Create arm (Arm 3: Arm 3)                                                      |

        #FUNCTIONAL REQUIREMENT
        ##ACTION - User Rename Arm in Development mode
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm Two"
        And I click on the link labeled "Rename Arm 2"
        And I clear field and enter "Arm 2" into the input field labeled "Arm name"
        And I click on the button labeled "Save"

        Then I should see "Arm name: Arm 2"

        When I click on the Edit image for the event named "Event 1"
        #And I change the current Event Name from "Event 1" to "Event One"
        And I clear field and enter "Event One" into the input field labeled "1"
        And I click on the button labeled "Save"

        Then I should see "Event One"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"

        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported                                       |
            | test_user1 | Manage/Design | Edit event (Event: Event One, Arm: Arm 1, Days Offset: 1, Offset Range: -0/+0 |
            | test_user1 | Manage/Design | Edit arm name/number (Arm 2: Arm 2)                                           |

        #FUNCTIONAL REQUIREMENT
        ##ACTION - User Adds event with days offset in development mode
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 1"
        And I add an event named "Event 4" with offset of 4 days into the currently selected arm
        Then I should see "Event 4" in the define events table

        #VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "Arm 3: Arm 3"
        And I should see "Arm 2: Arm 2"

        When I click on the link labeled "Arm 2"
        Then I should see "Event One"

        When I click on the link labeled "Arm 1"
        Then I should see "Event 4"

        #FUNCTIONAL REQUIREMENT
        ##ACTION - User designates instruments in development mode
        Given I click on the link labeled "Project Setup"
        When I click on the button labeled "Designate Instruments for My Events"
        And I click on the link labeled "Arm 1"
        And I click on the button labeled "Begin Editing"
        And I disable the Data Collection Instrument named "Data Types" for the Event named "Event 1"
        And I enable the Data Collection Instrument named "Consent" for the Event named "Event 2"
        And I enable the Data Collection Instrument named "Text Validation" for the Event named "Event 4"
        And I click on the button labeled "Save" on the Designate Instruments for My Events page

        Then I verify the Data Collection Instrument named "Data Types" is disabled for the Event named "Event 1"
        And I verify the Data Collection Instrument named "Consent" is enabled for the Event named "Event 1"
        And I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 4"
        And I click on the button labeled "Save" on the Designate Instruments for My Events page

        When I click on the link labeled "Arm 3"
        And I click on the button labeled "Begin Editing"
        And I enable the Data Collection Instrument named "Consent" for the Event named "Event 1"
        And I click on the button labeled "Save" on the Designate Instruments for My Events page

        Then I verify the Data Collection Instrument named "Consent" is enabled for the Event named "Event 1"

        #VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 1"

        Then I should see a Data Collection Instrument named "Consent" for the Event named "Event 1"
        And I should see a Data Collection Instrument named "Text Validation" for the Event named "Event 1"

        When I click on the link labeled "Arm 3"
        Then I should see a Data Collection Instrument named "Consent" for the Event named "Event 1"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"

        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Perform instrument-event mappings       |

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION - User verifies no ability to modify events
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"

        Then I should see "Events cannot be modified in production"
        And I should NOT see a button labeled "Add new arm"
        And I should NOT see a button labeled "Add new event"

        When I click on the button labeled "Upload or download arms/events"

        Then I should see "Download arms (CSV)"
        And I should see "Download events (CSV)"
        And I should NOT see "Upload arms (CSV)"
        And I should NOT see "Upload events (CSV)"

        When I click on the button labeled "Designate Instruments for My Events"

        Then I should see "Events cannot be modified in production"
        And I should NOT see a button labeled "Begin Editing"

        When I click on the button labeled "Upload or download instrument mappings"

        Then I should see "Download instrument-event mappings (CSV)"
        And I should NOT see "Upload instrument-event mappings (CSV)"

        Given I logout

        #SETUP_CONTROL_CENTER
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        And I select "Yes, normal users can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
        And I click on the button labeled "Save Changes"

        Then I should see "Your system configuration values have now been changed!"

        Given I logout

        #FUNCTIONAL REQUIREMENT
        ##ACTION - User verifies has the ability to modify events

        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.600.100"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"

        Then I should see a link labeled "Add New Arm"
        And I should see a link labeled "Add new event"

        When I click on the link labeled "Add New Arm"
        And I enter "Arm 4" into the input field labeled "Arm name:"
        And I click on the button labeled "Save"
        And I add an event named "Event 1" with offset of 0 days into the currently selected arm

        Then I should see "Arm 4"
        And I should see "Event 1" in the define events table

        ##ACTION - User renames arms and events
        When I click on the link labeled "Arm 2"
        And I click on the link labeled "Rename Arm 2"

        Then I should see "Sorry, but arms can only be renamed by REDCap administrators"

        When I click on the button labeled "Close" in the dialog box

        Then I should see "Arm 2"

        When I click on the link labeled "Arm 2"
        hen I click on the Edit image for the event named "Event 1"

        Then I should see a dialog containing the following text: "Sorry, but events can only be renamed by REDCap administrators when a project is in production status"

        When I click on the button labeled "Close" in the dialog box

        #VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 1"

        Then I should see a link labeled "Arm 1"
        And I should see a link labeled "Event 2"
        And I should see a link labeled "Arm 2"
        And I should see a link labeled "Arm 4"

        ##ACTION - User unable to undesignated events
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 1"
        And I click on the button labeled "Begin Editing"

        Then I should see "only REDCap administrators are allowed to uncheck any instruments that are already designated"

        When I verify the Data Collection Instrument named "Data Types" is unmodifiable for the Event named "Event One"

        ##ACTION - User unable to Upload designated instruments
        When I click on the button labeled "Upload or download instrument mappings"
        And I click on the link labeled "Upload instrument-event mappings (CSV)"
        And I upload a "csv" format file located at "import_files/instrument_designation.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file

        Then I should see a dialog containing the following text: "ERROR"
        And I click on the button labeled "Close" in the dialog box

        ##ACTION -  User designates instruments in production mode
        Given I click on the link labeled "Arm 1"
        And I click on the button labeled "Begin Editing"
        When I enable the Data Collection Instrument named "Data Types" for the Event named "Event 4"
        And I click on the button labeled "Save" on the Designate Instruments for My Events page

        Then I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 4"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"

        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Perform instrument-event mappings       |

        Given I logout

        #FUNCTIONAL REQUIREMENT
        ##ACTION - Admin Renames arms and events
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 1"
        Then I should see "Rename Arm 1"

        When I click on the link labeled "Rename Arm 1"
        And I clear field and enter "Arm One" into the input field labeled "Arm name"
        And I click on the button labeled "Save"
        And I click on the Edit image for the event named "Event 4"
        And I change the current Event Name from "Event 4" to "Event Four"
        And I click on the button labeled "Save" on the Designate Instruments for My Events page

        Then I should see "Arm name: Arm One"
        And I should see "Event Four"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"

        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Edit event                              |
            | test_admin | Manage/Design | Event Four, Arm: Arm One                |
            | test_admin | Manage/Design | Edit arm name/number                    |
            | test_admin | Manage/Design | Arm 1: Arm One                          |
            #End