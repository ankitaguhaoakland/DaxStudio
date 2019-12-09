; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!


#define MyAppName "DAX Studio"
;#define MyAppVersion "2.0.0.1"
#define myAppMajor
#define myAppMinor
#define myAppRevision
#define myAppBuild
#define MyAppVersionFull ParseVersion('..\release\DaxStudio.exe', myAppMajor, myAppMinor, myAppRevision, myAppBuild)
#define MyAppVersion GetFileVersion('..\release\DaxStudio.exe')
#define MyAppPublisher "Dax Studio"
#define MyAppURL "http://daxstudio.codeplex.com"
#define MyAppExeName "DaxStudio.exe"
; Calculated Constants
#define MyAppFileVersion StringChange(MyAppVersion, ".", "_")
#define use_dotnetfx45
;#define use_sql2012sp1amo
;#define use_sql2012sp1adomdclient
#define use_sql2016amo
#define use_sql2016adomdclient

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
;AppId={{2DDF2B91-978D-4B47-AF1C-15E6C07ADEAD}
AppId={{CE2CEA93-9DD3-4724-8FE3-FCBF0A0915C1}
#ifdef Preview
AppName={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision} ({#Preview})
#else
AppName={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision}
#endif
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
;DefaultDirName={pf}\{#MyAppName}
DefaultDirName={userappdata}\{#MyAppName}
DefaultGroupName={#MyAppName}
UseSetupLdr=Yes


LicenseFile=..\license.rtf
;OutputBaseFilename=DaxStudio_{#MyAppFileVersion}_setup
OutputBaseFilename=DaxStudioPerUser_{#myAppMajor}_{#myAppMinor}_{#myAppRevision}_setup
OutputDir=..\package
Compression=lzma
SolidCompression=yes
VersionInfoVersion={#MyAppVersion}
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoCompany={#MyAppURL}

SetupIconFile=DaxStudio2.ico
WizardImageFile=WizardImageFile.bmp
WizardSmallImageFile=WizardSmallImageFile.bmp

PrivilegesRequired=none
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64 

DisableDirPage=auto
DisableProgramGroupPage=auto

UninstallDisplayIcon={app}\daxstudio.exe

[Messages]
; define wizard title and tray status msg
; both are normally defined in innosetup's default.isl (install folder)
#ifdef Preview
SetupWindowTitle={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision} {#Preview}
#else
SetupWindowTitle={#MyAppName} {#myAppMajor}.{#myAppMinor}.{#myAppRevision}
#endif

[Languages]
;Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"
;Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\release\DaxStudio.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: Core
Source: "..\release\bin\DaxStudio.vsto"; DestDir: "{app}"; Flags: ignoreversion; Components: Excel
Source: "..\release\bin\DaxStudio.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: Excel
Source: "..\release\bin\DaxStudio.dll.manifest"; DestDir: "{app}"; Flags: ignoreversion; Components: Excel
Source: "..\release\*"; DestDir: "{app}"; Flags: replacesameversion recursesubdirs createallsubdirs ignoreversion; Components: Core; Excludes: "*.pdb,*.xml,DaxStudio.vshost.*,*.config,DaxStudio.dll,DaxStudio.exe,DaxStudio.vsto"

;Standalone configs
;Source: "..\release\DaxStudio.exe.2016.config"; DestDir: "{app}"; DestName: "DaxStudio.exe.config"; Flags: ignoreversion; Components: Core; Check: Not IsComponentSelected('ASAzureSupport')
;Source: "..\release\DaxStudio.exe.2017.config"; DestDir: "{app}"; DestName: "DaxStudio.exe.config"; Flags: ignoreversion; Components: Core; Check: IsComponentSelected('ASAzureSupport')

;Excel Addin configs
Source: "..\release\bin\DaxStudio.dll.config"; DestDir: "{app}"; DestName: "DaxStudio.dll.config"; Flags: ignoreversion; Components: Excel; Check: Not IsComponentSelected('ASAzureSupport') And IsExcel2010Installed
;Source: "..\release\bin\DaxStudio.dll.2016.config"; DestDir: "{app}"; DestName: "DaxStudio.dll.config"; Flags: ignoreversion; Components: Excel; Check: Not IsComponentSelected('ASAzureSupport') And Not IsExcel2010Installed
;Source: "..\release\bin\DaxStudio.dll.2017.config"; DestDir: "{app}"; DestName: "DaxStudio.dll.config"; Flags: ignoreversion; Components: Excel; Check: IsComponentSelected('ASAzureSupport') 
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon


; TODO - ngen DaxStudio
;Filename: {win}\Microsoft.NET\Framework64\v4.0.30319\ngen.exe Parameters: "install ""{app}\{#MyAppExeName}"""; StatusMsg: Optimizing performance for your system ...; Flags: runhidden; Check: CheckFramework;

;[UninstallRun]

;Filename: {win}\Microsoft.NET\Framework64\v4.0.30319\ngen.exe Parameters: "install ""{app}\{#MyAppExeName}"""; StatusMsg: Removing native images and dependencies ...; Flags: runhidden; Check: CheckFramework; 

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Filename: "eventcreate"; Parameters: "/ID 1 /L APPLICATION /T INFORMATION  /SO DaxStudio /D ""DaxStudio Installed"""; WorkingDir: "{sys}"; Flags: runascurrentuser runhidden; StatusMsg: "Registering DaxStudio Eventlog Source"; Components: Core
;Filename: {code:GetV4NetDir}ngen.exe; Parameters: "install ""{app}\{#MyAppExeName}"""; StatusMsg: Optimizing performance for your system ...; Flags: runhidden; 
;Check: CheckFramework;

#include "scripts\products.iss"
#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"
#include "scripts\products\dotnetfxversion.iss"
#include "scripts\products\excelversion.iss"
#include "scripts\products\dotnetfx45.iss"
#include "scripts\products\dotnetassembly.iss"
;#include "scripts\products\sql2016adomdclient.iss"
;#include "scripts\products\sql2016amo.iss"
;#include "scripts\products\sql2017adomdclient.iss"
;#include "scripts\products\sql2017amo.iss"

[UninstallRun]
;Filename: {code:GetV4NetDir}ngen.exe; Parameters: "uninstall ""{app}\{#MyAppExeName}""";  StatusMsg: Removing native images and dependencies ...; Flags: runhidden; 
;Check: CheckFramework; 

[Types]
Name: "full"; Description: "Full Install"
Name: "standalone"; Description: "DaxStudio Core"
Name: "custom"; Description: "Custom"; Flags: iscustom

[Registry]
Root: "HKCU"; Subkey: "Software\DaxStudio"; Flags: uninsdeletekey; Components: Core
;Excel x86 Addin Keys
Root: "HKCU32"; Subkey: "Software\DaxStudio"; ValueType: string; ValueName: "Path"; ValueData: """{app}\{#MyAppExeName}"""; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKCU32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Description"; ValueData: "Dax Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKCU32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "FriendlyName"; ValueData: "Dax Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKCU32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Manifest"; ValueData: "{code:SwapSlashes|file:///{app}\DaxStudio.vsto|vstolocal}"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
Root: "HKCU32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: dword; ValueName: "LoadBehavior"; ValueData: "3"; Flags: uninsdeletekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
;Excel x64 Addin keys
Root: "HKCU64"; Subkey: "Software\DaxStudio"; ValueType: string; ValueName: "Path"; ValueData: """{app}\{#MyAppExeName}"""; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKCU64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Description"; ValueData: "Dax Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKCU64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "FriendlyName"; ValueData: "Dax Studio Excel Add-In"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKCU64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: string; ValueName: "Manifest"; ValueData: "{code:SwapSlashes|file:///{app}\DaxStudio.vsto|vstolocal}"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
Root: "HKCU64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio.ExcelAddIn"; ValueType: dword; ValueName: "LoadBehavior"; ValueData: "3"; Flags: uninsdeletekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
;Clean up beta Excel x86 Addin Keys
Root: "HKCU32"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio"; ValueType: none; Flags: deletekey dontcreatekey; Components: Excel; Check: Is32BitExcelFromRegisteredExe
;Clean up beta Excel x64 Addin keys
Root: "HKCU64"; Subkey: "Software\Microsoft\Office\Excel\Addins\DaxStudio"; ValueType: none; Flags: deletekey dontcreatekey; Components: Excel; Check: Is64BitExcelFromRegisteredExe
;add file association for .dax files
;Root: "HKCR"; Subkey: ".dax"; ValueType: string; ValueData: "DAX file"; Flags: uninsdeletekey
;Root: "HKCR"; Subkey: "DAX file"; ValueType: string; ValueData: "DAX Query File"; Flags: uninsdeletekey
;Root: "HKCR"; Subkey: "DAX file\Shell\Open\Command"; ValueType: string; ValueData: """{app}\DaxStudio.exe"" -file ""%1"""; Flags: uninsdeletekey
;Root: "HKCR"; Subkey: "DAX file\DefaultIcon"; ValueType: string; ValueData: "{app}\DaxStudio.exe,0"; Flags: uninsdeletevalue

[CustomMessages]
win_sp_title=Windows %1 Service Pack %2

[Components]
Name: "Excel"; Description: "Excel Addin"; Types: full
Name: "Core"; Description: "DaxStudio Core (includes connectivity to SSAS Tabular)"; Types: full standalone custom; Flags: fixed
Name: "ASAzureSupport"; Description: "Ensures that the pre-requisites for Analysis Services Azure are installed"

; Make sure that local copies of the Excel files do not exist
[InstallDelete]
Type: files; Name: "{app}\Microsoft.Excel.Amo.dll"
Type: files; Name: "{app}\Microsoft.Excel.AdomdClient.dll"

[Code]
// If there is a command-line parameter "skipdependencies=true", don't check for them }
function ShouldInstallDependencies(): Boolean;
begin
  Result := True
  if ExpandConstant('{param:skipdependencies|false}') <> 'false' then begin
    Result := False;
  end;
end;

var maxCommonSsasAssemblyVersion: string;

function GetV4NetDir(version: string) : string;
var 
  regkey, regval  : string;
begin

    // in case the target is 3.5, replace 'v4' with 'v3.5'
    // for other info, check out this link 
    // http://stackoverflow.com/questions/199080/how-to-detect-what-net-framework-versions-and-service-packs-are-installed
    regkey := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'

    RegQueryStringValue(HKLM, regkey, 'InstallPath', regval);

    Result := regval;
end; 

function SwapSlashes(const path:String):String;
var
   tmp:String;
begin
   tmp := path;
   StringChange(tmp, '\','/');
   Result:=tmp;
end;

//convert String from REG_BINARY to Pascal String
function ConvertToString(AString:AnsiString):String;
var
 i : Integer;
 iChar : Integer;
 outString : String;
begin
 outString :='';
 for i := 6 to (Length(AString)/2-1) do
 begin
  iChar := Ord(AString[i*2+1]); //get int value
  outString := outString + Chr(iChar);
 end;

 Result := outString;
end;

// check that DaxStudio is not in the "hard" disabled addins list and remove it if it is
procedure CleanDisabledItems;
var
  I: Integer;
  J: Integer;
  RegKeys: array[1..3] of string;
  RegKeyCnt: Integer;
  Names: TArrayOfString;
  ResultStr: AnsiString;
  keyName: String;
begin
  RegKeys[1] := 'Software\Microsoft\Office\14.0\Excel\Resiliency\DisabledItems';    // Excel 2010
  RegKeys[2] := 'Software\Microsoft\Office\15.0\Excel\Resiliency\DisabledItems';    // Excel 2013
  RegKeys[3] := 'Software\Microsoft\Office\16.0\Excel\Resiliency\DisabledItems';    // Excel 2016
  RegKeyCnt := 3; //GetArrayLength(RegKeys);

  // for each version of Excel
  //for I := 1 to RegKeyCnt do
  for I := 1 to GetArrayLength(RegKeys) do
  begin
    If  RegKeyExists(HKEY_CURRENT_USER, RegKeys[I]) then
    begin  
      if RegGetValueNames(HKEY_CURRENT_USER, RegKeys[I], Names) then
      begin
        keyName := '';
        // loop through any disabled add-ins and delete
        // any keys that reference Dax Studio
        for J := 0 to GetArrayLength(Names)-1 do
        begin
          RegQueryBinaryValue(HKEY_CURRENT_USER, RegKeys[I], Names[J], ResultStr)
          keyName := Lowercase(ConvertToString(ResultStr));
          //MsgBox('List of values:'#13#10#13#10 + S, mbInformation, MB_OK);
          if Pos( 'daxstudio.vsto', keyName) > 0 then
              RegDeleteValue(HKEY_CURRENT_USER, RegKeys[i], Names[J])
        end;
      end else
      begin
        // add any code to handle failure here
      end;
    end;

  end;
  
end;


          
function GetMaxCommonSsasAssemblyVersion(): String;
begin
    Result := maxCommonSsasAssemblyVersion;
end;


function InitializeSetup(): boolean;
begin
                     
  // clear DaxStudio from Excel Add-ins hard disabled items
  try 
    Log('Clearing Disabled items from Excel Add-in registry location');
    CleanDisabledItems();
  except
    // Catch the exception, show it, and continue
    ShowExceptionMessage;
  end;

	//init windows version
	try 
    Log('Checking Windows Version');
    initwinversion();
  except
    // Catch the exception, show it, and continue
    ShowExceptionMessage;
  end;

  Log('Checking the maximum SSAS assembly versions');
  maxCommonSsasAssemblyVersion := GetMaxCommonSsasAssemblyVersionInternal();
  Log('Max SSAS assembly versions ' + maxCommonSsasAssemblyVersion);
//  msgbox(GetMaxCommonSsasAssemblyVersion(), mbInformation,MB_OK);

//  if IsExcel2010Installed() then begin
//      msgbox('hello', mbInformation,MB_OK);
//  end;

//  if IsAssemblyInstalled('Microsoft.AnalysisServices', '11.0.0.0' ) then begin
//      msgbox('amo ok',mbInformation, MB_OK);
//  end  else begin
//      msgbox('amo NOT ok',mbInformation, MB_OK);
//  end;

//  if IsAssemblyInstalled('Microsoft.AnalysisServices.AdomdClient', '11.0.0.0' ) then begin
//      msgbox('adomd ok',mbInformation, MB_OK);
//  end  else begin
//      msgbox('adomd NOT ok',mbInformation, MB_OK);
//  end;
  
#ifdef use_msi20
	msi20('2.0');
#endif
#ifdef use_msi31
	msi31('3.1');
#endif
#ifdef use_msi45
	msi45('4.5');
#endif

 

if ShouldInstallDependencies() then
  Log('Checking for Dependencies')
else
  Log('WARNING: Skipping Dependency checks due to /skipdependencies=true');

// if no .netfx 4.0 is found, install the client (smallest)
#ifdef use_dotnetfx40
  Log('Checking if .Net 4.0 is installed');
	if (not netfxinstalled(NetFx40Client, '') and not netfxinstalled(NetFx40Full, '')) and ShouldInstallDependencies() then
		dotnetfx40client();
#endif

#ifdef use_dotnetfx45
    
    //dotnetfx45(2); // min allowed version is .netfx 4.5.2
    if ShouldInstallDependencies() then begin
      Log('Checking if .Net 4.5 is installed');
      dotnetfx45(0); // min allowed version is .netfx 4.5.0
    end;
#endif

#ifdef use_vc2010
	vcredist2010();
#endif

#ifdef use_sql2012sp1adomdclient
  if ShouldInstallDependencies() then begin
    Log('Checking for AdomdClient 2012 SP1');
	  sql2012sp1adomdclient();
  end;
#endif

#ifdef use_sql2012sp1amo
  if ShouldInstallDependencies() then begin
    Log('Checking for AMO 2012 SP1');
	  sql2012sp1amo();
   end;
#endif



	Result := true;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
Log('Processing custom page actions for ' + IntToStr(CurPageID));
  if CurPageID = wpReady then begin
    Log('Processing custom Ready page actions');
    if IsComponentSelected('ASAzureSupport') then begin
      Log('Installing Azure Support');

        if ShouldInstallDependencies() then begin
       //#ifdef use_sql2017adomdclient
          Log('Checking for AdomdClient 2017');
          sql2017adomdclient();
      //#endif

      //#ifdef use_sql2017amo
          Log('Checking for AMO 2017');
          sql2017amo();
       //#endif
         end;

    end;

    if IsComponentSelected('AS Azure Support') = False then begin
      Log('Checking SQL 2016 dependencies');
      #ifdef use_sql2016adomdclient
        if ShouldInstallDependencies() then begin
          Log('Checking for AdomdClient 2016');
          sql2016adomdclient();
        end;
      #endif

      #ifdef use_sql2016amo
        if ShouldInstallDependencies() then begin
          Log('Checking for AMO 2016');
          sql2016amo();
         end;
      #endif
    end;

  end;
end;


// Check if Excel is x86 or x64
const
  // Constants for GetBinaryType return values.
  SCS_32BIT_BINARY = 0;
  SCS_64BIT_BINARY = 6;
  // There are other values that GetBinaryType can return, but we're
  // not interested in them.

// Declare Win32 function  
function GetBinaryType(lpApplicationName: AnsiString; var lpBinaryType: Integer): Boolean;
external 'GetBinaryTypeA@kernel32.dll stdcall';

function Is64BitExcelFromRegisteredExe(): Boolean;
var
  excelPath: String;
  binaryType: Integer;
begin
  Result := False; // Default value - assume 32-bit unless proven otherwise.
  // RegQueryStringValue second param is '' to get the (default) value for the key
  // with no sub-key name, as described at
  // http://stackoverflow.com/questions/913938/
  if IsWin64() and RegQueryStringValue(HKEY_LOCAL_MACHINE,
      'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\excel.exe',
      '', excelPath) then begin
    // We've got the path to Excel.
    try
      if GetBinaryType(excelPath, binaryType) then begin
        Result := (binaryType = SCS_64BIT_BINARY);
      end;
    except
      // Ignore - better just to assume it's 32-bit than to let the installation
      // fail.  This could fail because the GetBinaryType function is not
      // available.  I understand it's only available in Windows 2000
      // Professional onwards.
    end;
  end;
end;

function Is32BitExcelFromRegisteredExe(): boolean;
begin
  Result := NOT Is64BitExcelFromRegisteredExe();
end;

/////////////////////////////////////////////////////////////////////

function IsSQL2012DllsFound(): boolean;
begin
	Result := ((GetMaxCommonSsasAssemblyVersion() = '') Or  (CompareAssemblyVersion(GetMaxCommonSsasAssemblyVersion() ,'11.0.0.0000') = 0 ));
end;

function IsSQL2014DllsFound(): boolean;
begin
	Result := (CompareAssemblyVersion(GetMaxCommonSsasAssemblyVersion() ,'12.0.0.0000') = 0 ) ;
end;

function IsSQL2016DllsFound(): boolean;
begin
  Log('>>> IsSQL2016DllsFound() ');
  Log(GetMaxCommonSsasAssemblyVersion());
  Log(IntToStr(Integer(IsComponentSelected('AsAzureSupport')=False)));

	if (CompareAssemblyVersion(GetMaxCommonSsasAssemblyVersion() ,'13.0.0.0000') = 0 ) and not IsComponentSelected('ASAzureSupport') then begin //Or  IsComponentSelected('ASAzureSupport') = False) then begin
    Log('IsSQL2016DllsFound() = True');
    Result := True;
  end else begin
    Log('IsSQL2016DllsFound() = False');
    Result := False
  End;
  
 end;

function IsSQL2017DllsFound(): boolean;
begin
  Log('>>> IsSQL2017DllsFound() ');
  Log(IntToStr(Integer(CompareAssemblyVersion(GetMaxCommonSsasAssemblyVersion() ,'14.0.0.0000') = 0)));
  Log(IntToStr(Integer(IsComponentSelected('AsAzureSupport'))));
	Result := ((CompareAssemblyVersion(GetMaxCommonSsasAssemblyVersion() ,'14.0.0.0000') = 0 )  Or  IsComponentSelected('AsAzureSupport')) ;
end;         

/////////////////////////////////////////////////////////////////////
function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  //sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}');
  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);

  //Msgbox('The following uninstall strig was found' + #13#10 + 
  //    sUnInstallString, mbInformation, MB_OK);
  
  Result := sUnInstallString;
end;


/////////////////////////////////////////////////////////////////////
function IsUpgrade(): Boolean;
begin
  Result := (GetUninstallString() <> '');
end;


/////////////////////////////////////////////////////////////////////
function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
// Return Values:
// 1 - uninstall string is empty
// 2 - error executing the UnInstallString
// 3 - successfully executed the UnInstallString

  // default return value
  Result := 0;

  // get the uninstall string of the old app
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    StringChange(sUninstallString, ' /I', ' /x');
    sUnInstallString := sUninstallString + ' /quiet /norestart'
    //MsgBox('About to run: ' + sUninstallString, mbInformation, MB_OK);
    if Exec('>', sUnInstallString,'', SW_SHOW, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;


/////////////////////////////////////////////////////////////////////
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if (IsUpgrade()) then
    begin
      UnInstallOldVersion();
    end;
  end;
end;

const 
   ComponentList = 'CORE - core components| EXCEL - Excel Addin'; 
   TaskList = 'DESKTOPICON - adds a desktop icon'; 
   ParameterList = '/SKIPDEPENDENCIES=True/False - Skips the standard dependency checks'; 
#include "scripts/clihelp.iss"
