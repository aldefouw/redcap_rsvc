Feature: Saving Data: The system shall support the ability to: (Save and stay | Save and exit | Cancel the data entered and leave the record without saving)

  As a REDCap end user
  I want to see that saving data is functioning as expected

  Scenario: B.3.14.600.100 Save data options from data entry page
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
    And I create a new project named "B.3.14.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #SETUP create record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 7"

    #FUNCTIONAL_REQUIREMENT:
    ##ACTION: cancel data
    When I enter "CANCEL" into the data entry form field labeled "Name"
    And I click on the button labeled "Cancel"

    #MANUAL-ONLY step: Automated accepts confirmation windows because of default Cypress behavior
    #And I click on the button labeled "OK" in the pop-up box

    ##VERIFY
    Then I should see "Record ID 7 data entry cancelled - not saved"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should NOT see "Create record"

    #FUNCTIONAL_REQUIREMENT:
    ##ACTION: SAVE & STAY
    Given I click on the link labeled "Add / Edit Records"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 7"

    When I enter "SAVE & STAY" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    ##VERIFY
    Then I should see "Record ID 7 successfully edited."

    #SETUP create record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 8"

    #FUNCTIONAL_REQUIREMENT:
    ##ACTION  SAVE & Go To Next Form
    When I enter "SAVE & GO TO NEXT FORM" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Go To Next Form" on the Data Collection Instrument
    ##VERIFY
    Then I should see "Data Types"

    #SETUP create record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 9"

    #FUNCTIONAL_REQUIREMENT:
    ##ACTION Save & Exit Record
    When I enter "SAVE & EXIT RECORD" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument
    ##VERIFY
    Then I should see "Add / Edit Records"

    #SETUP create record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 10"

    When I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument
    Then I should see "Record ID 10 successfully edited"

    #FUNCTIONAL_REQUIREMENT:
    ##ACTION Save & Go To Next Record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 11"

    When I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument
    Then I should see "Record ID 11 successfully edited"

    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "10" and click on the bubble
    When I enter "SAVE & GO TO NEXT RECORD" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Go To Next Record" on the Data Collection Instrument
    ##VERIFY
    Then I should see "Record ID 10 successfully edited."
    And I should see "Now displaying the next record: Record ID 11"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action          | List of Data Changes OR Fields Exported |
      | test_user1 | Update record10 | name = 'SAVE & GO TO NEXT RECORD'       |
      | test_user1 | Create record9  | name = 'SAVE & EXIT RECORD'             |
      | test_user1 | Create record8  | name = 'SAVE & GO TO NEXT FORM'         |
      | test_user1 | Create record7  | name = 'SAVE & STAY'                    |

    ##VERIFY_DE:
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see "All data (all records and fields)"
    And I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Name                     |
      | 7         | Event 1 (Arm 1: Arm 1) | SAVE & STAY              |
      | 8         | Event 1 (Arm 1: Arm 1) | SAVE & GO TO NEXT FORM   |
      | 9         | Event 1 (Arm 1: Arm 1) | SAVE & EXIT RECORD       |
      | 10        | Event 1 (Arm 1: Arm 1) | SAVE & GO TO NEXT RECORD |
