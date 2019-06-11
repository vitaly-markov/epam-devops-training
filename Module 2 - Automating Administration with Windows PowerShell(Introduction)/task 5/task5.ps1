#В задании используются виртуальные машины созданные в предыдущих модулях.
#1.	При помощи WMI перезагрузить все виртуальные машины.
    #reboot VMs from Host
    Get-WmiObject -namespace root\virtualization\v2 Msvm_ComputerSystem | % { $_.requeststatechange(10) }

    Invoke-Command -Credential administrator -VMName MAYER_VM1, MAYER_VM2, MAYER_VM3 {
        (gwmi win32_operatingsystem -EnableAllPrivileges).Reboot()
    }

#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
    Invoke-Command -Credential administrator  -VMName MAYER_VM2 {Get-WmiObject -Class Win32_Process | Select-Object ProcessName -Unique}

#3.	Настроить PowerShellRemoting, для управления всеми виртуальными машинами с хостовой.
    #enable PowerShellRemoting
    Enable-PSRemoting

    #check PowerShellRemoting State
    Invoke-Command -Credential administrator -VMName MAYER_VM1, MAYER_VM2, MAYER_VM3 {Get-Service WinRM}
    Invoke-Command -Credential administrator -VMName MAYER_VM1, MAYER_VM2, MAYER_VM3 {Test-WSMan}

#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
    Invoke-Command -Credential administrator -VMName MAYER_VM2 {Set-Item WSMan:\localhost\listener\listener*\port -Value 42658}    
    Invoke-Command -Credential administrator -VMName MAYER_VM2 {Get-Item WSMan:\localhost\listener\listener*\port}

#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
    New-PSSessionConfigurationFile -Path .\diskContent.pssc -ModulesToImport Get-ChildItem
    Test-PSSessionConfigurationFile .\diskContent.pssc
    Register-PSSessionConfiguration -Path .\diskContent.pssc -Name DiskContent