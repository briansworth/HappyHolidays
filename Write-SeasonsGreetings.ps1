function Write-SeasonsGreeting {
    [CmdletBinding(DefaultParameterSetName='height')]
    Param(
        [Parameter(
            Position=0,
            ParameterSetName='height'
        )]
        [ValidateScript({$_ -gt 3 -and $_ -le ($host.UI.RawUI.WindowSize.Width/2-2)})]
        [Int16]$height= 11,

        [Parameter(
            Position=0,
            ParameterSetName='max'
        )]
        [Switch]$maxSize
    )
    if($PSCmdlet.ParameterSetName -eq 'max'){
        [int16]$height=$host.UI.RawUI.WindowSize.Width/2-2
    }
    [String]$message = "Happy Holidays!!"
    [Collections.HashTable]$params=@{
        BackgroundColor='Green';
        NoNewline=$true;
    }
    0..($height-1) | % { Write-Host ' ' -NoNewline }
    Write-Host -ForegroundColor Yellow '*'
    0..($height - 1) | %{
        $width = $_ * 2 
        1..($height - $_) | %{ Write-Host ' ' -NoNewline}

        Write-Host '/' -NoNewline -ForegroundColor Green
        while($Width -gt 0){
            switch (Get-Random -Minimum 1 -Maximum 20) {
                1       { Write-Host @params -ForegroundColor Red '@' }
                2       { Write-Host @params -ForegroundColor Green '@' }
                3       { Write-Host @params -ForegroundColor Blue '@' }
                4       { Write-Host @params -ForegroundColor Yellow '@' }
                5       { Write-Host @params -ForegroundColor Magenta '@' }
                Default { Write-Host @params ' ' }
            }
            $Width--
        }
         Write-Host '\' -ForegroundColor Green
    }
    0..($height*2) | %{ Write-Host -ForegroundColor Green '~' -NoNewline }
    Write-Host -ForegroundColor Green '~'
    
    ## TRUNK ##
    [int]$trunkh=1
    [int]$trunkw=1
    if ($height -ge 0 -and $height -lt 12){
        $trunkh=1
    }elseif ($height -ge 13 -and $height -lt 25){
        $trunkh=2
        $trunkw=2
    }elseif ($height -ge 25 -and $height -lt 35){
        $trunkh=3
        $trunkw=2
    }elseif ($height -ge 35 -and $height -lt 50){
        $trunkh=4
        $trunkw=2
    }elseif ($height -ge 50 -and $height -lt 75){
        $trunkh=5
        $trunkw=3
    }else{
        $trunkh=6
        $trunkw=4
    }
    1..$trunkh | % {
        0..($height-$trunkw) | % { Write-Host ' ' -NoNewline }
      1..$trunkw | % {
        Write-Host -BackgroundColor DarkRed -ForegroundColor Black '  ' -NoNewline
      }
      write-host $null
    }
    write-host $null
    $Padding = ($Height * 2 - ($Message.Length -2)) / 2
    if($Padding -gt 0){
        1..$Padding | % { Write-Host ' ' -NoNewline }
    }
    0..($Message.Length -1) | %{
        $Index = $_
        switch ($Index % 2 ){
            0 { Write-Host -ForegroundColor Green $Message[$Index] -NoNewline}
            1 { Write-Host -ForegroundColor Red $Message[$Index] -NoNewline }
        }
    }
    write-host $null
}