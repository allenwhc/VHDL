
########## Tcl recorder starts at 03/25/14 09:41:50 ##########

set version "7.0c"
set proj_dir "H:/ese382/lab06s14/ha_mixed_simnet/ispLEVER"
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../synplify/rev_1/ha_mixed.edf\" -jhd \"ha_mixed.jhd\" -err automake.err -log \"ha_mixed.log\" -prj ha_mixed -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@ha_mixed.esp\" -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/25/14 09:41:50 ###########


########## Tcl recorder starts at 03/25/14 09:42:00 ##########

# Commands to make the Process: 
# VHDL Post-Route Simulation Model
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../synplify/rev_1/ha_mixed.edf\" -out \"ha_mixed.bl0\" -err automake.err -log \"ha_mixed.log\" -prj ha_mixed -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@ha_mixed.esp\" -nbx -cvt YES"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" ha_mixed.bl0 -o ha_mixed.btp -template \"$install_dir/ispcpld/pld/j2mod.tft\" -testfix -bus rebuild -prj ha_mixed -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"ha_mixed.bl0\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"ha_mixed.bl1\" -o \"ha_mixed.bl2\" -omod ha_mixed -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" ha_mixed.bl2 -red bypin choose -sweep -collapse all -pterms 8 -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" ha_mixed.bl3 -pla -o ha_mixed.tt2 -dev p22v10gc -define N -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fit\" ha_mixed.tt2 -dev p22v10gc -str -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fuseasm\" ha_mixed.tt3 -dev p22v10gc -o ha_mixed.jed -ivec NoInput.tmv -rep ha_mixed.rpt -doc brief -con ptblown -for brief -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open ha_mixed.psl w} rspFile] {
	puts stderr "Cannot create response file ha_mixed.psl: $rspFile"
} else {
	puts $rspFile "-dev p22v10gc -part LAT ispGAL22V10C-10LJ GAL -o ha_mixed.tim
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/timsel\" @ha_mixed.psl"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ha_mixed.psl
if [catch {open ha_mixed._sp w} rspFile] {
	puts stderr "Cannot create response file ha_mixed._sp: $rspFile"
} else {
	puts $rspFile "#insert -- NOTE: Do not edit this file.
#insert -- Auto generated by Post-Route VHDL Simulation Models
#insert --
#unixpath $proj_dir
#vcom ha_mixed.vhq
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/chipsim\" \"ha_mixed._sp\" \"ha_mixed.vtd\" none"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete ha_mixed._sp
if [runCmd "\"$cpld_bin/j2svhdl\" ha_mixed.jed -dly custom ha_mixed.tim max -pldbus default ha_mixed.btp -o ha_mixed.vhq -module ha_mixed -suppress -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/25/14 09:42:00 ###########

