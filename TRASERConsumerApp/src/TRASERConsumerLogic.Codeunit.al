/// <summary>
/// Consumer logic that demonstrates usage of TRASER Core Library
/// </summary>
codeunit 72001 "TRASER Consumer Logic"
{
    Access = Public;

    /// <summary>
    /// Process customer registration using TRASER Core Library utilities
    /// </summary>
    /// <param name="CustomerName">Name of the customer to register</param>
    /// <param name="CustomerNo">Customer number to validate and format</param>
    /// <returns>Formatted registration message</returns>
    procedure ProcessCustomerRegistration(CustomerName: Text; CustomerNo: Code[20]): Text
    var
        TRASERUtilities: Codeunit "TRASER Core Utilities";
        RegistrationMessage: Text;
    begin
        // Validate customer number format using Core Library
        if not TRASERUtilities.ValidateTRASERCustomerNo(CustomerNo) then
            Error('Invalid customer number format. Expected format: TR-NNNNNN');

        // Format registration message using Core Library
        RegistrationMessage := TRASERUtilities.FormatTRASERText(
            StrSubstNo('Customer %1 registered with number %2', CustomerName, CustomerNo));
        
        exit(RegistrationMessage);
    end;

    /// <summary>
    /// Get application information including Core Library version
    /// </summary>
    /// <returns>Application info with Core Library version</returns>
    procedure GetApplicationInfo(): Text
    var
        TRASERUtilities: Codeunit "TRASER Core Utilities";
        AppInfo: Text;
    begin
        AppInfo := StrSubstNo('TRASER Consumer Application v1.0.0\Using Core Library v%1', 
                              TRASERUtilities.GetTRASERVersion());
        exit(TRASERUtilities.FormatTRASERText(AppInfo));
    end;

    /// <summary>
    /// Perform system health check including Core Library components
    /// </summary>
    /// <returns>Health check status message</returns>
    procedure PerformHealthCheck(): Text
    var
        TRASERUtilities: Codeunit "TRASER Core Utilities";
        HealthStatus: Text;
    begin
        if TRASERUtilities.IsDebugModeEnabled() then
            HealthStatus := 'System healthy - Debug mode enabled'
        else
            HealthStatus := 'System healthy - Production mode';
            
        exit(TRASERUtilities.FormatTRASERText(HealthStatus));
    end;
}