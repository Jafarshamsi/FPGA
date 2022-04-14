# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.runs/synth_1/TOP_UART_wrapper.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param chipscope.maxJobs 4
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7k325tffg900-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.cache/wt [current_project]
set_property parent.project_path D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths {C:/Users/Neuromorph/AppData/Roaming/Xilinx/Vivado/2021.2/xhub/board_store/xilinx_board_store} [current_project]
set_property board_part digilentinc.com:genesys2:part0:1.1 [current_project]
set_property ip_repo_paths c:/Xilinx/NewIPrepo/vivado-library-2019.1-1 [current_project]
update_ip_catalog
set_property ip_output_repo d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_verilog -library xil_defaultlib d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/hdl/TOP_UART_wrapper.v
add_files D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.srcs/sources_1/bd/TOP_UART/TOP_UART.bd
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_0/TOP_UART_microblaze_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_0/TOP_UART_microblaze_0_0_ooc_debug.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_0/TOP_UART_microblaze_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_dlmb_v10_0/TOP_UART_dlmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_ilmb_v10_0/TOP_UART_ilmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_dlmb_bram_if_cntlr_0/TOP_UART_dlmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_ilmb_bram_if_cntlr_0/TOP_UART_ilmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_lmb_bram_0/TOP_UART_lmb_bram_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_xbar_0/TOP_UART_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_axi_intc_0/TOP_UART_microblaze_0_axi_intc_0.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_axi_intc_0/TOP_UART_microblaze_0_axi_intc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_axi_intc_0/TOP_UART_microblaze_0_axi_intc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_mdm_1_0/TOP_UART_mdm_1_0.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_mdm_1_0/TOP_UART_mdm_1_0_ooc_trace.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_clk_wiz_1_0/TOP_UART_clk_wiz_1_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_clk_wiz_1_0/TOP_UART_clk_wiz_1_0.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_clk_wiz_1_0/TOP_UART_clk_wiz_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_rst_clk_wiz_1_100M_0/TOP_UART_rst_clk_wiz_1_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_rst_clk_wiz_1_100M_0/TOP_UART_rst_clk_wiz_1_100M_0.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_rst_clk_wiz_1_100M_0/TOP_UART_rst_clk_wiz_1_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_axi_uartlite_0_0/TOP_UART_axi_uartlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_axi_uartlite_0_0/TOP_UART_axi_uartlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_axi_uartlite_0_0/TOP_UART_axi_uartlite_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/TOP_UART_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.gen/sources_1/bd/TOP_UART/ip/TOP_UART_microblaze_0_0/data/mb_bootloop_le.elf]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.srcs/constrs_1/new/Clock_cnst.xdc
set_property used_in_implementation false [get_files D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.srcs/constrs_1/new/Clock_cnst.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1

read_checkpoint -auto_incremental -incremental D:/MYGITHUB/MYCODES/FPGA/IF_UART/UART/UART.srcs/utils_1/imports/synth_1/TOP_UART_wrapper.dcp
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top TOP_UART_wrapper -part xc7k325tffg900-2
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef TOP_UART_wrapper.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file TOP_UART_wrapper_utilization_synth.rpt -pb TOP_UART_wrapper_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
