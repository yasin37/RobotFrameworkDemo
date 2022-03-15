*** Settings ***
Documentation    All the page objects and keywords of landing page for Landing Page
Library    SeleniumLibrary
Resource    Common.robot

*** Variables ***
${Error_Message_Login}     class:alert-danger

*** Keywords ***

Fill the login Form
    [Arguments]    ${username}    ${invalid_password}
    input text    username    ${username}
    input password    password    ${invalid_password}
    click button    signInBtn

wait until it checks and display error message
    wait until element is visible    ${Error_Message_Login}    20

verify error message is correct
    [Arguments]    ${expectedResult}
    ${text} =    get text    ${Error_Message_Login}
    log    ${text}
    should be equal as strings    ${text}    ${expectedResult}    # First Method to Verify
    element text should be    ${Error_Message_Login}    ${expectedResult}    # Second Method to Verify (Prefered)