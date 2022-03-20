*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library    Collections     # A test library providing keywords for handling lists and dictionaries.
Resource    ../PO/Common.robot
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page

*** Variables ***
${Error_Message_Login_Element}    xpath://div[@class='alert alert-danger col-md-12']
${Error_Message_Login_Text}    Incorrect username/password.
${Shop_Page_Load_Element}    //h1[contains(text(),'Shop Name')]

*** Test Cases ***
Validate UnSuccesful Login
    [Tags]    Smoke
    Fill the login form    ${username}    ${invalid_password}
    wait until Element is located in the page    ${Error_Message_Login_Element}
    Verify error message is correct

Validate Cards display in the Shopping Page
    [Tags]    REGRESSION
    Fill the login form    ${username}    ${valid_password}
    wait until element is visible    ${Shop_Page_Load_Element}
    Verify Card titles in the Shop page
    Select the Card    Nokia Edge

Select the Form and navigate to Child window
    [Tags]    Current  T2T
    Fill the Login Details and Login Form    ${user_name}    ${valid_password}
    wait until element is visible    ${Shop_Page_Load_Element}

*** Keywords ***

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


Verify Card titles in the Shop page
    @{expectedList} =    create list    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements} =    get webelements    xpath://h4[@class='card-title']
    @{actualList} =    create list

    FOR    ${element}    IN    @{elements}
        ${element_text} =    get text    ${element}
        log    ${element_text}
        append to list    ${actualList}    ${element_text}
    END

    log    ${actualList}
    lists should be equal    ${expectedList}    ${actualList}

Select the Card
    [Arguments]    ${cardname}
    @{elements} =    get webelements    xpath://h4[@class='card-title']
    ${index}    set variable    1

    FOR    ${element}    IN    @{elements}
        ${element_text} =    get text    ${element}
        run keyword if    '${element_text}' == '${cardname}'    click button    xpath:(//button[@class='btn btn-info'])[${index}]
        ${index}    evaluate    ${index} + 1
    END

Fill the Login Details and Login Form
    [Arguments]    ${my_user}    ${my_passwd}
    input text    username    ${my_user}
    input password    password    ${my_passwd}
    click element    xpath://input[@value='user']
    wait until element is visible    xpath://div[@class='modal-body']
    click button     okayBtn
    click button     okayBtn    # Due to Selenium Lib issue in RobotFramework it is added
    wait until element is not visible    xpath://div[@class='modal-body']
    select from list by value    xpath://select[@class='form-control']    consult
    select checkbox    terms
    checkbox should be selected    terms
    click element    signInBtn







