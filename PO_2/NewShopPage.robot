*** Settings ***
Documentation    Page Object for Shop Page
Library    SeleniumLibrary
Library     Collections

*** Variables ***

${ShopName_Element}    xpath://h1[contains(text(),'Shop Name')]

*** Keywords ***

Wait Until Element Passed in Located on Page
    wait until element is visible    ${ShopName_Element}    timeout=10

Verify Card titles in the Shop page
    @{expectedList}    create list    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{actualList}    create list
    @{titles}    get webelements    //h4[@class='card-title']

    FOR    ${title}    IN    @{titles}
        ${text}    get text    ${title}
        log    ${text}
        append to list    ${actualList}    ${text}
    END

   # Second Solution to get text of elemenets
   # FOR    ${element}    IN    @{elements}
   #     log    ${element.text}    # element.text is a python function
   #     append to list    ${actualList}    ${element_text}
   # END

    lists should be equal    ${expectedList}    ${actualList}

Add items to cart and Checkout
    [Arguments]    ${ProductList}
    @{titles}   get webelements    //h4[@class='card-title']
    ${index}    evaluate    1
    log    ${index}
    FOR    ${title}    IN    @{titles}
        ${text}    get text    ${title}
        run keyword if    '${text}' in ${ProductList}    click button    xpath:(//div[@class='card-footer'])[${index}]/button
        ${index}    evaluate    ${index} +1
     END

     click element    xpath://a[@class='nav-link btn btn-primary']

Verify items in the checkout page and Confim Checkout
    [Arguments]    ${ProductList}
    @{actualList}    create list
    @{productTitles}    get webelements    //h4[@class='media-heading']

    FOR    ${productTitle}    IN    @{productTitles}
        ${product_text}    get text    ${productTitle}
        append to list    ${actualList}    ${product_text}
    END
    log    ${actualList}
    lists should be equal    ${actualList}    ${ProductList}

    click button    xpath://button[@class='btn btn-success']

