if { [namespace current] != {::60F1F07D} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for global constraints on Fri Jul 16   \
17:47:57 2021

###################################################################

# Set the current_design #
current_design radiation_sensor_digital_top

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_attribute -type integer [current_design] pwr_cg_gating_group_count 44
set_attribute -type boolean [current_design] pwr_cg_design_has_clock_gating    \
true
set_fix_multiple_port_nets -all -buffer_constants
set_max_area 0
set_local_link_library                                                         \
{/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/diglibs/D_CELLS_HD/v3_0/liberty_LPMOS/v3_0_1/PVT_1_80V_range/D_CELLS_HD_LPMOS_slow_1_62V_125C.db,/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/diglibs/D_CELLS_HDLL/v2_1/liberty_LPMOS/v2_1_1/PVT_1_80V_range/D_CELLS_HDLL_LPMOS_slow_1_62V_125C.db}
set_register_merging [current_design] 17
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg] clock_gating_logic    \
true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg]            \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part4/reply_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/counter_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]}]    \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part4/our_cid_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_abort_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg]             \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0}]  \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[0]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[11]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[12]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[13]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[1]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[2]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[3]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[4]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[5]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[6]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[7]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[8]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[9]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg]      \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/status_flags_reg[error]}] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]}]          \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg]             \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/cached_adc_value_reg] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg]                \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg]       \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]}]    \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg]              \
clock_gating_logic true
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg/CLK]                   \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg/EN]                    \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg/TE]                    \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg/CLK]        \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg/EN]         \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg/TE]         \
-constant_propagation false 
set_compile_directives [get_pins clk_gate_iso14443a_inst/part4/reply_reg/CLK]  \
-constant_propagation false 
set_compile_directives [get_pins clk_gate_iso14443a_inst/part4/reply_reg/EN]   \
-constant_propagation false 
set_compile_directives [get_pins clk_gate_iso14443a_inst/part4/reply_reg/TE]   \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg/CLK] -constant_propagation \
false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg/EN] -constant_propagation  \
false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg/TE] -constant_propagation  \
false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/counter_reg/CLK]                     \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/counter_reg/EN]                      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/counter_reg/TE]                      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg/CLK] -constant_propagation      \
false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg/EN] -constant_propagation false \

set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg/TE] -constant_propagation false \

set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]/EN}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]/TE}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part4/our_cid_reg/CLK] -constant_propagation false 
set_compile_directives [get_pins clk_gate_iso14443a_inst/part4/our_cid_reg/EN] \
-constant_propagation false 
set_compile_directives [get_pins clk_gate_iso14443a_inst/part4/our_cid_reg/TE] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_abort_reg/CLK] -constant_propagation      \
false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_abort_reg/EN] -constant_propagation false \

set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_abort_reg/TE] -constant_propagation false \

