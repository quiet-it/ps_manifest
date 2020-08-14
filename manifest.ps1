# Write-Output


#$sysinfo = Get-WmiObject -Class Win32_ComputerSystem
#$sysinfo.Domain

$comp_name = 'vmncusproshipp2.quietlogistics.com'
function Get-Manifest {

  $inner_path = 'c:\Program Files (x86)\ProShip\Server\alfred_data'

  $outbox = Get-ChildItem $inner_path -recurse | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "outbox"}

  foreach($path in $outbox)
  {
    $each_path = Convert-Path $path.PSPath
    if((Test-path -Path (Join-Path -Path $each_path -ChildPath '\*')) -eq $true)
    {
      $p =  -join($inner_path.ToString(), '\', $path.Parent.Parent.ToString(), '\', $path.Parent.ToString(), '\', $path.ToString())
      # get-ChildItem $p | Format-list -Property Name,CreationTime,Directory
      # $date | get-member
      # $csv

      $row = get-ChildItem $p | Select-Object -Property Name,CreationTime,Directory | Format-list
      $row
      # $output_array.Add($row)
      # $output_array | get-member


      # $inner_path | get-member
      # $path.Parent.Parent | get-member
      # $path.Parent.Parent.ToString()

      # $path | get-member
      # @($path.Parent.Parent, $path.Parent, $path) | %{$c_path = Join-Path $inner_path (Convert-Path  $_)}
      # $c_path
      # Get-ChildItem -Path $c_path
      # Get-ChildItem -ComputerName $comp_name -Path (Join-Path -Path $path -ChildPath '\*') | format-table -autosize -property name
      # Invoke-Command -ComputerName $comp_name -Credential $prm.Cred -ScriptBlock ${Get-ChildItem -Path (Join-Path -Path $path -ChildPath '\*')}  | format-table -autosize -property name
      # write-Output $path
      # write-host $path.Parent.Parent'\'$path.Parent - 'contains some files'.ToUpper()
    } else {
      # write-host $path.Parent - 'empty'
    }
  }
  # $date = Get-Date -Format "MM-dd-yyyy_HH_mm"
  # $csv = -join((Convert-Path ~), '\Documents', '\', "ProShip_$date.csv" )
  # $output_array | Export-CSV -Path $csv
}


# function Show-Menu {
#   param (
#     [string]$option = ''
#   )
#   Clear-Host
#   Write-Output 'Welcome to Manifest script'
#   Write-Output 'Please choose options from menu down below'
#
#   sleep 3
#   cls
#   Write-Host "1: Press '1' to check folders pss_dhlamp and pss_dhlgmi."
#   Write-Host '2: Press Q to exit this menu'
# }
#
# do{
#   Show-Menu
#   $selection = Read-Host 'Please make a selection'
#   switch ($selection)
#   {
#     "1" {
#       Write-Host 'Enter your username and login'
      $cred = Get-Credential 'quietlogistics.com\'
      # Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest}
      Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest}
#     }
#     "q"{
#       exit
#     }
#   }
#   pause
# }
# until($selection -eq 'q')
