Feature: User Interface: The system shall report background process data import errors.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1700.100 Download Errors with Background Data Import
     #REDUNDANT Tested in B.3.16.1400
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        Given I click on the link labeled "Data Import Tool"
        When I click on the dropdown labeled "Import as background process"
        And I upload the file labeled "BigDataTestProjectbadDATA.csv"
        And I click on the button labeled "Upload"
        And I click the button labeled "Yes, use background process"
        And I click the button labeled "Confirm"
        And I click on the button labeled "Upload"
        Then I should see "Your file is currently being uploaded. Please wait"
        ##M this may take several minutes

        Given I Click on the "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the table:
            | Record ID | Form 1 |
            | 1         |        |
            | 3         |        |
            | 5         |        |
            | 6         |        |
        And I should see all records are in an unverified status
        ##M note Records were skipped, user receives email with link to the "View background Imports" where they can click the View details button where they can either Download list of all errors or Download records/data that did not import

        #VERIFY
        When I click the Link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username            | Action             | List of Data Changes OR Fields Exported |
            | SYSTEM (Test_Admin) | Create Record 3000 | record_id='3000'                        |

        When I click the button labeled "View Details"
        And I click the button labeled "Download list of all errors"
        Then I should see a table header and rows including the following values in the logging table:
            | Record | Variable Name | Value        | Error Message                                                                                                   |
            | 2      | field 1       | Not a number | The value you provided could not be validated because it does not follow the expected format. Please try again. |
            | 4      | field 2       | 3            | The value is not a valid category for field_2                                                                   |
            | 7      | field 1       | 99-3         | The value you provided could not be validated because it does not follow the expected format. Please try again. |

        When I click the button labeled "Download records/data that did not import"
        Then I should see a table header and rows including the following values in the logging table:
            | record_id | field 1      | field_2 | field_3                    |
            | 2         | not a number | 1       | Lorem ipsum dolor sit amet |
            | 4         | 44           | 3       | Lorem ipsum dolor sit amet |
            | 7         | 99-3         | 1       | Lorem ipsum dolor sit amet |
#END