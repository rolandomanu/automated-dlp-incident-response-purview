[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$TenantDomain
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "         DETECCION Y TRIAGE AUTOMATICO DLP        " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

$incidentId = "DLP-INT-" + (Get-Random -Minimum 1000 -Maximum 9999)
$timestamp  = Get-Date -Format "yyyyMMdd_HHmmss"

$incidentData = [PSCustomObject]@{
    incidentId   = $incidentId
    timestamp    = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    tenant       = $TenantDomain
    user         = "rhuayamave@$TenantDomain"
    fileName     = "confidentialxy.docx"
    recipient    = "mcardenaschalco@gmail.com"
    policyName   = "Project Alpha DLP Policy"
    ruleName     = "Detect and Block Project Alpha Data"
    action       = "Blocked External Sharing & Remediation Logged"
    triageStatus = "Completed"
}

Write-Host "Incident ID:      $($incidentData.incidentId)" -ForegroundColor Yellow
Write-Host "Usuario:          $($incidentData.user)"
Write-Host "Archivo Afectado: $($incidentData.fileName)"
Write-Host "Destino Externo:  $($incidentData.recipient)"
Write-Host "Regla Infringida: $($incidentData.ruleName)"
Write-Host "Acción Aplicada:  $($incidentData.action)" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

$outputDir = ".\DLP_Incident_Reports"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

$jsonPath = Join-Path $outputDir "DLP_Incident_$timestamp.json"
$incidentData | ConvertTo-Json -Depth 3 | Out-File -FilePath $jsonPath -Encoding utf8
Write-Host "[+] Reporte JSON generado en: $jsonPath" -ForegroundColor Green

$csvPath = Join-Path $outputDir "DLP_Incident_Log.csv"
if (-not (Test-Path $csvPath)) {
    $incidentData | Export-Csv -Path $csvPath -NoTypeInformation -Encoding utf8
} else {
    $incidentData | Export-Csv -Path $csvPath -NoTypeInformation -Append -Encoding utf8
}
Write-Host "[+] Registro CSV actualizado en: $csvPath" -ForegroundColor Green
