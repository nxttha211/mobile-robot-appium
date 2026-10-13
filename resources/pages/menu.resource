*** Settings ***
Documentation       Side menu (hamburger). Locators are accessibility ids from the app;
...                 verify them with Appium Inspector if the app version changes.
Library             AppiumLibrary


*** Variables ***
${MENU_BUTTON}          accessibility_id=open menu
${MENU_ITEM_LOGIN}      accessibility_id=menu item log in


*** Keywords ***
Go To Login Screen
    Click Element    ${MENU_BUTTON}
    Click Element    ${MENU_ITEM_LOGIN}
