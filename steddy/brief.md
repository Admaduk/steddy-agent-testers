# Brief: Steddy Crew (technician app)

Read AGENT_BRIEF.md first. Its tools, rules, screenshot numbering and final report
all apply. This brief replaces its "What to check" list and the generic persona goal.

## The app
Steddy Crew is the phone app a garage-door technician uses during the working day:
see today's jobs, accept them, tap "On my way", start, write a quote, add parts and
labour, finish the job and record how the customer paid. The office runs the
business in a separate web CRM. The technician cannot sign up in the app.

You are signed in to a demo company, **Harbourline Garage Doors** in Sydney. Every
customer, address and phone number is fictional. The company works in Sydney time,
so "Today" follows the Sydney date even when this device is set to another timezone.
If the dates on Today look wrong for Sydney, report it as a finding.

## Sign in
- Read `steddy/login.md` for the email and password. Use the **Email** and
  **Password** fields and **Sign in**. Never use "Continue with Google".
- If sign-in fails, try once more and check for typing mistakes on the screenshot.
  If it still fails, report it as a blocker and stop.

## Hard rules for this app (they protect shared test data)
- Payment: choose **Cash** only. Never choose "Card (pay on my phone)" or any
  online payment option, and never type card details anywhere.
- Never tap Call, Text, "Send by email", or "Email me a reset link" or Forgot
  password. Never change the password. Never sign out unless your task says so.
- Several testers share this one account at the same time. Only change the state of
  the ONE job your task gives you. Do not accept, start, finish, put on hold or
  decline any other job. Opening and reading other jobs is fine.
- Jobs already shown as in progress or on the way when you arrive belong to other
  testers or earlier runs. Leave them alone.
- If the system asks for location access, follow your persona: allow "While using
  the app" unless your profile says you refuse location.

## Your task
Find your PERSONA id below. "Today's jobs" means the jobs on the Today tab still
waiting to start, in the order shown. If your job is already started or finished by
someone else, take the next job in the same order on Today. If none is left, take the
first job on the Schedule tab for tomorrow. Starting it should show a confirmation that
the job isn't scheduled for today: that is expected. Note the job number (JOB-xxxxx)
in your report.

- **tom**: the 1st of today's jobs, all the way through. Open it, Accept, On my way,
  Start. Add one Service / labour line ("Replace torsion spring", $280) and one part
  from company stock. Finish the job, choose Itemised for the customer copy, and
  record the full amount in Cash. Then go back to Today and check that the job moved
  to Done and that "Collected" went up by the amount you took.
- **priya**: the 2nd of today's jobs, with a quote. Open it, Accept, On my way,
  Start, then Write quote with two labour lines (for example "Service and lube, $149"
  and "Replace rollers, $220"). Look at the quote total and the GST. Use "Sign on my
  phone" and look at the page it opens, but do not sign. Go back, record a deposit of
  $50 in Cash, then finish the job and record the rest in Cash. Check the balance due
  at each step.
- **jake**: the 3rd of today's jobs, technician-paid part. Open it, Accept, On my
  way, Start. Add a part you paid for yourself ("Weather seal", cost $38.50 incl. GST,
  sell $65). Try to save it first without a cost and report what happens. Then add a
  note and one photo if the camera works on this device. Finish with Summary as the
  customer copy and Cash for the full amount.
- **mia**: read only. Change no job. Look at Today, Schedule (scroll through all 7
  days), at least four job screens (customer, address, notes, parts, money), and the
  Me tab. Pull down to refresh on each list. Leave the app and come back. Rotate is
  not needed. Report anything that is cut off, overlaps or can't be reached at your
  text size.
- Any other persona: read only, like mia.

## What to check (on top of your task)
1. Every amount: totals, GST and the balance due must add up on every screen.
   Write down the numbers you see and check the arithmetic.
2. Wording a tired technician on a roof could misread: unclear buttons,
   confirmations that don't say what will happen, or no feedback after a tap.
3. Layout at this device's text size and theme: cut text, buttons under the
   keyboard or the home bar, sheets you cannot scroll or close.
4. Slow or failed saves: spinners that never stop, errors in plain words or not,
   anything you had to tap twice.
5. Leaving and reopening the app mid-job: does it return to the same state?

Budget: about 40 actions, then write the report as AGENT_BRIEF.md says. Put the
job number you used on the first line of the summary.
