
########## Tcl recorder starts at 04/08/14 14:10:54 ##########

set version "7.0c"
set proj_dir "H:/ese382/lab08s14/sequential_system/ispLEVER"
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_1/seq.edf -jhd seq.jhd -err automake.err -log seq.log -prj seq -lib \"$install_dir/ispcpld/dat/mach.edn\" @seq.esp -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/08/14 14:10:54 ###########


########## Tcl recorder starts at 04/08/14 14:10:59 ##########

# Commands to make the Process: 
# Fitter Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_1/seq.edf -out seq_sys.bl0 -err automake.err -log seq.log -prj seq -lib \"$install_dir/ispcpld/dat/mach.edn\" @seq.esp -nbx -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" seq_sys.bl0 -collapse none -reduce none -keepwires  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"seq_sys.bl1\" -o \"seq.bl2\" -omod \"seq\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj seq -lci seq.lct -log seq.imp -err automake.err -tti seq.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci seq.lct -blifopt  seq.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" seq.bl2 -sweep -mergefb -err automake.err -o seq.bl3  @seq.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci seq.lct -dev mach4a -diofft  seq.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" seq.bl3 -pla -family AMDMACH -idev van -o seq.tt2 -oxrf seq.xrf -err automake.err  @seq.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj seq -dir $proj_dir -log seq.log -tti seq.tt2 -tto seq.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci seq.lct -dev mach4a -prefit  seq.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp seq.tt3 -out seq.tt4 -err automake.err -log seq.log -percent seq.tte -mod seq_sys  @seq.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" seq.tte -o seq.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci seq.lct -out seq.vct -log seq.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open seq.rsp w} rspFile] {
	puts stderr "Cannot create response file seq.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"seq.tt4\" -vci \"seq.vct\" -log \"seq.log\" -eqn \"seq.eq3\" -dev mach463a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"NoInput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@seq.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete seq.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci seq.vco -out seq.lco -log seq.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj seq -if seq.jed -j2s -log seq.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/08/14 14:10:59 ###########


########## Tcl recorder starts at 04/08/14 14:16:20 ##########

# Commands to make the Process: 
# Stamp Model Data File
if [runCmd "\"$cpld_bin/timer\" -inp \"seq.tte\" -lci \"seq.lct\" -stamp \"seq.trp\" -exf \"seq_sys.exf\" -lco \"seq.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i seq.trp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/08/14 14:16:20 ###########

