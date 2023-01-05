## Wallpaper Directory
$folder = "$env:userprofile\OneDrive\Pictures"

## The Magic
$image = "daily.png"
$wallpaper = ($folder + "\" + $image)

[xml]$feed = Invoke-WebRequest -Uri 'https://botsin.space/users/stripey.rss'
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
