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

# Nothing happens, the stream is not visible in function apps
Test-Debug -Debug

# do not prompt for user interaction
$DebugPreference = 'Continue'
# redirect debugstream to success stream (write-output) - will now see the debug stream in the log
Test-Debug 5>&1