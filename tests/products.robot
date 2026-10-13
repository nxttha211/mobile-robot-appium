*** Settings ***
Documentation       Product catalog: listing, scrolling and product details.
Resource            ../resources/common.resource
Resource            ../resources/pages/products_page.resource

Test Setup          Open My Demo App
Test Teardown       Close My Demo App


*** Test Cases ***
TC_06 แสดงรายการสินค้าเมื่อเปิดแอป
    [Tags]    smoke    products
    Products Screen Should Be Open
    Page Should Contain Text    ${FIRST_PRODUCT}

TC_07 เลื่อนหน้าจอจนเจอสินค้าตัวสุดท้าย
    [Documentation]    Uses swipe gestures to reach a product below the fold.
    [Tags]    regression    products    gesture
    Scroll Until Product Is Visible    ${LAST_PRODUCT}

TC_08 หน้ารายละเอียดสินค้ามีปุ่ม Add To Cart
    [Tags]    regression    products
    Open Product    ${FIRST_PRODUCT}
    Page Should Contain Element    ${ADD_TO_CART_BUTTON}
