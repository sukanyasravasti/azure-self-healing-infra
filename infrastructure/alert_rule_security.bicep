// Create an Azure Monitor scheduled query alert for fake threat simulation
param workspaceResourceId string

resource securityAlert 'Microsoft.Insights/scheduledQueryRules@2023-12-01' = {
  name: 'FakeSecurityThreatDetected'
  location: resourceGroup().location
  properties: {
    description: 'Fake security threat detection for demo purposes.'
    enabled: true

    // Define the KQL query that simulates security threats
    source: {
      query: '''
      datatable (ThreatDetected: string, ThreatLevel: string, AffectedUser: string, IPAddress: string)
      [
        "Brute Force Attack", "High", "demo_user", "192.168.1.100",
        "Suspicious Process Execution", "Medium", "demo_admin", "10.0.0.55"
      ]
      | extend TimeGenerated = now()
      '''
      dataSourceId: workspaceResourceId
      queryType: 'ResultCount'
    }

    // Schedule to run the query every 5 minutes
    schedule: {
      frequencyInMinutes: 5
      timeWindowInMinutes: 5
    }

    // Alert criteria: if query returns more than 0 results
    criteria: {
      allOf: [
        {
          threshold: 0
          operator: 'GreaterThan'
          timeAggregation: 'Count'
        }
      ]
    }

    severity: 2 // Severity level for the alert
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    actions: [] // No action group defined directly here
  }
}
