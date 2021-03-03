
#author: Yasar Unlu

$file_types= @("*.dll","*.exe","*.docx", "*.doc", "*.xls", "*.xslx", "*.zip")
$star= "*************************************************************************"
Start-Transcript 

function list_all_files ($drive){
ls -Path $drive -Verbose -Recurse -Include $file_types

$count_of_all_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).count
$total_size_of_all_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).sum
Write-Host "Count of all files :" $count_of_all_files -ForegroundColor Yellow
Write-Host "Total size of all files: " $total_size_of_all_files " byte" -ForegroundColor Yellow
Write-Host $star -ForegroundColor Green

}




function extention_info ($drive,
$extention){

#$extention_format= "*."+$extention

$count_of_all_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).count
$total_size_of_all_files= (ls -Path $drive -Verbose -Recurse -Include $file_types|measure -Sum Length).sum

$count_extention=(ls -Path $drive -Verbose -Recurse -Include $extention|measure -Sum Length).count
$sum_extention= (ls -Path $drive -Verbose -Recurse -Include $extention|measure -Sum Length).sum

if ($sum_extention -gt 0){
$percentage= ($sum_extention/$total_size_of_all_files)*100
$percentage_round= [math]::Round($percentage,2)}

if ($count_extention -eq 0){
Write-Host "There are no " $extention "files"-ForegroundColor Magenta}

else{
Write-Host "Count of" $extention "files:"    $count_extention -ForegroundColor Cyan
Write-Host "Total size of" $extention "files is:" $sum_extention "byte" -ForegroundColor Cyan
Write-Host "The percentage of " $extention " files: " $percentage_round "%" -ForegroundColor Cyan} 
Write-Host $star -ForegroundColor Green


}
$begin_time=get-date

list_all_files -drive 'C:\Program Files'

foreach ($file in $file_types){

extention_info -drive 'C:\Program Files' -extention $file
}


$end_time= Get-Date
$difference_time= ($end_time.Subtract($begin_time)).TotalSeconds
$difference_time_in_sec= [math]::Round($difference_time,0)
Write-Host `nThe process was completed  in $difference_time_in_sec seconds -ForegroundColor Red





