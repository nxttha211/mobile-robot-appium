*** Settings ***
Documentation       Shopping cart: adding products and quantities.
Resource            ../resources/common.resource
Resource            ../resources/pages/products_page.resource
Resource            ../resources/pages/cart_page.resource

Test Setup          Open My Demo App
Test Teardown       Close My Demo App


*** Test Cases ***
TC_04 เพิ่มสินค้า 1 ชิ้นลงตะกร้า
    [Tags]    smoke    cart
    Open Product    ${FIRST_PRODUCT}
    Add Product To Cart
    Cart Badge Should Show    1

TC_05 เพิ่มสินค้าจำนวน 3 ชิ้นลงตะกร้า
    [Tags]    regression    cart
    Open Product    ${FIRST_PRODUCT}
    Increase Quantity    times=2
    Element Text Should Be    ${QUANTITY_AMOUNT}    3
    Add Product To Cart
    Cart Badge Should Show    3
