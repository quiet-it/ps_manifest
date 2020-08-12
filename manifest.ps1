$main_path = '\\vmncusproshipp2.quietlogistics.com\c$\Program Files (x86)\ProShip\Server\alfred_data'

$r_host = '\\vmncusproshipp2.quietlogistics.com'
$comp_name = 'vmncusproshipp2.quietlogistics.com'

$cred = Get-Credential "quietlogistics.com\abrailko"

#$sysinfo = Get-WmiObject -Class Win32_ComputerSystem
#$sysinfo.Domain

function Get-Manifest {

  $inner_path = 'c:\Program Files (x86)\ProShip\Server\alfred_data'

  $outbox = Get-ChildItem $inner_path -recurse | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "outbox"}
  # write-host get-location $outbox
  # $outbox | foreach{ Convert-Path $_.PSPath} | `
  #
  # %{ if((Test-path -Path (Join-Path -Path $_ -ChildPath '\*')) -eq $true){Invoke-item $_  } else {write-host 'Empty'}}

  foreach($path in $outbox)
  {
    $each_path = Convert-Path $path.PSPath
    if((Test-path -Path (Join-Path -Path $each_path -ChildPath '\*')) -eq $true)
    {
      write-host $path.Parent.Parent'\'$path.Parent - 'contains some files'.ToUpper()
    } else {
      write-host $path.Parent - 'empty'
    }
  }
  # $outbox |
  # foreach($Directory in $outbox) {Write-Host $Directory}
  # $location = @('pss_dhlamp', 'pss_dhlgmi')
  # foreach($item in $location)
  # {
  #   Write-host 'HERE'
  #   $full_path = -join($inner_path, '\' , $item)
  #   $full_path
  #   # $children = Get-ChildItem $full_path -Directory
  #   foreach($folder in $full_path){
  #       Test-Path -Path
  #   }
    # $outbox = Get-ChildItem $full_path -Directory -Recurse | where {$_.PSIsContainer -eq $true -and $_.Name -match 'outbox'} |  `

    # %{ Write-host ($_ | Measure-Object).Count}

    # %{if ( ($_ | Measure-Object).Count -eq 0) {Write-Host $_.Parent - 'Empty'} else {Write-Host $_.Parent 'File in here'}}


    # if(($outbox | foreach {$_ | Measure-Object).Count} -lt 0 ){
    #   $outbox | foreach { Write-Host $_.Parent - 'contains some files'}
    # } else {
    #   $outbox | foreach { Write-Host $_.Parent - 'is empty'}
    #
    # }

  # }
    }
    # Write-Host $session
    # Invoke-Command -Session $session -ScriptBlock ${function:Get-Manifest}
    Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest}

    # Remove-PSSession $session
