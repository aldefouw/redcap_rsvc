Feature: User Interface: The system shall provide the ability for the user importing data to stop non-imported data during the background data import

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.2100.100 Stop non-imported data during the background data import
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.2100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        Given I click on the link labeled "Data Import Tool"
        And I click on the dropdown labeled "Import as background process"
        And I upload the file labeled "BigDataTestProjectDATA.csv"
        And I click on the button labeled "Upload"
        And I click the button labeled "Yes, use background process"
        And I click the button labeled "Confirm"
        And I click on the button labeled "Upload File"
        Then I should see "Your file is currently being uploaded. Please wait"
        ##M this may take several minutes while the system analyzes for errors

        And I Should see "File was uploaded and will be processed soon"
        And I click the button labeled "Close"
        And I click the tab labeled "View Background imports"
        And I click the button labeled "Halt imports"
        Then I should see "Cancel this background import?"
        And I click the button labeled "Yes, cancel it now"
        Then I should see "Success"
        And I click the button labeled "Close"

        #VERIFY: LOGGING
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes              |
            | test_admin | Manage/Design | Move project to Production status |
#END