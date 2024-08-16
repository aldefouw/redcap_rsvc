Feature: User Interface: Longitudinal Project Settings: The system shall support multiple study arms and the ability to define unique event schedules for each arm.

  As a REDCap end user
  I want to see that Project Setup is functioning as expected

  Scenario: B.4.27.500.100 Create unique event schedules for multiple arms
    #A.6.4.600
    ##SETUP_DEV
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.4.27.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    Then I should see a link labeled "Add New Arm"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION ADDING NEW ARM
    When I click on the link labeled "Add New Arm"
    And I enter "Arm 3" into the input field labeled "Arm name:"
    And I click on the button labeled "Save"
    #VERIFY
    Then I should see "Arm name:  Arm 3"

    ##ACTION ADD NEW EVENT TO NEW ARM
    Given I add an event named "Event 1" with offset of 0 days into the currently selected arm
    Then I should see "Event 1"


    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_admin | Manage/Design | Create event                            |
      | test_admin | Manage/Design | Create arm                              |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION ADD NEW EVENT TO EXISTING ARM
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 1"
    Then I should see the button labeled "Add new event"

    Given I add an event named "Event 4" with offset of 4 days into the currently selected arm
    ##VERIFY
    Then I should see "Event 4"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_admin | Manage/Design | Create event                            |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION  DESIGNATE INSTRUMENTS -  #REDUNDANT #A.6.4.600
    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 1"
    #VERIFY
    Then I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 2"
    And I verify the Data Collection Instrument named "Data Types" is disabled for the Event named "Event Three"


    ##ACTION:  DESIGNATE INSTRUMENTS different arm-  #REDUNDANT #A.6.4.600
    When I click on the link labeled "Arm 2"
    ##VERIFY
    Then I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1"


    ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 1"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 1"
    And I should NOT see "Event Three"
    Then I should see a table header containing the following values in the record status dashboard table:
      | Record ID | Event 1 | Event 2 |

    When I click on the link labeled "Arm 2"
    And I should NOT see "Event 2"
    And I should NOT see "Event Three"
    Then I should see a table header containing the following values in the record status dashboard table:
      | Record ID | Event 1 |
