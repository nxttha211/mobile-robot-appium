*** Settings ***
Documentation       Cart badge on the header and the cart screen.
Library             AppiumLibrary


*** Variables ***
${CART_BADGE}       accessibility_id=cart badge


*** Keywords ***
Cart Badge Should Show
    [Arguments]    ${expected_count}
    Wait Until Page Contains Element    ${CART_BADGE}
    Element Should Contain Text    ${CART_BADGE}    ${expected_count}
