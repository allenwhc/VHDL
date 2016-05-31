
########## Tcl recorder starts at 03/11/14 13:02:47 ##########

set version "7.0c"
set proj_dir "H:/ese382/lab05s14/BinaryToSeg/ispLEVER"
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
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../synplify/rev_2/binary2seg.edf\" -jhd \"binary2seg.jhd\" -err automake.err -log \"binary2seg.log\" -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@binary2seg.esp\" -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:02:48 ###########


########## Tcl recorder starts at 03/11/14 13:02:52 ##########

# Commands to make the Process: 
# Chip Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf \"../synplify/rev_2/binary2seg.edf\" -out \"BinaryToSeg.bl0\" -err automake.err -log \"binary2seg.log\" -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" \"@binary2seg.esp\" -nbx -cvt YES"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"BinaryToSeg.bl0\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"BinaryToSeg.bl1\" -o \"task3.bl2\" -omod BinaryToSeg -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" task3.bl2 -red bypin choose -sweep -collapse all -pterms 8 -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" task3.bl3 -pla -o task3.tt2 -dev p22v10gc -define N -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fit\" task3.tt2 -dev p22v10gc -str -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/fuseasm\" task3.tt3 -dev p22v10gc -o task3.jed -ivec NoInput.tmv -rep task3.rpt -doc brief -con ptblown -for brief -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:02:52 ###########


########## Tcl recorder starts at 03/11/14 13:05:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_2/binary2seg.edf -jhd binary2seg.jhd -err automake.err -log binary2seg.log -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" @binary2seg.esp -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:05:49 ###########


########## Tcl recorder starts at 03/11/14 13:06:00 ##########

# Commands to make the Process: 
# Fitter Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_2/binary2seg.edf -out BinaryToSeg.bl0 -err automake.err -log binary2seg.log -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" @binary2seg.esp -nbx -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" BinaryToSeg.bl0 -collapse none -reduce none -keepwires  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"BinaryToSeg.bl1\" -o \"task3.bl2\" -omod \"task3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj task3 -lci task3.lct -log task3.imp -err automake.err -tti task3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -blifopt  task3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" task3.bl2 -sweep -mergefb -err automake.err -o task3.bl3  @task3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -dev mach4a -diofft  task3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" task3.bl3 -pla -family AMDMACH -idev van -o task3.tt2 -oxrf task3.xrf -err automake.err  @task3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj task3 -dir $proj_dir -log task3.log -tti task3.tt2 -tto task3.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -dev mach4a -prefit  task3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp task3.tt3 -out task3.tt4 -err automake.err -log task3.log -percent task3.tte -mod BinaryToSeg  @task3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" task3.tte -o task3.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci task3.lct -out task3.vct -log task3.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open task3.rsp w} rspFile] {
	puts stderr "Cannot create response file task3.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"task3.tt4\" -vci \"task3.vct\" -log \"task3.log\" -eqn \"task3.eq3\" -dev mach463a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"NoInput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@task3.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete task3.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci task3.vco -out task3.lco -log task3.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj task3 -if task3.jed -j2s -log task3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:06:01 ###########


########## Tcl recorder starts at 03/11/14 13:12:03 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
# - none -
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src task3.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach463ace.dev\" -postfit -lci task3.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:12:03 ###########


########## Tcl recorder starts at 03/11/14 13:14:04 ##########

