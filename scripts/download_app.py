"""Download the Sauce Labs My Demo App (React Native) APK into apps/.

The APK is not committed to git because it is a large binary.
Run: python scripts/download_app.py
"""
from pathlib import Path
from urllib.request import urlretrieve

APP_URL = (
    "https://github.com/saucelabs/my-demo-app-rn/releases/download/"
    "v1.3.0/Android-MyDemoAppRN.1.3.0.build-244.apk"
)
TARGET = Path(__file__).resolve().parent.parent / "apps" / "my-demo-app.apk"


def main():
    if TARGET.exists():
        print(f"Already downloaded: {TARGET}")
        return
    TARGET.parent.mkdir(exist_ok=True)
    print(f"Downloading {APP_URL}")
    urlretrieve(APP_URL, TARGET)
    print(f"Saved to {TARGET} ({TARGET.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    main()
