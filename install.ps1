# SCHEDULE DAILYWALLPAPER
Set-Location $env:USERPROFILE
git clone https://codeberg.org/cbrookins/daily-wallpapers.git
$trigger = New-ScheduledTaskTrigger -Daily -At 9:00am
$action = New-ScheduledTaskAction -Execute PowerShell -Argument "-NoProfile -ExecutionPolicy Bypass -File $env:USERPROFILE\daily-wallpapers\dailyWallpaper.ps1 $style" -WorkingDirectory "$env:USERPROFILE\daily-wallpapers"
Register-ScheduledTask 'Daily Wallpaper' -Action $action -Trigger $trigger