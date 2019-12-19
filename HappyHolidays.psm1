$holidayBanner = @'
      _____________________________________________________________
  ___|  _  _                       _  _     _ _    _               |___
  \  | | || |__ _ _ __ _ __ _  _  | || |___| (_)__| |__ _ _  _ ___ |  /
   \ | | __ / _` | '_ \ '_ \ || | | __ / _ \ | / _` / _` | || (_-< | /
    \| |_||_\__,_| .__/ .__/\_, | |_||_\___/_|_\__,_\__,_|\_, /__/ |/
    /|           |_|  |_|   |__/                          |__/     |\
   / |_____________________________________________________________| \
  /_____)                                                       (_____\
'@

$star = @'
 __/\__ 
 \    /
 /_/\_\
'@

Function Write-Ornament
{
  [CmdletBinding()]
  Param(
    [ValidateRange(1, 100)]
    [int]$Frequency = 25
  )
  $ornaments = @(
    '@',
    '#',
    '$',
    '%',
    '&',
    '+',
    '®',
    '©',
    '§',
    '¤',
    '¥',
    '°',
    '»',
    'ø',
    'ł',
    'Δ',
    'π',
    'Ψ',
    'ζ',
    'Ξ'
  )
  $coreOrn = @(
    'Ɣ',
    'Ɛ',
    'Ƣ',
    'ƛ',
    'ƺ',
    'Ʊ',
    'Ʃ',
    'ǂ',
    'ȣ',
    'ȸ',
    'Ʌ',
    'ɮ',
    'ɸ',
    'ʘ',
    'ʚ',
    'ʞ',
    'ʬ',
    'ϣ',
    'Ϡ',
    'ϓ'
  )
  if ($PSVersionTable.PSEdition -eq 'Core')
  {
    $ornaments += $coreOrn
  }

  $colors = @(
    'Red',
    'DarkRed',
    'Blue',
    'DarkBlue',
    'DarkYellow',
    'Cyan',
    'DarkCyan',
    'Magenta',
    'DarkMagenta',
    'White'
  )
  $randInt = Get-Random -Minimum 0 -Maximum 100
  $randOrn = ' '
  $randCol = 'Green'
  if ($randInt -le $Frequency)
  {
    $randOrn = Get-Random -InputObject $ornaments
    $randCol = Get-Random -InputObject $colors
  }
  Write-Host -Object $randOrn `
    -ForegroundColor $randCol `
    -BackgroundColor 'Green' `
    -NoNewLine
}

Function Write-HostRepeat
{
  [CmdletBinding()]
  Param(
    [int]$Count = 1,

    [char]$Character = ' ',

    [ConsoleColor]$ForegroundColor,

    [ConsoleColor]$BackgroundColor
  )
  if ($Count -lt 0)
  {
    return
  }
  $writeParams = @{
    Object = $Character;
    NoNewline = $true;
  }
  if ($PSBoundParameters.ContainsKey('ForegroundColor'))
  {
    $writeParams.Add('ForegroundColor', $ForegroundColor)
  }
  if ($PSBoundParameters.ContainsKey('BackgroundColor'))
  {
    $writeParams.Add('BackgroundColor', $BackgroundColor)
  }
  for ($i = 0; $i -lt $Count; $i++)
  {
    Write-Host @writeParams
  }
}

Function Resolve-AsciiArtWidth
{
  [CmdletBinding()]
  Param(
    [string]$Art
  )
  $longest = 0
  foreach ($line in $Art.Split("`n"))
  {
    if ($line.length -gt $longest)
    {
      $longest = $line.length
    }
  }
  return $longest
}

Function Write-AsciiArt
{
  [CmdletBinding()]
  Param(
    [string]$Art,

    [ConsoleColor]$Color = 'Green'
  )
  $center = $host.UI.RawUI.WindowSize.Width / 2 - 2
  $artWidth = Resolve-AsciiArtWidth -Art $Art
  foreach ($line in $Art.Split("`n"))
  {
    Write-HostRepeat -Count ($center - ($artWidth / 2))
    Write-Host "$line" -ForegroundColor $Color
  }
}

