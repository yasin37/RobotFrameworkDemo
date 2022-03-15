*** Settings ***
Documentation   To validate the Login form
Resource    ../PO/Common.robot
Library     SeleniumLibrary
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    open login page
Test Template   Validate UnSuccesful Login


*** Variables ***
${Error_Message_Login}      css:.alert-danger


*** Test Cases ***    username    password

Invalid username        dsahed          learning
Invalid password        rahulshetty     ploudfg
special characters      @#$             learning


*** Keywords ***
Validate UnSuccesful Login
    [Arguments]     ${username}     ${password}
    Fill the login Form    ${username}      ${password}
    wait until it checks and display error message
    verify error message is correct


Fill the login Form
    [arguments]     ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible       ${Error_Message_Login}

verify error message is correct
   ${result}=   Get Text    ${Error_Message_Login}
   Should Be Equal As Strings     ${result}     Incorrect username/password.
   Element Text Should Be       ${Error_Message_Login}      Incorrect username/password.