# Commands to make the Process: 
# Generate Board-level Stamp Model
if [runCmd "\"$cpld_bin/timer\" -inp \"task3.tte\" -lci \"task3.lct\" -stamp \"task3.trp\" -exf \"BinaryToSeg.exf\" -lco \"task3.lco\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/stamppar\" -i task3.trp "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:14:05 ###########


########## Tcl recorder starts at 03/11/14 13:14:08 ##########

# Commands to make the Process: 
# Generate Timing Simulation Files
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj task3 -if task3.jed -j2s -log task3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open task3.rss w} rspFile] {
	puts stderr "Cannot create response file task3.rss: $rspFile"
} else {
	puts $rspFile "-i \"task3.tte\" -lib \"$install_dir/ispcpld/dat/mach4a\" -strategy top -sdfmdl \"$install_dir/ispcpld/dat/sdf.mdl\" -simmdl \"$install_dir/ispcpld/dat/sim.mdl\" -pla \"task3.tte\" -lci \"task3.lct\" -prj \"task3\" -dir \"$proj_dir\" -err automake.err -log \"task3.nrp\" -exf \"BinaryToSeg.exf\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/sdf\" \"@task3.rss\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete task3.rss

########## Tcl recorder end at 03/11/14 13:14:08 ###########


########## Tcl recorder starts at 03/11/14 13:14:11 ##########

# Commands to make the Process: 
# Timing Analysis
# - none -
# Application to view the Process: 
# Timing Analysis
if [runCmd "\"$cpld_bin/timing\" -prj \"task3\" -tti \"task3.tt4\" -gui -dir \"$proj_dir\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:14:11 ###########


########## Tcl recorder starts at 03/11/14 13:15:10 ##########

# Commands to make the Process: 
# Fitter Report
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj task3 -if task3.jed -j2s -log task3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:15:10 ###########


########## Tcl recorder starts at 03/11/14 13:26:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_2/binary2seg.edf -jhd binary2seg.jhd -err automake.err -log binary2seg.log -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" @binary2seg.esp -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:26:39 ###########


########## Tcl recorder starts at 03/11/14 13:26:45 ##########

# Commands to make the Process: 
# Fitter Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_2/binary2seg.edf -out BinaryToSeg.bl0 -err automake.err -log binary2seg.log -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" @binary2seg.esp -nbx -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" BinaryToSeg.bl0 -collapse none -reduce none -keepwires  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"BinaryToSeg.bl1\" -o \"task3.bl2\" -omod \"task3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj task3 -lci task3.lct -log task3.imp -err automake.err -tti task3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -blifopt  task3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" task3.bl2 -sweep -mergefb -err automake.err -o task3.bl3  @task3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -dev mach4a -diofft  task3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" task3.bl3 -pla -family AMDMACH -idev van -o task3.tt2 -oxrf task3.xrf -err automake.err  @task3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj task3 -dir $proj_dir -log task3.log -tti task3.tt2 -tto task3.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -dev mach4a -prefit  task3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp task3.tt3 -out task3.tt4 -err automake.err -log task3.log -percent task3.tte -mod BinaryToSeg  @task3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" task3.tte -o task3.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci task3.lct -out task3.vct -log task3.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open task3.rsp w} rspFile] {
	puts stderr "Cannot create response file task3.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"task3.tt4\" -vci \"task3.vct\" -log \"task3.log\" -eqn \"task3.eq3\" -dev mach463a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"NoInput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@task3.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete task3.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci task3.vco -out task3.lco -log task3.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj task3 -if task3.jed -j2s -log task3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:26:46 ###########


########## Tcl recorder starts at 03/11/14 13:41:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_2/binary2seg.edf -jhd binary2seg.jhd -err automake.err -log binary2seg.log -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" @binary2seg.esp -nbx"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:41:54 ###########


########## Tcl recorder starts at 03/11/14 13:41:55 ##########

# Commands to make the Process: 
# Fitter Report
if [runCmd "\"$cpld_bin/edif2blf\" -edf ../synplify/rev_2/binary2seg.edf -out BinaryToSeg.bl0 -err automake.err -log binary2seg.log -prj task3 -lib \"$install_dir/ispcpld/dat/mach.edn\" @binary2seg.esp -nbx -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" BinaryToSeg.bl0 -collapse none -reduce none -keepwires  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"BinaryToSeg.bl1\" -o \"task3.bl2\" -omod \"task3\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj task3 -lci task3.lct -log task3.imp -err automake.err -tti task3.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -blifopt  task3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" task3.bl2 -sweep -mergefb -err automake.err -o task3.bl3  @task3.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -dev mach4a -diofft  task3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" task3.bl3 -pla -family AMDMACH -idev van -o task3.tt2 -oxrf task3.xrf -err automake.err  @task3.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj task3 -dir $proj_dir -log task3.log -tti task3.tt2 -tto task3.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci task3.lct -dev mach4a -prefit  task3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp task3.tt3 -out task3.tt4 -err automake.err -log task3.log -percent task3.tte -mod BinaryToSeg  @task3.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" task3.tte -o task3.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci task3.lct -out task3.vct -log task3.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open task3.rsp w} rspFile] {
	puts stderr "Cannot create response file task3.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"task3.tt4\" -vci \"task3.vct\" -log \"task3.log\" -eqn \"task3.eq3\" -dev mach463a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"NoInput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@task3.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete task3.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci task3.vco -out task3.lco -log task3.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj task3 -if task3.jed -j2s -log task3.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/11/14 13:41:55 ###########

