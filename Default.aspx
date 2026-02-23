<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DiditVerificationTest.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Didit Verification Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 2rem;
            background: #f6f8fb;
            color: #1f2937;
        }

        .card {
            max-width: 780px;
            margin: 0 auto;
            background: #ffffff;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            padding: 1.25rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
        }

        .row {
            display: flex;
            flex-direction: column;
            margin-bottom: 0.75rem;
        }

        label {
            font-weight: bold;
            margin-bottom: 0.25rem;
        }

        input {
            padding: 0.6rem;
            border-radius: 6px;
            border: 1px solid #9ca3af;
            font-size: 0.95rem;
        }

        button {
            margin-top: 0.75rem;
            padding: 0.7rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            background: #2563eb;
            color: white;
        }

        #widgetContainer {
            margin-top: 1rem;
            min-height: 340px;
            border: 1px dashed #6b7280;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f9fafb;
            text-align: center;
            padding: 1rem;
        }

        #eventLog {
            margin-top: 1rem;
            background: #111827;
            color: #e5e7eb;
            padding: 0.75rem;
            border-radius: 6px;
            min-height: 110px;
            white-space: pre-wrap;
            font-family: Consolas, monospace;
        }

        .hint {
            color: #6b7280;
            margin-top: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <h1>Didit Verification Test Page</h1>
            <p class="hint">Use this page to launch a Didit verification URL and inspect callback details.</p>

            <div class="row">
                <label for="verificationUrl">Verification URL</label>
                <input id="verificationUrl" type="text" placeholder="https://..." />
            </div>

            <div class="row">
                <label for="sessionId">Session / Applicant ID (optional)</label>
                <input id="sessionId" type="text" placeholder="session_123" />
            </div>

            <button type="button" onclick="launchDidit()">Launch Verification</button>

            <div id="widgetContainer">Didit widget preview will appear here.</div>
            <div id="eventLog">Event log:</div>
        </div>
    </form>

    <script>
        function log(message, data) {
            const eventLog = document.getElementById('eventLog');
            const line = `[${new Date().toISOString()}] ${message}` + (data ? `\n${JSON.stringify(data, null, 2)}` : '');
            eventLog.textContent += `\n\n${line}`;
        }

        function launchDidit() {
            const verificationUrl = document.getElementById('verificationUrl').value.trim();
            const sessionId = document.getElementById('sessionId').value.trim();
            const widgetContainer = document.getElementById('widgetContainer');

            if (!verificationUrl) {
                log('Missing verification URL.');
                alert('Please provide the Didit verification URL.');
                return;
            }

            widgetContainer.innerHTML = '';
            const frame = document.createElement('iframe');
            frame.src = verificationUrl;
            frame.width = '100%';
            frame.height = '480';
            frame.style.border = '0';
            frame.allow = 'camera; microphone; geolocation';
            frame.title = 'Didit Verification Test Frame';

            frame.addEventListener('load', function () {
                log('Verification frame loaded.', {
                    verificationUrl: verificationUrl,
                    sessionId: sessionId || null
                });
            });

            widgetContainer.appendChild(frame);
            log('Launched verification.', { verificationUrl: verificationUrl, sessionId: sessionId || null });
        }

        window.addEventListener('message', function (event) {
            log('Received window message from verification frame.', {
                origin: event.origin,
                data: event.data
            });
        });
    </script>
</body>
</html>
