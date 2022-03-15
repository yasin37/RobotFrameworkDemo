*** Settings ***
Documentation    Page Object for Landing Page
Library    SeleniumLibrary
Resource    ../PO/Common.robot

*** Variables ***
${Error_Message_Login}    class:alert-danger

*** Keywords ***
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