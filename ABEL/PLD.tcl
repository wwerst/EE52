
########## Tcl recorder starts at 03/09/17 20:46:27 ##########

set version "2.0"
set proj_dir "C:/Users/will/Documents/GitHub/EE52/ABEL"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 20:46:27 ###########


########## Tcl recorder starts at 03/09/17 22:16:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 22:16:40 ###########


########## Tcl recorder starts at 03/09/17 22:23:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 22:23:06 ###########


########## Tcl recorder starts at 03/09/17 23:28:10 ##########

set version "2.0"
set proj_dir "C:/Users/will/GitReps/EE52/ABEL"
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
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 23:28:10 ###########


########## Tcl recorder starts at 03/09/17 23:30:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 23:30:47 ###########


########## Tcl recorder starts at 03/09/17 23:33:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 23:33:57 ###########


########## Tcl recorder starts at 03/09/17 23:41:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 23:41:49 ###########


########## Tcl recorder starts at 03/09/17 23:59:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/09/17 23:59:17 ###########


########## Tcl recorder starts at 03/10/17 00:01:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:01:17 ###########


########## Tcl recorder starts at 03/10/17 00:08:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:08:14 ###########


########## Tcl recorder starts at 03/10/17 00:09:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:09:23 ###########


########## Tcl recorder starts at 03/10/17 00:22:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:22:21 ###########


########## Tcl recorder starts at 03/10/17 00:22:45 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:22:45 ###########


########## Tcl recorder starts at 03/10/17 00:23:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:23:46 ###########


########## Tcl recorder starts at 03/10/17 00:23:50 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:23:50 ###########


########## Tcl recorder starts at 03/10/17 00:24:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:24:19 ###########


########## Tcl recorder starts at 03/10/17 00:24:22 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:24:22 ###########


########## Tcl recorder starts at 03/10/17 00:25:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:25:28 ###########


########## Tcl recorder starts at 03/10/17 00:25:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:25:37 ###########


########## Tcl recorder starts at 03/10/17 00:25:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:25:47 ###########


########## Tcl recorder starts at 03/10/17 00:25:55 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:25:55 ###########


########## Tcl recorder starts at 03/10/17 00:27:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:27:18 ###########


########## Tcl recorder starts at 03/10/17 00:27:23 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:27:23 ###########


########## Tcl recorder starts at 03/10/17 00:27:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:27:41 ###########


########## Tcl recorder starts at 03/10/17 00:27:45 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:27:45 ###########


########## Tcl recorder starts at 03/10/17 00:28:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:28:11 ###########


########## Tcl recorder starts at 03/10/17 00:28:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:28:40 ###########


########## Tcl recorder starts at 03/10/17 00:28:44 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:28:44 ###########


########## Tcl recorder starts at 03/10/17 00:28:50 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:28:50 ###########


########## Tcl recorder starts at 03/10/17 00:28:52 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/10/17 00:28:52 ###########


########## Tcl recorder starts at 03/12/17 15:32:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 15:32:48 ###########


########## Tcl recorder starts at 03/12/17 15:32:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 15:32:58 ###########


########## Tcl recorder starts at 03/12/17 15:33:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 15:33:31 ###########


########## Tcl recorder starts at 03/12/17 16:46:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 16:46:47 ###########


########## Tcl recorder starts at 03/12/17 17:01:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 17:01:24 ###########


########## Tcl recorder starts at 03/12/17 17:10:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 17:10:11 ###########


########## Tcl recorder starts at 03/12/17 19:32:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 19:32:49 ###########


########## Tcl recorder starts at 03/12/17 19:44:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 19:44:25 ###########


########## Tcl recorder starts at 03/12/17 20:18:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:18:49 ###########


########## Tcl recorder starts at 03/12/17 20:18:53 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:18:53 ###########


########## Tcl recorder starts at 03/12/17 20:40:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:40:37 ###########


########## Tcl recorder starts at 03/12/17 20:40:42 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:40:42 ###########


