Feature: User Interface: The system shall support branching logic for data entry forms.

  As a REDCap end user
  I want to see that Branching Logic is functioning as expected

  Scenario: B.4.9.100.100 Branching Logic
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.4.9.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.9.xml", and clicking the "Create Project" button

    ##VERIFY: Branching logic
    When I click on the link labeled "Designer"
    And I click on the instrument labeled "Data Types"
    Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "ptname"
    Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "textbox"
    Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "text2"
    Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "notesbox"

    #FUNCTIONAL_REQUIREMENT: survey mode
    When I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Then I should NOT see the field labeled "Name"
    And I should NOT see the field labeled "Text2"
    And I should NOT see the field labeled "Text box"
    And I should NOT see the field labeled "Notes box"
    And I should see the field labeled "Calculated Field"
    And I should see the field labeled "Multiple Choice dropdown Auto"
    And I should see the field labeled "Multiple Choice Dropdown Manual"
    #M: Close the survey page

    #FUNCTIONAL_REQUIREMENT: data entry mode
    Given I return to the REDCap page I opened the survey from
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"

    #MANUAL: These confirmation windows are automatically accepted on automated side
    Then I should see an alert box with the following text: 'ERASE THE VALUE OF THE FIELD "ptname" ?'
    #And I click the button labeled "OK" in the alert box
    Then I should see an alert box with the following text: 'ERASE THE VALUE OF THE FIELD "textbox" ?'
    #And I click the button labeled "OK" in the alert box
    Then I should see an alert box with the following text: 'ERASE THE VALUE OF THE FIELD "text2" ?'
    #And I click the button labeled "OK" in the alert box
    Then I should see an alert box with the following text: 'ERASE THE VALUE OF THE FIELD "notesbox" ?'
    #And I click the button labeled "OK" in the alert box

    Then I should NOT see the field labeled "Name"
    And I should NOT see the field labeled "Text2"
    And I should NOT see the field labeled "Text box"
    And I should NOT see the field labeled "Notes box"
    And I should see the field labeled "Calculated Field"
    And I should see the field labeled "Multiple Choice dropdown Auto"
    And I should see the field labeled "Multiple Choice Dropdown Manual"

    ##ACTION: change branching logic
    When I click on the link labeled "Designer"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    And I click on the instrument labeled "Data Types"
    And I click on the Branching Logic icon for the variable "ptname"
    And I click on "[record_id] = '999'" in the textarea field labeled "Advanced Branching Logic Syntax" in the dialog box
    And I clear field and enter "[record_id] <> '999'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save" in the dialog box
    Then I should see a dialog containing the following text: "Also edit Branching Logic for OTHER fields?"
    And I click on the button labeled "No" in the dialog box
    Then I should see "Branching logic: [record_id] <> '999'" within the field with variable name "ptname"

    ##ACTION: change branching logic
    When I click on the Branching Logic icon for the variable "text2"
    And I click on "[record_id] = '999'" in the textarea field labeled "Advanced Branching Logic Syntax" in the dialog box
    And I clear field and enter "[record_id] <> '999'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save" in the dialog box
    Then I should see a dialog containing the following text: "Also edit Branching Logic for OTHER fields?"
    And I click on the button labeled "Yes" in the dialog box
    Then I should see "Branching logic: [record_id] <> '999'" within the field with variable name "text2"

    #FUNCTIONAL_REQUIREMENT: survey mode
    When I click on the link labeled "Survey Distribution Tools"
    When I click on the button labeled "Open public survey" and will leave the tab open when I return to the REDCap project
    Then I should see "Please complete the survey below."
    And I should see the field labeled "Name"
    And I should see the field labeled "Text2"
    And I should see the field labeled "Text box"
    And I should see the field labeled "Notes box"
    And I should see the field labeled "Calculated Field"
    And I should see the field labeled "Multiple Choice dropdown Auto"
    And I should see the field labeled "Multiple Choice Dropdown Manual"
    #M: Close tab

    #FUNCTIONAL_REQUIREMENT: data entry mode
    Given I return to the REDCap page I opened the survey from
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see the field labeled "Name"
    And I should see the field labeled "Text2"
    And I should see the field labeled "Text box"
    And I should see the field labeled "Notes box"
    And I should see the field labeled "Calculated Field"
    And I should see the field labeled "Multiple Choice dropdown Auto"
    And I should see the field labeled "Multiple Choice Dropdown Manual"

    ##ACTION
    When I click on the link labeled "Designer"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    And I click on the instrument labeled "Data Types"
    And I click on the Branching Logic icon for the variable "descriptive_text_file"
    And I click on the radio labeled exactly "Drag-N-Drop Logic Builder" in the dialog box
    Then I should see "Displaying field choices for the following data collection instrument" in the dialog box

    Given I drag the field choice labeled "radio_button_manual = Choice101 (101)" to the box labeled "Show the field ONLY if..."
    And I click on the button labeled "Save" in the Add/Edit Branching Logic dialog box
    Then I should see "Branching logic: [radio_button_manual] = '101'" within the field with variable name "descriptive_text_file"

    Given I click on the Branching Logic icon for the variable "required"
    And I click on the radio labeled exactly "Drag-N-Drop Logic Builder" in the dialog box
    Then I should see "Displaying field choices for the following data collection instrument" in the dialog box

    Given I drag the field choice labeled "checkbox = Checkbox3 (3)" to the box labeled "Show the field ONLY if..."
    And I click on the button labeled "Save" in the Add/Edit Branching Logic dialog box
    Then I should see "Branching logic: [checkbox(3)] = '1'" within the field with variable name "required"

    #FUNCTIONAL_REQUIREMENT: survey mode
    When I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    And I select the radio option "Choice101" for the field labeled "Radio Button Manual"
    Then I should see the field labeled "Descriptive Text with File"

    When I select the radio option "Choice99" for the field labeled "Radio Button Manual"
    Then I should NOT see the field labeled "Descriptive Text with File"

    When I check the checkbox labeled "Checkbox3"
    Then I should see the field labeled "Required"

    When I uncheck the checkbox labeled "Checkbox3"
    Then I should NOT see the field labeled "Required"
    #M: Close the survey page

    ##VERIFY_LOG
    Given I return to the REDCap page I opened the survey from
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Add/edit branching logic                |


