# Starts an agent-tester run on Steddy Crew. Run from the repo folder:
#   powershell -ExecutionPolicy Bypass -File .\steddy\run.ps1
#   powershell -ExecutionPolicy Bypass -File .\steddy\run.ps1 -Android "tom" -Ios "none" -Model haiku
param(
  [string]$Android = "tom,priya",
  [string]$Ios = "jake,mia",
  [string]$Model = "sonnet",
  [string]$Ref = "main"
)
gh workflow run agent-testers.yml `
  -f source_repo=Admaduk/Service-Clarity-Tech-App -f ref=$Ref -f app_dir=. -f app_id=com.steddy.app `
  -f android_build="bash `$GITHUB_WORKSPACE/steddy/build-android.sh" -f apk_path=android/app/build/outputs/apk/release/app-release.apk `
  -f ios_build="bash `$GITHUB_WORKSPACE/steddy/build-ios.sh" -f ios_app_path=build/Steddy.app `
  -f brief=steddy/brief.md -f android_personas=$Android -f ios_personas=$Ios -f model=$Model
if ($LASTEXITCODE -eq 0) { Write-Host "Started. Follow it with: gh run watch" }