set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]/CLK}] -constant_propagation    \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]/EN}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]/TE}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg/CLK]         \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg/EN]          \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg/TE]          \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0/EN}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0/TE}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]/CLK}] -constant_propagation    \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]/EN}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]/TE}] -constant_propagation     \
false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[0]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[0]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[0]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/rx_buffer_reg[11]/CLK}] -constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[11]/EN}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[11]/TE}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/rx_buffer_reg[12]/CLK}] -constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[12]/EN}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[12]/TE}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/rx_buffer_reg[13]/CLK}] -constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[13]/EN}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[13]/TE}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[1]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[1]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[1]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[2]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[2]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[2]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[3]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[3]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[3]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[4]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[4]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[4]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[5]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[5]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[5]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[6]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[6]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[6]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[7]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[7]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[7]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[8]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[8]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[8]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[9]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[9]/EN}]  \
-constant_propagation false 
set_compile_directives [get_pins {clk_gate_adapter_inst/rx_buffer_reg[9]/TE}]  \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]/CLK}] -constant_propagation    \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]/EN}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]/TE}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]/CLK}] -constant_propagation    \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]/EN}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]/TE}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]/CLK}] -constant_propagation    \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]/EN}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]/TE}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg/CLK]  \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg/EN]   \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg/TE]   \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/status_flags_reg[error]/CLK}] -constant_propagation     \
false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/status_flags_reg[error]/EN}] -constant_propagation      \
false 
set_compile_directives [get_pins                                               \
{clk_gate_adapter_inst/status_flags_reg[error]/TE}] -constant_propagation      \
false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]/CLK}]      \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]/EN}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]/TE}]       \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg/CLK]         \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg/EN]          \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg/TE]          \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/cached_adc_value_reg/CLK] -constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/cached_adc_value_reg/EN] -constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/cached_adc_value_reg/TE] -constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg/CLK]            \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg/EN]             \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg/TE]             \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg/CLK]   \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg/EN]    \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg/TE]    \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]/CLK}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]/EN}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]/TE}] \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg/CLK]          \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg/EN]           \
-constant_propagation false 
set_compile_directives [get_pins                                               \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg/TE]           \
-constant_propagation false 
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg] hpower_inv_cg_cell    \
false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg]            \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part4/reply_reg] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/counter_reg] hpower_inv_cg_cell      \
false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]}]    \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part4/our_cid_reg] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_abort_reg] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg]             \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0}]  \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[0]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[11]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[12]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[13]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[1]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[2]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[3]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[4]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[5]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[6]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[7]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[8]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[9]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg]      \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_adapter_inst/status_flags_reg[error]}] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]}]          \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg]             \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/cached_adc_value_reg] hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg]                \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg]       \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]}]    \
hpower_inv_cg_cell false
set_attribute -type boolean [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg]              \
hpower_inv_cg_cell false
set_attribute -type integer [get_cells clk_r_REG577_S1]                        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells clk_r_REG466_S1]                        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells clk_r_REG162_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG414_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG553_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG185_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG163_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG184_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG412_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG338_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG180_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG183_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG182_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG30_S15] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG11_S12] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG410_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG181_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG69_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG12_S12] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG405_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG71_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG285_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG68_S12] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG67_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG72_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG522_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG179_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG178_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG431_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG369_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG367_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG174_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG167_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG165_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG176_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG164_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG169_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG177_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG170_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG373_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG353_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG168_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG325_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG455_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG468_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG448_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG494_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG452_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG357_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG586_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG166_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG173_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG575_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG171_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG407_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG401_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG368_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG555_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG372_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG340_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG366_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG443_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG447_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG370_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG172_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG426_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG361_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG363_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG202_S20] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG542_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG510_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG175_S16] pwr_cg_gating_group 38
set_attribute -type integer [get_cells clk_r_REG342_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG327_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG561_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG559_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG573_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG371_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG528_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG365_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG344_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG540_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG526_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG403_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG388_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG392_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG391_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG393_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG389_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG390_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG142_S19] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG450_S1] pwr_cg_gating_group 7
set_attribute -type integer [get_cells clk_r_REG157_S16] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG429_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG581_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG579_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG471_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG386_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG387_S1] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG578_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG473_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG472_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG475_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG359_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG580_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG355_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG490_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG312_S1] pwr_cg_gating_group 10
set_attribute -type integer [get_cells clk_r_REG474_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG310_S1] pwr_cg_gating_group 10
set_attribute -type integer [get_cells clk_r_REG506_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG492_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG508_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG524_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG537_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG336_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG503_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG571_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG315_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG153_S15] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG458_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG384_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG385_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG306_S1] pwr_cg_gating_group 10
set_attribute -type integer [get_cells clk_r_REG557_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG347_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG350_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG351_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG520_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG504_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG519_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG488_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG536_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG486_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG322_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG569_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG538_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG551_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG570_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG298_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG193_S13] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG144_S13] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG40_S14] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG152_S14] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG381_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG308_S1] pwr_cg_gating_group 10
set_attribute -type integer [get_cells clk_r_REG418_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG32_S13] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG380_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG212_S13] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG383_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG374_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG349_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG213_S13] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG378_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG377_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG379_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG319_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG348_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG321_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG516_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG566_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG483_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG333_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG500_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG498_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG485_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG568_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG518_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG549_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG428_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG292_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG375_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG533_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG481_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG382_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG284_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG512_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG323_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG496_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG487_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG289_S1] pwr_cg_gating_group 14
set_attribute -type integer [get_cells clk_r_REG302_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG299_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG290_S1] pwr_cg_gating_group 14
set_attribute -type integer [get_cells clk_r_REG297_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG300_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG295_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG437_S1] pwr_cg_gating_group 14
set_attribute -type integer [get_cells clk_r_REG301_S1] pwr_cg_gating_group 4
set_attribute -type integer [get_cells clk_r_REG296_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG453_S1] pwr_cg_gating_group 14
set_attribute -type integer [get_cells clk_r_REG291_S1] pwr_cg_gating_group 14
set_attribute -type integer [get_cells clk_r_REG550_S1] pwr_cg_gating_group 3
set_attribute -type integer [get_cells clk_r_REG456_S1] pwr_cg_gating_group 14
set_attribute -type integer [get_cells clk_r_REG329_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG154_S15] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG187_S15] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG189_S15] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG159_S16] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG346_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG77_S21] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG477_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG100_S23] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG59_S21] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG45_S17] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG345_S1] pwr_cg_gating_group 9
set_attribute -type integer [get_cells clk_r_REG60_S21] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG101_S23] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG99_S23] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG420_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG531_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG376_S1] pwr_cg_gating_group 13
set_attribute -type integer [get_cells clk_r_REG317_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG502_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG331_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG204_S20] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG545_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG547_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG564_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG535_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG134_S17] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG335_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG514_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG460_S1] pwr_cg_gating_group 12
set_attribute -type integer [get_cells clk_r_REG158_S17] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG155_S14] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG253_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG293_S1] pwr_cg_gating_group 5
set_attribute -type integer [get_cells clk_r_REG269_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG294_S1] pwr_cg_gating_group 2
set_attribute -type integer [get_cells clk_r_REG399_S1] pwr_cg_gating_group 0
set_attribute -type integer [get_cells clk_r_REG395_S1] pwr_cg_gating_group 0
set_attribute -type integer [get_cells clk_r_REG397_S1] pwr_cg_gating_group 0
set_attribute -type integer [get_cells clk_r_REG582_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG425_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG211_S17] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG118_S21] pwr_cg_gating_group 43
set_attribute -type integer [get_cells clk_r_REG62_S22] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG283_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG51_S21] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG457_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG439_S1] pwr_cg_gating_group 15
set_attribute -type integer [get_cells clk_r_REG104_S19] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG577_S1] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG111_S21] pwr_cg_gating_group 43
set_attribute -type integer [get_cells clk_r_REG112_S22] pwr_cg_gating_group 43
set_attribute -type integer [get_cells clk_r_REG114_S22] pwr_cg_gating_group 43
set_attribute -type integer [get_cells clk_r_REG583_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG105_S22] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG52_S22] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG251_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG263_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG281_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG267_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG259_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG109_S21] pwr_cg_gating_group 43
set_attribute -type integer [get_cells clk_r_REG241_S1] pwr_cg_gating_group 16
set_attribute -type integer [get_cells clk_r_REG151_S16] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG265_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG275_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG279_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG9_S10] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG220_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG141_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG478_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG110_S22] pwr_cg_gating_group 43
set_attribute -type integer [get_cells clk_r_REG441_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG23_S23] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG584_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG459_S1] pwr_cg_gating_group 15
set_attribute -type integer [get_cells clk_r_REG417_S1] pwr_cg_gating_group 15
set_attribute -type integer [get_cells clk_r_REG440_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG148_S14] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG10_S11] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG119_S17] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG126_S17] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG585_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG224_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG466_S1] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG465_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG430_S1] pwr_cg_gating_group 15
set_attribute -type integer [get_cells clk_r_REG271_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG0_S1] pwr_cg_gating_group 16
set_attribute -type integer [get_cells clk_r_REG191_S16] pwr_cg_gating_group 36
set_attribute -type integer [get_cells clk_r_REG311_S1] pwr_cg_gating_group 16
set_attribute -type integer [get_cells clk_r_REG307_S1] pwr_cg_gating_group 16
set_attribute -type integer [get_cells clk_r_REG313_S1] pwr_cg_gating_group 16
set_attribute -type integer [get_cells clk_r_REG273_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG261_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG257_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG444_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG255_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG470_S1] pwr_cg_gating_group 8
set_attribute -type integer [get_cells clk_r_REG543_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG479_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG511_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG328_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG495_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG314_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG529_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG562_S1] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG446_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG449_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG427_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG442_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG539_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG491_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG507_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG525_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG445_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG360_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG364_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG451_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG454_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG37_S14] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG572_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG354_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG362_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG92_S24] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG341_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG358_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG356_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG24_S11] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG221_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG140_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG303_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG138_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG25_S11] pwr_cg_gating_group 39
set_attribute -type integer [get_cells clk_r_REG137_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG135_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG106_S18] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG226_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG139_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG136_S18] pwr_cg_gating_group 20
set_attribute -type integer [get_cells clk_r_REG2_S3] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG222_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG160_S17] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG223_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG225_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG156_S15] pwr_cg_gating_group 42
set_attribute -type integer [get_cells clk_r_REG1_S2] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG228_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG230_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG235_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG232_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG229_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG231_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG469_S1] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG227_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG201_S19] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG203_S19] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG233_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG234_S18] pwr_cg_gating_group 18
set_attribute -type integer [get_cells clk_r_REG89_S18] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG91_S23] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG5_S6] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG38_S14] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG7_S8] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG8_S9] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG34_S14] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG192_S16] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG35_S14] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG39_S14] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG3_S4] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG127_S17] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG130_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG33_S14] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG4_S5] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG6_S7] pwr_cg_gating_group 17
set_attribute -type integer [get_cells clk_r_REG94_S24] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG195_S18] pwr_cg_gating_group 11
set_attribute -type integer [get_cells clk_r_REG36_S14] pwr_cg_gating_group 23
set_attribute -type integer [get_cells clk_r_REG243_S2] pwr_cg_gating_group 24
set_attribute -type integer [get_cells clk_r_REG309_S1] pwr_cg_gating_group 16
set_attribute -type integer [get_cells clk_r_REG44_S17] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG88_S18] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG121_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG96_S24] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG103_S18] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG98_S24] pwr_cg_gating_group 21
set_attribute -type integer [get_cells clk_r_REG188_S16] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG247_S2] pwr_cg_gating_group 24
set_attribute -type integer [get_cells clk_r_REG245_S2] pwr_cg_gating_group 24
set_attribute -type integer [get_cells clk_r_REG190_S16] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG131_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG125_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG124_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG123_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG133_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG120_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG129_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG122_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG132_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG128_S17] pwr_cg_gating_group 22
set_attribute -type integer [get_cells clk_r_REG194_S17] pwr_cg_gating_group 40
set_attribute -type integer [get_cells clk_r_REG246_S1] pwr_cg_gating_group 26
set_attribute -type integer [get_cells clk_r_REG87_S17] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG242_S1] pwr_cg_gating_group 26
set_attribute -type integer [get_cells clk_r_REG244_S1] pwr_cg_gating_group 26
set_attribute -type integer [get_cells clk_r_REG19_S19] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG22_S22] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG56_S21] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG57_S21] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG13_S13] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG324_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG15_S15] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG16_S16] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG54_S21] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG17_S17] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG408_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG55_S21] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG14_S14] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG21_S21] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG20_S20] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG18_S18] pwr_cg_gating_group 19
set_attribute -type integer [get_cells clk_r_REG532_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG517_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG554_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG90_S23] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG95_S23] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG93_S23] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG563_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG97_S23] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG102_S17] pwr_cg_gating_group 28
set_attribute -type integer [get_cells clk_r_REG411_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG501_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG548_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG320_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG565_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG482_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG484_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG404_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG493_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG316_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG409_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG337_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG343_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG326_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG567_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG534_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG413_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG541_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG499_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG530_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG489_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG252_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG330_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG556_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG560_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG513_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG480_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG527_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG398_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG394_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG396_S1] pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG558_S1] pwr_cg_gating_group 27
set_attribute -type integer [get_cells clk_r_REG521_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG334_S1] pwr_cg_gating_group 34
set_attribute -type integer [get_cells clk_r_REG552_S1] pwr_cg_gating_group 33
set_attribute -type integer [get_cells clk_r_REG546_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG406_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG352_S1] pwr_cg_gating_group 25
set_attribute -type integer [get_cells clk_r_REG505_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG318_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG523_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG509_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG339_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG515_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG402_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG278_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG544_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG497_S1] pwr_cg_gating_group 32
set_attribute -type integer [get_cells clk_r_REG276_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG400_S1] pwr_cg_gating_group 30
set_attribute -type integer [get_cells clk_r_REG574_S1] pwr_cg_gating_group 31
set_attribute -type integer [get_cells clk_r_REG332_S1] pwr_cg_gating_group 29
set_attribute -type integer [get_cells clk_r_REG250_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG258_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG274_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG256_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG260_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG268_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG280_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG254_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG266_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG270_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG272_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG264_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG262_S1] pwr_cg_gating_group 35
set_attribute -type integer [get_cells clk_r_REG29_S14] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG74_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG73_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG28_S13] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG31_S16] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG65_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG66_S17] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG70_S19] pwr_cg_gating_group 6
set_attribute -type integer [get_cells clk_r_REG277_S2] pwr_cg_gating_group 37
set_attribute -type integer [get_cells clk_r_REG288_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells clk_r_REG287_S1] pwr_cg_gating_group 41
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg] pwr_cg_gating_group   \
43
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]}]          \
pwr_cg_gating_group 42
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg]            \
pwr_cg_gating_group 41
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part4/reply_reg] pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg] pwr_cg_gating_group 39
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/counter_reg] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]}]          \
pwr_cg_gating_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg] pwr_cg_gating_group 15
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]}]    \
pwr_cg_gating_group 26
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]}]          \
pwr_cg_gating_group 24
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part4/our_cid_reg] pwr_cg_gating_group 10
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_abort_reg] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg]             \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0}]  \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[0]}] pwr_cg_gating_group 5
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[11]}] pwr_cg_gating_group 32
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[12]}] pwr_cg_gating_group 29
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[13]}] pwr_cg_gating_group 34
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[1]}] pwr_cg_gating_group 3
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[2]}] pwr_cg_gating_group 2
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[3]}] pwr_cg_gating_group 4
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[4]}] pwr_cg_gating_group 9
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[5]}] pwr_cg_gating_group 33
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[6]}] pwr_cg_gating_group 30
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[7]}] pwr_cg_gating_group 25
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[8]}] pwr_cg_gating_group 27
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[9]}] pwr_cg_gating_group 31
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]}]          \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]}]          \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]}]          \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg]      \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/status_flags_reg[error]}] pwr_cg_gating_group 36
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]}]          \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg]             \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/cached_adc_value_reg] pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg]                \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg]       \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]}]    \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg]              \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells clk_r_REG162_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG414_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG553_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG185_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG163_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG184_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG412_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG338_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG180_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG183_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG182_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG30_S15]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG11_S12]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG410_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG181_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG69_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG12_S12]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG405_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG71_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG285_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG68_S12]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG67_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG72_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG522_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG179_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG178_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG431_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG369_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG367_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG174_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG167_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG165_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG176_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG164_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG169_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG177_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG170_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG373_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG353_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG168_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG325_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG455_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG468_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG448_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG494_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG452_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG357_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG586_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG166_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG173_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG575_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG171_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG407_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG401_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG368_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG555_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG372_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG340_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG366_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG443_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG447_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG370_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG172_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG426_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG361_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG363_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG202_S20]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG542_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG510_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG175_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG342_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG327_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG561_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG559_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG573_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG371_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG528_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG365_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG344_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG540_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG526_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG403_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG388_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG392_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG391_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG393_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG389_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG390_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG142_S19]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG450_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG157_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG429_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG581_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG579_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG471_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG386_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG387_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG578_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG473_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG472_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG475_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG359_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG580_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG355_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG490_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG312_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG474_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG310_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG506_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG492_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG508_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG524_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG537_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG336_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG503_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG571_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG315_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG153_S15]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG458_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG384_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG385_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG306_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG557_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG347_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG350_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG351_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG520_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG504_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG519_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG488_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG536_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG486_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG322_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG569_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG538_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG551_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG570_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG298_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG193_S13]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG144_S13]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG40_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG152_S14]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG381_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG308_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG418_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG32_S13]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG380_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG212_S13]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG383_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG374_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG349_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG213_S13]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG378_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG377_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG379_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG319_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG348_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG321_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG516_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG566_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG483_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG333_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG500_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG498_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG485_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG568_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG518_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG549_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG428_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG292_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG375_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG533_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG481_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG382_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG284_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG512_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG323_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG496_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG487_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG289_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG302_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG299_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG290_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG297_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG300_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG295_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG437_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG301_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG296_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG453_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG291_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG550_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG456_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG329_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG154_S15]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG187_S15]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG189_S15]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG159_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG346_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG77_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG477_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG100_S23]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG59_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG45_S17]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG345_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG60_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG101_S23]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG99_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG420_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG531_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG376_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG317_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG502_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG331_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG204_S20]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG545_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG547_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG564_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG535_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG134_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG335_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG514_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG460_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG158_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG155_S14]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG253_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG293_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG269_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG294_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG399_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG395_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG397_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG582_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG425_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG211_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG118_S21]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG62_S22]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG283_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG51_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG457_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG439_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG104_S19]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG577_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG111_S21]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG112_S22]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG114_S22]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG583_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG105_S22]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG52_S22]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG251_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG263_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG281_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG267_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG259_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG109_S21]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG241_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG151_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG265_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG275_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG279_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG9_S10] pwr_cg_gating_sub_group \
0
set_attribute -type integer [get_cells clk_r_REG220_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG141_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG478_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG110_S22]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG441_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG23_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG584_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG459_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG417_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG440_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG148_S14]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG10_S11]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG119_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG126_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG585_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG224_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG466_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG465_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG430_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG271_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG0_S1] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG191_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG311_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG307_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG313_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG273_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG261_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG257_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG444_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG255_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG470_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG543_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG479_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG511_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG328_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG495_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG314_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG529_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG562_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG446_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG449_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG427_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG442_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG539_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG491_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG507_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG525_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG445_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG360_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG364_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG451_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG454_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG37_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG572_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG354_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG362_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG92_S24]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG341_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG358_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG356_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG24_S11]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG221_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG140_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG303_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG138_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG25_S11]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG137_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG135_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG106_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG226_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG139_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG136_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG2_S3] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG222_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG160_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG223_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG225_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG156_S15]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG1_S2] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG228_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG230_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG235_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG232_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG229_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG231_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG469_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG227_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG201_S19]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG203_S19]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG233_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG234_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG89_S18]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG91_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG5_S6] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG38_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG7_S8] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG8_S9] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG34_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG192_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG35_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG39_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG3_S4] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG127_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG130_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG33_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG4_S5] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG6_S7] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG94_S24]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG195_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG36_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG243_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG309_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG44_S17]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG88_S18]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG121_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG96_S24]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG103_S18]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG98_S24]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG188_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG247_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG245_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG190_S16]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG131_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG125_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG124_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG123_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG133_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG120_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG129_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG122_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG132_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG128_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG194_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG246_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG87_S17]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG242_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG244_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG19_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG22_S22]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG56_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG57_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG13_S13]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG324_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG15_S15]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG16_S16]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG54_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG17_S17]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG408_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG55_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG14_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG21_S21]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG20_S20]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG18_S18]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG532_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG517_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG554_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG90_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG95_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG93_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG563_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG97_S23]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG102_S17]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG411_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG501_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG548_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG320_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG565_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG482_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG484_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG404_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG493_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG316_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG409_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG337_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG343_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG326_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG567_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG534_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG413_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG541_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG499_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG530_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG489_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG252_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG330_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG556_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG560_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG513_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG480_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG527_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG398_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG394_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG396_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG558_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG521_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG334_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG552_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG546_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG406_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG352_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG505_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG318_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG523_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG509_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG339_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG515_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG402_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG278_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG544_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG497_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG276_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG400_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG574_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG332_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG250_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG258_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG274_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG256_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG260_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG268_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG280_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG254_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG266_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG270_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG272_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG264_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG262_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG29_S14]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG74_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG73_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG28_S13]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG31_S16]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG65_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG66_S17]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG70_S19]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG277_S2]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG288_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells clk_r_REG287_S1]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part2/tx_inst/bc_inst/count_reg]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_enable]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part4/reply_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part4/app_rx_iface_data_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/counter_reg] pwr_cg_gating_sub_group \
0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/signal_control_inst/signals_reg[sens_config]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part2/sd_inst/prev_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part4/our_cid_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_abort_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]_0}]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/tx_buffer_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[11]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[12]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[13]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[8]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/rx_buffer_reg[9]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part4/rx_buffer_reg[2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg]      \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_adapter_inst/status_flags_reg[error]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/cached_adc_value_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_adc_value_reg]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg]       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{clk_gate_iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
clk_gate_adapter_inst/signal_control_inst/cached_sync_timing_reg]              \
pwr_cg_gating_sub_group 0
set_register_merging [get_cells pause_n_latch_sync/pause_n_latched_reg] 17
set compile_inbound_cell_optimization false
set compile_inbound_max_cell_percentage 10.0
