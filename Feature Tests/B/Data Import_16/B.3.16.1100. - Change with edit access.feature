Feature: User Interface: The system shall allow data to be changed only by a user who has edit access to the data entry form.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1100.100 Data import of modified record limited by user rights with edit rights
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        ##ACTION: Import data
        When I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.2000.100data.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload" to upload the file
        And I click the button labeled "Upload File"

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

    Scenario: B.3.16.1100.200 Data import of modified record limited by user rights without edit rights

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Add User with Basic custom rights

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see a dialog containing the following text: "Adding new user"

        When I uncheck the User Right named "Data Import Tool"
        And I uheck the User Right named "Logging"
        And I click on the link labeled "Add User" in the dialog box

        ##VERIFY_LOG: Verify Update user rights
        And I click on the button labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action   | List of Data Changes OR Fields Exported |
            | test_admin | Add User | test_user1                              |
        Given I logout

        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.1100.100"
        Then I should NOT see "Data Import Tool"
#End