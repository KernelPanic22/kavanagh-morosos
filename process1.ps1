$pathAddDebtInputFolder="$PSScriptRoot\input-agregar-moroso"
$pathRemoveDebtInputFolder="$PSScriptRoot\input-sacar-moroso"
$pathAddDebtTxt = "$pathAddDebtInputFolder\agregarMoroso.txt"
$pathRemoveDebtTxt = "$pathRemoveDebtInputFolder\sacarMoroso.txt"
$pathMorosoTxt = "E:\kavanagh"
$pathMorosoFlag = "$PSScriptRoot\moroso.txt"

if(Test-Path -Path $pathAddDebtTxt){
    $fileAddDebt=Get-Content -Path $pathAddDebtTxt
    
    Add-Content "$PSScriptRoot\process-output\AGREGAR_MOROSO_LOG_$(get-date -f dd-mm-yyyy).txt" "`n $(Get-Date -Format "dddd MM/dd/yyyy HH:mm"):==========Comienza proceso agregado de morosos.=========="
    
    ForEach ($line in $fileAddDebt){
        Copy-Item -Path $pathMorosoFlag -Recurse -Destination "$pathMorosoTxt\$line" 
        Add-Content "$PSScriptRoot\process-output\AGREGAR_MOROSO_LOG_$(get-date -f dd-mm-yyyy).txt" "`n $(Get-Date -Format "dddd MM/dd/yyyy HH:mm"): Cliente $line agregado como moroso."
        }

    Add-Content "$PSScriptRoot\process-output\AGREGAR_MOROSO_LOG_$(get-date -f dd-mm-yyyy).txt" "`n $(Get-Date -Format "dddd MM/dd/yyyy HH:mm"):==========Termina proceso agregado de morosos.=========="
    Copy-Item -Path $pathAddDebtTxt -Recurse -Destination "$PSScriptRoot\output-agregar-moroso\ProcessedFile on $(get-date -f yyyy-MM-dd).txt"
    Remove-Item -Path $pathAddDebtTxt -Recurse    

    }


if(Test-Path -Path $pathRemoveDebtTxt){
    $fileRemoveDebt=Get-Content -Path $pathRemoveDebtTxt 
    
    Add-Content "$PSScriptRoot\process-output\ELIMINAR_MOROSO_LOG_$(get-date -f dd-mm-yyyy).txt" "`n $(Get-Date -Format "dddd MM/dd/yyyy HH:mm"):==========Comienza proceso eliminar morosos.=========="
    
    ForEach ($file in $fileRemoveDebt){
        Remove-Item -Path "$pathMorosoTxt\$file\moroso.txt" -Recurse
        Add-Content "$PSScriptRoot\process-output\ELIMINAR_MOROSO_LOG_$(get-date -f dd-mm-yyyy).txt" "`n $(get-date -f yyyy-MM-dd): Cliente $file eliminado como moroso."
        }

    Add-Content "$PSScriptRoot\process-output\ELIMINAR_MOROSO_LOG_$(get-date -f dd-mm-yyyy).txt" "`n $(Get-Date -Format "dddd MM/dd/yyyy HH:mm"):==========Termina proceso eliminar morosos.=========="
    Copy-Item -Path $pathRemoveDebtTxt -Recurse -Destination "$PSScriptRoot\output-sacar-moroso\ProcessedFile on $(get-date -f yyyy-MM-dd).txt"
    Remove-Item -Path $pathRemoveDebtTxt -Recurse    
    }