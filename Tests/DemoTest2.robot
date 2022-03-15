*** Settings ***
Documentation    To validate the Login form
Resource    ../PO/Common.robot
Library    SeleniumLibrary
Library    Collections
Library    String
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page


*** Variables ***

${PhoneName} =    Nokia Edge


*** Test Cases ***
Validate Child Window Functionality
    [Tags]    Current
    Select the link of child window
    Verify the user is switch to child window
    Grab the email in the child window
    Switch to parent window and enter the email

*** Keywords ***
Select the link of child window
    click link    Free Access to InterviewQues/ResumeAssistance/Material    #click element    //a[@class='blinkingText']

Verify the user is switch to child window
    switch window    NEW
    wait until element is visible    //h1
    element text should be    //h1    DOCUMENTS REQUEST

Grab the email in the child window
    ${text}=    get text    css:.red
    log    ${text}
    @{words}=    split string    ${text}    at
    log    ${words}
    #0 --> Please email us
    #1 --> mentor@rahulshettyacademy.com with below templ
    #2 --> e to receive response
    ${text_split}=    get from list    ${words}    1
    log    ${text_split}
    @{words_2}=    split string    ${text_split}
    #0--> mentor@rahulshettyacademy.com
    ${email}=    get from list    ${words_2}    0
    log    ${email}
    set global variable    ${email}

Switch to parent window and enter the email
    switch window    MAIN
    title should be    LoginPage Practise | Rahul Shetty Academy
    input text    username    ${email}


