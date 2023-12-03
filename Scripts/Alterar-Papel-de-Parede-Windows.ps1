## See the script below
## Change the $impPath to reflect the location of your image file (Ideally a network location that all of your company devices can access)

#Modify Path to the picture accordingly to reflect your infrastructure
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope Process
$imgPath="C:\Temp\bckgroundlambo.jpg" 
$code = @' 
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

add-type $code 

#Apply the Change on the system 
[Win32.Wallpaper]::SetWallpaper($imgPath)

