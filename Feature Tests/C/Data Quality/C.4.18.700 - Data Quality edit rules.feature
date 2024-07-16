Feature: User Interface: The system shall support editing of user defined rules.

  As a REDCap end user
  I want to see that Data Quality Module is functioning as expected

  Scenario: C.4.18.700.100 Edit rule

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.4.18.700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION  
    When I click on the link labeled "Project Setup"  
    And I click on the button labeled "Move project to production"   
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status:  "Production"
    #USER_RIGHTS  
    When I click on the link labeled "User Rights"  
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: 'Adding new user "Test_User1"'
    And I check the User Right named "User Rights"
    And I check the User Right named "Data Quality - Create & edit rules"
    And I check the User Right named "Data Quality - Execute rules"
    And I click on the button labeled "Add user" in the dialog box
    Then I should see "successfully added"
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_admin          |
      | —                       | test_user1          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |
    And I logout
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.4.18.700.100"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Manual rule add
    When I click on the link labeled "Data Quality"
    Then I should see "Data Quality Rules"

    When I enter "Integer" into the textarea field labeled "Enter descriptive name for new rule"
    And I enter "[integer]='1'" into the textarea field labeled "Enter logic for new rule"
    And I clear field and enter "[integer]='1'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Add"
    ##VERIFY
    Then I should see a table header and rows containing the following values in a table: 
    | Rule # | Rule Name   | Rule Logic (Show discrepancy only if...) |        
    |      3     |  Integer         |             [integer]='1'                           |  

    #FUNCTIONAL_REQUIREMENT
    ##ACTION executing rule 
    When I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name                                     | Rule Logic (Show discrepancy only if...) | Total Discrepancies |
      | A      | Blank values*                                 | -                                        | 377                 |
      | B      | Blank values* (required fields only)          | -                                        | 2                   |
      | C      | Field validation errors (incorrect data type) | -                                        | 1                   |
      | D      | Field validation errors (out of range)        | -                                        | 4                   |
      | E      | Outliers for numerical fields                 | -                                        | 2                   |
      | F      | Hidden fields that contain values***          | -                                        | 1                   |
      | G      | Multiple choice fields with invalid values    | -                                        | 1                   |
      | H      | Incorrect values for calculated fields        | -                                        | 26                  |
      | I      | Fields containing "missing data codes"        | -                                        | 4                   |
      | 1      | [radio]=9.9                                   | [radio]='9..9'                           | 1                   |
      | 2      | [ptname]<>[name]                              | [ptname]<>[name]                         | 8                   |
      | 3      | Integer                                       | [integer]='1'                            | 6                   |

    #USER_RIGHTS
    ##ACTION: change rights-cannot create rules  
    When I click on the link labeled "User Rights"  
    And I click on the link labeled "test_user1 (Test User1)"
    And I click on the button labeled "Edit user privileges"
    Then I uncheck the User Right named "Data Quality - Create & edit rules"
    And I click on the button labeled "Save Changes" 
    Then I should see 'User "test_user1" was successfully edited'


    #FUNCTIONAL_REQUIREMENT
    ##ACTION: cannot add rule and can execute rules
    When I click on the link labeled "Data Quality"
    Then I should see "Data Quality Rules"
    And I should NOT see a button labeled "Add"

    When I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name                                     | Rule Logic (Show discrepancy only if...) | Total Discrepancies |
      | A      | Blank values*                                 | -                                        | 377                 |
      | B      | Blank values* (required fields only)          | -                                        | 2                   |
      | C      | Field validation errors (incorrect data type) | -                                        | 1                   |
      | D      | Field validation errors (out of range)        | -                                        | 4                   |
      | E      | Outliers for numerical fields                 | -                                        | 2                   |
      | F      | Hidden fields that contain values***          | -                                        | 1                   |
      | G      | Multiple choice fields with invalid values    | -                                        | 1                   |
      | H      | Incorrect values for calculated fields        | -                                        | 26                  |
      | I      | Fields containing "missing data codes"        | -                                        | 4                   |
      | 1      | [radio]=9.9                                   | [radio]='9..9'                           | 1                   |
      | 2      | [ptname]<>[name]                              | [ptname]<>[name]                         | 8                   |
      | 3      | Integer                                       | [integer]='1'                            | 6                   |

    #USER_RIGHTS
    ##ACTION: change rights - cannot execute rules  
    When I click on the link labeled "User Rights"  
    And I click on the link labeled "test_user1 (Test User1)"
    And I click on the button labeled "Edit user privileges"
    Then I check the User Right named "Data Quality - Create & edit rules"
    Then I uncheck the User Right named "Data Quality - Execute rules"
    And I click on the button labeled "Save Changes" 
    Then I should see 'User "test_user1" was successfully edited'

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: can add rule and cannot execute rules
    When I click on the link labeled "Data Quality"
    Then I should see "Data Quality Rules"
    And I should see a button labeled "Add"
    And I should NOT see a button labeled "All"
    And I should NOT see a button labeled "Execute"