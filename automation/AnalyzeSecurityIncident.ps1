# Analyze detected security incident using Azure OpenAI API

param(
  [string]$IncidentDetails = "Multiple failed login attempts detected on VM."
)

# Define your Azure OpenAI endpoint and key
$openAIEndpoint = "https://your-openai-resource.openai.azure.com/openai/deployments/your-deployment-name/completions?api-version=2023-03-15-preview"
$openAIKey = "your-openai-key"

# Prepare the request body
$body = @{
    prompt = "Analyze this security incident and recommend next steps: $IncidentDetails"
    max_tokens = 300
    temperature = 0.2
} | ConvertTo-Json -Depth 3

# Make API call to Azure OpenAI
$response = Invoke-RestMethod -Uri $openAIEndpoint `
  -Method POST `
  -Headers @{
    "api-key" = $openAIKey
    "Content-Type" = "application/json"
  } `
  -Body $body

# Output the AI recommendation
Write-Output "AI Recommendation: $($response.choices[0].text.Trim())"
