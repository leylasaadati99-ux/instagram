param(
  [string]$Report = "research/2026-10-24-personal-branding-opportunities-fa.md",
  [string]$Message = "ops/telegram-message-fa.md"
)

$ErrorActionPreference = "Stop"
if (-not $env:TELEGRAM_BOT_TOKEN -or -not $env:TELEGRAM_CHAT_ID) {
  throw "Set TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID in the local environment first."
}

$base = "https://api.telegram.org/bot$($env:TELEGRAM_BOT_TOKEN)"
$text = Get-Content -Raw -LiteralPath $Message
Invoke-RestMethod -Method Post -Uri "$base/sendMessage" -Body @{
  chat_id = $env:TELEGRAM_CHAT_ID
  text = $text
}

Invoke-RestMethod -Method Post -Uri "$base/sendDocument" -Form @{
  chat_id = $env:TELEGRAM_CHAT_ID
  document = Get-Item -LiteralPath $Report
}
