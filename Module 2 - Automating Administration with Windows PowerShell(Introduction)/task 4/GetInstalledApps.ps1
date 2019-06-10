#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
    [CmdletBinding()]    
    param()
    Get-WmiObject -Class Win32_Product | Format-Table -Property Name, Version

