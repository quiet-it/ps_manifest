



function Get-Manifest {

  param ($date_range)

  $inner_path = 'c:\Program Files (x86)\ProShip\Server\alfred_data\'
  $outbox = Get-ChildItem $inner_path -Recurse | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "outbox"}

  foreach($path in $outbox)
  {
    $each_path = Convert-Path $path.PSPath
    if((Test-path -Path (Join-Path -Path $each_path -ChildPath '\*')) -eq $true)
    {
      $p =  -join($inner_path.ToString(), '\', $path.Parent.Parent.ToString(), '\', $path.Parent.ToString(), '\', $path.ToString())
      $day = (get-date).AddDays(-($date_range)).Date
      $get_all_objects = get-ChildItem $p 
      $day_files = $get_all_objects | Where-Object {$_.CreationTime.Date -gt $day} 
      $day_files | Select-Object -Property Name, CreationTime, DirectoryName | Format-list
      
    }
  }
}

$cred = Get-Credential 'quietlogistics.com\abrailko'
$comp_name = 'vmncusproshipp2.quietlogistics.com'

Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest} -ArgumentList 2
#Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest} -ArgumentList 9,'yellow'
#Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest} -ArgumentList 8,'red'
