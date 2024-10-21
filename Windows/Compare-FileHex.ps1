function Compare-FileHex {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourceFile,
 
        [Parameter(Mandatory=$true)]
        [string]$CompareFile,
 
        [Parameter(Mandatory=$false)]
        [string]$OutputFile,
 
        [Parameter(Mandatory=$false)]
        [int]$BufferSize = 1MB
    )
 
    function Format-FileSize {
        param ([long]$Size)
        if ($Size -ge 1GB) { "{0:N2} GB" -f ($Size / 1GB) }
        elseif ($Size -ge 1MB) { "{0:N2} MB" -f ($Size / 1MB) }
        elseif ($Size -ge 1KB) { "{0:N2} KB" -f ($Size / 1KB) }
        else { "$Size Bytes" }
    }
 
    $sourceStream = [System.IO.File]::OpenRead($SourceFile)
    $compareStream = [System.IO.File]::OpenRead($CompareFile)
 
    $results = New-Object System.Collections.Generic.List[PSCustomObject]
    $buffer1 = New-Object byte[] $BufferSize
    $buffer2 = New-Object byte[] $BufferSize
 
    $totalLength = [Math]::Max($sourceStream.Length, $compareStream.Length)
    $position = 0
 
    $sourceSize = $sourceStream.Length
    $compareSize = $compareStream.Length
 
    try {
        while ($position -lt $totalLength) {
            $read1 = $sourceStream.Read($buffer1, 0, $BufferSize)
            $read2 = $compareStream.Read($buffer2, 0, $BufferSize)
 
            $maxRead = [Math]::Max($read1, $read2)
 
            for ($i = 0; $i -lt $maxRead; $i++) {
                $sourceByte = if ($i -lt $read1) { $buffer1[$i] } else { $null }
                $compareByte = if ($i -lt $read2) { $buffer2[$i] } else { $null }
                
                if ($sourceByte -ne $compareByte) {
                    $results.Add([PSCustomObject]@{
                        Address = $position + $i
                        SourceFile = if ($sourceByte -ne $null) { "{0:X2}" -f $sourceByte } else { "--" }
                        CompareFile = if ($compareByte -ne $null) { "{0:X2}" -f $compareByte } else { "--" }
                    })
                }
            }
 
            $position += $maxRead
 
            $percentComplete = [math]::Round(($position / $totalLength) * 100, 2)
            Write-Progress -Activity "�Ƚ��ļ�" -Status "$percentComplete% ���" -PercentComplete $percentComplete
        }
    }
    finally {
        $sourceStream.Close()
        $compareStream.Close()
    }
 
    Write-Progress -Activity "�Ƚ��ļ�" -Completed
 
    $sourceSizeFormatted = Format-FileSize -Size $sourceSize
    $compareSizeFormatted = Format-FileSize -Size $compareSize
 
    $summary = @"
Դ�ļ���$SourceFile
��С: $sourceSizeFormatted
 
�Ƚ��ļ���$CompareFile
��С: $compareSizeFormatted
 
��֮ͬ��: $($results.Count) �ֽ�
��ϸ���£�
 
"@
 
    $detailedOutput = "��ַ       Դ�ļ�    �Ƚ��ļ�`n"
    $detailedOutput += "--------------------------`n"
    $lastAddress = -1
    foreach ($result in $results) {
        if ($lastAddress -ne -1 -and $result.Address -ne $lastAddress + 1) {
            $detailedOutput += "`n"  # ���ӿ��б�ʾ������
        }
        $detailedOutput += "0x{0:X8}  {1}        {2}`n" -f $result.Address, $result.SourceFile, $result.CompareFile
        $lastAddress = $result.Address
    }
 
    $fullOutput = $summary + $detailedOutput
 
    if ($OutputFile) {
        $fullOutput | Out-File -FilePath $OutputFile -Encoding utf8
        Write-Host "����ѱ��浽: $OutputFile"
    }
 
    Write-Host $fullOutput
}
 