########## Tcl recorder starts at 03/12/17 20:40:53 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:40:53 ###########


########## Tcl recorder starts at 03/12/17 20:40:58 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:40:58 ###########


########## Tcl recorder starts at 03/12/17 20:41:17 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:41:17 ###########


########## Tcl recorder starts at 03/12/17 20:54:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:54:53 ###########


########## Tcl recorder starts at 03/12/17 20:55:13 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:55:13 ###########


########## Tcl recorder starts at 03/12/17 20:55:20 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:55:20 ###########


########## Tcl recorder starts at 03/12/17 20:55:25 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:55:25 ###########


########## Tcl recorder starts at 03/12/17 20:57:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:57:00 ###########


########## Tcl recorder starts at 03/12/17 20:57:17 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:57:17 ###########


########## Tcl recorder starts at 03/12/17 20:57:23 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:57:23 ###########


########## Tcl recorder starts at 03/12/17 20:57:30 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:57:30 ###########


########## Tcl recorder starts at 03/12/17 20:58:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:58:37 ###########


########## Tcl recorder starts at 03/12/17 20:58:42 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:58:42 ###########


########## Tcl recorder starts at 03/12/17 20:58:48 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:58:48 ###########


########## Tcl recorder starts at 03/12/17 20:58:50 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:58:50 ###########


########## Tcl recorder starts at 03/12/17 20:59:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 20:59:59 ###########


########## Tcl recorder starts at 03/12/17 21:00:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 21:00:22 ###########


########## Tcl recorder starts at 03/12/17 21:00:59 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 21:00:59 ###########


########## Tcl recorder starts at 03/12/17 22:04:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:04:11 ###########


########## Tcl recorder starts at 03/12/17 22:06:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:06:01 ###########


########## Tcl recorder starts at 03/12/17 22:06:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:06:13 ###########


########## Tcl recorder starts at 03/12/17 22:07:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:07:49 ###########


########## Tcl recorder starts at 03/12/17 22:13:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:13:40 ###########


########## Tcl recorder starts at 03/12/17 22:15:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:15:14 ###########


########## Tcl recorder starts at 03/12/17 22:41:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:41:00 ###########


########## Tcl recorder starts at 03/12/17 22:41:15 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:41:15 ###########


########## Tcl recorder starts at 03/12/17 22:41:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:41:31 ###########


########## Tcl recorder starts at 03/12/17 22:41:36 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:41:36 ###########


########## Tcl recorder starts at 03/12/17 22:43:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:43:10 ###########


########## Tcl recorder starts at 03/12/17 22:43:16 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:43:16 ###########


########## Tcl recorder starts at 03/12/17 22:43:40 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:43:40 ###########


########## Tcl recorder starts at 03/12/17 22:43:42 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:43:42 ###########


########## Tcl recorder starts at 03/12/17 22:43:53 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:43:53 ###########


########## Tcl recorder starts at 03/12/17 22:44:17 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:44:17 ###########


########## Tcl recorder starts at 03/12/17 22:58:09 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:58:09 ###########


########## Tcl recorder starts at 03/12/17 22:59:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:59:25 ###########


########## Tcl recorder starts at 03/12/17 22:59:38 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:59:38 ###########


########## Tcl recorder starts at 03/12/17 22:59:45 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:59:45 ###########


########## Tcl recorder starts at 03/12/17 22:59:48 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 22:59:48 ###########


########## Tcl recorder starts at 03/12/17 23:01:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:01:30 ###########


########## Tcl recorder starts at 03/12/17 23:01:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:01:51 ###########


########## Tcl recorder starts at 03/12/17 23:02:13 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:02:13 ###########


########## Tcl recorder starts at 03/12/17 23:02:21 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:02:21 ###########


########## Tcl recorder starts at 03/12/17 23:02:24 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -list -sim PLD -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:02:24 ###########


########## Tcl recorder starts at 03/12/17 23:02:38 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:02:38 ###########


########## Tcl recorder starts at 03/12/17 23:06:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:06:41 ###########


