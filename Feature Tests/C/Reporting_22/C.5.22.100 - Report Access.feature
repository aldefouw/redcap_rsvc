Feature: User Interface: The system shall support the ability to assign the User Access to View Access and Edit Access in the Reporting module

  As a REDCap end user
  I want to see that Reporting is functioning as expected

  Scenario: C.5.22.100.100 - MISSING SCENARIO TITLE
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.5.22.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #SETUP: Assign record 1 to DAG1
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled exactly "1"
    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"
    When I select "TestGroup1" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 1 was successfully assigned to a Data Access Group"

    #SETUP: Assign record 2 to DAG2
    # Is this TestGroup2?
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled exactly "2"
    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"
    When I select "TestGroup2" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 2 was successfully assigned to a Data Access Group"

    #USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"

    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "TestGroup1" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "successfully ASSIGNED to the user role"
    Then I should see a table header and rows containing the following values in a table:
      | Role name    | Username   | Data Access Group |
      | 1_FullRights | test_user1 | TestGroup1        |

    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"

    And I select "2_Edit_RemoveID" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I select "TestGroup2" on the dropdown field labeled "Assign To DAG" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "successfully ASSIGNED to the user role"
    Then I should see a table header and rows containing the following values in a table:
      | Role name       | Username   | Data Access Group |
      | 1_FullRights    | test_user1 | TestGroup1        |
      | 2_Edit_RemoveID | test_user2 | TestGroup2        |

    When I enter "Test_User3" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I uncheck the User Right named "Add/Edit/Organize Reports"
    And I click on the button labeled "Add user"
    Then I should see "successfully added"
    Then I should see a table header and rows containing the following values in a table:
      | Role name       | Username   | Data Access Group |
      |                 | test_user3 |                   |
      | 1_FullRights    | test_user1 | TestGroup1        |
      | 2_Edit_RemoveID | test_user2 | TestGroup2        |

    #SETUP: Create report
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "C.5.22.100.100 REPORT" into the input field labeled "Name of Report:"
    #FUNCTIONAL_REQUIREMENT
    ##ACTION
    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!" in the dialog box
    And I click on the button labeled "Return to My Reports & Exports"
    And I logout

    ##VERIFY: USER 1
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    #
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |

    When I click on the button labeled "View Report" for the report named "C.5.22.100.100 REPORT"

    Then I should see table rows containing the following values in the report data table:
      | 1 | Event Three (Arm 1: Arm 1) |

    And I should NOT see a link labeled exactly "2"
    And I should NOT see a link labeled exactly "3"
    And I should NOT see a link labeled exactly "4"

    ##VERIFY: Edit Report button
    And I should see a button labeled "Edit Report"
    And I logout

    ##VERIFY: USER 2
    Given I login to REDCap with the user "Test_User2"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |

    When I click on the button labeled "View Report" for the report named "C.5.22.100.100 REPORT"
    Then I should see table rows containing the following values in the report data table:
      | 2 | Event 1 (Arm 1: Arm 1) |

    And I should NOT see a link labeled exactly "1"
    And I should NOT see a link labeled exactly "3"
    And I should NOT see a link labeled exactly "4"

    ##VERIFY: Edit Report button
    And I should see a button labeled "Edit Report"
    And I logout

    ##VERIFY: USER 3
    Given I login to REDCap with the user "Test_User3"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |

    ##VERIFY: cannot create report, edit, delete or copy report
    Then I should NOT see a button labeled "Edit"
    And I should NOT see a button labeled "Copy"
    And I should NOT see a button labeled "Delete"

    When I click on the button labeled "View Report" for the report named "C.5.22.100.100 REPORT"
    Then I should see table rows containing the following values in the report data table:
      | 1 | Event 1 (Arm 1: Arm 1) |
      | 2 | Event 1 (Arm 1: Arm 1) |
      | 3 | Event 1 (Arm 1: Arm 1) |
      | 4 | Event 1 (Arm 1: Arm 1) |
    Then I should see a link labeled exactly "1"
    And I should see a link labeled exactly "2"
    And I should see a link labeled exactly "3"
    And I should see a link labeled exactly "4"

    ##VERIFY: Edit Report button
    And I should NOT see a button labeled "Edit Report"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit" for the report named "C.5.22.100.100 REPORT"
    Then I should see "Edit Existing Report"
    And I should see "C.5.22.100.100 REPORT"


    #FUNCTIONAL_REQUIREMENT
    ##ACTION
    When I select the radio option "Custom user access" for the field labeled "View Access"

    And I select "test_user1 (Test User1)" on the multiselect field labeled "Selected users" in the View Access section of User Access
    And I select "test_user2 (Test User2)" on the multiselect field labeled "Selected users" in the View Access section of User Access

    When I select the radio option "Custom user access" for the field labeled "Edit Access"
    And I select "test_user1 (Test User1)" on the multiselect field labeled "Selected users" in the Edit Access section of User Access

    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!" in the dialog box
    And I click on the button labeled "Return to My Reports & Exports"
    And I logout

    ##VERIFY: USER 3
    Given I login to REDCap with the user "Test_User3"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should NOT see "C.5.22.100.100 REPORT"
    And I logout

    ##VERIFY: USER 2
    Given I login to REDCap with the user "Test_User2"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "C.5.22.100.100 REPORT"

    Then I should see table rows containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |

    #        NOTE: This fails because there is a "Test Report" row in this project that contains these buttons?
    #        And I should NOT see a button labeled "Edit"
    #        And I should NOT see a button labeled "Copy"
    #        And I should NOT see a button labeled "Delete"

    When I click on the button labeled "View Report" for the report named "C.5.22.100.100 REPORT"
    Then I should see "Number of results returned:1"

    #VERIFY: We see a link to Record ID 2 but none of the other records
    Then I should see a link labeled exactly "2"
    And I should NOT see a link labeled exactly "1"
    And I should NOT see a link labeled exactly "3"
    And I should NOT see a link labeled exactly "4"

    ##VERIFY: Edit Report button
    And I should NOT see a button labeled "Edit Report"
    And I logout

    ##VERIFY: USER 1
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.5.22.100.100"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "C.5.22.100.100 REPORT"

    Then I should see table rows containing the following values in the reports table:
      | 2 | C.5.22.100.100 REPORT |

    Then I should see the button labeled "Edit"
    And I should see the button labeled "Copy"
    And I should see the button labeled "Delete"

    When I click on the button labeled "View Report" for the report named "C.5.22.100.100 REPORT"
    Then I should see "Number of results returned:4"
    And I should see a link labeled exactly "1"
    And I should NOT see a link labeled exactly "2"
    And I should NOT see a link labeled exactly "3"
    And I should NOT see a link labeled exactly "4"

    ##VERIFY: Edit Report button
    And I should see a button labeled "Edit Report"
    And I logout