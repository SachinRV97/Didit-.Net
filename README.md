# Didit Verification Test (ASP.NET Web Forms)

This repository contains a minimal **.aspx** web application to test Didit verification flows.

## What it does

- Provides a test page (`Default.aspx`) where you can paste a Didit verification URL.
- Opens the verification flow inside an iframe.
- Logs iframe load events.
- Logs `window.postMessage` events for callback/debugging purposes.

## Run locally (Windows + IIS Express / Visual Studio)

1. Open `DiditVerificationTest.csproj` in Visual Studio.
2. Start with **IIS Express**.
3. Open `Default.aspx`.
4. Paste the Didit verification URL and click **Launch Verification**.

## Notes

- This project targets **.NET Framework 4.8** and ASP.NET Web Forms.
- If your Didit integration requires specific origin allowlists or callback URLs,
  configure them in your Didit dashboard.
