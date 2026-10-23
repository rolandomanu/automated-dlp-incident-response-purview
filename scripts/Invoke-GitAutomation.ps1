[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$Message = "Update automated DLP incident response files and reports"
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "         AUTOMATIZACION DE FLUJO GIT          " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Inicializar repositorio si no está inicializado
if (-not (Test-Path ".\.git")) {
    Write-Host "[*] Inicializando repositorio Git..." -ForegroundColor Yellow
    git init
    git branch -M main
    git remote add origin https://github.com/rolandomanu/automated-dlp-incident-response-purview.git
}

# 1. Comprobar estado de Git
Write-Host "[*] Verificando estado del repositorio..." -ForegroundColor Yellow
git status

# 2. Agregar todos los cambios
Write-Host "`n[*] Agregando archivos modificados (git add)..." -ForegroundColor Yellow
git add .

# 3. Realizar el commit
Write-Host "`n[*] Creando commit con mensaje: '$Message'..." -ForegroundColor Yellow
git commit -m "$Message"

# 4. Enviar a GitHub
Write-Host "`n[*] Subiendo cambios a GitHub (git push)..." -ForegroundColor Yellow
git push -u origin main --force

Write-Host "`n[+] ¡Sincronización con GitHub completada con éxito!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
