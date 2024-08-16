Feature: User Interface: The e-Consent framework shall support editing of responses by users.

  As a REDCap end user
  I want to see that eConsent is functioning as expected

  Scenario: C.3.24.600.100 Enable/disable edit ability for e-Consent framework
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named " C.3.24.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

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
    Then I should see "Adding new Record ID 5."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    And I clear field and enter "Consent Name" into the data entry form field labeled "Name"
    And I click on the button labeled "Next Page"
    Then I should see a checkbox labeled "I certify that all of my information in the document above is correct." that is unchecked

    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 5"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action            | List of Data Changes OR Fields Exported |
      | [survey respondent] | Update Response 5 | consent_complete = '2'                  |
      | [survey respondent] | Update Response 5 | name_consent = 'Consent Name'           |

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 1 File  |
      | Recycle Bin        |               | 0 Files |

    Given I click on the link labeled "PDF Survey Archive" in the File Repository table
    When I download the PDF by clicking on the link for Record "5" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "5" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | 1)Name | Consent Name |
    #M: Close document

    ##ACTION: edit survey response
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "5" and click on the bubble
    And I click on the button labeled "Edit response"
    Then I should see "Survey response is editable"
    And I should see "(now editing)"

    When I clear field and enter "Consent 2 Name" into the input field labeled "Name"
    When I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 5 successfully edited."

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action          | List of Data Changes OR Fields Exported |
      | test_admin | Update record 5 | name_consent = 'Consent 2 Name'         |

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 1 File  |
      | Recycle Bin        |               | 0 Files |

    #The PDF stays the same as before; eConsent changes only apply when you fill out via survey
    Given I click on the link labeled "PDF Survey Archive" in the File Repository table
    When I download the PDF by clicking on the link for Record "5" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "5" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | 1)Name | Consent Name |

    #M: Close document

    ##ACTION: disable e-consent survey settings - auto-archive and e-consent
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I uncheck the checkbox labeled "Allow e-Consent responses to be edited by users?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    ##VERIFY: cannot edit survey response
    When I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "5" and click on the bubble
    Then I should see "Survey response is read-only because it was completed via the e-Consent Framework."

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    And I should see "This module lists all changes made to this project"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_admin | Manage/Design | Modify survey info                      |