Function Write-Trunk
{
  [CmdletBinding()]
  Param(
    [int]$TreeHeight
  )
  [int]$center = $host.UI.RawUI.WindowSize.Width / 2 - 2
  $trunkh = 1
  $trunkw = 2
  if ($TreeHeight -ge 0 -and $TreeHeight -lt 12){
    $trunkh = 1
  }elseif ($TreeHeight -ge 13 -and $TreeHeight -lt 20){
    $trunkh = 2
    $trunkw = 2
  }elseif ($TreeHeight -ge 20 -and $TreeHeight -lt 30){
    $trunkh = 3
    $trunkw = 4
  }elseif ($TreeHeight -ge 30 -and $TreeHeight -lt 40){
    $trunkh = 4
    $trunkw = 6
  }elseif ($TreeHeight -ge 40 -and $TreeHeight -lt 75){
    $trunkh = 5
    $trunkw = 8
  }else{
    $trunkh = 6
    $trunkw = 10
  }
  for ($i = 0; $i -lt $trunkh; $i++)
  {
    Write-HostRepeat -Count ($center - ($trunkw / 2))
    Write-HostRepeat -Count $trunkw -BackgroundColor DarkRed
    Write-Host -Object ''
  }
}

<#
.SYNOPSIS
Happy Holidays!

.DESCRIPTION
Create a beautiful console tree in seconds by running this command.
Add some holiday spirit to your PSSession.

.PARAMETER Height
The height / size of the tree to produce.
It will not allow you to specify a height that would break the visual appeal of the tree.

.PARAMETER MaxSize
Produce the largest size of tree, without lines beginning to wrap, and thus breaking the appeal of the holiday tree.

.EXAMPLE
Write-SeasonsGreeting

.EXAMPLE
Write-SeasonsGreeting -MaxSize

.EXAMPLE
Write-SeasonsGreeting -Height 10
#>
Function Write-SeasonsGreeting 
{
  [CmdletBinding(DefaultParameterSetName = 'Height')]
  Param(
    [Parameter(Position = 0, ParameterSetName = 'Height')]
    [ValidateScript({
      $_ -gt 3 -and $_ -le ($host.UI.RawUI.WindowSize.Width / 2 - 2)
    })]
    [int16]$Height = 20,

    [Parameter(Position=0, ParameterSetName='Max')]
    [Switch]$MaxSize
  )
  if($PSCmdlet.ParameterSetName -eq 'Max')
  {
    [int16]$Height=$host.UI.RawUI.WindowSize.Width / 2 - 3
  }

  ## percent chance to produce ornament on tree. max: 100 ##
  $ornamentFrequency = 35
  [int]$center = $host.UI.RawUI.WindowSize.Width / 2 - 2

  Write-AsciiArt -Art $star -Color DarkYellow

  #  Skip first /\, the star takes care of that
  for ($i = 1; $i -lt $Height; $i++)
  {
    $width = $i * 2 

    ### Spacing before the tree
    for ($k = 1; $k -lt ($center - $i); $k++)
    {
      Write-Host ' ' -NoNewLine
    }

    ### BEGIN fill in tree ##
    Write-Host '/' -NoNewline -ForegroundColor Green
    while($width -gt 0){
      Write-Ornament -Frequency $ornamentFrequency
      $width--
    }
    Write-Host '\' -ForegroundColor Green
  }

  Write-HostRepeat -Count ($center - $Height)
  Write-HostRepeat -Count ($Height * 2) -Character '~' -ForegroundColor 'Green'
  Write-Host -Object ''
  ### END fill in tree ###

  Write-Trunk -TreeHeight $Height
  Write-AsciiArt -Art $holidayBanner
}

Export-ModuleMember -Function Write-SeasonsGreeting
