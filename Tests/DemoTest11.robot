*** Settings ***
Documentation    Page Object Model
Suite Setup    Common.open the app browser
Suite Teardown    Common.close the app browser
Test Setup    Common.open login page
Resource    ../PO_2/NewLandingPage.robot
Resource    ../PO_2/NewShopPage.robot
Resource    ../PO_2/NewPurchasePage.robot



*** Variables ***
@{ProductList}    iphone X    Samsung Note 8    Blackberry
${CountryName}    Turkey

*** Test Cases ***
Validate Unsuccessful Login
    [Tags]    SMOKE
    NewLandingPage.Fill the login form    ${username}    ${invalid_password}
    NewLandingPage.wait until it checks and display error message
    NewLandingPage.verify error message is correct    ${expectedResult}

End to end ecommerce Product validation
    [Tags]    REGRESSION
    NewLandingPage.Fill the login form    ${username}    ${valid_password}
    NewShopPage.Wait Until Element Passed in Located on Page
    NewShopPage.Verify Card titles in the Shop page
    NewShopPage.Add items to cart and Checkout    ${ProductList}
    NewShopPage.Verify items in the checkout page and Confim Checkout    ${ProductList}
    NewPurchasePage.Enter the Country and select the terms    ${CountryName}
    NewPurchasePage.Purchase the Product






