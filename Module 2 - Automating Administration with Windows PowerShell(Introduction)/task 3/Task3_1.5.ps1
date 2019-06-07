#1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
function Write-WinUpdatesToCSV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Enter csv file path with name to save content")]
        $csvfileName='c:\winupdates.csv'
    )
    Get-HotFix | Export-Csv $csvfileName
}

#1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
function Write-HKLMtoXML {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Enter xml file path with name to save content")]
        $xmlfileName = 'c:\regHKLM.xml'
    )
    Get-ChildItem HKLM:\SOFTWARE\Microsoft | Export-Clixml $xmlfileName
}

#1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка разными цветами
function Read-ContentFromCSV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Enter csv file path with name to read content")]
        $csvfileName = 'C:\winupdates.csv'
    )
    Import-Csv $csvfileName | Format-List
}