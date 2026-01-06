# detect.ps1
# Outputs JSON to stdout. No changes to system.

$ErrorActionPreference = "SilentlyContinue"

function BytesToGB([double]$b) { [math]::Round($b / 1GB, 2) }

$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$cs  = Get-CimInstance Win32_ComputerSystem

# GPU detection (prefer highest VRAM adapter)
$gpus = Get-CimInstance Win32_VideoController | ForEach-Object {
  [pscustomobject]@{
    Name   = $_.Name
    Vendor = if ($_.Name -match "NVIDIA") {"NVIDIA"} elseif ($_.Name -match "AMD|Radeon") {"AMD"} elseif ($_.Name -match "Intel") {"Intel"} else {"Unknown"}
    VRAMGB = if ($_.AdapterRAM -gt 0) { [math]::Round($_.AdapterRAM / 1GB, 2) } else { 0 }
    Driver = $_.DriverVersion
  }
}

$gpu = $gpus | Sort-Object VRAMGB -Descending | Select-Object -First 1


$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$battery = Get-CimInstance Win32_Battery
$isLaptop = $false
if ($battery) { $isLaptop = $true } else {
  $enclosure = Get-CimInstance Win32_SystemEnclosure
  if ($enclosure.ChassisTypes -contains 9 -or $enclosure.ChassisTypes -contains 10 -or $enclosure.ChassisTypes -contains 14) { $isLaptop = $true }
}

$ramGB = BytesToGB($cs.TotalPhysicalMemory)

$tier = "MID"
if ($ramGB -lt 8 -or $cpu.NumberOfLogicalProcessors -lt 8 -or $gpu.VRAMGB -lt 3) { $tier = "LOW" }
elseif ($ramGB -ge 16 -and $cpu.NumberOfLogicalProcessors -ge 12 -and $gpu.VRAMGB -ge 6) { $tier = "HIGH" }

$result = [pscustomobject]@{
  TimeUTC = (Get-Date).ToUniversalTime().ToString("o")
  Admin   = $isAdmin
  Laptop  = $isLaptop

  OS = [pscustomobject]@{
    Caption = $os.Caption
    Version = $os.Version
    Build   = $os.BuildNumber
  }

  CPU = [pscustomobject]@{
    Name    = $cpu.Name.Trim()
    Cores   = $cpu.NumberOfCores
    Threads = $cpu.NumberOfLogicalProcessors
    MaxMHz  = $cpu.MaxClockSpeed
  }

  RAM = [pscustomobject]@{
    TotalGB = $ramGB
  }

  GPU = [pscustomobject]@{
    Name   = $gpu.Name
    Vendor = $gpu.Vendor
    VRAMGB = $gpu.VRAMGB
    Driver = $gpu.Driver
  }

  Tier = $tier
}

$result | ConvertTo-Json -Depth 6
