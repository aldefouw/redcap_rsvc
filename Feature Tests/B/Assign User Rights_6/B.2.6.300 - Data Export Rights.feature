Feature: Project Level:  The system shall allow instrument level data export rights to be (No Access, De-Identified, Remove All Identifier Fields, Full Data Set)

  As a REDCap end user
  I want to see that data export rights is functioning as expected

  Scenario: B.2.6.300.100 Data Export Rights
        #SETUP_PRODUCTION
    Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named "B.2.6.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status: Production"

        ##USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I select "Upload users" on the dropdown field labeled "Upload or download users, roles, and assignments"
    And I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
    And I should see a table header and rows containing the following values in the table:
      | username   |
      | test_user1 |
      | test_user2 |
      | test_user3 |
      | test_user4 |

    Given I click on the button labeled "Upload"
    Then I should see a dialog containing the following text: "SUCCESS!"
    When I close the popup

    Then I should see a table header and rows including the following values in the table:
      | Role name               | Username   |
      |                         | test_admin |
      |                         | test_user1 |
      |                         | test_user2 |
      |                         | test_user3 |
      |                         | test_user4 |
      | 1_FullRights            |            |
      | 2_Edit_RemoveID         |            |
      | 3_ReadOnly_Deidentified |            |
      | 4_NoAccess_Noexport     |            |

        #B.2.6.500.100 Assign User Roles
    When I click on the link labeled "Test_User1"
    And I click on the button labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role" with the option "1_FullRights" selected
    And I click on the button labeled "Assign"
        ##VERIFY
    Then I should see "Test_User1" user assigned "T1_FullRights" role

    When I click on the link labeled "Test_User2"
    And I click on the button labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role" with the option "2_Edit_RemoveID" selected
    And I click on the button labeled "Assign"
        ##VERIFY
    Then I should see "Test_User2" user assigned "2_Edit_RemoveID" role

    When I click on the link labeled "Test_User3"
    And I click on the button labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role" with the option "3_ReadOnly_Deidentified" selected
    And I click on the button labeled "Assign"
        ##VERIFY
    Then I should see "Test_User3" user assigned "3_ReadOnly_Deidentified" role

    When I click on the link labeled "Test_User3"
    And I click on the button labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role" with the option "4_NoAccess_Noexport" selected
    And I click on the button labeled "Assign"
        ##VERIFY
    Then I should see "Test_User3" user assigned "4_NoAccess_Noexport" role
    And I logout

    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"
        #FUNCTIONAL REQUIREMENT #B.5.21.300.100 Export Full Data Set
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
        ##ACTION
    And I click on the button labeled "Export Data"
    Then I should see "All data (all records and fields)"

    When I click on the link labeled "CSV / Microsoft Excel (raw data) "
    And I click on the button labeled "Export Data"
    Then I should see "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box

        ##VERIFY_DE
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | pt_name | textbox | radio | notesbox | identifier | identifier_2 | date_ymd | datetime_ymd_hmss | date_types_complete |
        #Manual: Close the file

        ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows including the following values in the logging table:
      | Username   | Action      | List of Data Changes OR Fields Exported |
      | test_user1 | Data export | Download exported data file (CSV raw)   |

    And I logout

        #SETUP
    Given I login to REDCap with the user "Test_User2"
    Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT Export remove all identifier fields
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
        ##ACTION
    And I click on the button labeled "Export Data"
    Then I should see "All data (all records and fields)" Test_User3

    When I click on the link labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data"
    Then I should see "Data export was successful!"

    When I click on the button labeled "Excel CSV"
    And I click the button labeled "Close"
        ##VERIFY_DE
    And I open the Excel CSV File

    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | name | email | text_validation_complete | ptname | textbox | text2 | radio | notesbox | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload	required | edit_field | date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma | letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia | phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete	survey_timestamp | name_survey | email_survey | survey_complete | consent_timestamp | name_consent | email_consent | dob | signature_consent | consent_complete |
        # And I should NOT see "ptname"
        # And I should NOT see "identifier"
        # And I should NOT see "identifier2"
        #M: Close csv file

    And I logout

        #SETUP
    Given I login to REDCap with the user "Test_User3"
    Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT: Export Deidentified
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Export Data"
    Then I should see "All data (all records and fields) "

    When I click on the link labeled "CSV / Microsoft Excel (raw data)"
        ##ACTION
    And I click on the button labeled "Export Data"
    Then I should see "Data export was successful! "

    When I click on the button labeled "Excel CSV"
    And I click the button labeled "Close"
        ##VERIFY_DE

    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | email | text_validation_complete | radio | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual	checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload	date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma	letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia	phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete | survey_timestamp | email_survey | survey_complete	consent_timestamp | email_consent | dob | signature_consent | consent_complete |
        # And I should NOT see "ptname"
        # And I should NOT see "identifier"
        # And I should NOT see "identifier2"
        #M: Close csv file
    And I logout

        #SETUP
    Given I login to REDCap with the user "Test_User4"
    Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT: Export No Access
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
        ##ACTION:
    And I click on the link labeled "Data Exports, Reports, and Stats"
        ##VERIFY
    Then I should see the button labeled "View Report"
    Then I should not see the button labeled "Export Data"
#End