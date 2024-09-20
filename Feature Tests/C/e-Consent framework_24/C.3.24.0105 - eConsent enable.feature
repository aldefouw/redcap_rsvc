Feature: User Interface: The system shall support the enabling of the e-Consent Framework with an active/inactive status.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0105.100 The system shall support the enabling of the e-Consent Framework with an active/inactive status.

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0105.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project Status: Production"

    #FUNCTIONAL_REQUIREMENT
    Scenario: ##ACTION: e-consent survey settings - disabled
        When I click on the button labeled "Designer"
        And I click on the button labeled "e-Consent and PDF Snapshots"
        Then I should see "Hide inactive" is "Enabled"
        And I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

        When I "Disable" the "Hide inactive"
        And I "Inactive" the e-consent framework for survey labeled "Participant Consent"
        And I click on the button labeled "Set as inactive"
        Then I should see the e-consent framework for survey labeled "Participant Consent" is "Inactive"

        When I "Enable" the "Hide inactive"
        Then I should NOT see the e-consent framework for survey labeled "Participant Consent" is "Inactive"

    ##ACTION: add record to get participant signature
    Scenario: Add record to get participant signature
        When I click on the link labeled "Add/Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Adding new Record ID 1"

        When I click on the button labeled "Save & Stay"
        And I click on the button labeled "Okay" in the dialog box
        And I select the dropdown option labeled "Open survey" from the dropdown button "Survey options"
        And I enter "FirstName" in the field labeled "First Name"
        And I enter "LastName" in the field labeled "Last Name"
        And I enter "email@test.edu" in the field labeled "Email"
        And I enter "01-01-2000" in the field labeled "DOB"
        And I enter "MyName" in the field labeled "Participant's Name Typed"
        And I enter a signature in the field labeled "Participant signature field"
        And I click "Submit"
        Then I should see "Close survey"

        When I click on the button labeled "Close survey"
        And I click on the button labeled "Leave without saving changes" in the dialog box
        ##VERIFY_RSD
        Then I should see "Record Home Page"
        And I should see "Completed Survey Response" icon for the bubble labeled "Participant Consent" for event "Event 1"

        ##VERIFY_PDF Snapshot Specific File Location
        When I click on the bubble labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"
        Then I should see ".pdf" in the field labeled "Participant Consent file"

        ##VERIFY_FiRe
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows including the following values in the file repository table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             |
            | .pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |

        ##VERIFY_Logging
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username            | Action                                     | List of Data Changes OR Fields Exported                                           |
            | [survey respondent] | Save PDF Snapshot 1                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" |
            | [survey respondent] | Update Response 1 (Event 1 (Arm 1: Arm 1)) | participant_file =                                                                |
            | [survey respondent] | Save PDF Snapshot 1                        | Save PDF Snapshot to File Repository record = "1"                                 |

    ##ACTION: e-consent survey settings - enable
    Scenario: Enable e-Consent
        When I click on the button labeled "Designer"
        And I click on the button labeled "e-Consent and PDF Snapshots"
        When I "Enable" the "Hide inactive"
        And I "Active" the e-consent framework for survey labeled "Participant Consent"
        Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"


    ##ACTION: add record to get participant signature
    Scenario: Add record to get participant signature
        When I click on the link labeled "Add/Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click on the bubble labeled "Participant Consent" for event "Event 1"
        Then I should see "Adding new Record ID 2"
        And I should see "Consent File"

        When I click on the button labeled "Save & Stay"
        And I click on the button labeled "Okay" in the dialog box
        And I select the dropdown option labeled "Open survey" from the dropdown button "Survey options"
        And I enter "FirstName" in the field labeled "First Name"
        And I enter "LastName" in the field labeled "Last Name"
        And I enter "email@test.edu" in the field labeled "Email"
        And I enter "01-01-2000" in the field labeled "DOB"
        And I enter "MyName" in the field labeled "Participant's Name Typed"
        And I enter a signature in the field labeled "Participant signature field"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see a inline PDF of "Participant Consent"
        And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I click on the button labeled "Leave without saving changes" in the dialog box
        ##VERIFY_RSD
        Then I should see "Record Home Page"
        And I should see "Completed Survey Response" icon for the bubble labeled "Participant Consent" for event "Event 1"

        ##VERIFY_PDF Snapshot Specific File Location
        When I click on the bubble labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"
        Then I should see ".pdf" in the field labeled "Participant Consent file"

        ##VERIFY_FiRe
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows including the following values in the file repository table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             |
            | .pdf | icon                             | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |
            | .pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |

        When I click on the link labeled "PDF Survey Archive"
        And I click on the link on the PDF link for record "2"
        Then I should have a pdf file with the following values in the header: "PID xxxx - LastName"
        And I should have a pdf file with the following values in the footer: "Type: Participant"
    #Manual: Close document

    ##VERIFY_Logging
    Scenario: e-Consent Framework used, and PDF Snapshot is used
        ##e-Consent Framework used, and PDF Snapshot is used
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username            | Action                                     | List of Data Changes OR Fields Exported                                           |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" |
            | [survey respondent] | Update Response 2 (Event 1 (Arm 1: Arm 1)) | participant_file =                                                                |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Repository record = "2"                                 |
#END