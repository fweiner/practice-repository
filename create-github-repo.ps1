# Script to create GitHub repository via API
param(
    [Parameter(Mandatory=$true)]
    [string]$Token,
    
    [Parameter(Mandatory=$false)]
    [string]$RepoName = "practice-repository"
)

$headers = @{
    "Authorization" = "token $Token"
    "Accept" = "application/vnd.github.v3+json"
}

$body = @{
    name = $RepoName
    description = "Practice repository"
    private = $false
    auto_init = $false
} | ConvertTo-Json

try {
    Write-Host "Creating GitHub repository '$RepoName'..." -ForegroundColor Cyan
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
    
    Write-Host "Repository created successfully!" -ForegroundColor Green
    Write-Host "Repository URL: $($response.html_url)" -ForegroundColor Green
    
    # Add remote and push
    Write-Host "`nAdding remote origin..." -ForegroundColor Cyan
    git remote add origin $response.clone_url
    
    Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
    git push -u origin main
    
    Write-Host "`nDone! Repository is now on GitHub: $($response.html_url)" -ForegroundColor Green
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody" -ForegroundColor Red
    }
    exit 1
}

