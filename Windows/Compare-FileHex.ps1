function CompareFileHex {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourceFile,
        [Parameter(Mandatory=$true)]
        [string]$CompareFile,
        [Parameter(Mandatory=$false)]
        [string]$OutputFile,
        [Parameter(Mandatory=$false)]
        [int]$BufferSize = 1MB,
        [Parameter(Mandatory=$false)]
        [int]$MaxDifferences = 1000
       
    )

    function Format-FileSize {
        param ([long]$Size)
        if ($Size -ge 1GB) { "{0:N2} GB" -f ($Size / 1GB) }
        elseif ($Size -ge 1MB) { "{0:N2} MB" -f ($Size / 1MB) }
        elseif ($Size -ge 1KB) { "{0:N2} KB" -f ($Size / 1KB) }
        else { "$Size Bytes" }
    }

    # ����ļ��Ƿ����
    if (-not (Test-Path $SourceFile)) {
        Write-Host "Դ�ļ� '$SourceFile' �����ڡ������ļ�·���Ƿ���ȷ��"
        return
    }
    if (-not (Test-Path $CompareFile)) {
        Write-Host "�Ƚ��ļ� '$CompareFile' �����ڡ������ļ�·���Ƿ���ȷ��"
        return
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
    $differenceCount = 0
  

    $Block = "��"
    $ProgressBarWidth = [Math]::Min([Console]::WindowWidth - 1, 50) # ʹ�ÿ���̨��Ȼ����50���ַ�
    
    function Update-ProgressBar {
        param (
            [double]$PercentComplete
        )
        
        $filledWidth = [math]::Round($ProgressBarWidth * ($PercentComplete / 100))
        $progressBar = $Block * $filledWidth
    
        # �ƶ�����һ�п�ʼλ�ò����½�������
        [Console]::SetCursorPosition(0, [Console]::CursorTop - 1)
        Write-Host ("�ȽϽ��� {0:F2}%" -f $PercentComplete) -NoNewline
    
        # �ƶ����ڶ��п�ʼλ�ò����½�����
        [Console]::SetCursorPosition(0, [Console]::CursorTop + 1)
        Write-Host $progressBar.PadRight($ProgressBarWidth) -NoNewline -ForegroundColor Green
    }
    
    # Ϊ������Ԥ��
    Write-Host "`n"
  
    try {
        while ($position -lt $totalLength -and $differenceCount -lt $MaxDifferences) {
            $read1 = $sourceStream.Read($buffer1, 0, $BufferSize)
            $read2 = $compareStream.Read($buffer2, 0, $BufferSize)
            $maxRead = [Math]::Max($read1, $read2)

            for ($i = 0; $i -lt $maxRead -and $differenceCount -lt $MaxDifferences; $i++) {
                $sourceByte = if ($i -lt $read1) { $buffer1[$i] } else { $null }
                $compareByte = if ($i -lt $read2) { $buffer2[$i] } else { $null }
                
                if ($sourceByte -ne $compareByte) {
                    $results.Add([PSCustomObject]@{
                        Address = $position + $i
                        SourceFile = if ($null -ne $sourceByte) { "{0:X2}" -f $sourceByte } else { "--" }
                        CompareFile = if ($null -ne $compareByte) { "{0:X2}" -f $compareByte } else { "--" }
                    })
                    $differenceCount++
                }
            }

            $position += $maxRead
            $percentComplete = [math]::Round(($position / $totalLength) * 100, 2)
             # ���½�����
            Update-ProgressBar -PercentComplete $percentComplete
        }
    }
    finally {
        $sourceStream.Close()
        $compareStream.Close()
        Write-Host "`n" # ���һ������
    }

    #Write-Progress -Activity "�Ƚ��ļ�" -Completed

    $sourceSizeFormatted = Format-FileSize -Size $sourceSize
    $compareSizeFormatted = Format-FileSize -Size $compareSize

    if ($differenceCount -ge $MaxDifferences) {
        $summary = @"
Դ�ļ���$SourceFile
��С: $sourceSizeFormatted
�Ƚ��ļ���$CompareFile
��С: $compareSizeFormatted
���棺���������������� $MaxDifferences ������ֹͣ�Ƚϡ�
"@
        Write-Host $summary
        return
    }

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
            $detailedOutput += "`n"  # ��ӿ��б�ʾ������
        }
        $detailedOutput += "0x{0:X8}  {1}        {2}`n" -f $result.Address, $result.SourceFile, $result.CompareFile
        $lastAddress = $result.Address
    }

    $fullOutput = $summary + $detailedOutput

    # �������ļ��Ƿ���ڣ������ʱ���
    if ($OutputFile) {
        if (Test-Path $OutputFile) {
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $baseName = [System.IO.Path]::GetFileNameWithoutExtension($OutputFile)
            $extension = [System.IO.Path]::GetExtension($OutputFile)
            $newOutputFile = [System.IO.Path]::Combine(
                [System.IO.Path]::GetDirectoryName($OutputFile),
                "$baseName`_$timestamp$extension"
            )
            $OutputFile = $newOutputFile
        }
        $fullOutput | Out-File -FilePath $OutputFile -Encoding utf8
        Write-Host "����ѱ��浽: $OutputFile"
    }

    Write-Host $fullOutput
}