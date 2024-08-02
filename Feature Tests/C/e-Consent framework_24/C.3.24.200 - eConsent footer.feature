Feature: The e-Consent framework shall support the automatic insertion of select text fields into the footer of the PDF consent form.  Selectors e-Consent version | First name field |Last name field | e-Consent type | Date of birth field | Signature field #1-#5

  As a REDCap end user
  I want to see that eConsent is functioning as expected

  Scenario: C.3.24.200.100 e-Consent text validation
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Consent.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #SETUP_eConsent
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    Then I should see 'Modify survey settings for data collection instrument "Consent"'
    And I select "Auto-Archiver + e-Consent Framework" on the radio field labeled "e-Consent Framework"

    #        And I verify "version test" is within the input field labeled "e-Consent version:"
    #        Then I should see the dropdown field labeled "First name field" with the option "fname 'Name'" selected
    #        And I should see the dropdown field labeled "Last name field" with the option "lname 'Name'" selected
    #        And I verify "type test" is within the input field labeled "e-Consent type:"
    #        And I should see the dropdown field labeled "Date of birth field" with the option "dob 'DOB'" selected
    #        And I should see the dropdown field labeled "Signature field #1:" with the option "signature_consent 'Signature'" selected
    #        And I should see the dropdown field labeled "Signature field #2:" with the option "signature_consent_2 'Signature'" selected
    #        And I should see the dropdown field labeled "Signature field #3:" with the option "signature_consent_3 'Signature'" selected
    #        And I should see the dropdown field labeled "Signature field #4:" with the option "signature_consent_4 'Signature'" selected
    #        And I should see the dropdown field labeled "Signature field #5:" with the option "signature_consent_5 'Signature'" selected

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
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "4) DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct." that is unchecked

    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    When I click on the button labeled "Close survey"
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "1"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 1 File  |
      | Recycle Bin        |               | 0 Files |

    When I click on the link labeled "PDF Survey Archive" in the File Repository table
    Given I download the PDF by clicking on the link for Record "1" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "1" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | Version: version test, Type: type test |

    #M: Close document

    ##ACTION: add record_missing sig_1
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 2."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "DOB"

    #No signature entered for 5) Signature field this time

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    When I click on the button labeled "Next Page"
    Then I should see "NOTE: Some fields are required!"

    When I click on the button labeled "Okay" in the dialog box
    #M: Close browser page
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Partial Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "2"
    When I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "2" and click on the bubble
    Then I should see "Survey response is editable"

    When I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    Given I see "You have not completed the entire survey, and your responses are thus considered only partially complete. For security reasons, you will not be allowed to continue taking the survey from the place where you stopped."
    Then I should see the button labeled "Start Over"
    #M: Close browser page
    Given I return to the REDCap page I opened the survey from

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Survey Archive"
    Then I should NOT see a link labeled exactly "2" in the File Repository table

    ##ACTION: add record_missing sig_2
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 3."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I clear field and enter "" into the data entry form field labeled "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    When I click on the button labeled "Next Page"
    Then I should see "NOTE: Some fields are required!"

    When I click on the button labeled "Okay" in the dialog box
    #M: Close browser page
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Partial Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "3"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Survey Archive"
    Then I should NOT see a link labeled exactly "3" in the File Repository table

    ##ACTION: add record_missing sig_3
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 4."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I clear field and enter "" into the data entry form field labeled "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box

    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    When I click on the button labeled "Next Page"
    Then I should see "NOTE: Some fields are required!"

    When I click on the button labeled "Okay" in the dialog box
    #M: Close browser page
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Partial Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "4"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Survey Archive"
    Then I should NOT see a link labeled exactly "4" in the File Repository table

    ##ACTION: add record_missing sig_4
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 5."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    #No signature entered for 8) Signature field this time

    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    When I click on the button labeled "Next Page"
    Then I should see "NOTE: Some fields are required!"

    When I click on the button labeled "Okay" in the dialog box
    #M: Close browser page
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Partial Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "5"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Survey Archive"
    Then I should NOT see a link labeled exactly "5" in the File Repository table

    ##ACTION: add record_missing sig_5
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 6."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I clear field and enter "" into the data entry form field labeled "9) Signature"

    When I click on the button labeled "Next Page"
    Then I should see "NOTE: Some fields are required!"

    When I click on the button labeled "Okay" in the dialog box
    #M: Close browser page
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Partial Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "6"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Survey Archive"
    Then I should NOT see a link labeled exactly "6" in the File Repository table

    ##ACTION: add record_missing sig_5
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 7."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    When I clear field and enter "" into the data entry form field labeled "1) Name"
    And I clear field and enter "" into the data entry form field labeled "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I clear field and enter "" into the data entry form field labeled "DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_5" in the data entry form field "9) Signature"
    And I click on the button labeled "Next Page"
    Then I should see "Consent"
    And I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct." that is unchecked

    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    When I click on the button labeled "Close survey"
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "7"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 2 Files |
      | Recycle Bin        |               | 0 Files |

    Given I click on the link labeled "PDF Survey Archive" in the File Repository table
    When I download the PDF by clicking on the link for Record "7" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "7" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | Version: version test, Type: type test |
    #M: Close document

    #SETUP_eConsent_change field
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I select "Auto-Archiver + e-Consent Framework" on the radio field labeled "e-Consent Framework"
    And I clear field and enter "UPDATED VERSION TEST" into the input field labeled "e-Consent version:"
    #        And I should see "fname 'Name'" in the data entry form field "First name field:"
    #        And I should see "lname 'Name'" in the data entry form field "Last name field:"
    #        And I should see "type test" in the data entry form field "e-Consent type:"
    #        And I should see "dob 'DOB'" in the data entry form field "Date of birth field:"
    #        And I should see "signature_consent 'Signature'" in the data entry form field "Signature field #1:"
    #        And I should see "signature_consent_2 'Signature'" in the data entry form field "Signature field #2:"
    #        And I should see "signature_consent_3 'Signature'" in the data entry form field "Signature field #3:"
    #        And I should see "signature_consent_4 'Signature'" in the data entry form field "Signature field #4:"
    #        And I should see "signature_consent_5 'Signature'" in the data entry form field "Signature field #5:"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    ##ACTION: add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 8."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"

    When I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_5" in the data entry form field "9) Signature"
    And I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct." that is unchecked

    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    When I click on the button labeled "Close survey"
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "8"

    ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 3 Files |
      | Recycle Bin        |               | 0 Files |

    Given I click on the link labeled "PDF Survey Archive" in the File Repository table
    When I download the PDF by clicking on the link for Record "8" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "8" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | Name Name, yyyy-mm-dd, Version: UPDATED VERSION TEST, Type: type test |
    #M: Close document

    #SETUP_eConsent_change field
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Consent"
    And I select "Auto-Archiver enabled" on the radio field labeled "e-Consent Framework"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    ##ACTION: add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 9."

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Consent"
    And I should see "Name" in the data entry form field "1) Name"
    And I should see "Name" in the data entry form field "2) Name"
    And I should see "email@test.edu" in the data entry form field "3) Email"
    And I should see "yyyy-mm-dd" in the data entry form field "4) DOB"

    When I click on the "Add signature" link for the field labeled "5) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_2" in the data entry form field "6) Signature"
    And I should see "signature_consent_3" in the data entry form field "7) Signature"

    When I click on the "Add signature" link for the field labeled "8) Signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I should see "signature_consent_5" in the data entry form field "9) Signature"

    And I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct." that is unchecked

    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    When I click on the button labeled "Close survey"
    Given I return to the REDCap page I opened the survey from
    ##VERIFY_RSD
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1" for record "9"

    ##VERIFY_FiRe_no eConsent
    When I click on the link labeled "File Repository"
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name               | Time Uploaded | Size    |
      | Data Export Files  |               | 0 Files |
      | PDF Survey Archive |               | 4 Files |
      | Recycle Bin        |               | 0 Files |

    Given I click on the link labeled "PDF Survey Archive" in the File Repository table
    When I download the PDF by clicking on the link for Record "9" and Survey "Consent (Event 1 (Arm 1: Arm 1))" in the File Repository table
    Then I should see the following values in the downloaded PDF for Record "9" and Survey "Consent (Event 1 (Arm 1: Arm 1))"
      | Name Name, yyyy-mm-dd, Version: UPDATED VERSION TEST, Type: type test |
#M: Close document
