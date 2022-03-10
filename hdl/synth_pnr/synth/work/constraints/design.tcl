if { [namespace current] != {::622A46C7} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for global constraints on Thu Mar 10   \
15:43:19 2022

###################################################################

# Set the current_design #
current_design radiation_sensor_digital_top

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_optimize_registers true -designs [current_design] -justification_effort    \
high
set_attribute -type integer [current_design] pwr_cg_gating_group_count 221
set_attribute -type boolean [current_design] pwr_cg_design_has_clock_gating    \
true
set_fix_multiple_port_nets -all -buffer_constants
set_max_area 0
set_local_link_library                                                         \
{/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/diglibs/D_CELLS_HD/v3_0/liberty_LPMOS/v3_0_1/PVT_1_80V_range/D_CELLS_HD_LPMOS_slow_1_62V_125C.db,/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/diglibs/D_CELLS_HDLL/v2_1/liberty_LPMOS/v2_1_1/PVT_1_80V_range/D_CELLS_HDLL_LPMOS_slow_1_62V_125C.db}
set_register_merging [current_design] 17
set_attribute -type boolean [get_cells self_gate_adc_sync/q_reg_0]             \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part2/tx_inst/state_reg_0] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/rx_count_reg_0]             \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg_0]  \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fe_inst/state_reg_0]               \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg_0]            \
clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_error_flag_reg_0] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_count_reg_0] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_adapter_inst/tx_iface_data_valid_reg_0] clock_gating_logic true
set_attribute -type boolean [get_cells                                         \
self_gate_pause_n_latch_sync/sync_inst/tmp_reg_0] clock_gating_logic true
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
set_attribute -type integer [get_cells self_gate_adc_sync/q_reg_0]             \
power_sg_gating_bank 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part2/tx_inst/state_reg_0] power_sg_gating_bank 2
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/rx_count_reg_0]             \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg_0]  \
power_sg_gating_bank 4
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fe_inst/state_reg_0]               \
power_sg_gating_bank 6
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg_0]            \
power_sg_gating_bank 7
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_error_flag_reg_0] power_sg_gating_bank 8
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_count_reg_0] power_sg_gating_bank 9
set_attribute -type integer [get_cells                                         \
self_gate_adapter_inst/tx_iface_data_valid_reg_0] power_sg_gating_bank 11
set_attribute -type integer [get_cells                                         \
self_gate_pause_n_latch_sync/sync_inst/tmp_reg_0] power_sg_gating_bank 12
set_attribute -type integer [get_cells                                         \
{pause_n_latch_sync/sync_inst/q_reg[0]}] power_sg_gating_bank 12
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/pause_n_synchronised_old_reg]                 \
power_sg_gating_bank 12
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/idle_reg] power_sg_gating_bank 12
set_attribute -type integer [get_cells                                         \
{pause_n_latch_sync/sync_inst/tmp_reg[0]}] power_sg_gating_bank 12
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg]              \
power_sg_gating_bank 4
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_valid_reg]            \
power_sg_gating_bank 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/state_reg[1]}] power_sg_gating_bank \
6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/state_reg[1]}] power_sg_gating_bank 2
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/state_reg[0]}] power_sg_gating_bank 2
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/forward_from_app_reg] power_sg_gating_bank 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/tx_iface_data_valid_reg] power_sg_gating_bank 0
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[1]}]           \
power_sg_gating_bank 11
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[2]}]           \
power_sg_gating_bank 11
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[3]}]           \
power_sg_gating_bank 11
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[0]}]           \
power_sg_gating_bank 11
set_attribute -type integer [get_cells adapter_inst/tx_iface_data_valid_reg]   \
power_sg_gating_bank 11
set_attribute -type integer [get_cells adapter_inst/send_reply_reg]            \
power_sg_gating_bank 0
set_attribute -type integer [get_cells                                         \
adapter_inst/last_rx_had_invalid_magic_reg] power_sg_gating_bank 9
set_attribute -type integer [get_cells adapter_inst/rx_error_flag_reg]         \
power_sg_gating_bank 9
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_error_reg] power_sg_gating_bank 8
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[1]}]         \
power_sg_gating_bank 9
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[2]}]         \
power_sg_gating_bank 9
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[0]}]         \
power_sg_gating_bank 9
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_data_valid_reg] power_sg_gating_bank 9
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_eoc_reg] power_sg_gating_bank 8
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/forward_to_app_reg] power_sg_gating_bank 8
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_soc_reg] power_sg_gating_bank 8
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/state_star_reg] power_sg_gating_bank  \
4
set_attribute -type integer [get_cells iso14443a_inst/part4/rx_deselect_reg]   \
power_sg_gating_bank 4
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_tx_iface_req_reg] power_sg_gating_bank 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_start_reg] power_sg_gating_bank \
6
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_sample_reg]                     \
power_sg_gating_bank 6
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_type_reg] power_sg_gating_bank  \
6
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/rx_error_flag_reg]                    \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[1]}]                    \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[0]}]                    \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[2]}]                    \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/pkt_received_reg]                     \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/in_iface_req_reg]                     \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/state_reg[0]}] power_sg_gating_bank  \
4
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[2]}] \
power_sg_gating_bank 9
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[1]}] \
power_sg_gating_bank 8
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[0]}] \
power_sg_gating_bank 9
set_attribute -type integer [get_cells iso14443a_inst/part4/rx_error_flag_reg] \
power_sg_gating_bank 8
set_attribute -type integer [get_cells iso14443a_inst/part4/pkt_received_reg]  \
power_sg_gating_bank 8
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/state_reg[1]}] power_sg_gating_bank  \
4
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_resend_last_reg] power_sg_gating_bank 8
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/last_bit_reg] power_sg_gating_bank 4
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_valid_reg]            \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_error_reg]                 \
power_sg_gating_bank 4
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_error_reg]                 \
power_sg_gating_bank 4
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_soc_reg] power_sg_gating_bank 6
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/in_frame_reg] power_sg_gating_bank 7
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_data_valid_reg] power_sg_gating_bank 6
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_eoc_reg]                   \
power_sg_gating_bank 3
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/seq_valid_reg] power_sg_gating_bank 7
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/detected_soc_reg] power_sg_gating_bank 7
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/in_iface_req_reg]                    \
power_sg_gating_bank 6
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/tx_inst/bc_inst/encoded_data_reg] power_sg_gating_bank 2
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg] power_sg_gating_bank 7
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/tx_inst/in_iface_req_reg] power_sg_gating_bank 2
set_attribute -type integer [get_cells {adc_sync/q_reg[0]}]                    \
power_sg_gating_bank 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[adc_read]}]                      \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_read]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_enable]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[adc_enable]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[1]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[0]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[2]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[3]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[4]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[7]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[2]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[1]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[6]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[9]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[5]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[7]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[15]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[10]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[9]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][5]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[6]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][4]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[14]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[0]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[1]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[8]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][6]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[10]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[12]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[11]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][3]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][7]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][4]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][5]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][6]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[2]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[15]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[14]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[13]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[11]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[10]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[9]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[8]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[24]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[23]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[22]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[17]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[16]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[12]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[21]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[20]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[19]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[18]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[7]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[6]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[5]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[3]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[1]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/is_AC_SELECT_for_us_reg]              \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[13]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[1]}]  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[3]}]  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_count_minus_1_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells adapter_inst/signal_control_abort_reg]  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/seq_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells iso14443a_inst/part4/send_reply_reg]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[8]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/replyStdBlock_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/replyStdBlock_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[15]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[4]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[14]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[2]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/uid_matching_reg]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells adapter_inst/signal_control_start_reg]  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_cmd_reg[1]}]                          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/reply_reg[0]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[2]}]  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/reply_reg[1]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/seq_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[1]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[0]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[16]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[15]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[14]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[11]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[9]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[6]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[2]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[19]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[17]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[13]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[12]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[10]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[7]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[0]}]  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[0]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[0]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[1]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[2]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/cache_data_reg]                       \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/seen_error_reg]                      \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[4]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[1]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[0]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[24]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[3]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[2]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[22]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_cmd_reg[0]}]                          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[21]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[18]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[8]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[23]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[20]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[5]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells iso14443a_inst/part4/our_block_num_reg] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[0]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/tx_append_crc_reg]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/error_detected_reg]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/prev_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/prev_is_soc_reg] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/crc_byte_reg]                        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_data_reg] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[unexpected_pause]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_data_reg]                       \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[2]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[1]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][3]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[0]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][7]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[0]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][6]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[0]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_reg]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[0]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[1]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/parity_reg]                          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][1]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][0]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][5]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/expected_parity_reg]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][3]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][4]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][0]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][1]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][2]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][5]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][3]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][4]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][4]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][5]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/prev_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/check_need_to_forward_to_app_reg]                         \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/data_received_reg]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[1]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][2]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][7]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_enable]}]               \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[adc_enable]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][6]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][4]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][3]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][5]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][3]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][5]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][4]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][3]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][7]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[2]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_reg]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[4]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[5]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[7]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][4]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[6]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][3]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][2]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][1]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[0]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[1]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[2]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][7]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][6]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][0]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][5]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][3]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][4]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][0]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][0]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][1]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][1]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][2]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][2]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/check_need_to_forward_to_app_after_next_byte_reg]         \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[adc_read]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[1]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[2]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[3]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[4]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[5]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[6]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[7]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_read]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/starts_adc_read_reg]                          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[3]}]             \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][5]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][2]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][1]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][0]}]            \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][2]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[10][0]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][0]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[14][0]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][7]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][6]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][5]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][4]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][3]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][2]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][1]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][7]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][6]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][5]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][4]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][3]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][2]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][1]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][0]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][5]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][2]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][0]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][1]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][2]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][3]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][4]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][5]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][0]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][7]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][6]}]    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[15]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[1]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][0]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[2]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[3]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[4]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[5]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[6]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[7]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[8]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[9]}]                 \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[10]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[11]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[12]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[13]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[14]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][4]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][3]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][1]}]                \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][7]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][6]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][4]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][3]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][1]}]     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[2]}]                  \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[13]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[12]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[11]}]          \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[8]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[4]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[3]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[0]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[5]}]           \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[10]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[9]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[8]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[7]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[6]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[5]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[4]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[3]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[2]}]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg]                     \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[15]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[14]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[13]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[12]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[11]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[10]}]                   \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[9]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[8]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[7]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[6]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[5]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[4]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[3]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[2]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[1]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[0]}]                    \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/status_flags_reg[error]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[already_busy]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[conv_complete]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[2]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[3]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[4]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[5]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[6]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[7]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[8]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[9]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[10]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[11]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[12]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[13]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[14]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[15]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[16]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[17]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[18]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[19]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[20]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[21]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[22]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[23]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[24]}] pwr_cg_count_for_register  \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/state_reg[1]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/state_reg[0]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/unexpected_pause_reg]                         \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[7]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[6]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[5]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[4]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[3]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[2]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[1]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[0]}]        \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[15]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[14]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[13]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[12]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[11]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[10]}] pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[9]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[8]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[7]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[6]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[5]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[4]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[3]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[2]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[1]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[0]}] \
pwr_cg_count_for_register 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[6]}] pwr_cg_count_for_register \
1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[5]}] pwr_cg_count_for_register \
1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[4]}] pwr_cg_count_for_register \
1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[3]}] pwr_cg_count_for_register \
1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[2]}] pwr_cg_count_for_register \
1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[1]}] pwr_cg_count_for_register \
1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[adc_read]}] pwr_cg_gating_group  \
42
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_read]}] pwr_cg_gating_group \
42
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_enable]}]                   \
pwr_cg_gating_group 42
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[adc_enable]}]                    \
pwr_cg_gating_group 42
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][0]}]                \
pwr_cg_gating_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][2]}]                \
pwr_cg_gating_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][1]}]                \
pwr_cg_gating_group 0
set_attribute -type integer [get_cells self_gate_adc_sync/q_reg_0]             \
pwr_cg_gating_group 206
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part2/tx_inst/state_reg_0] pwr_cg_gating_group 208
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/rx_count_reg_0]             \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg_0]  \
pwr_cg_gating_group 210
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fe_inst/state_reg_0]               \
pwr_cg_gating_group 212
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg_0]            \
pwr_cg_gating_group 213
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_error_flag_reg_0] pwr_cg_gating_group 214
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_count_reg_0] pwr_cg_gating_group 215
set_attribute -type integer [get_cells                                         \
self_gate_adapter_inst/tx_iface_data_valid_reg_0] pwr_cg_gating_group 217
set_attribute -type integer [get_cells                                         \
self_gate_pause_n_latch_sync/sync_inst/tmp_reg_0] pwr_cg_gating_group 218
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
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[7]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[1]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[0]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[2]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[3]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][4]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][2]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][6]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][3]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][1]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][0]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[4]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][5]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][3]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][5]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][4]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][1]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][4]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][7]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][7]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][6]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][0]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][3]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][7]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][3]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][6]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][2]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][0]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][2]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][1]}]     \
pwr_cg_gating_group 4
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[7]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[2]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[1]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[6]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[9]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][5]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][1]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[5]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][6]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][7]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][2]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][0]}]     \
pwr_cg_gating_group 3
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][4]}]     \
pwr_cg_gating_group 5
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][5]}]     \
pwr_cg_gating_group 2
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[7]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[15]}]          \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[10]}]          \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][2]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[9]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][5]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[6]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][4]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[14]}]          \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[0]}]        \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][0]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[1]}]        \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[8]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][6]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[10]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][1]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[12]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[11]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][3]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][7]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][7]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][3]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][4]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][5]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][6]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][2]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][1]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][4]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][6]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][0]}]                \
pwr_cg_gating_group 7
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][5]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[6]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[2]}]        \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[15]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][2]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[14]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[13]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[11]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[10]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[9]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[8]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[24]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[23]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[22]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[17]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[16]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[12]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[21]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[20]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[19]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[18]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[7]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[6]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[5]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[3]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[1]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/is_AC_SELECT_for_us_reg]              \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[13]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[1]}]  \
pwr_cg_gating_group 10
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[3]}]  \
pwr_cg_gating_group 10
set_attribute -type integer [get_cells                                         \
{pause_n_latch_sync/sync_inst/q_reg[0]}] pwr_cg_gating_group 218
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/pause_n_synchronised_old_reg]                 \
pwr_cg_gating_group 218
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_count_minus_1_reg[0]}] pwr_cg_gating_group 40
set_attribute -type integer [get_cells adapter_inst/signal_control_abort_reg]  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/seq_reg[0]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[2]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][0]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells iso14443a_inst/part4/send_reply_reg]    \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[0]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[8]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[5]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[1]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][1]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][1]}]     \
pwr_cg_gating_group 9
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[7]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][3]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/idle_reg] pwr_cg_gating_group 218
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[4]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/replyStdBlock_reg[1]}] pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/replyStdBlock_reg[0]}] pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[15]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[4]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[14]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[2]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/uid_matching_reg] pwr_cg_gating_group \
11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[3]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells adapter_inst/signal_control_start_reg]  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_cmd_reg[1]}] pwr_cg_gating_group 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/reply_reg[0]}]    \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][3]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[2]}]  \
pwr_cg_gating_group 10
set_attribute -type integer [get_cells {iso14443a_inst/part4/reply_reg[1]}]    \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/seq_reg[1]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][0]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][0]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[1]}]            \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][1]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][6]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[0]}]            \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][7]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[16]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[15]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[14]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[11]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[9]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[6]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][2]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[2]}]            \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][4]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[19]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[17]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[13]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[12]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[10]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[7]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[0]}]  \
pwr_cg_gating_group 10
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][4]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[0]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][2]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][6]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][2]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][4]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][0]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][1]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][7]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][5]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][3]}] pwr_cg_gating_group 14
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[0]}]                   \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[1]}]                   \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][5]}] pwr_cg_gating_group 13
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[2]}]                   \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/cache_data_reg] pwr_cg_gating_group   \
11
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/seen_error_reg] pwr_cg_gating_group  \
11
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[4]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[1]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[0]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[24]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[3]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[2]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[22]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_cmd_reg[0]}] pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[21]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[18]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[8]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[23]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[20]}]           \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[5]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][7]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][6]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][5]}] pwr_cg_gating_group 12
set_attribute -type integer [get_cells iso14443a_inst/part4/our_block_num_reg] \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[0]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/tx_append_crc_reg]                    \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/error_detected_reg]                  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/prev_reg[1]}] pwr_cg_gating_group 15
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/prev_is_soc_reg] pwr_cg_gating_group 15
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/crc_byte_reg] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_data_reg] pwr_cg_gating_group 15
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[unexpected_pause]}] pwr_cg_gating_group 36
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_data_reg] pwr_cg_gating_group   \
11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[2]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[1]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][0]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][1]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][3]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[0]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[5]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[2]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[6]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[1]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[3]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[4]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[0]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][7]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[0]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][6]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[0]}]          \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_reg]                  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[0]}]                  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[1]}]          \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/parity_reg] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][1]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][0]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][5]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/expected_parity_reg]                 \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][3]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][4]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][0]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][1]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][2]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][5]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][3]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][4]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][1]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][2]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][4]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][5]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/prev_reg[0]}] pwr_cg_gating_group 15
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/check_need_to_forward_to_app_reg] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/data_received_reg]                   \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][2]}]                \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][6]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][0]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[1]}]                  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][2]}]          \
pwr_cg_gating_group 20
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][7]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][3]}] pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][7]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][6]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][5]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_enable]}]               \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[adc_enable]}]                \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][3]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][4]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][0]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][6]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][4]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][3]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][1]}]                \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][5]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][3]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][2]}]                \
pwr_cg_gating_group 24
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][1]}]                \
pwr_cg_gating_group 24
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][5]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][4]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][3]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][2]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][1]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][7]}]                \
pwr_cg_gating_group 8
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][0]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][2]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][1]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][0]}]                \
pwr_cg_gating_group 22
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[2]}]          \
pwr_cg_gating_group 21
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_reg]                  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[4]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[5]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[7]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][4]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][7]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][6]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][5]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][4]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][3]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][2]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[6]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][1]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][3]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][2]}]          \
pwr_cg_gating_group 26
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][1]}]          \
pwr_cg_gating_group 26
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[0]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[1]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[2]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][7]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][6]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][5]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][4]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][3]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][2]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][1]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][7]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][6]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][0]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][5]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][3]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][4]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][0]}]          \
pwr_cg_gating_group 26
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][0]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][1]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][1]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][2]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][2]}]          \
pwr_cg_gating_group 18
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/check_need_to_forward_to_app_after_next_byte_reg]         \
pwr_cg_gating_group 40
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[adc_read]}]                  \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][7]}] pwr_cg_gating_group 23
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[1]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[2]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[3]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[4]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[5]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[6]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[7]}]                 \
pwr_cg_gating_group 17
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_read]}]                 \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/starts_adc_read_reg] pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[3]}]             \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][5]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][2]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][1]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][0]}]            \
pwr_cg_gating_group 1
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][2]}] pwr_cg_gating_group 16
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][2]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[10][0]}]    \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][0]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[14][0]}]    \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][0]}]     \
pwr_cg_gating_group 27
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][7]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][6]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][5]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][2]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][0]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][7]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][6]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][5]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][4]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][3]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][2]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][1]}]    \
pwr_cg_gating_group 29
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][7]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][6]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][5]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][4]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][3]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][2]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][1]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][0]}]     \
pwr_cg_gating_group 31
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][7]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][6]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][5]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][4]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][3]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][2]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][1]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][0]}]    \
pwr_cg_gating_group 32
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][5]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][2]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][0]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][0]}]     \
pwr_cg_gating_group 25
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][1]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][2]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][3]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][4]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][5]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][0]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][7]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][6]}]    \
pwr_cg_gating_group 34
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[15]}]                \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[1]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][0]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][0]}]                \
pwr_cg_gating_group 24
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[2]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[3]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[4]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[5]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[6]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[7]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[8]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[9]}]                 \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[10]}]                \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[11]}]                \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[12]}]                \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[13]}]                \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[14]}]                \
pwr_cg_gating_group 19
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][4]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][3]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][1]}]                \
pwr_cg_gating_group 28
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][4]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][3]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][1]}]     \
pwr_cg_gating_group 30
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][7]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][6]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][4]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][3]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][1]}]     \
pwr_cg_gating_group 33
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[2]}]                  \
pwr_cg_gating_group 11
set_attribute -type integer [get_cells                                         \
{pause_n_latch_sync/sync_inst/tmp_reg[0]}] pwr_cg_gating_group 218
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[13]}]          \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[12]}]          \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[11]}]          \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[8]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[4]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[3]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[0]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[5]}]           \
pwr_cg_gating_group 6
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[10]}]                    \
pwr_cg_gating_group 41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[9]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[8]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[7]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[6]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[5]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[4]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[3]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[2]}] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg] pwr_cg_gating_group \
41
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[15]}]                   \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[14]}]                   \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[13]}]                   \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[12]}]                   \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[11]}]                   \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[10]}]                   \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[9]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[8]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[7]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[6]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[5]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[4]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[3]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[2]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[1]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[0]}]                    \
pwr_cg_gating_group 35
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg]              \
pwr_cg_gating_group 210
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_valid_reg]            \
pwr_cg_gating_group 212
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/state_reg[1]}] pwr_cg_gating_group  \
212
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/state_reg[1]}] pwr_cg_gating_group 208
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/state_reg[0]}] pwr_cg_gating_group 208
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/forward_from_app_reg] pwr_cg_gating_group 206
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/tx_iface_data_valid_reg] pwr_cg_gating_group 206
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[1]}]           \
pwr_cg_gating_group 217
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[2]}]           \
pwr_cg_gating_group 217
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[3]}]           \
pwr_cg_gating_group 217
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[0]}]           \
pwr_cg_gating_group 217
set_attribute -type integer [get_cells adapter_inst/tx_iface_data_valid_reg]   \
pwr_cg_gating_group 217
set_attribute -type integer [get_cells adapter_inst/send_reply_reg]            \
pwr_cg_gating_group 206
set_attribute -type integer [get_cells                                         \
adapter_inst/last_rx_had_invalid_magic_reg] pwr_cg_gating_group 215
set_attribute -type integer [get_cells adapter_inst/rx_error_flag_reg]         \
pwr_cg_gating_group 215
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_error_reg] pwr_cg_gating_group 214
set_attribute -type integer [get_cells {adapter_inst/status_flags_reg[error]}] \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[already_busy]}] pwr_cg_gating_group 36
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[conv_complete]}] pwr_cg_gating_group 36
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[2]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[3]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[4]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[5]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[6]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[7]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[8]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[9]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[10]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[11]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[12]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[13]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[1]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[14]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[15]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[16]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[17]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[18]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[19]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[20]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[21]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[22]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[23]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[24]}] pwr_cg_gating_group 38
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/state_reg[1]}] pwr_cg_gating_group 42
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/state_reg[0]}] pwr_cg_gating_group 42
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/unexpected_pause_reg] pwr_cg_gating_group 42
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[7]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[6]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[5]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[4]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[3]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[2]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[1]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[0]}]        \
pwr_cg_gating_group 36
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[1]}]         \
pwr_cg_gating_group 215
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[2]}]         \
pwr_cg_gating_group 215
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[0]}]         \
pwr_cg_gating_group 215
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_data_valid_reg] pwr_cg_gating_group 215
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_eoc_reg] pwr_cg_gating_group 214
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/forward_to_app_reg] pwr_cg_gating_group 214
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_soc_reg] pwr_cg_gating_group 214
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/state_star_reg] pwr_cg_gating_group   \
210
set_attribute -type integer [get_cells iso14443a_inst/part4/rx_deselect_reg]   \
pwr_cg_gating_group 210
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_tx_iface_req_reg] pwr_cg_gating_group 206
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_start_reg] pwr_cg_gating_group  \
212
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_sample_reg] pwr_cg_gating_group \
212
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_type_reg] pwr_cg_gating_group   \
212
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/rx_error_flag_reg]                    \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[1]}]                    \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[0]}]                    \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[2]}]                    \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/pkt_received_reg] pwr_cg_gating_group \
209
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/in_iface_req_reg] pwr_cg_gating_group \
209
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/state_reg[0]}] pwr_cg_gating_group   \
210
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[2]}] \
pwr_cg_gating_group 215
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[1]}] \
pwr_cg_gating_group 214
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[0]}] \
pwr_cg_gating_group 215
set_attribute -type integer [get_cells iso14443a_inst/part4/rx_error_flag_reg] \
pwr_cg_gating_group 214
set_attribute -type integer [get_cells iso14443a_inst/part4/pkt_received_reg]  \
pwr_cg_gating_group 214
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/state_reg[1]}] pwr_cg_gating_group   \
210
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[15]}] pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[14]}] pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[13]}] pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[12]}] pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[11]}] pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[10]}] pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[9]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[8]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[7]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[6]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[5]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[4]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[3]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[2]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[1]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[0]}] \
pwr_cg_gating_group 37
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_resend_last_reg] pwr_cg_gating_group 214
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/last_bit_reg] pwr_cg_gating_group    \
210
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_valid_reg]            \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_error_reg]                 \
pwr_cg_gating_group 210
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_error_reg]                 \
pwr_cg_gating_group 210
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_soc_reg] pwr_cg_gating_group 212
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/in_frame_reg] pwr_cg_gating_group 213
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_data_valid_reg] pwr_cg_gating_group 212
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_eoc_reg]                   \
pwr_cg_gating_group 209
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/seq_valid_reg] pwr_cg_gating_group 213
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/detected_soc_reg] pwr_cg_gating_group 213
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/in_iface_req_reg]                    \
pwr_cg_gating_group 212
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/tx_inst/bc_inst/encoded_data_reg] pwr_cg_gating_group 208
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg] pwr_cg_gating_group    \
213
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[6]}] pwr_cg_gating_group 43
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[5]}] pwr_cg_gating_group 43
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[4]}] pwr_cg_gating_group 43
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[3]}] pwr_cg_gating_group 43
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[2]}] pwr_cg_gating_group 43
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[1]}] pwr_cg_gating_group 43
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/tx_inst/in_iface_req_reg] pwr_cg_gating_group 208
set_attribute -type integer [get_cells {adc_sync/q_reg[0]}]                    \
pwr_cg_gating_group 206
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[adc_read]}]                      \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_read]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_enable]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[adc_enable]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/signals_reg[sens_config][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells self_gate_adc_sync/q_reg_0]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part2/tx_inst/state_reg_0] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/rx_count_reg_0]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg_0]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fe_inst/state_reg_0]               \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg_0]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_error_flag_reg_0] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_iso14443a_inst/part4/rx_count_reg_0] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_adapter_inst/tx_iface_data_valid_reg_0] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
self_gate_pause_n_latch_sync/sync_inst/tmp_reg_0] pwr_cg_gating_sub_group 0
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
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[1]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[0]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[2]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[3]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[4]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[3][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[7]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[2]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[1]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[6]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[9]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[5]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[1][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[0][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[2][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[7]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[15]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[10]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[9]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][5]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[6]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][4]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[14]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[0]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[1]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[8]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][6]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[10]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[12]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[11]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][3]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][7]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][4]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][5]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][6]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[2]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[15]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[14]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[13]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[11]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[10]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[9]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[8]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[24]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[23]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[22]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[17]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[16]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[12]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[21]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[20]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[19]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[18]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[7]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[6]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[5]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[3]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[1]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/is_AC_SELECT_for_us_reg]              \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[13]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[1]}]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[3]}]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{pause_n_latch_sync/sync_inst/q_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/pause_n_synchronised_old_reg]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_count_minus_1_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells adapter_inst/signal_control_abort_reg]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/seq_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells iso14443a_inst/part4/send_reply_reg]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[8]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[4][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/idle_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/replyStdBlock_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/replyStdBlock_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[15]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[4]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[14]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[2]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/uid_matching_reg]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/counter_reg[3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells adapter_inst/signal_control_start_reg]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_cmd_reg[1]}] pwr_cg_gating_sub_group  \
0
set_attribute -type integer [get_cells {iso14443a_inst/part4/reply_reg[0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[2]}]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/reply_reg[1]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/seq_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[1]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[0]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[16]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[15]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[14]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[11]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[9]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[6]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[2]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[19]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[17]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[13]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[12]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[10]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[7]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/our_cid_reg[0]}]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[0]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[2][3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[0]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[1]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[0][5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[2]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/cache_data_reg]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/seen_error_reg]                      \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[4]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[1]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[0]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[24]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[3]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[2]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[22]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_cmd_reg[0]}] pwr_cg_gating_sub_group  \
0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[21]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[18]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[8]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[23]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[20]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[5]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/rx_buffer_reg[1][5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells iso14443a_inst/part4/our_block_num_reg] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[0]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/tx_append_crc_reg]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/error_detected_reg]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/prev_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/prev_is_soc_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/crc_byte_reg]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_data_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[unexpected_pause]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_data_reg]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[2]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[1]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][3]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/app_rx_iface_data_reg[4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[0]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][7]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[0]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][6]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_reg]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[0]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/parity_reg] pwr_cg_gating_sub_group  \
0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][5]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/expected_parity_reg]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][3]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][4]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][2]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][5]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][3]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][4]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][4]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][5]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/sd_inst/prev_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/check_need_to_forward_to_app_reg] pwr_cg_gating_sub_group \
0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/data_received_reg]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[1]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][2]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][7]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_enable]}]               \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[adc_enable]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][6]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][4]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][3]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][5]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][3]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][5]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][4]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][3]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][7]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[2]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_reg]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[4]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[5]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[7]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][4]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[6]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][3]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][2]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[0]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[1]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[2]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][7]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][6]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][5]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][3]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][4]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][0]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][1]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][2]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][2]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/check_need_to_forward_to_app_after_next_byte_reg]         \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[adc_read]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[0][7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[1]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[2]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[3]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[4]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[5]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[6]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[7]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_read]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/starts_adc_read_reg] pwr_cg_gating_sub_group  \
0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[3]}]             \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][5]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][2]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][1]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][0]}]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part4/tx_buffer_reg[1][2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][2]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[10][0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[14][0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[8][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][7]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][6]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][5]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][4]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][3]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][2]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[12][1]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[9][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][7]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][6]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][5]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][4]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][3]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][2]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][1]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[11][0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][5]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][2]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[7][0]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][1]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][2]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][3]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][4]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][5]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][0]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][7]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[13][6]}]    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[15]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[1]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][0]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[2]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[3]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[4]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[5]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[6]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[7]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[8]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[9]}]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[10]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[11]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[12]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[13]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[14]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][4]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][3]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][1]}]                \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[6][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][7]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][6]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][4]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][3]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_buffer_reg[5][1]}]     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[2]}]                  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{pause_n_latch_sync/sync_inst/tmp_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[13]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[12]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[11]}]          \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[8]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[4]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[3]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[0]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[5]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[10]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[9]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[8]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[7]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[6]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[5]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[4]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[3]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[2]}]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[15]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[14]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[13]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[12]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[11]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[10]}]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[9]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[8]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[7]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[6]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[5]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[4]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[3]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[2]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[1]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/cached_adc_value_reg[0]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg]              \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_valid_reg]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/framing_inst/fe_inst/state_reg[1]}]                      \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/state_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/state_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/forward_from_app_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/tx_iface_data_valid_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[1]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[2]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[3]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/tx_idx_reg[0]}]           \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells adapter_inst/tx_iface_data_valid_reg]   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells adapter_inst/send_reply_reg]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
adapter_inst/last_rx_had_invalid_magic_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells adapter_inst/rx_error_flag_reg]         \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_error_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/status_flags_reg[error]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[already_busy]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/status_flags_reg[conv_complete]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[7]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[8]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[9]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[10]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[11]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[12]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[13]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[14]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[15]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[16]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[17]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[18]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[19]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[20]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[21]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[22]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[23]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/counter_reg[24]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/state_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/signal_control_inst/state_reg[0]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
adapter_inst/signal_control_inst/unexpected_pause_reg] pwr_cg_gating_sub_group \
0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[7]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[6]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[5]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[4]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[3]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[2]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[1]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/reply_cmd_reg[0]}]        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[1]}]         \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[2]}]         \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/rx_count_reg[0]}]         \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_data_valid_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_eoc_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/forward_to_app_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_rx_iface_soc_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/state_star_reg]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells iso14443a_inst/part4/rx_deselect_reg]   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_tx_iface_req_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_start_reg]                      \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_sample_reg]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/crc_inst/crc_type_reg]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/rx_error_flag_reg]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[1]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[0]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[2]}]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/initialisation_inst/pkt_received_reg]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/s_inst/in_iface_req_reg]                     \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/state_reg[0]}]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[2]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[1]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {iso14443a_inst/part4/rx_count_reg[0]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells iso14443a_inst/part4/rx_error_flag_reg] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells iso14443a_inst/part4/pkt_received_reg]  \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part3/initialisation_inst/state_reg[1]}]                       \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[15]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[14]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[13]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[12]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[11]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{adapter_inst/cached_adc_value_reg[10]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[9]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[8]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[7]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[6]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[5]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[4]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[3]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[2]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[1]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adapter_inst/cached_adc_value_reg[0]}] \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part4/app_resend_last_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/last_bit_reg]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_valid_reg]            \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_error_reg]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_error_reg]                 \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_soc_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/in_frame_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/out_iface_data_valid_reg] pwr_cg_gating_sub_group \
0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_eoc_reg]                   \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/seq_valid_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/sd_inst/detected_soc_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fe_inst/in_iface_req_reg]                    \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/tx_inst/bc_inst/encoded_data_reg] pwr_cg_gating_sub_group \
0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg]                        \
pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[6]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[5]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[4]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[3]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[2]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[1]}] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells                                         \
iso14443a_inst/part2/tx_inst/in_iface_req_reg] pwr_cg_gating_sub_group 0
set_attribute -type integer [get_cells {adc_sync/q_reg[0]}]                    \
pwr_cg_gating_sub_group 0
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[adc_read]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[sens_read]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[sens_enable]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[adc_enable]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[sens_config][0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[sens_config][2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/signals_reg[sens_config][1]}] 17
set_register_merging [get_cells self_gate_adc_sync/q_reg_0] 17
set_register_merging [get_cells                                                \
self_gate_iso14443a_inst/part2/tx_inst/state_reg_0] 17
set_register_merging [get_cells                                                \
self_gate_iso14443a_inst/part3/initialisation_inst/rx_count_reg_0] 17
set_register_merging [get_cells                                                \
self_gate_iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg_0]  \
17
set_register_merging [get_cells                                                \
self_gate_iso14443a_inst/part3/framing_inst/fe_inst/state_reg_0] 17
set_register_merging [get_cells                                                \
self_gate_iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg_0] 17
set_register_merging [get_cells                                                \
self_gate_iso14443a_inst/part4/rx_error_flag_reg_0] 17
set_register_merging [get_cells self_gate_iso14443a_inst/part4/rx_count_reg_0] \
17
set_register_merging [get_cells                                                \
self_gate_adapter_inst/tx_iface_data_valid_reg_0] 17
set_register_merging [get_cells                                                \
self_gate_pause_n_latch_sync/sync_inst/tmp_reg_0] 17
set_register_merging [get_cells {reset_synchroniser/shift_reg_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[7]}] 17
set_register_merging [get_cells iso14443a_inst/part2/tx_inst/lm_out_reg] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[3][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[9]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[1][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[0][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[2][5]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[15]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[10]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[9]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][5]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[14]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[8]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][6]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[10]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[12]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[11]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][5]}] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[6]}] \
17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[15]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[14]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[13]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[11]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[10]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[9]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[8]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[24]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[23]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[22]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[17]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[16]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[12]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[21]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[20]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[19]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[18]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[7]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[6]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[5]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[3]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[1]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/is_AC_SELECT_for_us_reg] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_sync_timing_reg[13]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/our_cid_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/our_cid_reg[3]}] 17
set_register_merging [get_cells {pause_n_latch_sync/sync_inst/q_reg[0]}] 17
set_register_merging [get_cells                                                \
adapter_inst/signal_control_inst/pause_n_synchronised_old_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/tx_count_minus_1_reg[0]}] 17
set_register_merging [get_cells adapter_inst/signal_control_abort_reg] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/seq_reg[0]}] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[2]}] \
17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][0]}] 17
set_register_merging [get_cells iso14443a_inst/part4/send_reply_reg] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[0]}] \
17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[8]}] \
17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[5]}] \
17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[1]}] \
17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[4][1]}] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[7]}] \
17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][3]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/s_inst/idle_reg] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[4]}] \
17
set_register_merging [get_cells {iso14443a_inst/part4/replyStdBlock_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/replyStdBlock_reg[0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[15]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[4]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[14]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[2]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/uid_matching_reg] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/counter_reg[3]}] \
17
set_register_merging [get_cells adapter_inst/signal_control_start_reg] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_cmd_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/reply_reg[0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][3]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/our_cid_reg[2]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/reply_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/seq_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[1]}] 2
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[0]}] 2
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][7]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[16]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[15]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[14]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[11]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[9]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[6]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[2]}] 2
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][4]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[19]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[17]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[13]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[12]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[10]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[7]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/our_cid_reg[0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][4]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][2]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][6]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][2]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][4]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][7]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][5]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[2][3]}] 17
set_register_merging [get_cells iso14443a_inst/part2/sd_inst/idle_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[0][5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[2]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/s_inst/cache_data_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/ds_inst/seen_error_reg] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[4]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[24]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[3]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[22]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_cmd_reg[0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[21]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[18]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[8]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[23]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[20]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[5]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][7]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][6]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_buffer_reg[1][5]}] 17
set_register_merging [get_cells iso14443a_inst/part4/our_block_num_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[0]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/tx_append_crc_reg] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/error_detected_reg] 17
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/prev_reg[1]}] 17
set_register_merging [get_cells iso14443a_inst/part2/sd_inst/prev_is_soc_reg]  \
17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fe_inst/crc_byte_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part2/sd_inst/out_iface_data_reg] 17
set_register_merging [get_cells                                                \
{adapter_inst/status_flags_reg[unexpected_pause]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/crc_inst/crc_data_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[1][0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[1][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part4/app_rx_iface_data_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[0]}] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[1]}] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fe_inst/parity_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][5]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/expected_parity_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][4]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][4]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][5]}] 2
set_register_merging [get_cells {iso14443a_inst/part2/sd_inst/prev_reg[0]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part4/check_need_to_forward_to_app_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/data_received_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][2]}] 2
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][6]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][7]}] 2
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][3]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[1][7]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[1][6]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][5]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[sens_enable]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[adc_enable]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[1][3]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][0]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][6]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][4]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][3]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][1]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][5]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][3]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][2]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][1]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][5]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][4]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][3]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][2]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][1]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][0]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][2]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][1]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][0]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[2]}] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][7]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][6]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][2]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part4/check_need_to_forward_to_app_after_next_byte_reg] 2
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[adc_read]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[0][7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[7]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[sens_read]}] 17
set_register_merging [get_cells                                                \
adapter_inst/signal_control_inst/starts_adc_read_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][5]}] 2
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][0]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/tx_buffer_reg[1][2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][2]}] 2
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[10][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[14][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[8][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[12][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[9][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[11][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[7][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][2]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][5]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][0]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[13][6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[15]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][0]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][0]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[8]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[9]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[10]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[11]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[12]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[13]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[14]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][4]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][3]}] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][1]}] 2
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[6][1]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][7]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][6]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][4]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][3]}] 17
set_register_merging [get_cells {adapter_inst/rx_buffer_reg[5][1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[2]}] 17
set_register_merging [get_cells {pause_n_latch_sync/sync_inst/tmp_reg[0]}] 17
set_register_merging [get_cells iso14443a_inst/part4/allow_pps_reg] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[13]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[12]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[11]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[8]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[10]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[9]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[8]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[7]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[0]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[15]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[14]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[13]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[12]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[11]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[10]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[9]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[8]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[7]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[6]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[5]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[4]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[3]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/cached_adc_value_reg[0]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_valid_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/state_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/state_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/framing_inst/fe_inst/state_reg[0]}] 17
set_register_merging [get_cells {iso14443a_inst/part2/tx_inst/state_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part2/tx_inst/state_reg[0]}] 17
set_register_merging [get_cells pause_n_latch_sync/pause_n_latched_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/forward_from_app_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/tx_iface_data_valid_reg]  \
17
set_register_merging [get_cells {adapter_inst/tx_idx_reg[1]}] 17
set_register_merging [get_cells {adapter_inst/tx_idx_reg[2]}] 17
set_register_merging [get_cells {adapter_inst/tx_idx_reg[3]}] 17
set_register_merging [get_cells {adapter_inst/tx_idx_reg[0]}] 17
set_register_merging [get_cells adapter_inst/tx_iface_data_valid_reg] 17
set_register_merging [get_cells adapter_inst/send_reply_reg] 17
set_register_merging [get_cells adapter_inst/last_rx_had_invalid_magic_reg] 17
set_register_merging [get_cells adapter_inst/rx_error_flag_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/app_rx_iface_error_reg] 17
set_register_merging [get_cells {adapter_inst/status_flags_reg[error]}] 17
set_register_merging [get_cells {adapter_inst/status_flags_reg[already_busy]}] \
17
set_register_merging [get_cells                                                \
{adapter_inst/status_flags_reg[conv_complete]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[3]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[4]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[5]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[6]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[7]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[8]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[9]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[10]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[11]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[12]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[13]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[14]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[15]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[16]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[17]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[18]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[19]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[20]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[21]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[22]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[23]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[24]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/counter_reg[0]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/state_reg[1]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/state_reg[2]}] 17
set_register_merging [get_cells                                                \
{adapter_inst/signal_control_inst/state_reg[0]}] 17
set_register_merging [get_cells                                                \
adapter_inst/signal_control_inst/unexpected_pause_reg] 17
set_register_merging [get_cells adapter_inst/signal_control_result_read_reg] 17
set_register_merging [get_cells                                                \
adapter_inst/signal_control_inst/cached_adc_conversion_complete_reg] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[7]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[6]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[5]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[4]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[3]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[2]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[1]}] 17
set_register_merging [get_cells {adapter_inst/reply_cmd_reg[0]}] 17
set_register_merging [get_cells {adapter_inst/rx_count_reg[1]}] 17
set_register_merging [get_cells {adapter_inst/rx_count_reg[2]}] 17
set_register_merging [get_cells {adapter_inst/rx_count_reg[3]}] 17
set_register_merging [get_cells {adapter_inst/rx_count_reg[4]}] 17
set_register_merging [get_cells {adapter_inst/rx_count_reg[0]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part4/app_rx_iface_data_valid_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/app_rx_iface_eoc_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/forward_to_app_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/app_rx_iface_soc_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/state_star_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/rx_deselect_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/app_tx_iface_req_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/crc_inst/crc_start_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/crc_inst/crc_sample_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/crc_inst/crc_type_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/rx_error_flag_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[0]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[2]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/initialisation_inst/pkt_received_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/s_inst/in_iface_req_reg] 2
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/state_reg[0]}] 2
set_register_merging [get_cells {iso14443a_inst/part4/rx_count_reg[2]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_count_reg[1]}] 17
set_register_merging [get_cells {iso14443a_inst/part4/rx_count_reg[0]}] 17
set_register_merging [get_cells iso14443a_inst/part4/rx_error_flag_reg] 17
set_register_merging [get_cells iso14443a_inst/part4/pkt_received_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part3/initialisation_inst/state_reg[1]}] 2
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[15]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[14]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[13]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[12]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[11]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[10]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[9]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[8]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[7]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[6]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[5]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[4]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[3]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[2]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[1]}] 17
set_register_merging [get_cells {adapter_inst/cached_adc_value_reg[0]}] 17
set_register_merging [get_cells iso14443a_inst/part4/app_resend_last_reg] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/last_bit_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/next_bit_is_parity_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_valid_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_valid_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_error_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_error_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part2/sd_inst/out_iface_soc_reg] 2
set_register_merging [get_cells iso14443a_inst/part2/sd_inst/in_frame_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part2/sd_inst/out_iface_data_valid_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_eoc_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_eoc_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part2/sd_inst/out_iface_eoc_reg] 2
set_register_merging [get_cells                                                \
iso14443a_inst/part2/sd_inst/out_iface_error_reg] 17
set_register_merging [get_cells iso14443a_inst/part2/sd_inst/seq_valid_reg] 17
set_register_merging [get_cells iso14443a_inst/part2/sd_inst/detected_soc_reg] \
17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fe_inst/in_iface_req_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part2/tx_inst/bc_inst/encoded_data_reg] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[6]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[5]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[4]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[3]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/bc_inst/count_reg[0]}] 17
set_register_merging [get_cells                                                \
iso14443a_inst/part2/tx_inst/sc_inst/subcarrier_reg] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/sc_inst/count_reg[2]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/sc_inst/count_reg[1]}] 17
set_register_merging [get_cells                                                \
{iso14443a_inst/part2/tx_inst/sc_inst/count_reg[0]}] 17
set_register_merging [get_cells iso14443a_inst/part2/tx_inst/in_iface_req_reg] \
2
set_register_merging [get_cells {adc_sync/q_reg[0]}] 17
set_register_merging [get_cells {adc_sync/tmp_reg[0]}] 17
set_register_merging [get_cells {reset_synchroniser/shift_reg_reg[0]}] 17
set compile_inbound_cell_optimization false
set compile_inbound_max_cell_percentage 10.0
