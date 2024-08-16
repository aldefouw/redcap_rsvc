Feature: User Interface: The system shall provide the option to allow blank values to overwrite existing saved values.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.1200.100 Data import overwrite existing values with blank

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.16.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    #M: Will have to accept confirmation window "And I click on the button labeled "Ok" in the pop-up box"
    Then I see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Error during import
    When I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/B3161200100_INACCURATE.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file

    ##VERIFY
    Then I should see "ERROR:"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: w DAGs
    When I upload a "csv" format file located at "import_files/B3161200100_ACCURATE.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file

    ##VERIFY
    Then I should see "Your document was uploaded successfully"

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"