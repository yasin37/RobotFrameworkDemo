*** Settings ***
Documentation    All the page objects and keywords of landing page for Shopping Page
Library    SeleniumLibrary
Library    Collections


*** Variables ***

${Shop_page_load}    xpath=//h1[contains(text(),'Shop Name')]

*** Keywords ***
Wait Until Element Passed in Located on Page
    wait until element is visible    ${Shop_page_load}    timeout=10

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