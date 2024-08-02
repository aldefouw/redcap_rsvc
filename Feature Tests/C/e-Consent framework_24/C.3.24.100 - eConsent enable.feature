Feature: Survey Settings: The system shall support the enabling/disabling of e-Consent framework. The framework categories are listed below: (Disabled | Auto-Archiver enabled |  Auto-Archiver + e-Consent Framework (includes end-of-survey certification & archival of PDF consent form))

  As a REDCap end user
  I want to see that eConsent is functioning as expected

  Scenario: C.3.24.100.100 Enable/Disable eConsent framework
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named " C.3.24.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: e-consent survey settings - disabled
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I select "Disabled" on the radio field labeled "e-Consent Framework"

    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    ##ACTION: add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 5."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    ##VERIFY
    Then I should see "Consent"
    And I should NOT see a checkbox labeled "I certify that all of my information in the document above is correct."
    When I click on the button labeled "Submit"

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 5"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 0 Files |
      | Recycle Bin        |               | 0 Files |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action            | List of Data Changes OR Fields Exported |
      | [survey respondent] | Update Response 5 | consent_complete = '2'                  |

    #FUNCTIONAL_REQUIREMENTauto-archive enabled
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I select "Auto-Archiver enabled" on the radio field labeled "e-Consent Framework"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    ##ACTION: add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 6."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    ##VERIFY
    Then I should see "Consent"
    And I should NOT see a checkbox labeled "I certify that all of my information in the document above is correct."
    But I should see a button labeled "Next Page"

    Given I click on the button labeled "Next Page"
    And I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 6"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 1 File  |
      | Recycle Bin        |               | 0 Files |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action            | List of Data Changes OR Fields Exported |
      | [survey respondent] | Update Response 6 | consent_complete = '2'                  |


    #FUNCTIONAL_REQUIREMENT
    ##ACTION: e-consent survey settings - auto-archive and e-consent
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I select "Auto-Archiver + e-Consent Framework" on the radio field labeled "e-Consent Framework"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    ##ACTION: add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 7."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label

    Then I should see "Consent"
    And I should NOT see a checkbox labeled "I certify that all of my information in the document above is correct."
    But I should see a button labeled "Next Page"

    Given I click on the button labeled "Next Page"
    And I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 7"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 2 Files |
      | Recycle Bin        |               | 0 Files |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see "This module lists all changes made to this project"
    And I should see a table header and rows containing the following values in the logging table:
      | Username            | Action            | List of Data Changes OR Fields Exported |
      | [survey respondent] | Update Response 7 | consent_complete = '2'                  |


