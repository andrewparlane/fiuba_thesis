if { [namespace current] != {::60F1F07D} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for scenario constraints on Fri Jul 16 \
17:47:57 2021

###################################################################

# Set the current_design #
current_design radiation_sensor_digital_top


set_tlu_plus_files -max_tluplus                                                \
/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/synopsys/v8_0/TLUplus/v8_0_1/xh018_xx43_MET4_METMID_METTHK_max.tlu \
-min_tluplus                                                                   \
/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/synopsys/v8_0/TLUplus/v8_0_1/xh018_xx43_MET4_METMID_METTHK_min.tlu \
-tech2itf_map                                                                  \
/usr/pdks/xfab180/PDK/XFAB_snps_CustomDesigner_kit_v2_2_2/xh018/synopsys/v8_0/TLUplus/v8_0_1/xh018_xx43_MET4_METMID_METTHK.map \

set_operating_conditions -max slow_1_62V_125C -max_library                     \
D_CELLS_HD_LPMOS_slow_1_62V_125C\
                         -min fast_1_98V_m40C -min_library                     \
D_CELLS_HD_LPMOS_fast_1_98V_m40C
set_driving_cell -lib_cell INHDX1 [get_ports clk]
set_driving_cell -lib_cell INHDX1 [get_ports rst_n_async]
set_driving_cell -lib_cell INHDX1 [get_ports {power[1]}]
set_driving_cell -lib_cell INHDX1 [get_ports {power[0]}]
set_driving_cell -lib_cell INHDX1 [get_ports pause_n_async]
set_driving_cell -lib_cell INHDX1 [get_ports {afe_version[3]}]
set_driving_cell -lib_cell INHDX1 [get_ports {afe_version[2]}]
set_driving_cell -lib_cell INHDX1 [get_ports {afe_version[1]}]
set_driving_cell -lib_cell INHDX1 [get_ports {afe_version[0]}]
set_driving_cell -lib_cell INHDX1 [get_ports {uid_variable[2]}]
set_driving_cell -lib_cell INHDX1 [get_ports {uid_variable[1]}]
set_driving_cell -lib_cell INHDX1 [get_ports {uid_variable[0]}]
set_driving_cell -lib_cell INHDX1 [get_ports {sens_version[3]}]
set_driving_cell -lib_cell INHDX1 [get_ports {sens_version[2]}]
set_driving_cell -lib_cell INHDX1 [get_ports {sens_version[1]}]
set_driving_cell -lib_cell INHDX1 [get_ports {sens_version[0]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_version[3]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_version[2]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_version[1]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_version[0]}]
set_driving_cell -lib_cell INHDX1 [get_ports adc_conversion_complete_async]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[15]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[14]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[13]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[12]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[11]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[10]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[9]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[8]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[7]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[6]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[5]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[4]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[3]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[2]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[1]}]
set_driving_cell -lib_cell INHDX1 [get_ports {adc_value[0]}]
set_load -pin_load 0.4 [get_ports lm_out]
set_load -pin_load 0.4 [get_ports {sens_config[2]}]
set_load -pin_load 0.4 [get_ports {sens_config[1]}]
set_load -pin_load 0.4 [get_ports {sens_config[0]}]
set_load -pin_load 0.4 [get_ports sens_enable]
set_load -pin_load 0.4 [get_ports sens_read]
set_load -pin_load 0.4 [get_ports adc_enable]
set_load -pin_load 0.4 [get_ports adc_read]
set_switching_activity -period 1 -toggle_rate 0.0241367 -static_probability    \
0.555233 [get_ports clk]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports rst_n_async]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.561501 [get_ports {power[1]}]
set_switching_activity -period 1 -toggle_rate 2.12468e-07 -static_probability  \
0.601203 [get_ports {power[0]}]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.907959 [get_ports pause_n_async]
set_switching_activity -period 1 -toggle_rate 0.000356097 -static_probability  \
0.104989 [get_ports lm_out]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {afe_version[3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {afe_version[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {afe_version[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {afe_version[0]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {uid_variable[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {uid_variable[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {uid_variable[0]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {sens_version[3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {sens_version[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {sens_version[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {sens_version[0]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {sens_config[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {sens_config[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {sens_config[0]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527312 [get_ports sens_enable]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527204 [get_ports sens_read]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {adc_version[3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {adc_version[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_ports {adc_version[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_ports {adc_version[0]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527312 [get_ports adc_enable]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527097 [get_ports adc_read]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
9.80009e-06 [get_ports adc_conversion_complete_async]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.258425 [get_ports {adc_value[15]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.347959 [get_ports {adc_value[14]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_ports {adc_value[13]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.521939 [get_ports {adc_value[12]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_ports {adc_value[11]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.347959 [get_ports {adc_value[10]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.347959 [get_ports {adc_value[9]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_ports {adc_value[8]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_ports {adc_value[7]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_ports {adc_value[6]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_ports {adc_value[5]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_ports {adc_value[4]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.606384 [get_ports {adc_value[3]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_ports {adc_value[2]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.347959 [get_ports {adc_value[1]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.432405 [get_ports {adc_value[0]}]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.0937655 [get_pins pause_n_latch_sync/pause_n_latched_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[26]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[25]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[22]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[21]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[18]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[16]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[7]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[4]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[0]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167413 [get_nets {adapter_inst/set_signal_req_args[sync][15]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.22572 [get_nets {adapter_inst/set_signal_req_args[sync][14]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167413 [get_nets {adapter_inst/set_signal_req_args[sync][12]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.72096 [get_nets {adapter_inst/set_signal_req_args[sync][11]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.941693 [get_nets {adapter_inst/set_signal_req_args[sync][9]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167859 [get_nets {adapter_inst/set_signal_req_args[sync][4]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.111906 [get_nets {adapter_inst/set_signal_req_args[sync][3]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.170351 [get_nets {adapter_inst/set_signal_req_args[sync][1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/tx_msg[cmd][7]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/tx_msg[cmd][6]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/tx_msg[cmd][5]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/tx_msg[cmd][4]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/tx_msg[cmd][3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/tx_msg[cmd][2]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527312 [get_nets {adapter_inst/tx_msg[cmd][1]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.596501 [get_nets {adapter_inst/tx_msg[cmd][0]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_nets {adapter_inst/get_result_reply_args[adc_value][15]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_nets {adapter_inst/get_result_reply_args[adc_value][14]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_nets {adapter_inst/get_result_reply_args[adc_value][13]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_nets {adapter_inst/get_result_reply_args[adc_value][12]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.606384 [get_nets {adapter_inst/get_result_reply_args[adc_value][11]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_nets {adapter_inst/get_result_reply_args[adc_value][10]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.347959 [get_nets {adapter_inst/get_result_reply_args[adc_value][9]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.432405 [get_nets {adapter_inst/get_result_reply_args[adc_value][8]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.258425 [get_nets {adapter_inst/get_result_reply_args[adc_value][7]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.347959 [get_nets {adapter_inst/get_result_reply_args[adc_value][6]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_nets {adapter_inst/get_result_reply_args[adc_value][5]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.521939 [get_nets {adapter_inst/get_result_reply_args[adc_value][4]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_nets {adapter_inst/get_result_reply_args[adc_value][3]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.347959 [get_nets {adapter_inst/get_result_reply_args[adc_value][2]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.347959 [get_nets {adapter_inst/get_result_reply_args[adc_value][1]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_nets {adapter_inst/get_result_reply_args[adc_value][0]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets adapter_inst/signal_control_unexpected_pause]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.172351 [get_nets adapter_inst/signal_control_conversion_complete]
set_switching_activity -period 1 -toggle_rate 2.16452e-05 -static_probability  \
0.516175 [get_nets iso14443a_inst/part3/framing_inst/last_rx_bit]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_nets iso14443a_inst/part3/framing_inst/fdt_trigger]
set_switching_activity -period 1 -toggle_rate 3.2428e-05 -static_probability   \
0.417606 [get_nets {iso14443a_inst/part3/framing_inst/crc[15]}]
set_switching_activity -period 1 -toggle_rate 3.34903e-05 -static_probability  \
0.447605 [get_nets {iso14443a_inst/part3/framing_inst/crc[14]}]
set_switching_activity -period 1 -toggle_rate 3.33841e-05 -static_probability  \
0.438303 [get_nets {iso14443a_inst/part3/framing_inst/crc[13]}]
set_switching_activity -period 1 -toggle_rate 3.34637e-05 -static_probability  \
0.404265 [get_nets {iso14443a_inst/part3/framing_inst/crc[12]}]
set_switching_activity -period 1 -toggle_rate 3.33044e-05 -static_probability  \
0.42148 [get_nets {iso14443a_inst/part3/framing_inst/crc[11]}]
set_switching_activity -period 1 -toggle_rate 3.64648e-05 -static_probability  \
0.461265 [get_nets {iso14443a_inst/part3/framing_inst/crc[10]}]
set_switching_activity -period 1 -toggle_rate 3.77662e-05 -static_probability  \
0.465312 [get_nets {iso14443a_inst/part3/framing_inst/crc[9]}]
set_switching_activity -period 1 -toggle_rate 3.77131e-05 -static_probability  \
0.465662 [get_nets {iso14443a_inst/part3/framing_inst/crc[8]}]
set_switching_activity -period 1 -toggle_rate 3.78725e-05 -static_probability  \
0.46061 [get_nets {iso14443a_inst/part3/framing_inst/crc[7]}]
set_switching_activity -period 1 -toggle_rate 3.90145e-05 -static_probability  \
0.492264 [get_nets {iso14443a_inst/part3/framing_inst/crc[6]}]
set_switching_activity -period 1 -toggle_rate 3.89082e-05 -static_probability  \
0.482112 [get_nets {iso14443a_inst/part3/framing_inst/crc[5]}]
set_switching_activity -period 1 -toggle_rate 3.91738e-05 -static_probability  \
0.48946 [get_nets {iso14443a_inst/part3/framing_inst/crc[4]}]
set_switching_activity -period 1 -toggle_rate 3.8802e-05 -static_probability   \
0.465594 [get_nets {iso14443a_inst/part3/framing_inst/crc[3]}]
set_switching_activity -period 1 -toggle_rate 3.84036e-05 -static_probability  \
0.46132 [get_nets {iso14443a_inst/part3/framing_inst/crc[2]}]
set_switching_activity -period 1 -toggle_rate 3.96519e-05 -static_probability  \
0.441858 [get_nets {iso14443a_inst/part3/framing_inst/crc[1]}]
set_switching_activity -period 1 -toggle_rate 3.93863e-05 -static_probability  \
0.463248 [get_nets {iso14443a_inst/part3/framing_inst/crc[0]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.972006 [get_nets iso14443a_inst/part3/tx_append_crc_init]
set_switching_activity -period 1 -toggle_rate 0.000712193 -static_probability  \
0.209977 [get_nets iso14443a_inst/part2/tx_inst/subcarrier]
set_switching_activity -period 1 -toggle_rate 7.14424e-05 -static_probability  \
0.477087 [get_nets iso14443a_inst/part2/tx_inst/encoded_data]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets iso14443a_inst/part4_deselect]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets app_resend_last]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
9.80009e-06 [get_nets adc_conversion_complete_sync]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.993305 [get_nets pause_n_synchronised]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets rst_n]
create_clock [get_ports clk]  -period 73.7463  -waveform {0 36.8732}
set_clock_uncertainty -setup 14.7493  [get_clocks clk]
set_clock_uncertainty -hold 0.5  [get_clocks clk]
set_false_path   -from [list [get_ports {afe_version[3]}] [get_ports           \
{afe_version[2]}] [get_ports {afe_version[1]}] [get_ports {afe_version[0]}]]
set_false_path   -from [list [get_ports {adc_version[3]}] [get_ports           \
{adc_version[2]}] [get_ports {adc_version[1]}] [get_ports {adc_version[0]}]]
set_false_path   -from [list [get_ports {sens_version[3]}] [get_ports          \
{sens_version[2]}] [get_ports {sens_version[1]}] [get_ports                    \
{sens_version[0]}]]
set_false_path   -from [list [get_ports {uid_variable[2]}] [get_ports          \
{uid_variable[1]}] [get_ports {uid_variable[0]}]]
set_false_path   -from [get_ports rst_n_async]
set_false_path   -from [list [get_ports {power[1]}] [get_ports {power[0]}]]
set_false_path   -to [list [get_ports {sens_config[2]}] [get_ports             \
{sens_config[1]}] [get_ports {sens_config[0]}]]
set_false_path   -to [get_ports sens_enable]
set_false_path   -to [get_ports sens_read]
set_false_path   -to [get_ports adc_enable]
set_false_path   -to [get_ports adc_read]
set_false_path   -from [list [get_ports {adc_value[15]}] [get_ports            \
{adc_value[14]}] [get_ports {adc_value[13]}] [get_ports {adc_value[12]}]       \
[get_ports {adc_value[11]}] [get_ports {adc_value[10]}] [get_ports             \
{adc_value[9]}] [get_ports {adc_value[8]}] [get_ports {adc_value[7]}]          \
[get_ports {adc_value[6]}] [get_ports {adc_value[5]}] [get_ports               \
{adc_value[4]}] [get_ports {adc_value[3]}] [get_ports {adc_value[2]}]          \
[get_ports {adc_value[1]}] [get_ports {adc_value[0]}]]
set_false_path   -from [get_ports adc_conversion_complete_async]
set_max_delay  5 -from [get_ports pause_n_async] -ignore_clock_latency
set_max_delay  5 -to [get_ports lm_out] -ignore_clock_latency
set compile_inbound_cell_optimization false
set compile_inbound_max_cell_percentage 10.0
