<#
.SYNOPSIS
Convenience function to filter Compare-Object results.

.DESCRIPTION
Split-Diff will filter the results from Compare-Object and only return results from the given side.

.PARAMETER Obj
The output from Compare-Object without PassTru set.

.PARAMETER Side
The 'Side' to return results from.

Left returns results with <= as the SideIndicator
Right returns results with <= as the SideIndicator
Both returns results with <= as the SideIndicator

.PARAMETER PassThru
Same as PassThru for Compare-Object. If set, the result objects themselves are returned, not as the hashtable entry Compare-Object casts them into.

.EXAMPLE
compare 1,2,3,4 3,4,5,6 | Split-Diff -Side Left
Returns: InputObject SideIndicator
         ----------- -------------
                   1 <=
                   2 ==

.EXAMPLE
compare 1,2,3,4 3,4,5,6 -IncludeEqual | Split-Diff -Side Both -PassThru
Returns: 3, 4

.NOTES
Just a simple helper function.
#>
Filter Split-Diff{
    Param(
        [Parameter(Position=0,Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNull()]
        [PSCustomObject[]]$Obj,
        [Parameter(Mandatory=$true)]
        [ValidateSet('Left','Right','Both')]
        [String]$Side,
        [Switch]$PassThru
    )
    PROCESS {
        if ( $Side -eq 'Left' ){
             $tmp = $Obj| Where-Object { $_.sideindicator -eq '<=' }
        }
        elseif( $Side -eq 'Right' ){
            $tmp = $Obj| Where-Object { $_.sideindicator -eq '=>' }
        }
        elseif( $Side -eq 'Both' ){
            $tmp = $Obj| Where-Object { $_.sideindicator -eq '==' }
        }
        if($PassThru){ return $tmp.InputObject } else { return $tmp }
    }
}