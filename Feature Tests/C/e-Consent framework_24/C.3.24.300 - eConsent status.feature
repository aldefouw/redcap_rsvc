Feature: User Interface: The e-Consent framework will enable surveys to be considered as complete (submit button appears) once the certification step has been successfully completed.

  As a REDCap end user
  I want to see that eConsent is functioning as expected

  Scenario: C.3.24.300.100 Certification required to submit completed survey
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named " C.3.24.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Consent.xml", and clicking the "Create Project" button

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

    ##ACTION: add record
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
    ##VERIFY: cannot submit without attestation

    And I should see a button labeled "Submit" that is disabled

    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    ##VERIFY: can submit once attestation complete
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled exactly "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "1"

    When I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "1" and click the new instance link
    Then I should see "Editing existing Record ID 1.(Instance #2)"

    Given I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box

    When I click on the button labeled "Survey options"
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
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a button labeled "Previous Page"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: click on previous page and cancel
    When I click on the button labeled "Previous Page"
    Then I should see "Erase your signature(s) in this survey?"

    When I click on the button labeled "Cancel" in the dialog box
    Then I should see "Displayed below is a read-only copy of your survey responses."

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: click on previous page and accept
    When I click on the button labeled "Previous Page"
    Then I should see "Erase your signature(s) in this survey?"
    And I click on the button labeled "Erase my signature(s) and go to earlier page" in the dialog box
    Then I should see "Consent"

    #If there is no "Remove signature" link, there are no E-signatures present
    Then I should NOT see a link labeled "Remove signature"

    #These values are blank now
    And I should see "" in the data entry form field "6) Signature"
    And I should see "" in the data entry form field "7) Signature"
    And I should see "" in the data entry form field "9) Signature"
    #M: Close browser page

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record Status Dashboard"
    When I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the second instance
    Then I should see "Editing existing Record ID 1.(Instance #2)"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    ##VERIFY: partial survey completion not accepted
    And I should see "You have partially completed this survey."

    When I click on the button labeled "Start Over"
    Then I should see an alert box with the following text: "ERASE YOUR RESPONSES?"

    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "4) DOB"
    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"
    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    #M: Close browser page
    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled exactly "Record ID 1"
    ##VERIFY_RSD
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument for instance 1 on event "Event 1"
    Then I should see the "Partial Survey Response" icon for the "Consent" longitudinal instrument for instance 2 on event "Event 1"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 1 File  |
      | Recycle Bin        |               | 0 Files |

    Given I click on the link labeled "PDF Survey Archive" in the File Repository table
    When I download the PDF by clicking on the link for Record "1" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "1" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | Response was added on mm/dd/yyyy                              |                     |
      | 1)Name                                                        | Name                |
      | 2)Name                                                        | Name                |
      | 3)Email                                                       | email@test.edu      |
      | 4)DOB                                                         | yyyy-mm-dd          |
      | 5)Signature                                                   |                     |
      | 6)Signature                                                   | signature_consent_2 |
      | 7)Signature                                                   | signature_consent_3 |
      | 8)Signature                                                   |                     |
      | 9)Signature                                                   | signature_consent_5 |
      | Name Name, yyyy-mm-dd, Version: version test, Type: type test |                     |

#M: Close document
