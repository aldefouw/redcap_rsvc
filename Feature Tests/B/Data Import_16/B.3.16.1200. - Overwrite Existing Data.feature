Feature: User Interface: The system shall provide the option to allow blank values to overwrite existing saved values.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.1200.100 Data import overwrite existing values with blank

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
<<<<<<< HEAD
=======
    #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
>>>>>>> v14.7.0
    And I create a new project named "B.3.16.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
<<<<<<< HEAD
    #M: Will have to accept confirmation window "And I click on the button labeled "Ok" in the pop-up box"
    Then I see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Error during import
    When I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/B3161200100_INACCURATE.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file

    ##VERIFY
    Then I should see "ERROR:"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: w DAGs
    When I upload a "csv" format file located at "import_files/B3161200100_ACCURATE.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
=======
    Then I should see Project status: "Production"

    ##Verify Data present
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Data Access Group | Survey Identifier | Name | Email          |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |                   |                   |      | email@test.edu |

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Import new data, ignoring blank values
    When I click on the link labeled "Data Import Tool"
    Then I should see the button labeled "Choose File"

    When I click on the button labeled "Choose File"
    And I select the file labeled "B3161200100_ACCURATE"
    And I click on the button labeled "Upload "
    And I click on the button labeled "Upload File"

>>>>>>> v14.7.0

    ##VERIFY
    Then I should see "Your document was uploaded successfully"

    When I click on the button labeled "Import Data"
<<<<<<< HEAD
    Then I should see "Import Successful!"
=======
    Then I should see "Import Successful!"

    ##Verify Data present
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Data Access Group | Survey Identifier | Name | Email          |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |                   |                   |      | email@test.edu |

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Import new data, overwrite blank values
    When I click on the link labeled "Data Import Tool"
    Then I should see the button labeled "Choose File"

    When I click on the button labeled "Choose File"
    And I select "Yes, blank values in the file will overwrite existing values" on the dropdown field labeled "Overwrite data with blank values?"
    And I click on the button labeled "Yes, I understand" in the dialog box
    And I select the file labeled "B3161200100_ACCURATE"
    And I click on the button labeled "Upload "
    And I click on the button labeled "Upload File"

    ##VERIFY
    Then I should see "Your document was uploaded successfully"

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    ##Verify Data was overwritten with a blank
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Data Access Group | Survey Identifier | Name | Email |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |                   |                   |      |       |
#End
>>>>>>> v14.7.0
