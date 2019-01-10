<#
.SYNOPSIS
will output to the debug stream

.EXAMPLE
Test-Debug -Debug
#>

function Test-Debug {
    [CmdletBinding()]
    param (
        
    )
    
    begin { 
        # will be 'Inquire' regardless of what is set outside the function
        $DebugPreference    
    }
    
    process {
        Write-Debug "debugging in Azure function app"
    }
    
    end {
    }
}

# this has no effect
$DebugPreference = 'Continue'

#Nothing happens
Test-Debug -Debug
# redirect debugstream to success stream (write-output) - will now see the debug stream in the log
Test-Debug -Debug 5>&1