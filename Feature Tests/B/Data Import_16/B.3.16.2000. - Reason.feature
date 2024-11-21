Feature: User Interface: The system shall provide the ability to require a reason when modifying records via real-time data import

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.2000.100 reason when modifying records via real-time data import

        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.2000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project Status: Production"

        #SETUP DRW
        When I click the button labeled " Additional customization "
        And I select "Require a 'reason' when making changes to existing records? "
        And I click the button labeled "Save"

        #FUNCTIONAL REQUIREMENT
        ##ACTION
        When I click on the link labeled "Data Import Tool"
        And I click on the tab labeled "CVS import"
        Then I should see the button labeled "Choose File"

        When I click on the button labeled "Choose File"
        And I upload the csv file labeled "B3.16.2000.100data.csv"
        And I click on the button labeled "Upload File"
        Then I should see "Your document was uploaded successfully and is ready for review"

        When I click on the button labeled "Import Data"
        Then I should see "Please supply a reason for the data changes for EACH existing records in the text boxes" in the " Data Display Table "
        And I enter "because I said so"
        And I click the link labeled "Copy to all "
        And I click the button labeled "Import Data"
        Then I should see "Import Successful! "

        #VERIFY
        When I click the Link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported | Reason for Data Change |
            | test_Admin | Update record | [instance=3]                            | because I said so      |
#END