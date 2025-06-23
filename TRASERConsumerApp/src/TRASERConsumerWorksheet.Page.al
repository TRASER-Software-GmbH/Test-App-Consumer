/// <summary>
/// Worksheet page demonstrating TRASER Consumer Application functionality
/// </summary>
page 72001 "TRASER Consumer Worksheet"
{
    Caption = 'TRASER Consumer Worksheet';
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(CustomerRegistration)
            {
                Caption = 'Customer Registration';
                
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                    ToolTip = 'Enter the customer name for registration';
                }
                field(CustomerNo; CustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Number';
                    ToolTip = 'Enter customer number in format TR-NNNNNN';
                }
            }
            group(Results)
            {
                Caption = 'Results';
                
                field(RegistrationResult; RegistrationResult)
                {
                    ApplicationArea = All;
                    Caption = 'Registration Result';
                    ToolTip = 'Shows the result of customer registration';
                    Editable = false;
                    MultiLine = true;
                }
                field(ApplicationInfo; ApplicationInfo)
                {
                    ApplicationArea = All;
                    Caption = 'Application Information';
                    ToolTip = 'Shows application and library version information';
                    Editable = false;
                    MultiLine = true;
                }
                field(HealthStatus; HealthStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Health Status';
                    ToolTip = 'Shows system health check status';
                    Editable = false;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Register Customer")
            {
                Caption = 'Register Customer';
                Image = NewCustomer;
                ApplicationArea = All;
                ToolTip = 'Register customer using TRASER Core Library validation';
                
                trigger OnAction()
                var
                    ConsumerLogic: Codeunit "TRASER Consumer Logic";
                begin
                    Clear(RegistrationResult);
                    if (CustomerName = '') or (CustomerNo = '') then begin
                        Message('Please enter both customer name and number');
                        exit;
                    end;
                    
                    RegistrationResult := ConsumerLogic.ProcessCustomerRegistration(CustomerName, CustomerNo);
                    CurrPage.Update(false);
                    Message('Customer registration completed successfully!');
                end;
            }
            action("Get App Info")
            {
                Caption = 'Get Application Info';
                Image = Info;
                ApplicationArea = All;
                ToolTip = 'Get application and Core Library version information';
                
                trigger OnAction()
                var
                    ConsumerLogic: Codeunit "TRASER Consumer Logic";
                begin
                    ApplicationInfo := ConsumerLogic.GetApplicationInfo();
                    CurrPage.Update(false);
                end;
            }
            action("Health Check")
            {
                Caption = 'Health Check';
                Image = Health;
                ApplicationArea = All;
                ToolTip = 'Perform system health check';
                
                trigger OnAction()
                var
                    ConsumerLogic: Codeunit "TRASER Consumer Logic";
                begin
                    HealthStatus := ConsumerLogic.PerformHealthCheck();
                    CurrPage.Update(false);
                end;
            }
            action("Open TRASER Setup")
            {
                Caption = 'Open TRASER Setup';
                Image = Setup;
                ApplicationArea = All;
                ToolTip = 'Open TRASER Core Library setup page';
                
                trigger OnAction()
                var
                    TRASERSetup: Record "TRASER Setup";
                    TRASERSetupPage: Page "TRASER Setup";
                begin
                    TRASERSetupPage.SetRecord(TRASERSetup.GetSetup());
                    TRASERSetupPage.Run();
                end;
            }
        }
    }

    var
        CustomerName: Text[100];
        CustomerNo: Code[20];
        RegistrationResult: Text;
        ApplicationInfo: Text;
        HealthStatus: Text;

    trigger OnOpenPage()
    var
        ConsumerLogic: Codeunit "TRASER Consumer Logic";
    begin
        ApplicationInfo := ConsumerLogic.GetApplicationInfo();
        HealthStatus := ConsumerLogic.PerformHealthCheck();
    end;
}