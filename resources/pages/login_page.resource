*** Settings ***
Documentation       Login screen: page object keywords and locators.
Library             AppiumLibrary
Resource            menu.resource


*** Variables ***
${USERNAME_FIELD}       accessibility_id=Username input field
${PASSWORD_FIELD}       accessibility_id=Password input field
${LOGIN_BUTTON}         accessibility_id=Login button


*** Keywords ***
Login Screen Should Be Open
    Wait Until Page Contains Element    ${LOGIN_BUTTON}

Login As
    [Arguments]    ${username}    ${password}
    Go To Login Screen
    Login Screen Should Be Open
    Submit Credentials    ${username}    ${password}

Submit Credentials
    [Documentation]    Empty values are skipped so validation messages can be tested.
    [Arguments]    ${username}    ${password}
    IF    $username    Input Text    ${USERNAME_FIELD}    ${username}
    IF    $password    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Element    ${LOGIN_BUTTON}

Login Should Fail With Message
    [Arguments]    ${expected_message}
    Wait Until Page Contains    ${expected_message}
    Page Should Contain Element    ${LOGIN_BUTTON}
