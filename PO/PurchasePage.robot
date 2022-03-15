*** Settings ***
Documentation    All the page objects and keywords of landing page for Purchase Page
Library    SeleniumLibrary

*** Variables ***
${country_name}    Turkey

*** Keywords ***

Enter the Country and select the terms
    [Arguments]    ${country_name}
    input text    country    ${country_name}
    wait until element is visible    //a[text()='${country_name}']    timeout=10
    click element    //a[text()='${country_name}']
    click element    xpath://label[@for='checkbox2']

Purchase the Product and Confirm the Purchase
    click element    //input[@type='submit']
    page should contain    Success!