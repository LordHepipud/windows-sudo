@{
    ModuleVersion     = '1.0';
    GUID              = 'a9232538-a37a-46a1-946d-10673f0de2ea';
    RootModule        = 'windows-sudo.psm1'
    Author            = 'Lord Hepipud';
    CompanyName       = 'Lord Hepipud';
    Copyright         = '(c) 2023 Lord Hepipud. All rights reserved.';
    FunctionsToExport = @( 'Start-AsAdmin' );
    CmdletsToExport   = @();
    VariablesToExport = '*';
    AliasesToExport   = @( 'sudo' );
    PrivateData       = @{
        PSData = @{ };
    };
}
