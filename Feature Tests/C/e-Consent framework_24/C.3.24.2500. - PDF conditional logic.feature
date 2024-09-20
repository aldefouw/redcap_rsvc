Feature: User Interface: The system shall support conditional logic integration within PDF Snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2500.100 PDF snapshots conditional logic 
   
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the button labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project Status: Production"

   Scenario: New PDF Trigger testing Every time the following survey is completed
      ##ACTION: New PDF Trigger with survey based Every time the following survey is completed
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshot"
      And I click on the button labeled "PDF Snapshots of Record"
      And I click the button "+Add new trigger"
      And I enter "Snapshot 1" in the box labeled "Name of trigger"
      And I select "'Participant Consent' - Event 1 (Arm 1: Arm 1)" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "Snapshot 1" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | Snapshot 1 | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository                  |

   Scenario: New PDF Trigger testing When the following logic becomes true (only once per record)
      ##ACTION: When the following logic becomes true (only once per record)
      When I click the button "+Add new trigger"
      And I enter "Snapshot 2" in the box labeled "Name of trigger"
      And I select "--- select a survey ---" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "[participant_consent_complete]='2'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "Snapshot 2" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                                  | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | Snapshot 2 | Logic-based       | Logic becomes true: [participant_consent_complete]='2' | All instruments       | File Repository                  |
         | Active | Edit Copy     | Snapshot 1 | Survey completion | Complete survey "Participant Consent"                  | All instruments       | File Repository                  |

   Scenario: New PDF Trigger testing multi-form
      ##ACTION: When the following logic becomes true (only once per record)
      When I click the button "+Add new trigger"
      And I enter "Snapshot 3" in the box labeled "Name of trigger"
      And I select "--- select a survey ---" from the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I enter "[participant_consent_complete]='2' and [coordinator_signature_complete]='2'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "Snapshot 3" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | Snapshot 3 | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | All instruments       | File Repository                  |
         | Active | Edit Copy     | Snapshot 2 | Logic-based       | Logic becomes true: [participant_consent_complete]='2'   | All instruments       | File Repository                  |
         | Active | Edit Copy     | Snapshot 1 | Survey completion | Complete survey "Participant Consent"                    | All instruments       | File Repository                  |

      ##VERIFY_Logging - Manage/Designof the triggers
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported        |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

   Scenario: Add record
      #Add record in
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 1."

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
      Then I should see "Editing existing Record ID 1."

      When I enter a signature in the field labeled "Coordinator's Signature"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"

   Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
         | Name      | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Snapshot3 | -                                | 1      | (Event 1 (Arm 1: Arm 1))                     |                        |         |      |
         | Snapshot2 | -                                | 1      | (Event 1 (Arm 1: Arm 1))                     |                        |         |      |
         | Snapshot1 | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username            | Action                                   | List of Data Changes OR Fields Exported                                                                                                                                 |
         | test_admin          | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "coordinator_signature" snapshot_id =                                            |
         | [survey respondent] | Save PDF Snapshot 1                      | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = |
         | [survey respondent] | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id =                                              |
         | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                                                                         |
#END