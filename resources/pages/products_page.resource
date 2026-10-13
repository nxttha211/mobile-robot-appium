*** Settings ***
Documentation       Product catalog and product detail screens.
Library             AppiumLibrary
Resource            ../common.resource


*** Variables ***
${PRODUCTS_SCREEN}      accessibility_id=products screen
${STORE_ITEM_TITLE}     accessibility_id=store item text
${ADD_TO_CART_BUTTON}   accessibility_id=Add To Cart button
${PLUS_BUTTON}          accessibility_id=counter plus button
${QUANTITY_AMOUNT}      accessibility_id=counter amount


*** Keywords ***
Products Screen Should Be Open
    Wait Until Page Contains Element    ${PRODUCTS_SCREEN}

Open Product
    [Arguments]    ${product_name}
    Click Element    xpath=//*[@content-desc="store item text" and @text="${product_name}"]
    Wait Until Page Contains Element    ${ADD_TO_CART_BUTTON}

Increase Quantity
    [Arguments]    ${times}=1
    FOR    ${i}    IN RANGE    ${times}
        Click Element    ${PLUS_BUTTON}
    END

Add Product To Cart
    Click Element    ${ADD_TO_CART_BUTTON}

Scroll Until Product Is Visible
    [Documentation]    Swipes up at most ${max_swipes} times until the product appears.
    [Arguments]    ${product_name}    ${max_swipes}=6
    FOR    ${i}    IN RANGE    ${max_swipes}
        ${found}=    Run Keyword And Return Status    Page Should Contain Text    ${product_name}
        IF    ${found}    RETURN
        Swipe Up
    END
    Page Should Contain Text    ${product_name}
