Feature: User Interface: The system shall support ranges for the following data types:  Date (Y-M-D) | Datetime (Y-M-D H:M) | Datetime w/seconds (Y-M-D H:M:S) | Integer | Number | Number (1 Decimal Place,  comma as decimal) | Time (HH:MM)  | Time (MM:SS) | Time (HH:MM:SS)

  As a REDCap end user
  I want to see that Field validation is functioning as expected

  Scenario: B.4.8.300.100 Field range validation

        #SETUP
    Given I login to REDCap with the user "Test_User1"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named "B.4.8.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.8.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

        ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    And I click on the button labeled "Expand all instruments"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name | Field Label       | Field Attributes                                                                |
      | [date_ymd]            | date YMD          | text (date_ymd, Min: 2023-08-01, Max: 2023-08-31)                               |
      | [datetime_ymd_hm]     | Datetime          | text (datetime_ymd, Min: 2023-09-01 01:01, Max: 2023-09-30 01:59)               |
      | [datetime_ymd_hmss  ] | Datetime YMD HMSS | text (datetime_seconds_ymd, Min: 2023-09-01 11:01:01, Max: 2023-09-30 11:01:01) |
      | [email]               | Email             | text (email)                                                                    |
      | [integer]             | Integer           | text (integer, Min: 1, Max: 100)                                                |
      | [number]              | Number            | text (number, Min: 1, Max: 5)                                                   |
      | [number_dec]          | Number Decimal    | text (number_1dp, Min: 1.0, Max: 5.0)                                           |
      | [num_comma]           | Number Comma      | text (number_1dp_comma_decimal, Min: 1,0, Max: 2,0)                             |
      | [time_hhmm]           | Time HH:MM        | text (time, Min: 08:05, Max: 23:00)                                             |
      | [time_mm_ss]          | Time MM:SS        | text (time_mm_ss, Min: 02:01, Max: 59:00)                                       |
      | [time_hhmmss]         | Time HH:MM:SS     | text (time_hh_mm_ss, Min: 8:01:01, Max: 23:00:00)                               |

        #FUNCTIONAL REQUIREMENT
        ##ACTION - Verify field validation within range text
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Date Types" for event "Event 1"
    Then I should see "Adding new Record ID 5."

    When I enter "2023-08-02" in the field labeled "date YMD"
    And I enter "2023-09-02 12:12" in the field labeled "Datetime"
    And I enter "2023-09-02 12:12:12" in the field labeled "Datetime YMD HMSS"
    And I enter "3" in the field labeled "Integer"
    And I enter "3" in the field labeled "Number"
    And I enter "1.5" in the field labeled "Number Decimal"
    And I enter "1,5" in the field labeled "Number Comma"
    And I enter "11:11" in the field labeled "Time HH:MM"
    And I enter "11:11:11" in the field labeled "Time HH:MM:SS"
    And I enter "11:11" in the field labeled "Time MM:SS"
    And I click the button labeled "Save and Exit Form"
    Then I should see "Record ID 5 successfully added."

        #FUNCTIONAL REQUIREMENT
        ##ACTION - Verify field validation outside lower bound
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Date Types" for event "Event 1"
    And I enter "2022-08-02" in the field labeled "date YMD"
    Then I should see "The value you provided is outside the suggested range (2023-08-01 - 2023-08-31). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "2022-08-02 12:12" in the field labeled "Datetime"
    Then I should see "The value you provided is outside the suggested range (2023-09-01 01:01 - 2023-09-30 01:59). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "2022-08-02 12:12:12" in the field labeled "Datetime YMD HMSS"
    Then I should see "The value you provided is outside the suggested range (2023-09-01 11:01:01 - 2023-09-30 11:01:01). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "0" in the field labeled "Integer"
    Then I should see "The value you provided is outside the suggested range (1 - 100). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "0" in the field labeled "Number"
    Then I should see "The value you provided is outside the suggested range (1 - 5). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "0.0" in the field labeled "Number Decimal"
    Then I should see "The value you provided is outside the suggested range (1.0 - 5.0). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "0,0" in the field labeled "Number Comma"
    Then I should see "The value you provided is outside the suggested range (1,0 - 2,0). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "07:07" in the field labeled "Time HH:MM"
    Then I should see "The value you provided is outside the suggested range (08:05 - 23:00). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "01:00" in the field labeled "Time MM:SS"
    Then I should see "The value you provided is outside the suggested range (02:01 - 59:00). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "07:07:07" in the field labeled " Time HH:MM:SS"
    Then I should see "The value you provided is outside the suggested range (08:01:01 - 23:00:00). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I click the button labeled "Save and Exit Form"
    Then I should see "Record ID 6 successfully added."
        

        #FUNCTIONAL REQUIREMENT
        ##ACTION - Verify field validation outside upper bound
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble labeled "Date Types" for event "Event 1"
    And I enter "2024-08-02" in the field labeled "date YMD"
    Then I should see "The value you provided is outside the suggested range (2023-08-01 - 2023-08-31). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "2024-08-02 12:12" in the field labeled "Datetime"
    Then I should see "The value you provided is outside the suggested range (2023-09-01 01:01 - 2023-09-30 01:59). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "2024-08-02 12:12:12" in the field labeled "Datetime YMD HMSS"
    Then I should see "The value you provided is outside the suggested range (2023-09-01 11:01:01 - 2023-09-30 11:01:01). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "200" in the field labeled "Integer"
    Then I should see "The value you provided is outside the suggested range (1 - 100). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "10" in the field labeled "Number"
    Then I should see "The value you provided is outside the suggested range (1 - 5). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "6.0" in the field labeled "Number Decimal"
    Then I should see "The value you provided is outside the suggested range (1.0 - 5.0). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "3,0" in the field labeled "Number Comma"
    Then I should see "The value you provided is outside the suggested range (1,0 - 2,0). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "23:07" in the field labeled "Time HH:MM"
    Then I should see "The value you provided is outside the suggested range (08:05 - 23:00). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "59:01" in the field labeled "Time MM:SS"
    Then I should see "The value you provided is outside the suggested range (02:01 - 59:00). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I enter "23:07:07" in the field labeled " Time HH:MM:SS"
    Then I should see "The value you provided is outside the suggested range (08:01:01 - 23:00:00). This value is admissible, but you may wish to double check it." in the dialog box

    When I click the button labeled "Close" in the dialog box
    And I click the button labeled "Save and Exit Form"
    Then I should see "Record ID 7 successfully added."

        ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table row containing the following values in the logging table:
      | Username   | Action                                   | List of Data Changes                      |
      | test_user1 | Update record 7                          | time_hhmm = '23:07'                       |
      | test_user1 | Update record 7                          | time_mm_ss = '59:01'                      |
      | test_user1 | Update record 7                          | time_hhmmss = '23:07:07'                  |
      | test_user1 | Update record 7                          | date_ymd = '2024-08-02'                   |
      | test_user1 | Update record 7                          | datetime_ymd_hm = '2024-08-02 12:12'      |
      | test_user1 | Update record 7                          | datetime_ymd_hmss = '2024-08-02 12:12:12' |
      | test_user1 | Update record 7                          | integer = '200'                           |
      | test_user1 | Update record 7                          | number = '10'                             |
      | test_user1 | Update record 7                          | number_dec = '6.0'                        |
      | test_user1 | Update record 7                          | num_comma = '30'                          |
      | test_user1 | Update record 6                          | date_ymd = '2022-08-02'                   |
      | test_user1 | Update record 6                          | datetime_ymd_hm = '2022-08-02 12:12'      |
      | test_user1 | Update record 6                          | datetime_ymd_hmss = '2022-08-02 12:12:12' |
      | test_user1 | Update record 6                          | integer = '0'                             |
      | test_user1 | Update record 6                          | number = '0'                              |
      | test_user1 | Update record 6                          | number_dec = '0.0'                        |
      | test_user1 | Update record 6                          | num_comma = '00'                          |
      | test_user1 | Update record 6                          | time_hhmm = '01:00'                       |
      | test_user1 | Update record 6                          | time_mm_ss = '00:07'                      |
      | test_user1 | Update record 6                          | time_hhmmss = '07:07:07'                  |
      | test_user1 | Update record 5                          | date_ymd = '2023-08-02'                   |
      | test_user1 | Update record 5                          | datetime_ymd_hm = '2023-09-02 12:12'      |
      | test_user1 | Update record 5                          | datetime_ymd_hmss = '2023-09-02 12:12:12' |
      | test_user1 | Update record 5                          | integer = '3'                             |
      | test_user1 | Update record 5                          | number = '3'                              |
      | test_user1 | Update record 5                          | number_dec = '1.5'                        |
      | test_user1 | Update record 5                          | num_comma = '15'                          |
      | test_user1 | Update record 5                          | time_hhmm = '11:11'                       |
      | test_user1 | Update record 5                          | time_mm_ss = '11:11'                      |
      | test_user1 | Update record 5	time_hhmmss = '11:11:11' |
#END