*** Settings ***
Documentation    Validating Login Form
Resource    ../PO/Common.robot
Library    SeleniumLibrary
Library    Collections
Library    String
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    open login page

*** Variables ***
${Error_Message_Login_Element}    xpath://div[@class='alert alert-danger col-md-12']
${Error_Message_Login_Text}    Incorrect username/password.

*** Test Cases ***

Validate Child window Functionality
    [Tags]    REGRESSION
    Select the link of Child window
    Verify the user is Switched to Child window
    Grab the Email id in the Child Window
    Switch to Parent window and enter the Email
    Fill the login form    ${new_email}    ${invalid_password}
    wait until Element is located in the page    ${Error_Message_Login_Element}
    Verify error message is correct

*** Keywords ***


Select the link of Child window
    click link    Free Access to InterviewQues/ResumeAssistance/Material      #click element    xpath://a[@class='blinkingText']

Verify the user is Switched to Child window
    switch window    NEW
    wait until element is visible    //h1
    element text should be    //h1    DOCUMENTS REQUEST

Grab the Email id in the Child Window
    ${text} =    get text    css:.red     # the element is used to get fulll text then grab the email address with split string
    log    ${text}
    @{words} =    split string    ${text}    at
    log    ${words}
    #0 --> Please email us
    #1 --> mentor@rahulshettyacademy.com with below templ
    #2 --> e to receive response

    ${text_split} =    get from list  ${words}    1
    log    ${text_split}

    @{words_2} =    split string    ${text_split}
    #0 --> mentor@rahulshettyacademy.com
    #1 --> with below templ

   ${new_email} =    get from list    ${words_2}    0
   log     ${new_email}
   set global variable    ${new_email}    # THIS IS IMPORTANT


Switch to Parent window and enter the Email

    switch window    MAIN
    title should be    LoginPage Practise | Rahul Shetty Academy
    # input text    username    ${new_email}

Fill the login form
    [Arguments]    ${username}    ${password}
    input text    username    ${username}    # id: is not necessary
    input password    password    ${password}
    click button    signInBtn

wait until Element is located in the page
    [Arguments]    ${element}
    wait until element is visible    ${element}

Verify error message is correct
    # Method -1
    ${result} =    get text    ${Error_Message_Login_Element}
    should be equal as strings    ${result}    ${Error_Message_Login_Text}

    # Method -2
    element text should be    ${Error_Message_Login_Element}    ${Error_Message_Login_Text}