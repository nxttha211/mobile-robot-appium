*** Settings ***
Documentation       Shared setup: Appium connection, device capabilities and timeouts.
Library             AppiumLibrary    timeout=15s    run_on_failure=Capture Page Screenshot
Resource            test_data.resource


*** Variables ***
# Override any of these from the command line, e.g. --variable DEVICE_NAME:Pixel_7
${REMOTE_URL}       http://127.0.0.1:4723
${PLATFORM}         Android
${DEVICE_NAME}      emulator-5554
${APP_PATH}         ${CURDIR}/../apps/my-demo-app.apk
${APP_PACKAGE}      com.saucelabs.mydemoapprn
${APP_ACTIVITY}     .MainActivity


*** Keywords ***
Open My Demo App
    [Documentation]    Starts a fresh app session. noReset=false clears app data,
    ...                so every test starts logged out with an empty cart.
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM}
    ...    automationName=UiAutomator2
    ...    deviceName=${DEVICE_NAME}
    ...    app=${APP_PATH}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    autoGrantPermissions=true
    ...    noReset=false
    ...    newCommandTimeout=120
    Wait Until Page Contains Element    accessibility_id=products screen

Close My Demo App
    Close Application

Swipe Up
    [Documentation]    Scrolls the screen content down by swiping from 70% to 30% height.
    Swipe By Percent    50    70    50    30    duration=800
