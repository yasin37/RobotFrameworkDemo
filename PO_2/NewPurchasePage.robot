*** Settings ***
Documentation    Page Object for Purchase Page
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
Enter the Country and select the terms
    [Arguments]    ${CountryName}
    input text    country    ${CountryName}
    wait until element is visible    //a[text()='${CountryName}']    timeout=10
    click element    //a[text()='${CountryName}']
    click element    //a[contains(text(),'term & Conditions')]
    page should contain     Please read the following terms
    click button    xpath://button[contains(text(),'Close')]
    select checkbox    id:checkbox2
    checkbox should be selected    id:checkbox2

Purchase the Product
    click element    xpath://input[@value='Purchase']
    page should contain    Success!



