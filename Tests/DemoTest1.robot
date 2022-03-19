*** Settings ***
Documentation    To validate the Login form
Resource    ../PO/Common.robot
Library    ../CustomLibraries/Shop.py
Library    SeleniumLibrary
Library    Collections    # A test library providing keywords for handling lists and dictionaries.
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page


*** Variables ***

${PhoneName} =    Nokia Edge


*** Test Cases ***

Validate Cards display in the Shopping Page
    [Tags]    Smoke    Sanity
    Fill the login Form    ${user_name}    ${valid_password}
    Verify Card titles in the Shop page
    hello world
    Select the Card    ${PhoneName}


Select the Form and Navigate the Child Window
    [Tags]    Smoke
    Fill the Login Details and Login Form    ${user_name}    ${valid_password}

*** Keywords ***
Fill the login Form
    [Arguments]    ${user_name}    ${valid_password}
    input text    id=username    ${user_name}
    input text    id=password    ${valid_password}
    click button    id=signInBtn
    wait until element is visible    xpath=//h1[contains(text(),'Shop Name')]



Verify Card titles in the Shop page
    @{expectedList} =    create list    iphone X    Samsung Note 8      Nokia Edge       Blackberry
    ${elements} =    get webelements    //h4[@class='card-title']
    log    ${elements}
    @{actualList} =    create list

    FOR    ${element}    IN    @{elements}
        ${element_text} =    get text    ${element}
        log    ${element_text}
        append to list    ${actualList}    ${element_text}
    END

   # Second Solution to get text of elemenets
   # FOR    ${element}    IN    @{elements}
   #     log    ${element.text}    # element.text is a python function
   #     append to list    ${actualList}    ${element_text}
   # END

    lists should be equal    ${expectedList}    ${actualList}

Select the Card
    [Arguments]    ${cardname}

    @{expectedList} =    create list    iphone X    Samsung Note 8      Nokia Edge       Blackberry
    @{elements} =    Get WebElements    //h4[@class='card-title']
    ${index}=    set variable    1

    FOR    ${element}    IN    @{elements}
        exit for loop if    '${element.text}' == '${cardname}'
        ${index}=  EVALUATE    ${index} + 1
    END

    log    ${index}
    click button    xpath:(//div[@class='card-footer'])[${index}]/button


Fill the Login Details and Login Form
    [Arguments]    ${user_name}    ${valid_password}
    input text    id=username    ${user_name}
    input text    id=password    ${valid_password}
    click element    xpath://input[@value='user']//following-sibling::span
    wait until element is visible    okayBtn     # 'id:' does not need
    click button    okayBtn    # RobotFramework issue that click button does not work in the first time
    click button    okayBtn
    wait until element is not visible    okayBtn
    select from list by value    xpath://select[@class='form-control']    teach
    select checkbox    terms    # 'id:' does not need
    checkbox should be selected    terms
