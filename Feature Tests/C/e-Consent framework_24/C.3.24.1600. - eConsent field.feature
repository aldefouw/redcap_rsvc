Feature: User Interface: The system shall support the e-Consent Framework to place a consent form in a descriptive field.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.1600.100 Add consent form version via rich text
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.1600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the button labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project Status: Production"

      When I click on the button labeled "+Add consent from" for the survey labeled "Participant Consent"
      Then I should see "Consent form version"

   Scenario: Add consent form version via rich text
      When I click on the button labeled "+Add consent from" for the survey labeled "Participant Consent"
      Then I should see "Consent form version"

      When I enter "test 1" in the field labeled "Consent form version:" in the dialog box
      And I select "Consent file" from the dropdown field labeled "Placement of consent form:" in the dialog box
      And I select "When record is not assigned to a DAG (default)" from the dropdown field labeled "Display for specific DAG" in the dialog box
      And I select "No languages defined on MLM page" for the dropdown filed labeled "Display for specific language" in the dialog box
      And I click on the link labeled "Consent Form (Rich Text)" in the dialog box
      And I enter "This is my test 1 consent form" in the field labeled "Consent Form (Rich Text)" in the dialog box
      And I click on the button labeled "Add new consent form" in the dialog box
      Then I should see "Consent form vtest 1" for the survey labeled "Participant Consent"

      #VERIFY: view all versions for Test 1
      When I click on the button labeled "View all versions" for the survey labeled "Participant Consent"
      Then I should see a table header and rows including the following values in the version table:
         | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
         |            | 1.0     |                    |                         | 0                           |                   |              | 20240718153905_Fake_Consent[311203].pdf |                              |
         | check icon | test 1  | XX/XX/XXXX XX:XXXm | Test_Admin (Admin Test) | 0                           |                   |              | " This is my test 1 consent form "      | "Set as inactive" button     |

      When I click on the button labeled "Close" in the dialog box
      Then I should see "Consent form vtest 1" for the survey labeled "Participant Consent"

      ##VERIFY_Logging
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported                                      |
         | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |

      #Test e-Consent by adding record
      ##ACTION: add record to get participant signature
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 1."
      And I should see "This is my test 1 consent form"

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"
      And I should see "This is my test 1 consent form"

      When I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"

      When I click on the button labeled "Next Page"
      Then I should see "Displayed below is a read-only copy of your survey responses."
      And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

      When I check the checkbox labeled "I certify that all of my information in the document above is correct."
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

      # Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)        | Version | Type |
         | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LatName, 2000-01-01 |         |      | e-Consent Participant |

      When I click on the file link for record "1" Survey "(Event 1 (Arm 1: Arm 1))"
      Then I should see "This is my test 1 consent form"
   #M: Close document

   Scenario: C.3.24.1600.200 e-Consent create unique version using Inline PDF
      #Add consent form version via file upload
      #SETUP_eConsent
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshots"
      Then I should see "Participant Consent"

      When I click on the button labeled "+Add consent from" for the survey labeled "Participant Consent"
      Then I should see "Consent form version"

      When I enter "test 2" in the field labeled "Consent form version:" in the dialog box
      And I select "Consent file" from the dropdown field labeled "Placement of consent form:" in the dialog box
      And I select "When record is not assigned to a DAG (default)" from the dropdown field labeled "Display for specific DAG" in the dialog box
      And I select "No languages defined on MLM page" for the dropdown filed labeled "Display for specific language" in the dialog box
      And I click on the link labeled "Consent Form (Inline PDF)" in the dialog box
      And I click on the button labeled "Choose File" in the dialog box
      And I select the file labeled "consent.pdf" in the dialog box
      And I click on the button labeled "Upload File" in the dialog box
      And I click on the button labeled "Add new consent form" in the dialog box
      Then I should see "Consent form vtest 2" for the survey labeled "Participant Consent"

      # view all versions
      When I click on the button labeled "View all versions" for the survey labeled "Participant Consent"
      Then I should see a table header and rows including the following values in the version table:
         | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
         |            | 1.0     |                    |                         | 0                           |                   |              | 20240718153905_Fake_Consent[311203].pdf |                              |
         |            | test 1  | XX/XX/XXXX XX:XXXm | Test_Admin (Admin Test) | 1                           |                   |              | " This is my test 1 consent form "      |                              |
         | check icon | test 2  | XX/XX/XXXX XX:XXXm | Test_Admin (Admin Test) | 1                           |                   |              | consent.pdf                             | "Set as inactive" button     |

      When I click on the button labeled "Close" in the dialog box
      Then I should see "Consent form vtest 2" for the survey labeled "Participant Consent"

      ##VERIFY_Logging
      When I click on the link labeled "Logging"
      Then I should see a table header and rows including the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported                                      |
         | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |

      # Test e-Consent by adding record
      ##ACTION: add record to get participant signature
      When I click on the link labeled "Add/Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click on the bubble labeled "Participant Consent" for event "Event 1"
      Then I should see "Adding new Record ID 2."
      And I should see "consent.pdf"

      When I click on the button labeled "Save & Stay"
      And I click on the button labeled "Okay" in the dialog box
      And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options"
      Then I should see "Participant Consent"
      And I should see "consent.pdf"

      When I enter "FirstName" in the field labeled "First Name"
      And I enter "LastName" in the field labeled "Last Name"
      And I enter "email@test.edu" in the field labeled "Email"
      And I enter "2000-01-01" in the field labeled "DOB"
      And I enter a signature in the field labeled "Participant signature field"
      And I click "Save signature"

      When I click on the button labeled "Next Page"
      Then I should see "Displayed below is a read-only copy of your survey responses."
      And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

      When I check the checkbox labeled "I certify that all of my information in the document above is correct."
      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I click on the button labeled "Leave without saving changes" in the dialog box
      Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

      # Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows including the following values in the PDF Snapshot Archive table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)        | Version | Type |
         | .pdf | YES                              | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LatName, 2000-01-01 |         |      | e-Consent Participant |
         | .pdf | YES                              | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LatName, 2000-01-01 |         |      | e-Consent Participant |

      When I click on the file link for record "2" Survey "(Event 1 (Arm 1: Arm 1))"
      Then I should see "consent.pdf"
#M: Close document
#END