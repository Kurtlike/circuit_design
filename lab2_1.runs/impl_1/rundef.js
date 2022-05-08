//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//

echo "This script was generated under a different operating system."
echo "Please update the PATH variable below, before executing this script"
exit

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/ids_lite/ISE/bin/lin64;/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/bin;";
} else {
  PathVal = "/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/ids_lite/ISE/bin/lin64;/media/kurtlike/0bc13ae9-569d-48dc-9158-75f16c6ace65/Vivaldo/Vivado/2021.2/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


// pre-commands:
ISETouchFile( "init_design", "begin" );
ISEStep( "vivado",
         "-log main_funk.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source main_funk.tcl -notrace" );





function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
