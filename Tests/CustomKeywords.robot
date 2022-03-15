*** Settings ***
Library    SeleniumLibrary
Library    ../CustomLibraries/CustomLib.py

Documentation
...    My First Custom Keyword Case
...    This test will try to Signin with Wrong Email

*** Test Cases ***

Open Store & Login Store With Wrong Credentials
    Navigate To Store
    Verify Page Title Contains Store
    Signin With Dummy Email
    close browser

*** Keywords ***

Navigate To Store
    open browser    http://automationpractice.com/    browser=chrome
    maximize browser window

Verify Page Title Contains Store
    ${title}    get title
    should be equal as strings    ${title}    My Store

Signin With Dummy Email
    click element    //a[contains(text(),'Sign in')]
    wait until page contains element    //a[contains(text(), 'Forgot your password')]
    ${random_email}    generate random emails    ${10}
    log    ${random_email}
    input text    email    ${random_email}
    ${random_pass}    generate random pass    ${12}
    log    ${random_pass}
    input password    passwd    ${random_pass}
    Click Element       SubmitLogin
    Wait Until Page Contains      Authentication failed.