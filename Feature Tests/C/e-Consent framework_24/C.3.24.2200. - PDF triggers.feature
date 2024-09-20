Feature: User Interface: The system shall support the creation, modification, and copying of custom triggers for PDF snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2200.100 creation, modification, and copying of custom triggers for PDF snapshots.

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the button labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project Status: Production"

      When I click on the button lanbeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshot"

   Scenario: Cancel New PDF Trigger
      ##ACTION: New PDF Trigger
      When I click on the button labeled "PDF Snapshots of Record"
      And I click the button "+Add new trigger"
      And I click "Cancel"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name | Type of trigger | Save snapshot when... | Scope of the snapshot | Location(s) to save the snapshot |

   Scenario: New PDF Trigger for survey completion all instruments
      ##ACTION: New PDF Trigger
      When I click on the button labeled "PDF Snapshots of Record"
      And I click the button "+Add new trigger"
      And I enter "Custom Dropdown 1 Form Snapshot" in the box labeled "Name of trigger"
      And I select "'Participant Consent' - [Any EVENT]" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Check" the box labeled "Save to specified field:"
      And I select "participant_file" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "select a File Upload field" in the dialog box
      And I enter "Custom" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Cancel Copy trigger
      ##ACTION: Cancel Copy trigger
      When I click on the button labeled "Copy trigger" for the trigger labeled "Custom Dropdown 1 Form Snapshot"
      Then I should see "Do you wish to copy this PDF Snapshot Trigger?"

      When I click on the button labeled "Cancel"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Copy trigger
      ##ACTION: Copy trigger
      When I click on the button labeled "Copy trigger" for the trigger labeled "Custom Dropdown 1 Form Snapshot"
      Then I should see "Do you wish to copy this PDF Snapshot Trigger?"

      When I click on the button labeled "Copy trigger"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Cancel Edit trigger
      ##ACTION: Cancel Edit trigger
      When I click on the button labeled "Edit trigger" for the trigger labeled "Custom Dropdown 1 Form Snapshot"
      Then I should see "Custom Dropdown 1 Form Snapshot" in the field labeled "Name of trigger:"

      When I click on the button labeled "Cancel"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Edit trigger with Logic-based and selected instruments
      ##ACTION: Edit trigger
      When I click on the button labeled "Edit trigger" for the trigger labeled "Custom Dropdown 1 Form Snapshot"
      Then I should see "Custom Dropdown 1 Form Snapshot" in the field labeled "Name of trigger:"

      When I enter "Edit trigger name" in the box labeled "Name of trigger"
      And I select "--- select a survey ---" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "[participant_consent_complete]='2' and [coordinator_signature_complete]='2'" in the box labeled "When the following logic becomes true"
      And I click "Particpant Consent" and "Coordinator Siganture" from "[Any Event]" located in "Arm 1: Arm 1"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Check" the box labeled "Save to specified field:"
      And I select "coo_sign" on the event name "Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "select a File Upload field" in the dialog box
      And I enter "Custom" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved! Trigger for PDF Snapshot was successfully modified"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | Active | Edit Copy     | Edit trigger name               | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | Selected instruments  | File Repository Specified field: [event_1_arm_1][participant_file] |
         | Active | Edit Copy     | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent"                    | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

      ##VERIFY_Logging
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported        |
         | test_admin | Manage/Design | Modify trigger for PDF Snapshot (snapshot_id = |
         | test_admin | Manage/Design | Copy PDF Snapshot Trigger (copy snapshot_id =  |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

   Scenario: Add record in data form mode (no pdf snapshot)
      #Add record in data form mode (no pdf snapshot)
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 1."

      When I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter the "MyName" in the field labeled "Participant’s Name Typed"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"
      And I select "Complete" from the field labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I Should see "Record Home Page"
      And I should see "Complete" status for "Event 1" insturment "Participant Consent"
      And I Should see "Incomplete (no data saved)" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"

   Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed | Identifier (Name, DOB) | Version | Type |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username   | Action                                   | List of Data Changes OR Fields Exported |
         | test_admin | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                         |

   Scenario: Add record in data survey mode (pdf snapshot created)
      #Add record in data survey mode (pdf snapshot created)
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 2."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"

      When I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter the "MyName" in the field labeled "Participant’s Name Typed"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"
      And I should see "Incomplete" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"

      When I click on the bubble labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"
      Then I should see "custom" in the field labeled "Participant Consent file"

      When I click on the file link the field labeled "Participant Consent file"
      Then I should have a pdf file with the following values "Participant Consent"
      #M: Close document

      #Add Insturment 2's response
      When I click on the bubble labeled "Coordiantor Signature"
      Then I should see "Editing existing Record ID 2."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      And I enter a signature in the field labeled "Coordinator's Signature"
      And I click "Save signature"
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"
      Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Coordinator Signature" for event "Event 1"
      And I should see "Incomplete" icon for the Data Collection Instrument labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"


      When I click on the bubble labeled "Pdfs And Combined Signatures Pdf" for event "Event 1"
      Then I should see "custom" in the field labeled "Participant Consent file"
      And I should see "custom" in the field labeled "Coordinator Signature file"

      When I click on the file link the field labeled "Coordinator Signature file"
      Then I should have a pdf file with the following values "Participant Consent"
      And I should have a pdf file with the following values "Coordinator Signature"
   #M: Close document


   Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Custom.pdf | -                                | 2      | (Event 1 (Arm 1: Arm 1))                     |                        |         |      |
         | Custom.pdf | -                                | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username | Action | List of Data Changes OR Fields Exported |
         | [survey respondent] | Save PDF Snapshot 2 | Save PDF Snapshot to File Upload Field field =  "coo_sign (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument =  "coordinator_signature" snapshot_id = |
         | [survey respondent] | Save PDF Snapshot 2                      | Save PDF Snapshot to File Repository record = "2" event = "event_1_arm_1" instrument = "coordinator_signature" snapshot_id = |
         | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                              |
         | [survey respondent] | Save PDF Snapshot 2 | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = |
         | [survey respondent] | Save PDF Snapshot 2                      | Save PDF Snapshot to File Repository record = "2" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = |
         | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                            |