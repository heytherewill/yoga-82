$datasetFolder = "yoga_dataset_images_final"
$failureFile = "failures.txt"
$webClient = New-Object System.Net.WebClient
$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$failureSkips = [System.Collections.Generic.HashSet[String]]::new()
$failureFileExists = Test-Path $failureFile
if ($failureFileExists) {
    Get-Content $failureFile | ForEach-Object { $failureSkips.Add($_) }
} else {
    if ($IsWindows) {
        fsutil file createnew $failureFile 0
    } else {
        touch $failureFile
    }
}

$categoryFiles = Get-ChildItem -Attributes !Directory $datasetFolder

foreach ($categoryFile in $categoryFiles) {
    $categoryName = $categoryFile -replace ".txt"
    $directoryExists = Test-Path $categoryName
    if ($directoryExists) {
        Write-Output "Skipping creation of $categoryName"
    } else {
        mkdir $categoryName
    }

    $fileContents = Get-Content $categoryFile
    $entries = $fileContents -split ([System.Environment]::NewLine)

    $entries | ForEach-Object {
        $entry = $_
        $entryComponents = $entry -split "\t"
        $fileName = $entryComponents[0]
        $downloadUrl = $entryComponents[1]
        $outFile = "$root/$datasetFolder/$fileName"

        if ($failureSkips.Contains($entry)) {
            Write-Output "Skipping $fileName due to a previous failure"
        } else {
            $fileAlreadyDownloaded = Test-Path $outFile
        
            if ($fileAlreadyDownloaded) {
                Write-Output "Skipping download of $downloadUrl"
            } else {
                Write-Output "Downloading $downloadUrl"

                try {
                    $webClient.DownloadFile($downloadUrl, $outFile)
                }
                catch {
                    $entry | Add-Content -path $failureFile
                }
            }
        }
    }
}