########## Tcl recorder starts at 03/12/17 23:07:19 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:07:19 ###########


########## Tcl recorder starts at 03/12/17 23:07:23 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.abt\" -testfix -template \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:07:23 ###########


########## Tcl recorder starts at 03/12/17 23:10:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:10:03 ###########


########## Tcl recorder starts at 03/12/17 23:10:12 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:10:12 ###########


########## Tcl recorder starts at 03/12/17 23:10:20 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:10:20 ###########


########## Tcl recorder starts at 03/12/17 23:10:23 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:10:23 ###########


########## Tcl recorder starts at 03/12/17 23:11:12 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -list -sim PLD -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:11:12 ###########


########## Tcl recorder starts at 03/12/17 23:11:41 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:11:41 ###########


########## Tcl recorder starts at 03/12/17 23:15:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:15:00 ###########


########## Tcl recorder starts at 03/12/17 23:15:07 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:15:07 ###########


########## Tcl recorder starts at 03/12/17 23:15:13 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:15:13 ###########


########## Tcl recorder starts at 03/12/17 23:15:25 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:15:25 ###########


########## Tcl recorder starts at 03/12/17 23:15:28 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:15:28 ###########


########## Tcl recorder starts at 03/12/17 23:17:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:17:42 ###########


########## Tcl recorder starts at 03/12/17 23:17:48 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:17:48 ###########


########## Tcl recorder starts at 03/12/17 23:17:54 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:17:54 ###########


########## Tcl recorder starts at 03/12/17 23:17:58 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:17:58 ###########


########## Tcl recorder starts at 03/12/17 23:18:00 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:18:00 ###########


########## Tcl recorder starts at 03/12/17 23:20:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:20:34 ###########


########## Tcl recorder starts at 03/12/17 23:20:45 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:20:45 ###########


########## Tcl recorder starts at 03/12/17 23:21:11 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:21:11 ###########


########## Tcl recorder starts at 03/12/17 23:21:15 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:21:15 ###########


########## Tcl recorder starts at 03/12/17 23:21:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:21:59 ###########


########## Tcl recorder starts at 03/12/17 23:22:06 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:22:06 ###########


########## Tcl recorder starts at 03/12/17 23:22:09 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:22:09 ###########


########## Tcl recorder starts at 03/12/17 23:22:53 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:22:53 ###########


########## Tcl recorder starts at 03/12/17 23:29:04 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.abt\" -testfix -template \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:29:04 ###########


########## Tcl recorder starts at 03/12/17 23:38:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:38:36 ###########


########## Tcl recorder starts at 03/12/17 23:38:42 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:38:42 ###########


########## Tcl recorder starts at 03/12/17 23:38:49 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:38:50 ###########


########## Tcl recorder starts at 03/12/17 23:38:52 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:38:52 ###########


########## Tcl recorder starts at 03/12/17 23:40:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:40:51 ###########


########## Tcl recorder starts at 03/12/17 23:41:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:41:31 ###########


########## Tcl recorder starts at 03/12/17 23:41:38 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:41:38 ###########


########## Tcl recorder starts at 03/12/17 23:41:46 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:41:46 ###########


########## Tcl recorder starts at 03/12/17 23:41:48 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:41:48 ###########


########## Tcl recorder starts at 03/12/17 23:42:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:42:16 ###########


########## Tcl recorder starts at 03/12/17 23:42:20 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:42:20 ###########


########## Tcl recorder starts at 03/12/17 23:42:27 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:42:27 ###########


########## Tcl recorder starts at 03/12/17 23:42:29 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:42:29 ###########


########## Tcl recorder starts at 03/12/17 23:42:32 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:42:32 ###########


########## Tcl recorder starts at 03/12/17 23:42:52 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:42:52 ###########


########## Tcl recorder starts at 03/12/17 23:46:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:46:57 ###########


########## Tcl recorder starts at 03/12/17 23:47:02 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:47:02 ###########


########## Tcl recorder starts at 03/12/17 23:47:08 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:47:08 ###########


