I built a fun DevOps project recently using my personal Azure cloud subscription. This project watches over virtual machines in Azure and detects problems and security risks. Once a problem is detected, my workflow automatically fixes it. The system uses AI to quickly analyze issues and suggest what actions should be taken next. 

For simplicity, this project is limited to 1 VM already deployed on Azure that is connected to the Log Analytics workspace. The system simulates detection of brute-force login attempts and suspicious process execution risks. When these threats are detected through KQL queries and Azure Monitor alerts, an Automation Runbook is triggered. The runbook uses an Azure OpenAI API endpoint to perform AI-driven incident analysis, and automatically remediates the threat by restarting the affected VM. 


- Technology Stack Used and Steps: 

1. I use a Service Principal (SPN) to authenticate to my Azure account from GitHub Actions and configure monitoring on an existing VM to collect logs.  I.e. Authenticate (SPN) → GitHub Actions (Connect Existing VM + Deploy Monitoring)

2. Collected VM logs trigger KQL-based alerts that launch automated AI incident analysis and remediation. I.e. Azure Monitor Agent (Collect Logs) → Log Analytics + KQL → Alerts → Automation Runbook → AI Incident Analysis and Remediation

- Simplified Logic Diagram:

![Screenshot 2025-04-27 at 3 15 56 PM](https://github.com/user-attachments/assets/03ce2413-8972-4f33-88d9-44dfcc323eb3)


- How to run this workflow:
1. Clone this repo
2.	Set GitHub Secrets (SPN info)
GitHub → Your Repo → Settings → Secrets and variables → Actions → New repository secret
AZURE_CLIENT_ID	Your Service Principal App (client) ID
AZURE_CLIENT_SECRET	Your Service Principal Secret (password)
AZURE_TENANT_ID	Your Azure AD tenant ID
AZURE_SUBSCRIPTION_ID	Your Azure Subscription ID

3.	Update deploy.yml with your real Azure names

4.	Manually trigger GitHub Actions from GitHub
- Go to your GitHub repository
- Click Actions tab
- Click on "Configure Existing VM for Self-Healing" workflow
- Click the Run workflow button manually
