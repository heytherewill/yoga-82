# This cleans ups the train and test sets by removing the entries which failed to download
# or were manually removed after the manual clean up phase

$datasetFolder = "yoga_dataset_images_final"
$failureFile = "failures.txt"
$baseTestFile = "yoga_test.txt"
$testFile = "actual_yoga_test.txt"
$baseTrainFile = "yoga_train.txt"
$trainFile = "actual_yoga_train.txt"

$testEntries = Get-Content $baseTestFile
$trainEntries = Get-Content $baseTrainFile
$failureEntries = [System.Collections.Generic.HashSet[String]]::new()
Get-Content $failureFile | ForEach-Object { 
    $entryComponents = $_ -split "\t"
    $failureEntries.Add($entryComponents[0])
}

foreach ($entry in $testEntries) {
    $entryComponents = $entry -split ","
    $fileName = $entryComponents[0]
    Write-Output "$datasetFolder\$fileName"

    if ($failureEntries.Contains($fileName)) {
        continue;
    }

    if (Test-Path "$datasetFolder\$fileName") {
        $entry | Add-Content -path $testFile
    }
}

foreach ($entry in $trainEntries) {
    $entryComponents = $entry -split ","
    $fileName = $entryComponents[0]
    Write-Output "$datasetFolder\$fileName"

    if ($failureEntries.Contains($fileName)) {
        continue;
    }

    if (Test-Path "$datasetFolder\$fileName") {
        $entry | Add-Content -path $trainFile
    }
}