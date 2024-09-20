Feature: User Interface: The system shall support the capture and storage of multi-form/survey PDF snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario:  C.3.24.2600.100 multi-form/survey PDF snapshots.

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_DESIGNER
      When I click on the button labeled "Designer"
      And I click on the link labeled "Participant Consent"
      And I click on the button labeled "Add Field" at the bottom of the instrument
      And I click on the dropdown field labeled "Select a Type of Field"
      And I add a new Multiple Choice - Radio Buttons (Single Answer) field labeled "Form 1 Trigger" with the variable name "trigger1"
      And I enter "1, Data Mode" on the first row of the input field labeled "Choices (one choice per line)"
      And I enter "2, Survey Mode" on the second row of the input field labeled "Choices (one choice per line)"
      And I click on the button labeled "Save"
      Then I should see the field labeled "Form 1 Trigger"

      When I click on the button labeled "Designer"
      And I click on the link labeled "Coordinator Signature"
      And I click on the button labeled "Add Field" at the bottom of the instrument
      And I click on the dropdown field labeled "Select a Type of Field"
      And I add a new Multiple Choice - Radio Buttons (Single Answer) field labeled "Form 2 Trigger" with the variable name "trigger2"
      And I enter "1, Data Mode" on the first row of the input field labeled "Choices (one choice per line)"
      And I enter "2, Survey Mode" on the second row of the input field labeled "Choices (one choice per line)"
      And I click on the button labeled "Save"
      Then I should see the field labeled "Form 2 Trigger"

      #SETUP_PRODUCTION
      When I click on the button labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project Status: Production"

   Scenario: New multi data form same event PDF Trigger
      ##ACTION: New PDF Trigger
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshot"
      And I click on the button labeled "PDF Snapshots of Record"
      And I click the button "+Add new trigger"
      And I enter "1 multi data form same event" in the box labeled "Name of trigger"
      And I enter "[trigger1]='1' and [trigger2]='1'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "multi data form same event" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                         | Type of trigger | Save snapshot when...                                 | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | 1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1' | All instruments       | File Repository                  |

   Scenario: New mixed multi data form and survey same event PDF Trigger
      ##ACTION: New PDF Trigger
      When I click the button "+Add new trigger"
      And I enter "2 multi data form and survey same event" in the box labeled "Name of trigger"
      And I enter "[trigger1]='2' and [trigger2]='1'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "multi data form and survey same event" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                                    | Type of trigger | Save snapshot when...                                 | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | 1 multi data form same event            | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1' | All instruments       | File Repository                  |
         | Active | Edit Copy     | 2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1' | All instruments       | File Repository                  |


   Scenario: New multi survey same event PDF Trigger
      ##ACTION: New PDF Trigger
      When I click the button "+Add new trigger"
      And I enter "3 multi survey same event" in the box labeled "Name of trigger"
      And I enter "[trigger1]='2' and [trigger2]='2'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "multi data form and survey same event" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                                    | Type of trigger | Save snapshot when...                                 | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | 1 multi data form same event            | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1' | All instruments       | File Repository                  |
         | Active | Edit Copy     | 2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1' | All instruments       | File Repository                  |
         | Active | Edit Copy     | 3 multi survey same event               | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2' | All instruments       | File Repository                  |

   Scenario: New multi data form different event PDF Trigger
      ##ACTION: New PDF Trigger
      When I click the button "+Add new trigger"
      And I enter "4 multi data form different event" in the box labeled "Name of trigger"
      And I enter "[event_1_arm_1][trigger1]='1' and [event_three_arm_1][trigger1]='1'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "multi data form different event" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings | Name                                    | Type of trigger | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | 1 multi data form same event            | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 3 multi survey same event               | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 4 multi data form different event       | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |

   Scenario: New mixed multi data form and survey different event PDF Trigger
      ##ACTION: New PDF Trigger
      When I click the button "+Add new trigger"
      And I enter "5 multi data form and survey different event" in the box labeled "Name of trigger"
      And I enter "[event_1_arm_1][trigger1]='1' and [event_three_arm_1][trigger1]='2'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "multi data form and survey different event" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
         | Active | Edit settings | Name                                         | Type of trigger | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | 1 multi data form same event                 | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 2 multi data form and survey same event      | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 3 multi survey same event                    | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 4 multi data form different event            | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |
         | Active | Edit Copy     | 5 multi data form and survey different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |

   Scenario: New multi survey different event PDF Trigger
      ##ACTION: New PDF Trigger
      When I click the button "+Add new trigger"
      And I enter "6 multi survey different event" in the box labeled "Name of trigger"
      And I enter "[event_1_arm_1][trigger1]='2' and [event_three_arm_1][trigger1]='2'" in the box labeled "When the following logic becomes true"
      And I enter "" into the field labeled "[All instruments]"
      And I "Check" the box labeled "Save as Compact PDF (includes only fields with saved data)"
      And I "Uncheck" the box labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I "Check" the box labeled "Save to File Repository"
      And I "Uncheck" the box labeled "Save to specified field:"
      And I enter "multi data form and survey different event" in the field labeled "File name:"
      And I click "Save"
      Then I should see "Saved!"
         | Active | Edit settings | Name                                         | Type of trigger | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
         | Active | Edit Copy     | 1 multi data form same event                 | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 2 multi data form and survey same event      | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 3 multi survey same event                    | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2'    | All instruments       | File Repository                  |
         | Active | Edit Copy     | 4 multi data form different event            | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |
         | Active | Edit Copy     | 5 multi data form and survey different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |
         | Active | Edit Copy     | 6 multi survey different event               | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='2' and... | All instruments       | File Repository                  |


   Scenario: Add record - 1 multi data form same event
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 1."

      When I select "Data Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter the "MyName" in the field labeled "Participant’s Name Typed"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"

      When I click on the bubble labeled "Coordinator Signature" for event "Event 1"
      When I select "Data Mode" from the field labeled "Form 2 Trigger"
      And I enter "Coordinator" in the field labeled "Coordinator's Name Typed"
      And I enter a signature in the field labeled "Coordinator's Signature"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"
      And  I should see a Complete icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 1"
      And  I should see a Complete icon for the Data Collection Instrument labeled "Coordinator Signature" for event "Event 1"



   Scenario: Add record - 2 multi data form and survey same event
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 2."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"

      When I select "Survey Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
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

      When I click on the bubble labeled "Coordinator Signature" for event "Event 1"
      When I select "Data Mode" from the field labeled "Form 2 Trigger"
      And I enter "Coordinator" in the field labeled "Coordinator's Name Typed"
      And I enter a signature in the field labeled "Coordinator's Signature"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"
      And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 1"
      And  I should see a Complete icon for the Data Collection Instrument labeled "Coordinator Signature" for event "Event 1"

   Scenario: Add record -3 multi survey same event
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 3."

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"

      When I select "Survey Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
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

      When I click on the bubble labeled "Coordinator Signature" for event "Event 1"
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      And  I select "Survey Mode" from the field labeled "Form 2 Trigger"
      And I enter "Coordinator" in the field labeled "Coordinator's Name Typed"
      And I enter a signature in the field labeled "Coordinator's Signature"
      And I click "Save signature"
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see "Record Home Page"
      And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 1"
      And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Coordinator Signature" for event "Event 1"

   Scenario: Add record - 4 multi data form different event
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 4."

      When I select "Data Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter the "MyName" in the field labeled "Participant’s Name Typed"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"

      When I click on the bubble labeled "Participant Consent" for event "Event 2"
      And I select "Data Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter the "MyName" in the field labeled "Participant’s Name Typed"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"
      And  I should see a Complete icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 1"
      And  I should see a Complete icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 2"








   Scenario: Add record -  5 multi data form and survey different event
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 5."


      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"

      When I select "Survey Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
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

      When I click on the bubble labeled "Participant Consent" for event "Event 2"
      And I select "Data Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter the "MyName" in the field labeled "Participant’s Name Typed"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"
      And I slect "Complete" from the drowpown labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"
      And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 1"
      And  I should see a Complete icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 2"




   Scenario: Add record -  6 multi survey different event
      #Add record
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 6."


      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"

      When I select "Survey Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
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

      When I click on the bubble labeled "Participant Consent" for event "Event 2"
      And I select "Survey Mode" from the field labeled "Form 1 Trigger"
      And I enter "FirstName" in the field labeled "First Name"
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
      Then I should see "Record Home Page"
      And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 1"
      And  I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Participant Consent" for event "Event 2"



   Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
         | Name                                 | PDF utilized e-Consent Framework | Record | Survey Completed             | Identifier (Name, DOB) | Version | Type |
         | multidataformandsurveydifferentevent | -                                | 6      | (Event Three (Arm 1: Arm 1)) |                        |         |      |
         | multidataformandsurveydifferentevent | -                                | 5      | (Event Three (Arm 1: Arm 1)) |                        |         |      |
         | multidataformdifferentevent          | -                                | 4      | (Event 1 (Arm 1: Arm 1))     |                        |         |      |
         | multisurveysameevent                 | -                                | 3      | (Event Three (Arm 1: Arm 1)) |                        |         |      |
         | multidataformandsurveysameevent      | -                                | 2      | (Event 1 (Arm 1: Arm 1))     |                        |         |      |
         | multidataformsameevent               | -                                | 1      | (Event 1 (Arm 1: Arm 1))     |                        |         |      |
#END