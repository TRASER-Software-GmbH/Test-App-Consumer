/// <summary>
/// Test codeunit for TRASER Consumer Logic functionality
/// </summary>
codeunit 73001 "TRASER Consumer Logic Test"
{
    Subtype = Test;

    [Test]
    procedure TestProcessCustomerRegistration_ValidCustomer()
    var
        ConsumerLogic: Codeunit "TRASER Consumer Logic";
        Result: Text;
    begin
        // [GIVEN] Valid customer data
        // [WHEN] Processing customer registration
        Result := ConsumerLogic.ProcessCustomerRegistration('Test Customer', 'TR-123456');
        
        // [THEN] Registration should succeed with formatted message
        Assert.IsTrue(Result.Contains('TRASER: Customer Test Customer registered'), 
                     'Registration result should contain formatted message');
        Assert.IsTrue(Result.Contains('TR-123456'), 
                     'Registration result should contain customer number');
    end;

    [Test]
    procedure TestProcessCustomerRegistration_InvalidCustomerNo()
    var
        ConsumerLogic: Codeunit "TRASER Consumer Logic";
    begin
        // [GIVEN] Invalid customer number
        // [WHEN] Processing customer registration
        // [THEN] Should throw error for invalid format
        asserterror ConsumerLogic.ProcessCustomerRegistration('Test Customer', 'INVALID123');
        Assert.ExpectedError('Invalid customer number format');
    end;

    [Test]
    procedure TestGetApplicationInfo()
    var
        ConsumerLogic: Codeunit "TRASER Consumer Logic";
        AppInfo: Text;
    begin
        // [GIVEN] Consumer application
        // [WHEN] Getting application info
        AppInfo := ConsumerLogic.GetApplicationInfo();
        
        // [THEN] Should return formatted application info
        Assert.IsTrue(AppInfo.Contains('TRASER: TRASER Consumer Application'), 
                     'App info should contain application name');
        Assert.IsTrue(AppInfo.Contains('Core Library v1.0.0'), 
                     'App info should contain Core Library version');
    end;

    [Test]
    procedure TestPerformHealthCheck()
    var
        ConsumerLogic: Codeunit "TRASER Consumer Logic";
        HealthStatus: Text;
    begin
        // [GIVEN] System running
        // [WHEN] Performing health check
        HealthStatus := ConsumerLogic.PerformHealthCheck();
        
        // [THEN] Should return formatted health status
        Assert.IsTrue(HealthStatus.Contains('TRASER: System healthy'), 
                     'Health status should contain system status');
        Assert.IsTrue(HealthStatus.Contains('mode'), 
                     'Health status should indicate current mode');
    end;
}