*** Settings ***
Documentation    Page Object Model Sample
Library    SeleniumLibrary    # Since a method is called in shop.py the lib needs to decleared
Library    ../CustomLibraries/Shop.py
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page
Resource    ../PO/LandingPage.robot
Resource    ../PO/ShopPage.robot
Resource    ../PO/PurchasePage.robot


*** Variables ***
@{ProductList}    Samsung Note 8    Blackberry


*** Test Cases ***
Validate Unsuccessful Login
    [Tags]    SMOKE    REGRESSION
    LandingPage.Fill the login Form    ${username}    ${invalid_password}
    LandingPage.wait until it checks and display error message
    LandingPage.verify error message is correct    ${expectedResult}


End to end ecommerce Product validation
    [Tags]    REGRESSION
    LandingPage.Fill the login Form    ${username}    ${valid_password}
    ShopPage.Wait Until Element Passed in Located on Page
    ShopPage.Verify Card titles in the Shop page
    add items to cart and checkout    ${ProductList}
    verify items in the checkout page and proceed    ${ProductList}
    PurchasePage.Enter the Country and select the terms    ${country_name}
    PurchasePage.Purchase the Product and Confirm the Purchase







