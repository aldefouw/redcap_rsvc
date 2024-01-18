Feature: User Interface: The logging module shall be secure, tamper-proof, and not susceptible to unauthorized modifications.

As a REDCap end user
I want to see that Logging Module is functioning as expected

Scenario: B.2.23.400.100 Logging module security
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.2.23.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
When I click on the link labeled "My Projects" 
And I click on the link labeled "B.2.23.400.100" 

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I see "Project status:  Production"

#USER_RIGHTS
And I click on the link labeled "User Rights"  
And I enter "Test_User1" in field labeled "Add with custom rights" 
And I verify the User Right named "Logging" is unchecked
And I click on the button labeled "Add user"
Then I should see "User "test_user1" was successfully added"

#FUNCTIONAL REQUIREMENT
##ACTION: Logging Module - Admin unable to edit
When I click on the link labeled "Logging"
##VERIFY
Then I should not see Edit/Modify/Upload
And I logout 

#FUNCTIONAL REQUIREMENT
Given I login to REDCap with the user "Test_User1" 
When I click on the link labeled "My Projects" 
##ACTION: Logging Module - Restricted access to module
And I click on the link labeled "B.2.23.400.100" 
##VERIFY 
Then I should NOT see the link labeled "Logging"

