*** Settings ***
Documentation    Validate Unsucessfull Login
Library    SeleniumLibrary
Resource    ../PO/Common.robot
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page

*** Variables ***
${Error_Message_Element}    xpath://div[@class='alert alert-danger col-md-12']
${Error_Message_Text}    Incorrect username/password.

*** Test Cases ***
Validate Unsuccessful Login
    Fill the login form    ${username}    ${invalid_password}
    Wait until it checks and display error message
    Verify error message is correct

*** Keywords ***
Fill the login form
    [Arguments]    ${username}    ${invalid_password}
    input text    username    ${username}    # id: is not necessary
    input password    password    ${invalid_password}
    click button    signInBtn

Wait until it checks and display error message
    wait until element is visible    ${Error_Message_Element}

Verify error message is correct
    # Method-1
    ${result} =    get text    ${Error_Message_Element}
    should be equal as strings    ${result}    ${Error_Message_Text}

    # Method-2
    element text should be    ${Error_Message_Element}    ${Error_Message_Text}







