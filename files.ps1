$file_types= @("*.dll","*.exe","*.docx", "*.doc", "*.xls", "*.xslx", "*.zip")
$star= "*************************************************************************"
Start-Transcript  
function alle_bestanden_weergeven ($drive){
ls -Path $drive -Verbose -Recurse -Include $file_types

$totaal_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).count
$totaal_grootte_van_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).sum
Write-Host "Aantal bestanden:" $totaal_files -ForegroundColor Yellow
Write-Host "Totale grootte van alle bestanden: " $totaal_grootte_van_files " byte" -ForegroundColor Yellow
Write-Host $star -ForegroundColor Green

}




function file_type_weergeven ($drive,
$extention){

#$extention_format= "*."+$extention

$totaal_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).count
$totaal_grootte_van_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).sum

$count_extention=(ls -Path $drive -Verbose -Recurse -Include $extention|measure -Sum Length).count
$sum_extention= (ls -Path $drive -Verbose -Recurse -Include $extention|measure -Sum Length).sum

if ($sum_extention -gt 0){
$percentage= ($sum_extention/$totaal_grootte_van_files)*100
$percentage_round= [math]::Round($percentage,2)}

if ($count_extention -eq 0){
Write-Host "There are no " $extention "files"-ForegroundColor Magenta}

else{
Write-Host "Amount" $extention "files:"    $count_extention -ForegroundColor Cyan
Write-Host "Totale grootte van" $extention "bestanden is:" $sum_extention "byte" -ForegroundColor Cyan
Write-Host "Het percentage van" $extention " bestanden: " $percentage_round "%" -ForegroundColor Cyan} 
Write-Host $star -ForegroundColor Green


}
$begin_time=get-date

alle_bestanden_weergeven -drive 'C:\Program Files'

foreach ($file in $file_types){

file_type_weergeven -drive 'C:\Program Files' -extention $file
}


$end_time= Get-Date
$difference_time= ($end_time.Subtract($begin_time)).TotalSeconds
$difference_time_in_sec= [math]::Round($difference_time,0)
Write-Host `nThe process was completed  in $difference_time_in_sec seconds -ForegroundColor Red



