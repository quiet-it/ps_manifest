



function Get-Manifest {

  param ($date_range, $color)  

  
  $inner_path = 'c:\Program Files (x86)\ProShip\Server\alfred_data'

  

  $outbox = Get-ChildItem 'c:\Program Files (x86)\ProShip\Server\alfred_data' -Recurse | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "outbox"}

  foreach($path in $outbox)
  {
    $each_path = Convert-Path $path.PSPath
    if((Test-path -Path (Join-Path -Path $each_path -ChildPath '\*')) -eq $true)
    {
      $p =  -join($inner_path.ToString(), '\', $path.Parent.Parent.ToString(), '\', $path.Parent.ToString(), '\', $path.ToString())
     
      $day = (get-date).AddDays(-($date_range)).Date
           

      $get_all_objects = get-ChildItem $p 

     
      $day_files = $get_child | Where-Object {$_.CreationTime.Date -gt $day}
               
      Write-Host $day_files -BackgroundColor $color  
    } 
  }
}

Write-Host $3day_files

$cred = Get-Credential 'quietlogistics.com\abrailko'
# Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest}

$commands = @(
    Get-Manifest 1 green,
    Get-Manifest 2 yellow,
    Get-Manifest 5 red
)
$comp_name = 'vmncusproshipp2.quietlogistics.com'
foreach ($each_command in $commands){
    $comp_name
    Invoke-Command $each_command -ComputerName 'vmncusproshipp2.quietlogistics.com' -Credential $cred 
}
#Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest 1 green}
#Invoke-Command -ComputerName $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest 2 yellow}
#Invoke-Command -me $comp_name -Credential $cred -ScriptBlock ${function:Get-Manifest 6 red}
