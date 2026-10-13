# Mobile Test Automation with Robot Framework + Appium

![Mobile Tests](https://github.com/nxttha211/mobile-robot-appium/actions/workflows/mobile-tests.yml/badge.svg)

Hi, I'm Natthaphon. This is a practice project where I automate UI tests for an Android app using Robot Framework and Appium.

The app I'm testing is [My Demo App](https://github.com/saucelabs/my-demo-app-rn) from Sauce Labs. It's a free shopping app made for people who want to practice mobile automation, so it has login, a product list, a cart and some test accounts built in.

## What's tested

Right now there are 8 tests in 3 suites:

**Login** (`tests/login.robot`)
- valid user can log in
- locked user gets an error message
- validation messages for empty username, empty password and wrong password (one data-driven test with 3 rows)

**Cart** (`tests/cart.robot`)
- add one product, cart badge shows 1
- set quantity to 3 before adding, cart badge shows 3

**Products** (`tests/products.robot`)
- product list shows on app launch
- swipe down to the last product
- product page has an Add To Cart button

Tests are tagged `smoke` or `regression`. Smoke is the short set I run on every push.

## How I set it up

I used the Page Object pattern. Each screen has its own file in `resources/pages/` with the locators and keywords for that screen, so if the UI changes I only need to fix one place. Test data like usernames and expected error messages is in `resources/test_data.resource`.

A few things I decided on purpose:

- I use accessibility IDs for locators where I can, because they're faster and break less than XPath. I only used XPath to click a product by its name.
- No `Sleep` anywhere. I use `Wait Until ...` keywords so the test continues as soon as the element shows up.
- Every test opens a fresh app session (`noReset=false`), so one test can't leave something in the cart that breaks the next one. It's slower, but the tests don't depend on each other.
- AppiumLibrary takes a screenshot automatically when a step fails, which helps a lot when checking failures in CI.

```
tests/                    test suites
resources/
  common.resource         Appium settings, open/close app
  test_data.resource      test users and expected messages
  pages/                  one file per screen
scripts/download_app.py   downloads the APK
.github/workflows/        GitHub Actions
Jenkinsfile               Jenkins pipeline
```

## Running it

You need Python 3.10+, Node.js 20+ and an Android emulator (I use the one from Android Studio).

Install everything:

```bash
pip install -r requirements.txt
npm install -g appium
appium driver install uiautomator2
python scripts/download_app.py
```

Start the emulator, then run `appium` in one terminal and the tests in another:

```bash
robot --outputdir results tests
```

Only smoke tests:

```bash
robot --include smoke --outputdir results tests
```

If your emulator has a different name than `emulator-5554` (check with `adb devices`):

```bash
robot --variable DEVICE_NAME:emulator-5556 --outputdir results tests
```

The report is in `results/report.html`.

Tip: `robot --dryrun tests` checks the syntax without a device. I use it to catch typos before running the real thing.

## CI

The GitHub Actions workflow has 2 jobs:

1. a dry run, which takes a few seconds
2. the smoke tests on an Android 13 emulator, with the Robot report uploaded as an artifact

You can also start the full regression run by hand from the Actions tab.

There's a `Jenkinsfile` too, because a lot of teams still use Jenkins. It does the same steps and lets you pick the tag to run.

## Next steps

- add iOS
- add tests for checkout
- run on real devices with a device cloud
