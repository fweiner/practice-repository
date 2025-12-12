# PowerShell script to set up Git repository and connect to GitHub

Write-Host "Setting up Git repository..." -ForegroundColor Green

# Check if Git is installed
try {
    $gitVersion = git --version
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Git is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "After installation, restart your terminal and run this script again." -ForegroundColor Yellow
    exit 1
}

# Initialize Git repository
if (Test-Path .git) {
    Write-Host "Git repository already initialized." -ForegroundColor Yellow
} else {
    Write-Host "Initializing Git repository..." -ForegroundColor Cyan
    git init
    Write-Host "Repository initialized!" -ForegroundColor Green
}

# Configure Git (you'll need to provide your details)
Write-Host "`nConfiguring Git..." -ForegroundColor Cyan
$userName = Read-Host "Enter your GitHub username"
$userEmail = Read-Host "Enter your GitHub email"

git config user.name $userName
git config user.email $userEmail

Write-Host "Git configured with: $userName <$userEmail>" -ForegroundColor Green

# Check for existing remote
$remoteExists = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "`nRemote 'origin' already exists: $remoteExists" -ForegroundColor Yellow
    $changeRemote = Read-Host "Do you want to change it? (y/n)"
    if ($changeRemote -eq "y") {
        git remote remove origin
    } else {
        Write-Host "Keeping existing remote." -ForegroundColor Green
        exit 0
    }
}

# Add GitHub remote
Write-Host "`nSetting up GitHub remote..." -ForegroundColor Cyan
$repoUrl = Read-Host "Enter your GitHub repository URL (e.g., https://github.com/username/repo.git)"

if ($repoUrl) {
    git remote add origin $repoUrl
    Write-Host "Remote 'origin' added: $repoUrl" -ForegroundColor Green
    
    # Verify connection
    Write-Host "`nVerifying connection..." -ForegroundColor Cyan
    git remote -v
    
    Write-Host "`nSetup complete!" -ForegroundColor Green
    Write-Host "You can now:" -ForegroundColor Cyan
    Write-Host "  1. Add files: git add ." -ForegroundColor White
    Write-Host "  2. Commit: git commit -m 'Initial commit'" -ForegroundColor White
    Write-Host "  3. Push: git push -u origin main" -ForegroundColor White
} else {
    Write-Host "No repository URL provided. You can add it later with:" -ForegroundColor Yellow
    Write-Host "  git remote add origin <your-repo-url>" -ForegroundColor White
}

