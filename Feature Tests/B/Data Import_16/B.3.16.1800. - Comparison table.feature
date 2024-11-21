Feature: User Interface:The system shall provide the ability to display real-time process data comparison table

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1800.100 Data Import real-time process data comparison table
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button
        
        #SETUP_PRODUCTION
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        Given I click on the link labeled "Data Import Tool"
        When I click on the dropdown labeled "Import in real time"
        And I select "Yes, display uploaded data prior to importing"
        And I select the file labeled "BigDataTestProjectDATA.csv"
        And I click on the button labeled "Upload File"
        Then I should see " File is Large. Consider using the background process"

        When I click the button labeled "No, import in real time"
        And I click on the button labeled "Upload File"
        Then I should see "Instructions for Data Review"

        When I Click the Button labeled "Import Data"
        Then I should see "Import successful! 75 records were created or modified during the import"

        Given I Click on the "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the table:
            | Record ID | Form 1 |
            | 1         |        |
            | 2         |        |
            | 3         |        |
            | 4         |        |
        And I should see all records are in an unverified status
        #VERIFY
        When I click the Link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username    | Action                   | List of Data Changes OR Fields Exported |
            | test_admin) | Create Record (import)75 | record_id='75                           |
#END