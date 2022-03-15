*** Settings ***
Documentation    Custom Python Library on RobotFramework
Resource    ../PO/Common.robot
Library    SeleniumLibrary
Library    Collections
Library    ../CustomLibraries/Shop.py
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page

*** Variables ***

@{ProductList}    Samsung Note 8    Blackberry    iphone X

*** Test Cases ***
Validate Cards Display in the Shopping Page
    [Tags]    smoke
    Fill the login Form    ${user_name}    ${valid_password}
    Verify Card titles in the Shop page
    # Select the Card    ${ProductList}
    add items to cart and checkout    ${ProductList}
    sleep    3



*** Keywords ***
Fill the login Form
    [Arguments]    ${user_name}    ${valid_password}
    input text    id=username    ${user_name}
    input text    id=password    ${valid_password}
    click button    id=signInBtn
    wait until element is visible    xpath=//h1[contains(text(),'Shop Name')]

Verify Card titles in the Shop page
    @{expectedList}  create list    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements}    get webelements    xpath://h4[@class='card-title']
    log    ${elements}
    @{actualList}    create list

    FOR    ${element}    IN    @{elements}
        ${element_text}    get text    ${element}
        log    ${element_text}
        append to list    ${actualList}    ${element_text}
    END

    lists should be equal    ${actualList}    ${expectedList}

Select the Card
    [Arguments]    ${ProductList}

    @{productTitles}    Get WebElements    //h4[@class='card-title']
    ${index}    set variable    1

    FOR    ${productTitle}    IN    @{productTitles}
        ${product_text}    get text    ${productTitle}
        log    ${product_text}
        run keyword if    '${product_text}' in ${ProductList}    click button    xpath:(//div[@class='card-footer'])[${index}]/button
        ${index}    EVALUATE    ${index} + 1
    END



