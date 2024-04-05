Feature: User Interface: The system shall support the ability to download two versions of a data import template formatted as a CSV file, one to accommodate records in rows and one to accommodate records in columns.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.100.100 data import template
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.16.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Data Import Template (with records in rows)
    When I click on the link labeled "Data Import Tool"
    Then I should see a link labeled "Download your Data Import Template"
    And I click on the link labeled "Download your Data Import Template" to download a file
    Then I should see a downloaded file named "B316100100_ImportTemplate_yyyy-mm-dd.csv"

    ##VERIFY
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has the headings below
      | record_id | name | email | text_validation_complete | ptname | bdate | role | notesbox | multiple_dropdown_auto | multiple_dropdown_manual | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | required | identifier_ssn | identifier_phone | slider | date_time_hh_mm | date_time_hh_mm_ss | data_types_complete | data_dictionary_form_complete | phone | demo_branching_complete |  |
    #M: close csv file

    #FUNCTIONAL REQUIREMENT
    ##ACTION Data Import Template (with records in columns)
    Given I click on the link labeled "Data Import Tool"
    Then I should see a link labeled "column format"
    And I click on the link labeled "column format" to download a file
    Then I should see a downloaded file named "B316100100_ImportTemplate_yyyy-mm-dd.csv"
    #M: close csv file

    ##VERIFY
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "record_id" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "name" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "email" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "text_validation_complete" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "ptname" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "bdate" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "role" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "notesbox" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "multiple_dropdown_auto" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "multiple_dropdown_manual" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "multiple_radio_auto" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "radio_button_manual" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "checkbox___1" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "checkbox___2" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "checkbox___3" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "required" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "identifier_ssn" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "identifier_phone" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "slider" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "date_time_hh_mm" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "date_time_hh_mm_ss" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "data_types_complete" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "data_dictionary_form_complete" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "phone" for column "Variable / Field Name"
    And the CSV file at path "B316100100_ImportTemplate_yyyy-mm-dd.csv" has a value "demo_branching_complete" for column "Variable / Field Name"