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
# The prebuild default (-Xmx2048m, 512m Metaspace) ran out of Metaspace in lint and hung
# until the 60 min job limit (run 45408975192). Hosted Linux runners have 16 GB.
sed -i '/^org.gradle.jvmargs=/d' gradle.properties
echo 'org.gradle.jvmargs=-Xmx6g -XX:MaxMetaspaceSize=2g -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8' >> gradle.properties
# Release lint is a store check, not needed for a test build, and was where memory ran out.
APP_GRADLE=app/build.gradle; [ -f app/build.gradle.kts ] && APP_GRADLE=app/build.gradle.kts
printf '\nandroid { lint { checkReleaseBuilds = false } }\n' >> "$APP_GRADLE"  # same syntax in Groovy and Kotlin DSL
./gradlew assembleRelease -PreactNativeArchitectures=x86_64 --build-cache
