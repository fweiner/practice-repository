# Git and GitHub Setup Guide for Cursor

## Prerequisites

1. **Install Git** (if not already installed)
   - Download from: https://git-scm.com/download/win
   - Run the installer with default settings
   - Restart Cursor after installation

2. **Create a GitHub Account** (if you don't have one)
   - Sign up at: https://github.com

## Setting Up Your Repository

### Option 1: Using the Setup Script (Recommended)

After Git is installed, run:
```powershell
.\setup-git.ps1
```

The script will guide you through:
- Initializing the git repository
- Configuring your Git username and email
- Adding your GitHub repository URL

### Option 2: Manual Setup

#### 1. Initialize Git Repository
```powershell
git init
```

#### 2. Configure Git (one-time setup)
```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Or for this repository only:
```powershell
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

#### 3. Create a GitHub Repository
1. Go to https://github.com/new
2. Create a new repository (don't initialize with README if you already have files)
3. Copy the repository URL

#### 4. Connect to GitHub
```powershell
git remote add origin https://github.com/yourusername/your-repo-name.git
```

#### 5. Add, Commit, and Push
```powershell
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

## Connecting Cursor to GitHub

Cursor integrates with GitHub in several ways:

### 1. **Git Integration** (Built-in)
- Cursor automatically detects Git repositories
- Use the Source Control panel (Ctrl+Shift+G) to:
  - Stage changes
  - Commit changes
  - Push/pull from GitHub

### 2. **GitHub Authentication**
- When you push/pull, Cursor will prompt for GitHub credentials
- You can use:
  - **Personal Access Token** (recommended)
  - **GitHub CLI** (`gh auth login`)
  - **Git Credential Manager** (comes with Git for Windows)

### 3. **Creating a Personal Access Token**
1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Give it a name and select scopes: `repo` (full control)
4. Copy the token (you won't see it again!)
5. When Git prompts for password, use the token instead

### 4. **Using GitHub CLI** (Optional)
```powershell
# Install GitHub CLI
winget install GitHub.cli

# Authenticate
gh auth login

# This will automatically configure Git credentials
```

## Common Commands

```powershell
# Check status
git status

# Add files
git add .
git add filename.txt

# Commit
git commit -m "Your commit message"

# Push to GitHub
git push

# Pull from GitHub
git pull

# Check remotes
git remote -v

# View commit history
git log
```

## Troubleshooting

### Git not found
- Make sure Git is installed and added to PATH
- Restart Cursor after installing Git

### Authentication issues
- Use Personal Access Token instead of password
- Or use GitHub CLI: `gh auth login`

### Push rejected
- If repository already has content: `git pull --rebase origin main` then `git push`

