Feature: User Interface: The system shall support the enabling of the e-Consent Framework with an active/inactive status.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0105.100 The system shall support the enabling of the e-Consent Framework with an active/inactive status.

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0105.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

    #FUNCTIONAL_REQUIREMENT
    Scenario: ##ACTION: e-consent survey settings - disabled
        When I click on the button labeled "Designer"
        And I click on the button labeled "e-Consent"
        Then I should see a checkbox labeled "Hide inactive" that is checked

        And  I check the checkbox labeled "Participant Consent"
        And  I should see a checkbox labeled "Participant Consent" that is checked
        #And I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

        When I uncheck the checkbox labeled "Hide inactive"

        Given  I uncheck the checkbox labeled "Participant Consent"
        #And I "Inactive" the e-consent framework for survey labeled "Participant Consent"
        And I click on the button labeled "Set as inactive" in the dialog box
        Then I should see 'e-Consent has been successfully disabled for survey "participant_consent"'
        And I should see a checkbox labeled "Participant Consent" that is unchecked
        #Then I should see the e-consent framework for survey labeled "Participant Consent" is "Inactive"

        When I check the checkbox labeled "Hide inactive"
        Then I should NOT see a checkbox labeled "Participant Consent"

    ##ACTION: add record to get participant signature
    Scenario: Add record to get participant signature
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 1"

        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options" and will leave the tab open when I return to the REDCap project
        And I click on the survey option label containing "Open survey" label
        And I clear field and enter "FirstName" into the data entry form field labeled "First Name"
        And I clear field and enter "LastName" into the data entry form field labeled "Last Name"
        And I clear field and enter "email@test.edu" into the data entry form field labeled "email"
        And I clear field and enter "2000-01-01" into the data entry form field labeled "Date of Birth"
        And I clear field and enter "MyName" into the data entry form field labeled "Participant's Name Typed"

        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        And I click on the button labeled "Submit"

        Then I should see "Close survey"
        When I click on the button labeled "Close survey"

        ##VERIFY_RSD
        Given I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" instrument on event "Event 1" for record "1"

        ##VERIFY_PDF Snapshot Specific File Location
        And I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "1" and click on the bubble
        #This currently does not work - not sure if bug or intended behavior ?
        #Then I should see ".pdf" in the field labeled "Participant Consent file"

        ##VERIFY_FiRe
        ##e-Consent Framework not used, and PDF Snapshot is used
#        When I click on the link labeled "File Repository"
#        Then I should see a table header and rows containing the following values in the file repository table:
#            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             |
#            | .pdf | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |

        ##VERIFY_Logging
        ##e-Consent Framework not used, and PDF Snapshot is used
#        When I click on the link labeled "Logging"
#        Then I should see a table header and rows containing the following values in the logging table:
#            | Username            | Action                                     | List of Data Changes OR Fields Exported                                           |
#            | [survey respondent] | Save PDF Snapshot 1                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" |
#            | [survey respondent] | Update Response 1 (Event 1 (Arm 1: Arm 1)) | participant_file =                                                                |
#            | [survey respondent] | Save PDF Snapshot 1                        | Save PDF Snapshot to File Repository record = "1"                                 |

    ##ACTION: e-consent survey settings - enable
    Scenario: Enable e-Consent
        Then I should see a link labeled "Designer"
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        When I uncheck the checkbox labeled "Hide inactive"
        And  I check the checkbox labeled "Participant Consent"
        And  I should see a checkbox labeled "Participant Consent" that is checked
#        And I should see the e-consent framework for survey labeled "Participant Consent" is "Active"

    ##ACTION: add record to get participant signature
    Scenario: Add record to get participant signature
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 2"
        And I should see a field labeled "Consent file"

        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options" and will leave the tab open when I return to the REDCap project
        And I click on the survey option label containing "Open survey" label
        And I clear field and enter "FirstName" into the data entry form field labeled "First Name"
        And I clear field and enter "LastName" into the data entry form field labeled "Last Name"
        And I clear field and enter "email@test.edu" into the data entry form field labeled "email"
        And I clear field and enter "2000-01-01" into the data entry form field labeled "Date of Birth"
        And I clear field and enter "MyName" into the data entry form field labeled "Participant's Name Typed"

        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."

        #ATS: Looks like step definition needed for PDF:
        #And I should see a inline PDF of "Participant Consent"
        #And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct"

        When I check the checkbox labeled "I certify that all of my information in the document above is correct"
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."
        And I click on the button labeled "Close survey"

        ##VERIFY_RSD
        Given I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" instrument on event "Event 1" for record "1"

        ##VERIFY_PDF Snapshot Specific File Location
        And I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "2" and click on the bubble
        Then I should see a link labeled ".pdf"

        ##VERIFY_FiRe
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "File Repository"
        ##VERIFY file uploaded in folder
#        Then I should see a table header and rows containing the following values in the file repository table:
#            | PDF Snapshot Archive           | 1 File  |               |
#            | Miscellaneous File Attachments | 0 Files |               |
#            | Recycle Bin                    | 0 Files |               |

        Then I should see a link labeled "PDF Snapshot Archive"
        Given I click on the link labeled "PDF Snapshot Archive"
        Then I should see "PDF Snapshot Archive"

        #Manual: Note that the PID prefix will not likely be PID 13 in any environments except automated
        Then I should see a table header and rows containing the following values in a table:
            | Name                             | Record | Survey Completed                             |
            | pid13_formParticipantConsent_id2 | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |

#        When I click on the link labeled "PDF Survey Archive"
        And I download the PDF by clicking on the link for Record "2" and Survey "Participant Consent" in the File Repository table
        And I should see the following values in the downloaded PDF for Record "2" and Survey "Participant Consent"
            | PID 13 - LastName   |
            | Participant Consent |

    #Manual: Close document

    ##VERIFY_Logging
    Scenario: e-Consent Framework used, and PDF Snapshot is used
        ##e-Consent Framework used, and PDF Snapshot is used
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action                                     | List of Data Changes OR Fields Exported    |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field     |
            | [survey respondent] | Save PDF Snapshot 2                        | record = "2"                               |
            | [survey respondent] | Save PDF Snapshot 2                        | field = "participant_file (event_1_arm_1)" |
            | [survey respondent] | Update Response 2 (Event 1 (Arm 1: Arm 1)) | participant_file = '8'                     |

#END