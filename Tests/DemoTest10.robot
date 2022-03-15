*** Settings ***
Documentation    To validate the Login form as Data Driven Test with DataDriver Library
Library    SeleniumLibrary
Library    DataDriver   file=Data/my_data.csv    encoding=UTF-8
Resource    ../PO/Common.robot
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page
Test Template    Validate UnSuccesful Login

*** Variables ***
${Error_Message_Login}    class:alert-danger

*** Test Cases ***

Login with ${username} and ${password} so message is ${expectedResult}    xyz    123456    Incorrect username/password

*** Keywords ***

Validate UnSuccesful Login
    [Arguments]    ${username}    ${password}    ${expectedResult}
    Fill the login form    ${username}    ${password}
    wait until it checks and display error message
    verify error message is correct    ${expectedResult}

Fill the login form
    [Arguments]    ${username}    ${password}
    input text    username    ${username}
    input password    password    ${password}
    click button    signInBtn

wait until it checks and display error message
    wait until element is visible    class:alert-danger    20

verify error message is correct
    [Arguments]    ${expectedResult}
    ${text}    get text    ${Error_Message_Login}
    log    ${text}
    should be equal as strings    ${text}    ${expectedResult}
    element text should be    ${Error_Message_Login}    ${expectedResult}
