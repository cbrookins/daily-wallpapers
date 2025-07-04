$param=$args[0]

if ($param -eq 'gradient') {
    $feed = 'https://shuriken.masto.host/users/gradientbot.rss'
} elseif ($param -eq 'stripe') {
    $feed = 'https://shuriken.masto.host/users/stripey.rss'
} else {
    Write-Warning 'invalid parameter'
}

## Wallpaper Directory
$folder = "$env:userprofile"

## The Magic
$image = "daily.png"
$wallpaper = ($folder + "\" + $image)

[xml]$feed = Invoke-WebRequest -Uri $feed
$post = $feed.rss.channel.item[0]
$url = $post.description.Split() | select-string ".png"
$url = $url[0]
$url = $url -replace 'href=','' -replace '"',''

Invoke-WebRequest -Uri $url -OutFile $folder\$image

$setWallpaper = @' 
using System.Runtime.InteropServices; 
namespace Win32{ 
    
     public class Wallpaper{ 
        [DllImport("user32.dll", CharSet=CharSet.Auto)] 
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ; 
         
         public static void SetWallpaper(string thePath){ 
            SystemParametersInfo(20,0,thePath,3); 
         }
    }
 } 
'@

add-type $setWallpaper 
[Win32.Wallpaper]::SetWallpaper($wallpaper)
