# PowerShell Profile
# Managed alongside chezmoi dotfiles

# --- PSReadLine ---
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -Colors @{
    Command   = '#50fa7b'
    Parameter = '#ffb86c'
    Operator  = '#ff79c6'
    Variable  = '#bd93f9'
    String    = '#f1fa8c'
    Number    = '#8be9fd'
    Type      = '#8be9fd'
    Comment   = '#6272a4'
    Keyword   = '#ff79c6'
    Error     = '#ff5555'
}

# --- Aliases ---
Set-Alias -Name g -Value git

function gs { git status @args }
function gd { git diff @args }
function gds { git diff --staged @args }
function gl { git log --oneline --graph --decorate @args }
function ga { git add @args }
function gc { git commit @args }
function gp { git push @args }
function gpull { git pull @args }
function gco { git checkout @args }
function gb { git branch @args }

# --- Environment ---

# fnm (Node version manager)
if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}

# uv completions
if (Get-Command uv -ErrorAction SilentlyContinue) {
    (& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
    (& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression
}

# --- Oh My Posh ---
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    $ompConfig = Join-Path $env:USERPROFILE ".config\oh-my-posh\oddrationale.omp.json"
    oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
}
