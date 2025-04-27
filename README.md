- Summary:
I built a fun DevOps project recently using my personal Azure cloud subscription. This project watches over virtual machines in Azure (only my device in this case) and detects problems or security risks. Once a problem is detected, my workflow automatically fixes it. Problem examples: freeing up disk space or restarting a stuck service. For security risks, the system uses AI to quickly analyze issues and suggest what actions should be taken next.

- Simplified Logic Diagram:

![Screenshot 2025-04-27 at 3 15 56 PM](https://github.com/user-attachments/assets/03ce2413-8972-4f33-88d9-44dfcc323eb3)

- Technology Stack Used:
Authenticate (SPN) → GitHub Actions (Deploy VM + Monitoring) → Azure Monitor Agent (Collect Logs) → Log Analytics + KQL → Alerts → Automation Runbook → AI Incident Analysis
