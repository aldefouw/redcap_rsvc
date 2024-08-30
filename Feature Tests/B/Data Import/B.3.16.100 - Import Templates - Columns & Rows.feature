Feature: User Interface: The system shall support the ability to download two versions of a data import template formatted as a CSV file, one to accommodate records in rows and one to accommodate records in columns.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.100.100 data import template rows
        #ATS requires two scenarios for assessing the row and column file
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status: Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Data Import Template (with records in rows)
        When I click on the link labeled "Data Import Tool"
        Then I should see "Download your Data Import Template"

        When I click on the link labeled "Download your Data Import Template (with records in rows)"
        Then I should receive a download to a csv file labeled "B316100100_ImportTemplate_yyyy_mm_dd"

        ##VERIFY
        When I open the csv file labeled "B316100100_ImportTemplate_[timestamp]"
        Then I should see "record_id" in the column labeled "A"
        And I should see "name" in the column labeled "B"
    #M: close csv file
    #END

    Scenario: B.3.16.100.200 data import template column
        #ATS requires two scenarios for assessing the row and column file
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.100.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status: Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Data Import Template (with records in columns)
        Given I click on link labeled "Data Import Tool"
        Then I should see "download the template with records in column format"

        When I click on the link labeled "column format"
        Then I should receive a download to a csv file labeled "B316100200_ ImportTemplate_ yyyy_mm_dd"
        #M: close csv file

        ##VERIFY
        When I open the csv file labeled "B316100200_ImportTemplate_ yyyy_mm_dd "
        Then I should see "record_id"  in the row labeled "2"
        And I should see "name" in the row labeled "3"
#END