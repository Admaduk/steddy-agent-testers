#!/usr/bin/env bash
# Steddy Crew: Android build for the agent testers (used as the android_build input).
# Runs inside the app checkout (src/). The template's own Expo build has no way to
# pass EXPO_PUBLIC_* values, which Expo inlines at bundle time, so this writes the
# app's .env from the BUILD_ARGS secret first, then builds like scripts/build/android.sh.
# Output: android/app/build/outputs/apk/release/app-release.apk (the apk_path input).
set -euo pipefail
. "$GITHUB_WORKSPACE/steddy/write-env.sh"
npm ci
CI=1 npx expo prebuild --platform android --no-install
cd android
./gradlew assembleRelease -PreactNativeArchitectures=x86_64 --build-cache
