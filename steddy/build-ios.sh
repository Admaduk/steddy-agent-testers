#!/usr/bin/env bash
# Steddy Crew: iOS Simulator build for the agent testers (used as the ios_build input).
# Same as scripts/build/ios.sh for Expo, plus the .env written from the BUILD_ARGS secret.
# Output: build/Steddy.app (the ios_app_path input), arm64, unsigned.
set -euo pipefail
. "$GITHUB_WORKSPACE/steddy/write-env.sh"
npm ci
CI=1 npx expo prebuild --platform ios --no-install
(cd ios && pod install)
WS=$(find ios -maxdepth 1 -name '*.xcworkspace' | head -1)
[ -n "$WS" ] || { echo "No .xcworkspace after prebuild"; exit 1; }
SCHEME=$(basename "$WS" .xcworkspace)
xcodebuild -workspace "$WS" -scheme "$SCHEME" -configuration Release -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' -derivedDataPath "$RUNNER_TEMP/dd" \
  EXCLUDED_ARCHS=x86_64 ONLY_ACTIVE_ARCH=YES CODE_SIGNING_ALLOWED=NO build
APP=$(find "$RUNNER_TEMP/dd/Build/Products" -maxdepth 2 -path '*iphonesimulator/*.app' -not -name '*Tests*' | head -1)
[ -n "$APP" ] || { echo "No Simulator .app found"; exit 1; }
mkdir -p build && rm -rf build/Steddy.app && cp -R "$APP" build/Steddy.app
