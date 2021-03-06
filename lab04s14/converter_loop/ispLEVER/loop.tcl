
########## Tcl recorder starts at 03/05/14 15:06:45 ##########

set version "7.0c"
set proj_dir "//esdl-2k3/Users/usr53/ese382/lab04s14/converter_loop/ispLEVER"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../rev_1/loop.edf\" -jhd \"loop.jhd\" -err automake.err -log \"loop.log\" -prj loop -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@loop.esp\" -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/14 15:06:45 ###########


########## Tcl recorder starts at 03/05/14 15:06:50 ##########

# Commands to make the Process: 
# Chip Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../rev_1/loop.edf\" -out \"converter_loop.bl0\" -err automake.err -log \"loop.log\" -prj loop -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@loop.esp\" -nbx -cvt YES"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"converter_loop.bl0\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"converter_loop.bl1\" -o \"loop.bl2\" -omod converter_loop -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" loop.bl2 -red bypin choose -sweep -collapse all -pterms 8 -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" loop.bl3 -pla -o loop.tt2 -dev p22v10gc -define N -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fit\" loop.tt2 -dev p22v10gc -str -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fuseasm\" loop.tt3 -dev p22v10gc -o loop.jed -ivec NoInput.tmv -rep loop.rpt -doc brief -con ptblown -for brief -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/14 15:06:50 ###########


########## Tcl recorder starts at 03/05/14 15:06:59 ##########

# Commands to make the Process: 
# VHDL Post-Route Simulation Model
if [runCmd "\"$cpld_bin/blif2eqn\" converter_loop.bl0 -o converter_loop.btp -template \"$install_dir/ispcpld/pld/j2mod.tft\" -testfix -bus rebuild -prj loop -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open loop.psl w} rspFile] {
	puts stderr "Cannot create response file loop.psl: $rspFile"
} else {
	puts $rspFile "-dev p22v10gc -part LAT ispGAL22V10C-10LJ GAL -o loop.tim
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/timsel\" @loop.psl"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete loop.psl
if [catch {open loop._sp w} rspFile] {
	puts stderr "Cannot create response file loop._sp: $rspFile"
} else {
	puts $rspFile "#insert -- NOTE: Do not edit this file.
#insert -- Auto generated by Post-Route VHDL Simulation Models
#insert --
#unixpath $proj_dir
#vcom loop.vhq
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" \"loop._sp\" \"loop.vtd\" none"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete loop._sp
if [runCmd "\"$cpld_bin/j2svhdl\" loop.jed -dly custom loop.tim max -pldbus default converter_loop.btp -o loop.vhq -module converter_loop -suppress -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/05/14 15:06:59 ###########


########## Tcl recorder starts at 03/06/14 12:21:21 ##########

set version "7.0c"
set proj_dir "H:/ese382/lab04s14/converter_loop/ispLEVER"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../rev_1/loop.edf\" -jhd \"loop.jhd\" -err automake.err -log \"loop.log\" -prj loop -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@loop.esp\" -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/06/14 12:21:21 ###########


########## Tcl recorder starts at 03/06/14 12:21:26 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../rev_1/loop.edf\" -out \"converter_loop.bl0\" -err automake.err -log \"loop.log\" -prj loop -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@loop.esp\" -nbx -cvt YES"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" \"converter_loop.bl0\" -o \"converter_loop.eq0\" -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/06/14 12:21:26 ###########


########## Tcl recorder starts at 03/06/14 12:21:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../rev_1/loop.edf\" -jhd \"loop.jhd\" -err automake.err -log \"loop.log\" -prj loop -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@loop.esp\" -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/06/14 12:21:55 ###########

