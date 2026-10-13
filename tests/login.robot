*** Settings ***
Documentation       Login feature: valid login, locked account and field validation.
Resource            ../resources/common.resource
Resource            ../resources/pages/login_page.resource
Resource            ../resources/pages/products_page.resource

Test Setup          Open My Demo App
Test Teardown       Close My Demo App


*** Test Cases ***
TC_01 เข้าสู่ระบบด้วยบัญชีที่ถูกต้อง
    [Documentation]    A registered user lands on the product catalog after login.
    [Tags]    smoke    login    positive
    Login As    ${VALID_USER}    ${VALID_PASSWORD}
    Products Screen Should Be Open

TC_02 เข้าสู่ระบบด้วยบัญชีที่ถูกล็อก
    [Tags]    regression    login    negative
    Login As    ${LOCKED_USER}    ${VALID_PASSWORD}
    Login Should Fail With Message    ${MSG_LOCKED_OUT}

TC_03 ข้อความแจ้งเตือนเมื่อกรอกข้อมูลไม่ครบหรือผิด
    [Documentation]    Data-driven: each row is one test run with different input.
    [Tags]    regression    login    negative
    [Template]    Login Attempt Should Show Error
    # username          password             expected message
    ${EMPTY}            ${VALID_PASSWORD}    ${MSG_USERNAME_REQUIRED}
    ${VALID_USER}       ${EMPTY}             ${MSG_PASSWORD_REQUIRED}
    ${VALID_USER}       ${WRONG_PASSWORD}    ${MSG_BAD_CREDENTIALS}


*** Keywords ***
Login Attempt Should Show Error
    [Arguments]    ${username}    ${password}    ${expected_message}
    Go To Login Screen
    Login Screen Should Be Open
    Submit Credentials    ${username}    ${password}
    Login Should Fail With Message    ${expected_message}
