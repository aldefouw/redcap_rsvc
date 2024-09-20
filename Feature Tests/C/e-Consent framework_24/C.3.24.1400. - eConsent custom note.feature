Feature: User Interface: The system shall support the e-Consent Framework to create optional custom notes for reference and documentation purposes.

 As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.1400.100 - eConsent Framework custom note
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the button labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project Status: Production"

      #SETUP_eConsent for participant consent process
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshots"
      And I click on the button labeled "+Enable the e-Consent Framework for a survey"
      And I select "Participant Consent" from the dialogue box labeled "Enable e-Consent for a Survey"
      Then I should see a dialogue box labeled "Enable e-Consent"
      And I should see "Primary settings"

      When I enter "My custom note" in the field labeled "Notes:"
      And I click the button labeled "Save settings"
      Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
      Then I should see a table header and rows including the following values in the e-Consent Framework table:
         | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes          |
         | Active            | "Participant Consent" (participant_consent) | File Repository Specified field:[participant_file] | Participant         | My custom note |
#END