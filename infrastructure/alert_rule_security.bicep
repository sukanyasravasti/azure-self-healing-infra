param workspaceResourceId string

resource securityAlert 'Microsoft.Insights/scheduledQueryRules@2023-03-15-preview' = {
  name: 'FakeSecurityThreatDetected'
  location: resourceGroup().location
  properties: {
    displayName: 'Fake Threat Simulation'
    description: 'Simulated brute-force and suspicious logins'
    severity: 2
    enabled: true

    scopes: [
      workspaceResourceId
    ]

    criteria: {
      allOf: [
        {
          query: '''
            datatable (ThreatDetected: string, ThreatLevel: string, AffectedUser: string, IPAddress: string)
            [
              "Brute Force Attack", "High", "demo_user", "192.168.1.100",
              "Suspicious Process Execution", "Medium", "demo_admin", "10.0.0.55"
            ]
            | extend TimeGenerated = now()
          '''
          timeAggregation: 'Count'
          threshold: 0
          operator: 'GreaterThan'
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }

    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'

    actions: {
      actionGroups: [
        '/subscriptions/240623fd-297f-4c97-833d-66f0166f67d7/resourceGroups/selfHealingInfra-rg/providers/microsoft.insights/actionGroups/SelfHealingRemediation'
      ]
    }
  }
}
