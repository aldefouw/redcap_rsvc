Feature: User Interface: The system shall support the e-Consent Framework for repeatable instruments and repeatable events.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0805.100 e-Consent framework & Repeatable instruments/events
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0805.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24ConsentWithSetup.xml", and clicking the "Create Project" button

        #Verify Longitudinal
        And I click on the button labeled "Enable" on the field labeled "Use longitudinal data collection with defined events?"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 1"
        Then I should see a table header and rows including the following values in the Define My Events table:
            | Event # [event-number] | Days Offset | Offset Range Min / Max | Event Label [event-label] | Custom Event Label | Unique event name  (auto-generated) [event-name] |
            | 1                      | 1           | -0/+0                  | Event 1                   |                    | event_1_arm_1                                    |
            | 2                      | 2           | -0/+0                  | Event 2                   |                    | event_2_arm_1                                    |
            | 3                      | 3           | -0/+0                  | Event Three               |                    | event_three_arm_1                                |

        When I click on the link labeled "Arm 2"
        And I click on the link labeled "Arm 1"
        Then I should see a table header and rows including the following values in the Define My Events table:
            | Event # [event-number] | Days Offset | Offset Range Min / Max | Event Label [event-label] | Custom Event Label | Unique event name  (auto-generated) [event-name] |
            | 1                      | 1           | -0/+0                  | Event 1                   |                    | event_1_arm_2                                    |

        And I click on the button labeled "Designate Instruments for My Events"
        And I click on the link labeled "Arm 1"
        Then I should see a table header and rows including the following values in the Designate Instruments table:
            | Data Collection Instrument       | Event 1 (1) | Event 2 (2) | Event Three (3) |
            | Participant Consent(survey)      | Check       |             | Check           |
            | Coordinator Signature(survey)    | Check       |             | Check           |
            | Pdfs And Combined Signatures Pdf | Check       |             | Check           |

        And I click on the link labeled "Arm Two"
        And I click on the button labeled "Begin Editing"
        And I enable the Data Collection Instrument named "Participant Consent" for the Event named "Event 1"
        And I click on the button labeled "Save"
        Then I should see a table header and rows including the following values in the Designate Instruments table:
            | Data Collection Instrument  | Event 1 (1) |
            | Participant Consent(survey) | Check       |

        #Verify Repeatable
        When I click on the button labeled "Project Setup"
        And I click on the button labeled "Modify" on the field labeled  "Repeating instruments and events"
        And I select "Repeat Entire Event" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
        And I select "Repeat Instruments" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
        And I check the checkbox labeled "Participant Consent"
        And I select "Repeat Entire Event" on the dropdown field labeled "Event 1 (Arm 2: Arm Two)"
        And I click on the button labeled "Save"
        Then I should see "Successfully saved"
        And I click on the button labeled "Close" in the dialog box

        #SETUP_PRODUCTION
        When I click on the button labeled "Project Setup"

        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project Status: Production"

    Scenario: add record with consent framework
        ##ACTION: add record with consent framework in Arm 1 Event 1  (repeatable event)
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

    Scenario:   add instance 2 for record with consent framework in Arm 1 Event 1  (repeatable event)
        ##ACTION: add instance 2 for record with consent framework in Arm 1 Event 1  (repeatable event)
        When I click on the button labeled "Add New" for event "Event 1"
        And I click on the bubble labeled "Participant Consent" for event "Event 1" instance "2"


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
        Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" instance "2"
        And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" instance "1"

    Scenario: add instance 1 for record with consent framework in Arm 1 Event Three  (repeatable instance)
        ##ACTION: add instance 1 for record with consent framework in Arm 1 Event Three  (repeatable instance)
        When I click on the bubble labeled "Participant Consent" for event "Event Three"
        And I click on the button labeled "Save & Stay"
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
        Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event Three"

    Scenario: add instance 2 for record with consent framework in Arm 1 Event Three  (repeatable instance)
        ##ACTION: add instance 2 for record with consent framework in Arm 1 Event Three  (repeatable instance)
        When I click on the button labled "Add a New Instance" for the bubble labeled "Participant Consent" for event "Event Three"
        And I click on the button labeled "Save & Stay"
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
        Then I should see a Many Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event Three"


    Scenario: add record in arm 2 with consent framework
        ##ACTION: add record with consent framework in Arm 1 Event 1  (repeatable event)
        When I click on the link labeled "Add/Edit Records"
        And I select the dropdown option labeled "Arm 2: Arm Two" from the dropdown button labeld "Choose an existing Record ID"
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

    Scenario:   add instance 2 for record with consent framework in Arm 2 Event 1  (repeatable event)
        ##ACTION: add instance 2 for record with consent framework in Arm 1 Event 1  (repeatable event)
        When I click on the button labeled "Add New" for event "Event 1"
        And I click on the bubble labeled "Participant Consent" for event "Event 1" instance "2"


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
        Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" instance "2"
        And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" instance "1"

    Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                                    | Identifier (Name, DOB) | Version | Type      |
            | .pdf | YES                              | 2      | Participant Consent (Event 1 (Arm 2: Arm Two)) #2   |                        | 1.0     | e-Consent |
            | .pdf | YES                              | 2      | Participant Consent (Event 1 (Arm 2: Arm Two)) #1   |                        | 1.0     | e-Consent |
            | .pdf | YES                              | 1      | Participant Consent (Event Three (Arm 1: Arm 1)) #2 | 2000-01-01             | 1.0     | e-Consent |
            | .pdf | YES                              | 1      | Participant Consent (Event Three (Arm 1: Arm 1)) #1 | 2000-01-01             | 1.0     | e-Consent |
            | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) #2     | 2000-01-01             | 1.0     | e-Consent |
            | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) #1     | 2000-01-01             | 1.0     | e-Consent |

        ##VERIFY_Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username            | Action                    | List of Data Changes OR Fields Exported                                                                                                                                       |
            | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_2)" record = "2" event = "event_1_arm_2" instrument = "participant_consent" instance = "2" |
            | [survey respondent] | e-Consent Certification 2 | e-Consent Certification record = "2" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_2" instrument = "participant_consent" instance = "2"     |
            | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_2)" record = "2" event = "event_1_arm_2" instrument = "participant_consent" instance = "1" |
            | [survey respondent] | e-Consent Certification 2 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_2" instrument = "participant_consent" instance = "1"     |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_three_arm_1)" record = "1" event = "event_three_arm_1" instrument = "participant_consent" instance = "2" |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_three_arm_1" instrument = "participant_consent" instance = "2" |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_three_arm_1)" record = "1" event = "event_three_arm_1" instrument = "participant_consent" instance = "1" |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_three_arm_1" instrument = "participant_consent" instance = "1" |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" instance = "2" |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_1" instrument = "participant_consent" instance = "2"     |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" instance = "1" |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_1" instrument = "participant_consent" instance = "1"     |
#END