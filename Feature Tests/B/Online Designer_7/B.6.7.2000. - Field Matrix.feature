Feature: Field Creation: The system shall support the creation and spliting matrix of fields

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.2000.100 Matrix of Fields through the Online Designer

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "B.6.7.1600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

        ##SETUP_PRODUCTION
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.2000.100"
        And I click on the button labeled "Online Designer"


        #FUNCTIONAL_REQUIREMENT
        ##ACTION: matrix fields creation
        When I click on the instrument labeled "Form 1"
        And I click on the button labeled "Add matrix of Fields"
        And add "Vanilla" into the box labeled "Field Label"
        And I add "flavor1" into the box labeled "Variable Name"
        And I click the button labeled "Add another row"
        And I add "Chocolate" into the box labeled "Field Label"
        And I add "flavor2" into the box labeled "Variable Name"
        And I click the button labeled "Add another row"
        And I add "Strawberry" into the box labeled "Field Label"
        And I add "flavor3" into the box labeled "Variable Name"
        And I click the button labeled "Add another row"

        And I add a new Matrix Column Choices
        And I enter "1, Dislike" on the first row of the input field labeled "Choices (one choice per line)"
        And I enter "2, Neutral" on the second row of the input field labeled "Choices (one choice per line)"
        And I enter "3, Love" on the third row of the input field labeled "Choices (one choice per line)"
        And I enter "ice_cream" in the box labeled "Matrix group name"
        And I click on the button labeled "Save"
        Then I should see the field labeled "Matrix Group: ice_cream"
        And I should see the radio button options "Dislike","Neutral "Love"

        ##VERIFY_LOGGING
        When I click on "Logging"
        Then I should see "Create matrix of fields"

        #VERIFY: SPLIT OF MATRIX
        When I click the link labeled "Designer"  
        And I click on the instrument labeled "Form 1"
        When I click on the icon labeled "Edit Matrix" on the field labeled "Matrix Group: ice_cream"
        And I click the button labeled "Save & split into separate fields"
        And I click the button labeled "Split matrix"
        Then I should see a field name  with the variable name " flavor1"
        And I should see a field name  with the variable name " flavor2"
        And I should see a field name  with the variable name " flavor2"

        ##VERIFY_LOGGING
        When I click on "Logging"
        Then I should see "Edit matrix of fields"
#END