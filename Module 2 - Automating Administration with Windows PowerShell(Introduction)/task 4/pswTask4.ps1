#1.	Вывести список всех классов WMI на локальном компьютере.
    Get-WmiObject -List * -NameSpace root -Recurse

#2.	Получить список всех пространств имён классов WMI.
    Get-WmiObject -Namespace Root -Recurse -Class __NAMESPACE | ForEach-Object { $_.name }

#3.	Получить список классов работы с принтером.
    Get-WmiObject -List | Where-Object {$_.name -match "printer"}

#4.	Вывести информацию об операционной системе, не менее 10 полей.
    Get-WMIObject win32_operatingsystem | Select-Object PSComputerName, Status, Name, FreePhysicalMemory, 
    Version,  LocalDateTime, Manufacturer, CurrentTimeZone, FreeVirtualMemory, NumberOfProcesses, Caption

#5.	Получить информацию о BIOS.
    Get-WmiObject -Class Win32_Bios

#6.	Вывести свободное место на локальных дисках. На каждом и сумму.
    Get-WmiObject win32_logicaldisk | Select-Object DeviceID, FreeSpace
    (Get-WmiObject win32_logicaldisk | ForEach-Object { $_.FreeSpace} | Measure-Object -Sum).Sum / 1GB

#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
    Get-WmiObject -Class Win32_PingStatus -Filter "Address='8.8.8.8'" | Select-Object Address, ResponseTime, StatusCode

#9.	Выводить сообщение при каждом запуске приложения MSWord.
Register-WmiEvent -query "select * from win32_ProcessStartTrace where processname = 'WINWORD.EXE'" -SourceIdentifier "Process Startes" -Action { Write-Host "MS-OFFICE is started" }