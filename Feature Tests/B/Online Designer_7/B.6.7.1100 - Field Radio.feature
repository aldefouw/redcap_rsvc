Feature: Field Creation: The system shall support the creation and manual coding for multiple choice radio buttons (single answer).

  As a REDCap end user
  I want to see that Project Designer is functioning as expected

  Scenario: B.6.7.1100.100 Creation of multiple choice radio buttons (single answer) through the Online Designer

        #SETUP
    Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named "B.6.7.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

        ##SETUP_PRODUCTION
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.1100.100"
    When I click on the button labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status: Production"

    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Radio field creation
    Given When I click on the instrument labeled "Form 1"
    And I click on the button labeled "Add Field" at the bottom of the instrument
    And I click on the dropdown field labeled "Select a Type of Field"
    And I add a new Multiple Choice - Radio Buttons (Single Answer) field labeled "Radio Button Manual" with the variable name "radio_button_manual"
    And I enter "9..9, Choice99" on the first row of the input field labeled "Choices (one choice per line)"
    And I enter "100, Choice100" on the second row of the input field labeled "Choices (one choice per line)"
    And I enter "101, Choice101" on the third row of the input field labeled "Choices (one choice per line)"
    And I enter "Abc123, Choice Abc123" on the fourth row of the input field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    Then I should see the field labeled "Radio Button Manual"
    And I should see the radio button options "Choice99","Choice100", "Choice101, Choice ABc123"

        ##SETUP_PRODUCTION
    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    When I click on the button labeled "Close" in the dialog box

        ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    And I click on the button labeled "Expand all instruments"
    Then I should see a table row containing the following values in the codebook table:
      | [radio_button_manual] | Radio Button Manual | radio |

        ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows including the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_admin | Manage/Design | Create project field                    |

  Scenario: B.6.7.1100.200 Creation of multiple choice radio buttons (single answer) through Data Dictionary upload (#CROSSFUNCTIONAL - B.6.7.100.100)

        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.1100.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Upload data dictionary
    When I click on the link labeled "Dictionary"
    And I click on the button labeled "Choose File"
    And I select the file labeled "Project1xml_DataDictionary.csv"
    And I click on the button labeled "Upload File"
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."

    When I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

        ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    And I click on the button labeled "Expand all instruments"
    Then I should see a table row containing the following values in the codebook table:
      | [radio_button_manual] | Radio Button Manual | radio |
#END