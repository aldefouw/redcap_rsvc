Feature: User Interface: The system shall restrict users by DAGs when using the background process to import data files

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.2200.100 DAG restictions on background import
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.2200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project1.xml", and clicking the "Create Project" button

        #SETUP_USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select " TestGroup1" on the dropdown field labeled " Assign to DAG "
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        When I click on the link labeled "User Rights"
        And I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select " TestGroup2" on the dropdown field labeled " Assign to DAG "
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        #SETUP_PRODUCTION
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status: Production"

        #Import file with all DAGs
        #FUNCTIONAL REQUIREMENT
        ##ACTION
        When I click on the link labeled "Data Import Tool"
        And I click on the tab labeled "CVS import"
        Then I should see the button labeled "Choose File"

        When I click on the button labeled "Choose File"
        And I upload the csv file labeled "B.3.16.2200_DataImport_Dag.csv"
        And I click on the button labeled "Upload File"
        Then I should see "Your document was uploaded successfully and is ready for review"

        ##VERIFY

        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action                   | List of Data Changes OR Fields Exported                                      |
            | test_Admin | Update record (import) 4 | Assign record to Data Access Group (redcap_data_access_group = 'testgroup1') |
            | test_Admin | Update record (import) 3 | Assign record to Data Access Group (redcap_data_access_group = 'testgroup2') |
            | test_Admin | Update record (import) 2 | Assign record to Data Access Group (redcap_data_access_group = 'testgroup1') |

        Given I login to REDCap with the use "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.2200.100"
        And I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 2         |
            | 4         |
        And I log out

        Given I login to REDCap with the use "Test_User2"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.2200.100"
        And I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 3         |
        And I log out
#END