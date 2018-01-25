#include <idp.iss> 
#define MyAppName "FFRK Drop Tracker"
#define MyAppVersion "1.7.1"
#define MyAppPublisher "BaconCatBug"
#define MyAppURL "https://www.reddit.com/r/FFRecordKeeper/comments/6vhyod/ffrk_drop_tracker_export_your_entire_inventory/"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
AppId={{2E23B3AF-348F-4D9D-9DA2-C8E4F1D0F576}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={userdocs}\{#MyAppName}
DefaultGroupName={#MyAppName}
InfoBeforeFile=docs/prep.rtf
InfoAfterFile=docs/setup.rtf
OutputBaseFilename=setupffrkdroptracker_v{#MyAppVersion}
SetupIconFile=icon.ico
Compression=lzma
SolidCompression=yes
AppCopyright=u/baconcatbug 2018
VersionInfoVersion=1.7.1
UninstallDisplayIcon={app}\icon.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "files\ffrk_drop_tracker.bat"; DestDir: "{app}"; Flags: ignoreversion; Components: required
Source: "files\ffrk_copyproxybypasstoclipboard.bat"; DestDir: "{app}"; Flags: ignoreversion; Components: required
Source: "files\ffrk_drop_tracker.py"; DestDir: "{app}"; Flags: ignoreversion; Components: required
Source: "files\ffrk_drop_tracker_db.csv"; DestDir: "{app}"; Flags: ignoreversion; Components: required
Source: "files\config.ini"; DestDir: "{app}"; Flags: ignoreversion; Components: required
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion; Components: required
Source: "{tmp}\vc_redist.x86.exe"; DestDir: "{app}"; Flags: external deleteafterinstall; ExternalSize: 13767776; Components: prereq
Source: "{tmp}\mitmproxy-2.0.2-windows-installer.exe"; DestDir: "{app}"; Flags: external deleteafterinstall; ExternalSize: 34162113; Components: prereq

[Icons]
Name: "{group}\FFRK Drop Tracker"; Filename: "{app}\ffrk_drop_tracker.bat"; WorkingDir: "{app}"; IconFilename: "{app}\icon.ico"; IconIndex: 0; Components: required
Name: "{group}\Configuration"; Filename: "{app}\config.ini"; WorkingDir: "{app}"; Components: required 
Name: "{group}\View Reddit Post"; Filename: "{#MyAppURL}"; Components: required
Name: "{group}\Copy Proxy Bypass List to Clipboard"; Filename: "{app}\ffrk_copyproxybypasstoclipboard.bat"; WorkingDir: "{app}"; MinVersion: 0,5.01; Components: required
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; Components: required
Name: "{userdesktop}\FFRK Drop Tracker"; Filename: "{app}\ffrk_drop_tracker.bat"; WorkingDir: "{app}"; IconFilename: "{app}\icon.ico"; IconIndex: 0; Components: required; Tasks: desktopicon
Name: "{app}\FFRK Drop Tracker"; Filename: "{app}\ffrk_drop_tracker.bat"; WorkingDir: "{app}"; IconFilename: "{app}\icon.ico"; IconIndex: 0; Components: required

[Run]
Filename: "{app}\vc_redist.x86.exe"; Parameters: "/quiet"; WorkingDir: "{app}"; Flags: runhidden; StatusMsg: "Installing Visual C++ Redistributable for Visual Studio 2015"; Components: prereq
Filename: "{app}\mitmproxy-2.0.2-windows-installer.exe"; Parameters: "--mode unattended"; Flags: runhidden; StatusMsg: "Installing mitmproxy"; Components: prereq
Filename: "{app}\ffrk_copyproxybypasstoclipboard.bat"; WorkingDir: "{app}"; Flags: postinstall runhidden; Description: "Copy proxy bypass list to clipboard"; MinVersion: 0,5.01; Components: required

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Components]
Name: "required"; Description: "Required scripts and database"; Types: compact custom full; Flags: fixed
Name: "prereq"; Description: "Installs prerequisites such as Visual C++ Redistributable and mitmproxy"; Types: full custom

[Code]
procedure InitializeWizard();
begin
    idpAddFileComp('https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe', ExpandConstant('{tmp}\vc_redist.x86.exe'), 'prereq');
    idpAddFileComp('https://github.com/mitmproxy/mitmproxy/releases/download/v2.0.2/mitmproxy-2.0.2-windows-installer.exe', ExpandConstant('{tmp}\mitmproxy-2.0.2-windows-installer.exe'), 'prereq');
    idpDownloadAfter(wpReady);
end;
