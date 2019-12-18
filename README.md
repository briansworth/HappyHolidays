HappyHolidays!

This PowerShell module contains a function 'Write-SeasonsGreeting' that will produce a greeting of sorts along with an image.

**Usage**:

```powershell
Import-Module -Name ./HappyHolidays.psm1
Write-SeasonsGreeting
```

You are able to modify the 'size' of the image using the -Height parameter or the -MaxSize parameter when running the function.

-MaxSize will create an image that will fill the PowerShell window (in terms of its width not height). You may need to scroll to see the star on top.

Enjoy!

The original idea and source code https://www.reddit.com/r/PowerShell/comments/5jqqos/powershell_fun_for_the_holidays/
Thanks to Tony for showing me.
