
########## Tcl recorder starts at 02/25/14 11:25:51 ##########

set version "7.0c"
set proj_dir "H:/ese382/lab03s14/lab03s14/ispLEVER"
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../synplify/rev_2/proj_1.edf\" -jhd \"proj_1.jhd\" -err automake.err -log \"proj_1.log\" -prj selector -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@proj_1.esp\" -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/25/14 11:25:51 ###########


########## Tcl recorder starts at 02/25/14 11:26:13 ##########

# Commands to make the Process: 
# Chip Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../synplify/rev_2/proj_1.edf\" -out \"selected.bl0\" -err automake.err -log \"proj_1.log\" -prj selector -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@proj_1.esp\" -nbx -cvt YES"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"selected.bl0\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"selected.bl1\" -o \"selector.bl2\" -omod selected -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" selector.bl2 -red bypin choose -sweep -collapse all -pterms 8 -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" selector.bl3 -pla -o selector.tt2 -dev p22v10gc -define N -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fit\" selector.tt2 -dev p22v10gc -str -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fuseasm\" selector.tt3 -dev p22v10gc -o selector.jed -ivec NoInput.tmv -rep selector.rpt -doc brief -con ptblown -for brief -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/25/14 11:26:13 ###########


########## Tcl recorder starts at 02/25/14 11:28:04 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" selector.tt2 -o selector.eq3 -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/25/14 11:28:04 ###########


########## Tcl recorder starts at 02/25/14 11:28:16 ##########

# Commands to make the Process: 
# Post-Fit Equations
if [runCmd "\"$cpld_bin/blif2eqn\" selector.tt3 -o selector.eq4 -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/25/14 11:28:16 ###########


########## Tcl recorder starts at 02/25/14 11:32:52 ##########

# Commands to make the Process: 
# VHDL Post-Route Simulation Model
if [runCmd "\"$cpld_bin/blif2eqn\" selected.bl0 -o selected.btp -template \"$install_dir/ispcpld/pld/j2mod.tft\" -testfix -bus rebuild -prj selector -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open selector.psl w} rspFile] {
	puts stderr "Cannot create response file selector.psl: $rspFile"
} else {
	puts $rspFile "-dev p22v10gc -part LAT ispGAL22V10C-10LJ GAL -o selector.tim
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/timsel\" @selector.psl"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete selector.psl
if [catch {open selector._sp w} rspFile] {
	puts stderr "Cannot create response file selector._sp: $rspFile"
} else {
	puts $rspFile "#insert -- NOTE: Do not edit this file.
#insert -- Auto generated by Post-Route VHDL Simulation Models
#insert --
#unixpath $proj_dir
#vcom selector.vhq
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" \"selector._sp\" \"selector.vtd\" none"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete selector._sp
if [runCmd "\"$cpld_bin/j2svhdl\" selector.jed -dly custom selector.tim max -pldbus default selected.btp -o selector.vhq -module selected -suppress -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/25/14 11:32:52 ###########


########## Tcl recorder starts at 02/25/14 11:32:59 ##########

# Commands to make the Process: 
# Verilog Post-Route Simulation Model
if [runCmd "\"$cpld_bin/blif2eqn\" \"selected.bl0\" -o \"selected.tfi\" -template \"$install_dir/ispcpld/generic/verilog/tfi.tft\" -testfix -bus rebuild -prj selector -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open selector._sp w} rspFile] {
	puts stderr "Cannot create response file selector._sp: $rspFile"
} else {
	puts $rspFile "#insert -- NOTE: Do not edit this file.
#insert -- Auto generated by Post-Route Verilog Simulation Models
#insert --
#unixpath
#unixpath $install_dir/ispcpld/pld/verilog
#libfile pldlib.v
#unixpath
#vlog \"$proj_dir/selector.vt\"
#insert -- End
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" \"selector._sp\" \"selector.vtl\" none"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete selector._sp
if [runCmd "\"$cpld_bin/j2vlog\" selector.jed -dly custom selector.tim -pldbus default selected.btp -o selector.vt -module selected -suppress -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 02/25/14 11:32:59 ###########

