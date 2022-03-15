*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    DataDriver    file=Data/my_data.csv    encoding=UTF-8
Resource    ../PO/Common.robot
Test Template    Validate UnSuccesful Login
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page



*** Variables ***
${Error_Message_Login}     class:alert-danger

*** Test Cases ***

Login with user ${username} and password ${password} so message is ${expectedResult}    xyz    123456    Incorrect username/password.

*** Keywords ***

Validate UnSuccesful Login
    [Arguments]    ${username}    ${password}    ${expectedResult}
     Fill the login Form    ${username}    ${password}
     wait until it checks and display error message
     verify error message is correct    ${expectedResult}

Fill the login Form
    [Arguments]    ${username}    ${password}
    input text    username    ${username}
    input password    password    ${password}
    click button    signInBtn


wait until it checks and display error message
    wait until element is visible    ${Error_Message_Login}    20

verify error message is correct
    [Arguments]    ${expectedResult}
    ${text} =    get text    ${Error_Message_Login}
    log    ${text}
    should be equal as strings    ${text}    ${expectedResult}    # First Method to Verify
    element text should be    ${Error_Message_Login}    ${expectedResult}    # Second Method to Verify (Prefered)





