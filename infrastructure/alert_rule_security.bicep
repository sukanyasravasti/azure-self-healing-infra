param workspaceResourceId string

resource securityAlert 'Microsoft.Insights/scheduledQueryRules@2023-03-15-preview' = {
  name: 'FakeSecurityThreatDetected'
  location: resourceGroup().location
  properties: {
    displayName: 'Fake Threat Simulation'
    description: 'Simulates a fake security threat for demonstration purposes'
    severity: 2
    enabled: true

    // The workspace where the query runs
    scopes: [
      workspaceResourceId
    ]

    // KQL logic and trigger criteria
    criteria: {
      query: '''
        datatable (ThreatDetected: string, ThreatLevel: string, AffectedUser: string, IPAddress: string)
        [
          "Brute Force Attack", "High", "demo_user", "192.168.1.100",
          "Suspicious Process Execution", "Medium", "demo_admin", "10.0.0.55"
        ]
        | extend TimeGenerated = now()
      '''
      timeWindow: 'PT5M'               // How far back to evaluate
      evaluationFrequency: 'PT5M'      // How often to run
      trigger: {
        threshold: 0
        operator: 'GreaterThan'
      }
    }

    // Connect to your manual Action Group
    actions: {
      actionGroups: [
        '/subscriptions/240623fd-297f-4c97-833d-66f0166f67d7/resourceGroups/selfHealingInfra-rg/providers/microsoft.insights/actionGroups/SelfHealingRemediation'
      ]
    }
  }
}