########## Tcl recorder starts at 03/12/17 23:47:11 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:47:11 ###########


########## Tcl recorder starts at 03/12/17 23:50:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:50:20 ###########


########## Tcl recorder starts at 03/12/17 23:54:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:54:16 ###########


########## Tcl recorder starts at 03/12/17 23:55:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:55:56 ###########


########## Tcl recorder starts at 03/12/17 23:56:04 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:56:04 ###########


########## Tcl recorder starts at 03/12/17 23:56:07 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:56:07 ###########


########## Tcl recorder starts at 03/12/17 23:56:24 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:56:24 ###########


########## Tcl recorder starts at 03/12/17 23:57:34 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:57:34 ###########


########## Tcl recorder starts at 03/12/17 23:57:36 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.eq0\" -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:57:36 ###########


########## Tcl recorder starts at 03/12/17 23:59:15 ##########

# Commands to make the Process: 
# Compiler Listing
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -list -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/12/17 23:59:15 ###########


########## Tcl recorder starts at 03/13/17 00:01:24 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:01:24 ###########


########## Tcl recorder starts at 03/13/17 00:01:39 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:01:39 ###########


########## Tcl recorder starts at 03/13/17 00:02:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:02:17 ###########


########## Tcl recorder starts at 03/13/17 00:02:38 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:02:38 ###########


########## Tcl recorder starts at 03/13/17 00:02:46 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:02:46 ###########


########## Tcl recorder starts at 03/13/17 00:02:49 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:02:49 ###########


########## Tcl recorder starts at 03/13/17 00:03:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 00:03:21 ###########


########## Tcl recorder starts at 03/13/17 01:53:43 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:53:43 ###########


########## Tcl recorder starts at 03/13/17 01:53:50 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:53:50 ###########


########## Tcl recorder starts at 03/13/17 01:53:53 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:53:53 ###########


########## Tcl recorder starts at 03/13/17 01:58:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:58:51 ###########


########## Tcl recorder starts at 03/13/17 01:58:58 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:58:58 ###########


########## Tcl recorder starts at 03/13/17 01:59:05 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:59:05 ###########


########## Tcl recorder starts at 03/13/17 01:59:07 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:59:07 ###########


########## Tcl recorder starts at 03/13/17 01:59:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 01:59:43 ###########


########## Tcl recorder starts at 03/13/17 02:02:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:02:30 ###########


########## Tcl recorder starts at 03/13/17 02:02:45 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:02:45 ###########


########## Tcl recorder starts at 03/13/17 02:02:52 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:02:52 ###########


########## Tcl recorder starts at 03/13/17 02:02:56 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:02:56 ###########


########## Tcl recorder starts at 03/13/17 02:03:25 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:03:26 ###########


########## Tcl recorder starts at 03/13/17 02:07:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:07:32 ###########


########## Tcl recorder starts at 03/13/17 02:08:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:08:16 ###########


########## Tcl recorder starts at 03/13/17 02:08:22 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:08:22 ###########


########## Tcl recorder starts at 03/13/17 02:08:28 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:08:28 ###########


########## Tcl recorder starts at 03/13/17 02:08:31 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:08:31 ###########


########## Tcl recorder starts at 03/13/17 02:09:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:09:00 ###########


########## Tcl recorder starts at 03/13/17 02:09:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:09:59 ###########


########## Tcl recorder starts at 03/13/17 02:13:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:13:18 ###########


########## Tcl recorder starts at 03/13/17 02:17:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:17:10 ###########


########## Tcl recorder starts at 03/13/17 02:17:14 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:17:14 ###########


########## Tcl recorder starts at 03/13/17 02:17:22 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:17:22 ###########


########## Tcl recorder starts at 03/13/17 02:17:24 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:17:24 ###########


########## Tcl recorder starts at 03/13/17 02:25:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:25:25 ###########


########## Tcl recorder starts at 03/13/17 02:25:32 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:25:32 ###########


########## Tcl recorder starts at 03/13/17 02:25:39 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:25:39 ###########


