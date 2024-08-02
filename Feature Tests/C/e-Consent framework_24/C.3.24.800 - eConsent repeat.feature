Feature: User Interface: The e-Consent framework shall support repeatable instruments and repeatable events

  As a REDCap end user
  I want to see that eConsent is functioning as expected

  Scenario: C.3.24.800.100 e-Consent framework & Repeatable instruments/events
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Consent.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #SETUP: Project Setup:modify repeating instruments
    When I click on the button labeled "Modify" in the "Repeating instruments and events" row in the "Enable optional modules and customizations" section
    Then I should see a dialog containing the following text: "WARNING"
    And I click on the button labeled "Close" in the dialog box
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And for the Event Name "Event 1 (Arm 1: Arm 1)", I check the checkbox labeled "Consent" in the dialog box
    And I click on the button labeled "Save" on the dialog box for the Repeatable Instruments and Events module
    Then I should see "Successfully saved!"

    #SETUP_eConsent
    When I click on the button labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I select "Auto-Archiver + e-Consent Framework" on the radio field labeled "e-Consent Framework"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: instance 1 for event 1
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I click on the button labeled "Next Page"
    Then I should see "Consent"
    And I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox labeled "I certify that all of my information in the document above is correct." that is unchecked
    And I should see a button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    ##VERIFY_RSD
    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 1"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument for instance 1 on event "Event 1"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: instance 2 for event 1
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "1" and click the new instance link
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I click on the button labeled "Next Page"
    Then I should see "Consent"
    And I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox labeled "I certify that all of my information in the document above is correct." that is unchecked
    And I should see a button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    ##VERIFY_RSD
    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 1"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument for instance 2 on event "Event 1"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: instance 1 for event 3
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Consent" instrument on event "Event Three" for record ID "1" and click on the bubble
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I click on the button labeled "Next Page"
    Then I should see "Consent"
    And I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox labeled "I certify that all of my information in the document above is correct." that is unchecked
    And I should see a button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    ##VERIFY_RSD
    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 1"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument for instance 1 on event "Event 1"


    #FUNCTIONAL_REQUIREMENT
    ##ACTION: instance 2 for event 3
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see "Record Status Dashboard (all records)"
    When I locate the bubble for the "Consent" instrument on event "Event Three" for record ID "1" and click the new instance link
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I click on the button labeled "Next Page"
    Then I should see "Consent"
    And I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox labeled "I certify that all of my information in the document above is correct." that is unchecked
    And I should see a button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    ##VERIFY_RSD
    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 1"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument for instance 2 on event "Event Three"
    ##VERIFY_LOG: Keeping here in case you change your mind and want to include something in logging. If you don't feel like its valuable, then delete

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 4 File  |
      | Recycle Bin        |               | 0 Files |

    When I click on the link labeled "PDF Survey Archive" in the File Repository table
    Then I should see a table header and rows containing the following values in the file repository table:
      | Record | Survey                                  |
      | 1      | Consent (Event Three (Arm 1: Arm 1)) #2 |
      | 1      | Consent (Event Three (Arm 1: Arm 1)) #1 |
      | 1      | Consent (Event 1 (Arm 1: Arm 1)) #2     |
      | 1      | Consent (Event 1 (Arm 1: Arm 1)) #1     |
    And I should see "Showing 1 to 4 of 4 entries"