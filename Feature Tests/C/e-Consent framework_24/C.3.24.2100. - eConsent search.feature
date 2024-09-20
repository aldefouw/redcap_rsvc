Feature: User Interface: The system shall support the e-Consent Framework to search within e-Consent framework settings.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2100.100 e-Consent Framework search
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      When I click on the button labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project Status: Production"

      #FUNCTIONAL_REQUIREMENT
      ##ACTION: e-consent search
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshots"
      Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
      And I should see the e-consent framework for survey labeled "Coordinator Consent" is "Active"

      When I enter "Participant Consent" in the field labeled "Search"
      Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
      And I should NOT see the e-consent framework for survey labeled "Coordinator Consent" is "Active"

      ##ACTION: clear search
      When I enter "" in the field labeled "Search"
      Then I should see the e-consent framework for survey labeled "Participant Consent" is "Active"
      And I should see the e-consent framework for survey labeled "Coordinator Consent" is "Active"
#END