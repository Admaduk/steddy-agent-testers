# Steddy Crew on the agent testers

This repo is the [mobile-agent-testers](https://github.com/pierridotite/mobile-agent-testers)
template, with a few additions for the Steddy Crew technician app
(private repo `Admaduk/Service-Clarity-Tech-App`):

| File | What it does |
|---|---|
| `steddy/brief.md` | What the agents do: sign in to the Harbourline demo tenant, one job per persona, cash only |
| `personas.json` | Four Sydney technicians added at the end: `tom`, `priya` (Android), `jake`, `mia` (iOS) |
| `steddy/build-android.sh`, `steddy/build-ios.sh` | Builds the app. They write the app's `.env` from the `BUILD_ARGS` secret first, because the template's Expo build cannot pass `EXPO_PUBLIC_*` values |
| `steddy/run.ps1` | Starts a run with the right inputs |
| `.github/workflows/agent-testers.yml` | Two changes: Node 22, and a step that writes `steddy/login.md` from the `STEDDY_TEST_LOGIN` secret before each agent starts |

Test data: technician **Sam Carter** (`crew.demo@steddyhq.com`) in **Harbourline Garage
Doors**, the fictional demo tenant used for store review. Its customers have
`example.com` emails and phone numbers in the ACMA fictional ranges, and email
sending is off for the tenant. Demo jobs run to 31 Jan 2027 at about 3 a day. The `tom`,
`priya` and `jake` testers each use up one of today's jobs per run (`mia` only reads).

## One-time setup (Windows, PowerShell)

1. Install and sign in to the GitHub CLI:
   ```powershell
   winget install --id GitHub.cli
   gh auth login
   ```
2. Create the GitHub repo from this folder and push it. It is public so the
   runners are free; reports, screenshots and build logs are encrypted before upload.
   ```powershell
   cd C:\Users\shayv\OneDrive\Desktop\steddy-agent-testers
   gh repo create Admaduk/steddy-agent-testers --public --source . --remote origin --push
   ```
3. Run the template's setup (encryption key pair, Claude token). For a Claude
   subscription, run `claude setup-token` in another terminal and paste the token.
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\setup.ps1
   ```
4. Add the three Steddy secrets:
   - App repo access: make a fine-grained token at github.com → Settings → Developer
     settings → Fine-grained tokens, repository `Service-Clarity-Tech-App` only,
     permission Contents: Read-only. Then:
     ```powershell
     gh secret set SOURCE_REPO_TOKEN
     ```
   - App config (the app's `.env` without the dev-only tech override):
     ```powershell
     Get-Content "..\Clarity Application\.env" | Where-Object { $_ -notmatch '^EXPO_PUBLIC_DEV_TECH_ID' } | gh secret set BUILD_ARGS
     ```
   - Test login, one line (paste when asked):
     ```powershell
     gh secret set STEDDY_TEST_LOGIN
     # Email: crew.demo@steddyhq.com   Password: <the reviewer password>
     ```

## Run

```powershell
powershell -ExecutionPolicy Bypass -File .\steddy\run.ps1      # tom, priya on Android; jake, mia on iOS
gh run watch
bash scripts/collect.sh <run id>                                  # Git Bash: decrypts into runs/<id>/SUMMARY.md
```

The first run is mostly a build check: about 25 minutes for each build plus 20 for the
agents. Try `-Android tom -Ios none` first if you want the cheapest signal. The app is
built from the `main` branch of the app repo (pushed commits only), or `-Ref <branch>`.

## Before an App Store or Play review

Agents leave jobs in progress or completed in Harbourline. The reviewer uses the same
login, so tidy today's and tomorrow's jobs before submitting a build for review.
