# shellcheck shell=bash
# Sourced by steddy/build-*.sh. Writes the app's .env from the BUILD_ARGS secret
# (the same lines as the app repo's .env: EXPO_PUBLIC_SUPABASE_URL,
# EXPO_PUBLIC_SUPABASE_ANON_KEY, EXPO_PUBLIC_CRM_URL). Never prints the values:
# build logs of a public repo are public until the template encrypts them.
if [ -z "${BUILD_ARGS_SECRET:-}" ]; then
  echo "BUILD_ARGS secret is empty: set it to the app's .env lines (see steddy/README.md)" >&2
  exit 1
fi
# The dev-only impersonation override must never reach a test build.
printf '%s\n' "$BUILD_ARGS_SECRET" | tr -d '\r' | grep -v '^EXPO_PUBLIC_DEV_TECH_ID' > .env || true
for k in EXPO_PUBLIC_SUPABASE_URL EXPO_PUBLIC_SUPABASE_ANON_KEY EXPO_PUBLIC_CRM_URL; do
  grep -q "^$k=." .env || { echo "$k is missing from the BUILD_ARGS secret" >&2; exit 1; }
done
echo ".env written ($(wc -l < .env | tr -d ' ') lines)"
