*** Settings ***
Documentation    A resource file with reusable keywords and variables.
...
...    The system specific keywords created here form our own
...    domain specific language. They utilize keywords provided
...    by the imported SeleniumLibrary.
...    That is for test

Library    SeleniumLibrary

*** Variables ***
${user_name}             rahulshettyacademy
${invalid_password}      123445
${valid_password}        learning
${url}                   https://rahulshettyacademy.com/loginpagePractise/
${browser_name}          chrome
${expectedResult}        Incorrect username/password.


*** Keywords ***

open the app browser
    open browser    about:blank    ${browser_name}
    maximize browser window

close the app browser
    close browser

open login page
    go to    ${url}




