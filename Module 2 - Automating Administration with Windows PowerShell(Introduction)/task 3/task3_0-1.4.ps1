
#run script with save functions in memmory: . .\script.ps1
#after that you can evoke functions by name

#1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. 
#Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
function Write-RunningServiceToFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Enter file path with name to save and get content")]
        $txtfileName ='c:\myservices.txt'
    )
    Get-Service | Where-Object {$_.Status -eq "Running"} | Out-File -FilePath $txtfileName
}

function Read-DiskContent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Enter disk name to get content")]
        $disk='c:'
    )
    Get-ChildItem -Path $disk
}

function Read-FileContent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Enter file path with name to save and get content")]
        $txtfileName ='c:\myservices.txt'
    )
    Get-Content $txtfileName
}

#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
function Measure-SumOfNumericVariables {
    [CmdletBinding()]
    param()
    (Get-Variable | ForEach-Object { if($_.Value -is [int]) {$_.Value}} | Measure-Object -Sum).Sum
}

#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор.Результат записывать в файл.
function Get-LongestProcesses {
    [CmdletBinding()]
    param()
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
}

#1.3.1.	Организовать запуск скрипта каждые 10 минут
function Set-CustomScheduleTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, HelpMessage="Enter New-JobTrigger settings")]
        $scheduleTask = (New-JobTrigger -Once -At $(Get-Date) -RepetitionInterval(New-TimeSpan -Minutes 10) -RepetitionDuration(New-TimeSpan -Hours 1))
    )
    Register-ScheduledJob -Name StartMyScript -FilePath C:\Scripts\task3_0-1.4.ps1 -Trigger $scheduleTask
}

#1.4.	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)
function Measure-SizeOfFiles {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, HelpMessage="Enter directory to get files size")]
        $directory='c:\windows\'
    )
    (Get-ChildItem $directory -File -Recurse -Exclude *.tmp | Measure-Object -Sum Length).Sum / 1GB
}