########## Tcl recorder starts at 03/13/17 02:25:42 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:25:42 ###########


########## Tcl recorder starts at 03/13/17 02:26:07 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.eq0\" -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:26:07 ###########


########## Tcl recorder starts at 03/13/17 02:26:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:26:44 ###########


########## Tcl recorder starts at 03/13/17 02:26:51 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:26:51 ###########


########## Tcl recorder starts at 03/13/17 02:26:59 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:26:59 ###########


########## Tcl recorder starts at 03/13/17 02:27:01 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:27:01 ###########


########## Tcl recorder starts at 03/13/17 02:30:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:30:40 ###########


########## Tcl recorder starts at 03/13/17 02:34:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:34:20 ###########


########## Tcl recorder starts at 03/13/17 02:34:27 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:34:27 ###########


########## Tcl recorder starts at 03/13/17 02:34:36 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:34:36 ###########


########## Tcl recorder starts at 03/13/17 02:34:37 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:34:37 ###########


########## Tcl recorder starts at 03/13/17 02:36:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:36:52 ###########


########## Tcl recorder starts at 03/13/17 02:37:00 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:37:00 ###########


########## Tcl recorder starts at 03/13/17 02:37:15 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:37:15 ###########


########## Tcl recorder starts at 03/13/17 02:37:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:37:48 ###########


########## Tcl recorder starts at 03/13/17 02:37:53 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:37:53 ###########


########## Tcl recorder starts at 03/13/17 02:44:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:44:22 ###########


########## Tcl recorder starts at 03/13/17 02:44:26 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:44:26 ###########


########## Tcl recorder starts at 03/13/17 02:44:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:44:58 ###########


########## Tcl recorder starts at 03/13/17 02:45:03 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:45:03 ###########


########## Tcl recorder starts at 03/13/17 02:48:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:48:01 ###########


########## Tcl recorder starts at 03/13/17 02:48:07 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:48:07 ###########


########## Tcl recorder starts at 03/13/17 02:49:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:49:02 ###########


########## Tcl recorder starts at 03/13/17 02:49:15 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:49:15 ###########


########## Tcl recorder starts at 03/13/17 02:49:27 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:49:27 ###########


########## Tcl recorder starts at 03/13/17 02:49:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:49:45 ###########


########## Tcl recorder starts at 03/13/17 02:49:50 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:49:50 ###########


########## Tcl recorder starts at 03/13/17 02:49:57 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:49:57 ###########


########## Tcl recorder starts at 03/13/17 02:50:06 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:50:06 ###########


########## Tcl recorder starts at 03/13/17 02:52:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:52:35 ###########


########## Tcl recorder starts at 03/13/17 02:52:40 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:52:40 ###########


########## Tcl recorder starts at 03/13/17 02:52:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:52:53 ###########


########## Tcl recorder starts at 03/13/17 02:52:56 ##########

# Commands to make the Process: 
# Check Syntax
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -syn -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:52:56 ###########


########## Tcl recorder starts at 03/13/17 02:55:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:55:38 ###########


########## Tcl recorder starts at 03/13/17 02:55:42 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:55:42 ###########


########## Tcl recorder starts at 03/13/17 02:56:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:56:11 ###########


########## Tcl recorder starts at 03/13/17 02:56:13 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:56:13 ###########


########## Tcl recorder starts at 03/13/17 02:56:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:56:27 ###########


########## Tcl recorder starts at 03/13/17 02:56:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:56:48 ###########


########## Tcl recorder starts at 03/13/17 02:56:51 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:56:51 ###########


########## Tcl recorder starts at 03/13/17 02:57:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:57:02 ###########


########## Tcl recorder starts at 03/13/17 02:57:06 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:57:06 ###########


########## Tcl recorder starts at 03/13/17 02:57:14 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:57:14 ###########


########## Tcl recorder starts at 03/13/17 02:57:17 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:57:17 ###########


########## Tcl recorder starts at 03/13/17 02:58:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:58:34 ###########


