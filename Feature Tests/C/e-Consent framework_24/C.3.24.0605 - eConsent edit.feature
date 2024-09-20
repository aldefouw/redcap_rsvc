Feature: User Interface: The e-Consent framework shall support editing of responses by users.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0605.100 Enable/disable edit ability for e-Consent framework

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0605.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24ConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project Status: Production"


    Scenario: #SETUP_eConsent to NOT allow for edit by users
        ##SETUP Allow e-Consent responses to be edited by users?
        When I click on the button labeled "Designer"
        And I click on the button labeled "e-Consent and PDF Snapshots"
        Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

        When I edit "Participant Consent"
        When I uncheck "Allow e-Consent responses to be edited by users?"
        And I select "part_sign Particiant signature" for the field labeled "Signature field #1"
        And I check "Save to a specific field"
        And I select "participant_file" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "select a File Upload field" in the dialog box
        And I click the button labeled "Save settings"
        Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
        Then I should see a table header and rows including the following values in the e-Consent Framework table:
            | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot | Custom tag/category | Notes |
            | Active            | "Participant Consent" (participant_consent) | File Repository                                 |                     |       |

    Scenario: add record with consent framework
        ##ACTION: add record with consent framework
        When I click on the link labeled "Add/Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Adding new Record ID 1."

        When I click on the button labeled "Save & Stay"
        And I click on the button labeled "Okay" in the dialog box
        And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
        Then I should see "Participant Consent"

        When I enter "FirstName" in the field labeled "Name"
        And I enter "LastName" in the field labeled "Name"
        And I enter "email@test.edu" in the field labeled "Email"
        And I enter "2000-01-01" in the field labeled "DOB"
        And I enter the "MyName" in the field labeled "Participant’s Name Typed"
        And I enter a signature in the field labeled "Participant signature field"
        And I click "Save signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."
        And I should see the button labeled "Submit" is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        Then I should see the button labeled "Submit" is enabled

        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I click on the button labeled "Leave without saving changes" in the dialog box
        Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

    Scenario: User unable to edit consent
        ##ACTION: User unable to edit consent
        When I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Survey response is read-only because it was completed via the e-Consent Framework."

    Scenario: #SETUP_eConsent to allow for edit by users
        ##SETUP Allow e-Consent responses to be edited by users?
        When I click on the button labeled "Designer"
        And I click on the button labeled "e-Consent and PDF Snapshots"
        Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

        When I edit "Participant Consent"
        When I check "Allow e-Consent responses to be edited by users?"
        And I select "part_sign Particiant signature" for the field labeled "Signature field #1"
        And I check "Save to a specific field"
        And I select "participant_file" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "select a File Upload field" in the dialog box
        And I click the button labeled "Save settings"
        Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
        Then I should see a table header and rows including the following values in the e-Consent Framework table:
            | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot | Custom tag/category | Notes |
            | Active            | "Participant Consent" (participant_consent) | File Repository                                 |                     |       |

    Scenario: add record with consent framework
        ##ACTION: add record with consent framework
        When I click on the link labeled "Add/Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Adding new Record ID 2."

        When I click on the button labeled "Save & Stay"
        And I click on the button labeled "Okay" in the dialog box
        And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
        Then I should see "Participant Consent"

        When I enter "FirstName" in the field labeled "Name"
        And I enter "LastName" in the field labeled "Name"
        And I enter "email@test.edu" in the field labeled "Email"
        And I enter "2000-01-01" in the field labeled "DOB"
        And I enter the "MyName" in the field labeled "Participant’s Name Typed"
        And I enter a signature in the field labeled "Participant signature field"
        And I click "Save signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."
        And I should see the button labeled "Submit" is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        Then I should see the button labeled "Submit" is enabled

        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I click on the button labeled "Leave without saving changes" in the dialog box
        Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

    Scenario: Test ability to for user to edit a completed consent
        ##ACTION: Test ability to for user to edit a completed consent
        When I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Survey response is editable"

        When I click the bubble labeled "Edit response"
        Then I should see "Survey response is editable (now editing)"

        When I enter "NewFirstName" in the field labeled "First Name"
        And I click on the button "Save & Exit Form"
        Then I should see "Record ID 2"
        Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

        When I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Survey response is editable"
        And I should see "NewFirstName" in the field labeled "First Name"


    Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type      |
            | .pdf | YES                              | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) | 2000-01-01             |         | e-Consent |
            | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | 2000-01-01             |         | e-Consent |


        When I click on the file link for record "1" Survey "Participant Consent (Event 1 (Arm 1: Arm 1))"
        Then I should have a pdf file with "FirstName" in the field labeled "First Name"

        When I click on the file link for record "2" Survey "Participant Consent (Event 1 (Arm 1: Arm 1))"
        Then I should have a pdf file with "FirstName" in the field labeled "First Name"
        #NOTE: Edited version with "NewFirstName" is NOT in the file repository.
        #M: Close document

        ##VERIFY_Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username            | Action                                     | List of Data Changes OR Fields Exported                                                                                                                    |
            | test_admin          | Update Response 2 (Event 1 (Arm 1: Arm 1)) | first_name = 'NewFirstName'                                                                                                                                |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument = "participant_consent"  |
            | [survey respondent] | e-Consent Certification 2                  | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_1" instrument = "participant_consent" |
            | [survey respondent] | Update Response 2 (Event 1 (Arm 1: Arm 1)) | first_name = 'FirstName', type_sign1 = 'MyName'                                                                                                            |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent"  |
            | [survey respondent] | e-Consent Certification 1                  | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent"                                                           |
            | [survey respondent] | Update Response 1 (Event 1 (Arm 1: Arm 1)) | first_name = 'FirstName', type_sign1 = 'MyName'                                                                                                            |
#END