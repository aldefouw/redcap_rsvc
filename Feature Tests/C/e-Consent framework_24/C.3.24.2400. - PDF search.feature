Feature: User Interface: The system shall support the search function within PDF snapshots.


   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario:  C.3.24.2400.100 search function within PDF snapshots.

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button


      ##ACTION: Search function
      When I click on the button labeled "Designer"
      And I click on the button labeled "e-Consent and PDF Snapshot"
      And I click on the button labeled "PDF Snapshots of Record"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings         | Name             | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot  | Location(s) to save the snapshot                     |
         | Active | Edit Copy             | combo file | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | Selected instruments   | File Repository Specified field: [combo_file]        |
         | Active | Governed by e-Consent |                  | Survey completion | Complete survey "Participant Consent"                    | Single survey response | File Repository Specificed field: [participant_file] |
         | Active | Governed by e-Consent |                  | Survey completion | Complete survey "Coordinator Signature"                  | Single survey response | File Repository Specificed field: [coo_sign]         |

      When I enter "combo file" in the field labeled "Search"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings         | Name             | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot  | Location(s) to save the snapshot                     |
         | Active | Edit Copy             | combo file | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | Selected instruments   | File Repository Specified field: [combo_file]        |

      ##ACTION: clear search
      When I enter "" in the field labeled "Search"
      Then I should see a table header and rows including the following values in the PDF snapshot table:
         | Active | Edit settings         | Name             | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot  | Location(s) to save the snapshot                     |
         | Active | Edit Copy             | combo file | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | Selected instruments   | File Repository Specified field: [combo_file]        |
         | Active | Governed by e-Consent |                  | Survey completion | Complete survey "Participant Consent"                    | Single survey response | File Repository Specificed field: [participant_file] |
         | Active | Governed by e-Consent |                  | Survey completion | Complete survey "Coordinator Signature"                  | Single survey response | File Repository Specificed field: [coo_sign]         |
#END