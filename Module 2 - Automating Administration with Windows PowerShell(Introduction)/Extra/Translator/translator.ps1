function decodeText() {
    $fileName = Read-Host("Enter input.txt file path to decode")
    foreach($byte in (Get-Content $fileName -Encoding Byte)) {
        if (($byte -eq 121) -or ($byte -eq 122) -or ($byte -eq 89) -or ($byte -eq 90)) { 
            Write-Host ([char]($byte - 24)) -NoNewline 
        } elseif(($byte -in 97..120) -or ($byte -in 65..88)) { 
            Write-Host ([char]($byte + 2)) -NoNewline 
        } else { 
            Write-Host([char]$byte) -NoNewline 
        }
    }
    Write-Host "`n"
}
decodeText