########## Tcl recorder starts at 03/13/17 02:58:53 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:58:53 ###########


########## Tcl recorder starts at 03/13/17 02:59:29 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 02:59:29 ###########


########## Tcl recorder starts at 03/13/17 03:01:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:01:20 ###########


########## Tcl recorder starts at 03/13/17 03:04:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:04:42 ###########


########## Tcl recorder starts at 03/13/17 03:04:46 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:04:46 ###########


########## Tcl recorder starts at 03/13/17 03:04:54 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:04:54 ###########


########## Tcl recorder starts at 03/13/17 03:04:57 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:04:57 ###########


########## Tcl recorder starts at 03/13/17 03:16:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:16:58 ###########


########## Tcl recorder starts at 03/13/17 03:17:16 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:17:16 ###########


########## Tcl recorder starts at 03/13/17 03:17:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:17:31 ###########


########## Tcl recorder starts at 03/13/17 03:17:36 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:17:36 ###########


########## Tcl recorder starts at 03/13/17 03:18:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:18:15 ###########


########## Tcl recorder starts at 03/13/17 03:18:22 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:18:22 ###########


########## Tcl recorder starts at 03/13/17 03:18:30 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:18:30 ###########


########## Tcl recorder starts at 03/13/17 03:18:33 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:18:33 ###########


########## Tcl recorder starts at 03/13/17 03:18:56 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:18:56 ###########


########## Tcl recorder starts at 03/13/17 03:20:35 ##########

# Commands to make the Process: 
# Functional Simulation
# - none -
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:20:35 ###########


########## Tcl recorder starts at 03/13/17 03:23:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:23:05 ###########


########## Tcl recorder starts at 03/13/17 03:24:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:24:54 ###########


########## Tcl recorder starts at 03/13/17 03:25:22 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:25:22 ###########


########## Tcl recorder starts at 03/13/17 03:25:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:25:34 ###########


########## Tcl recorder starts at 03/13/17 03:25:41 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:25:41 ###########


########## Tcl recorder starts at 03/13/17 03:25:49 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:25:49 ###########


########## Tcl recorder starts at 03/13/17 03:25:51 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:25:51 ###########


########## Tcl recorder starts at 03/13/17 03:30:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:30:02 ###########


########## Tcl recorder starts at 03/13/17 03:30:24 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:30:24 ###########


########## Tcl recorder starts at 03/13/17 03:30:30 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:30:30 ###########


########## Tcl recorder starts at 03/13/17 03:30:32 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/13/17 03:30:32 ###########


########## Tcl recorder starts at 03/14/17 10:21:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/17 10:21:35 ###########


########## Tcl recorder starts at 03/14/17 10:22:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -ojhd only -def _PLSI_ _LATTICE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/17 10:22:29 ###########


########## Tcl recorder starts at 03/14/17 10:22:44 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -mod DRAM -ojhd compile -prj pld -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/17 10:22:44 ###########


########## Tcl recorder starts at 03/14/17 10:22:52 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" \"dram.abl\" -vec -ovec \"dram.tmv\" -sim PLD  -def _PLSI_ _LATTICE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/17 10:22:52 ###########


########## Tcl recorder starts at 03/14/17 10:22:54 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/blif2eqn\" \"DRAM.bl0\" -o \"DRAM.lsi\" -template \"$install_dir/ispcpld/plsi/latsim/plsi.tft\" -testfix -bus rebuild -prj pld -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"DRAM.bl0\" -o \"DRAM.blo\" -red bypin choose -collapse -pterms 8 -family -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblflink\" \"DRAM.blo\" -o \"pld.blh\" -omod pld -propadd -family PLSI -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/iblifopt\" \"pld.blh\" -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/idiofft\" -i \"pld.bli\" -o \"pld.blj\" -idev PLSI -propadd -dev pla_basic -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre1 -ini simcpls.ini -unit simcp.pre1
-cfg plsi.fdk \"dram.lts\" -map \"DRAM.lsi\"
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 03/14/17 10:22:54 ###########

