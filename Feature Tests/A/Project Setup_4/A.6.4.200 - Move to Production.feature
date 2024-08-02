Feature: A.6.4.200 Manage project creation, deletion, and settings

  As a REDCap end user
  I want to see that project management features are functioning as expected

  Scenario: A.6.4.200.100 User requests admin move project to production
    #SETUP_CONTROL_CENTER
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

    When I select "No, only Administrators can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    Given I logout

    #SETUP_DEV
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "A.6.4.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Project Setup"

    #FUNCTIONAL REQUIREMENT
    ##ACTION User request move to production
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "Yes, Request Admin to Move to Production Status" in the dialog box to request a change in project status
    ##VERIFY
    Then I should see "Request pending"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported            |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Send request to move project to production status |

    Given I logout

    ##ACTION Admin moves project to production
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.100"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "To-Do List"
    Then I should see "Pending Requests"
    And I should see the "Move to prod" request created for the project named "A.6.4.200.100" within the "Pending Requests" table

    When I click on the "process request" icon for the "Move to prod" request created for the project named "A.6.4.200.100" within the "Pending Requests" table
    Then I should see "Move Project To Production Status" in the iframe

    When I click on the radio labeled "Keep ALL data saved so far." in the dialog box in the iframe
    And I click on the button labeled "YES, Move to Production Status" in the dialog box in the iframe
    And I close the iframe window
    Then I should see the "Move to prod" request created for the project named "A.6.4.200.100" within the "Completed & Archived Requests" table

    ##VERIFY
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.100"
    Then I should see Project status: "Production"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Move project to Production status      |


  Scenario: A.6.4.200.200 User moves project to production
    #SETUP_CONTROL_CENTER
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

    When I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    Given I logout

    #SETUP_DEV
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.200.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Project Setup"

    #FUNCTIONAL REQUIREMENT
    ##ACTION User moves project into production
    When I should see a button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    ##VERIFY_PRODUCTION
    Then I should see Project status: "Production"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Move project to Production status      |
        #End