<#
.SYNOPSIS
A cmdlet that emulates the use of ternary operators or inline if statements.

.DESCRIPTION
Powershell lacks a traditional ternary operator and the alternatives are all ugly, confusing, or long-winded; All of which ruin the point of using them in the first place.

This cmdlet offers a reasonably robust and terse alternative.

.PARAMETER Condition
The condition to evaluate. Any value can be passed in (including null) as long as casting to a Boolean is possible.

If Condition evaluates to true, TrueValue is returned, otherwise FalseValue is returned.

.PARAMETER TrueVal
The value to return on Condition evaluating to True.

.PARAMETER FalseVal
The value to return on Condition evaluating to False.

.EXAMPLE
1 -lt 2 | Get-TernaryResult "foo" "bar"
A simple int comparison

.EXAMPLE
"hello world" | ?: "foo" "bar"
Strings evaluate to true

.EXAMPLE
Get-TernaryResult "foo" "bar" $null
$null evaluates to false. If not piped in or named then Condition must be the last parameter

.EXAMPLE
0 | Get-TernaryResult "foo" "bar"
0 evaluates to false. All other numbers evaluate to true

.NOTES
TrueValue and FalseValue are positional paramters, so if Conditional is not piped into Get-TernaryResult then it must either be explicitly named or passed in last.

An alias mapping Get-TernaryResult to the much shorter '?:' is also provided, which also makes the function look even more like a traditonal ternary operator.
#>
function Get-TernaryResult{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowNull()]
        [Object]$Condition,
        [Parameter(Mandatory=$true,Position=0)]
        [Object]$TrueVal,
        [Parameter(Mandatory=$true,Position=1)]
        [Object]$FalseVal
    )
    END { return @{$true=$TrueVal;$false=$FalseVal}[[bool]$Condition] }
}
New-Alias -Name "?:" -Value Get-TernaryResult -Description "Powershell doesn't have a ternary operator, so use this instead."
