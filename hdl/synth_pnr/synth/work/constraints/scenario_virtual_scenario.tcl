if { [namespace current] != {::622A46C7} } { error {This script [file tail [info script]] should not be sourced directly}; }
###################################################################

# Created by write_script -format dctcl for scenario constraints on Thu Mar 10 \
15:43:19 2022

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
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.316013 [get_ports {adc_value[15]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.3567 [get_ports {adc_value[14]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.47583 [get_ports {adc_value[13]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.485136 [get_ports {adc_value[12]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.369794 [get_ports {adc_value[11]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.521678 [get_ports {adc_value[10]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.357402 [get_ports {adc_value[9]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.467195 [get_ports {adc_value[8]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.369794 [get_ports {adc_value[7]}]
set_switching_activity -period 1 -toggle_rate 2.12468e-07 -static_probability  \
0.197864 [get_ports {adc_value[6]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.658834 [get_ports {adc_value[5]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.465842 [get_ports {adc_value[4]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.804628 [get_ports {adc_value[3]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.482764 [get_ports {adc_value[2]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.359364 [get_ports {adc_value[1]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.470826 [get_ports {adc_value[0]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527097 [get_pins {adapter_inst/signal_control_inst/signals_reg[adc_read]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527204 [get_pins                                                             \
{adapter_inst/signal_control_inst/signals_reg[sens_read]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527312 [get_pins                                                             \
{adapter_inst/signal_control_inst/signals_reg[sens_enable]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527312 [get_pins                                                             \
{adapter_inst/signal_control_inst/signals_reg[adc_enable]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/signals_reg[sens_config][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/signals_reg[sens_config][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/signals_reg[sens_config][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {reset_synchroniser/shift_reg_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.948e-06 -static_probability    \
0.316173 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000356097 -static_probability  \
0.104989 [get_pins iso14443a_inst/part2/tx_inst/lm_out_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[1][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[1][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[3][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[1][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[1][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[3][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[1][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[1][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[3][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[3][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[1][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[3][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[3][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[3][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[3][1]/Q}]
set_switching_activity -period 1 -toggle_rate 3.77131e-05 -static_probability  \
0.465662 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 3.33841e-05 -static_probability  \
0.438303 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 3.34903e-05 -static_probability  \
0.447605 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 3.77662e-05 -static_probability  \
0.465312 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 3.90145e-05 -static_probability  \
0.492264 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[1][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[0][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[2][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 3.93863e-05 -static_probability  \
0.463248 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 3.89082e-05 -static_probability  \
0.482112 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.960339 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0396607 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][4]/Q}]
set_switching_activity -period 1 -toggle_rate 3.96519e-05 -static_probability  \
0.441858 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 4.92926e-05 -static_probability  \
0.254741 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.969265 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.46463e-05 -static_probability  \
0.253801 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.969737 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0396607 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[4][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[4][3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0307348 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[4][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[4][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[4][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0307348 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][6]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0302626 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[0][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[4][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000102994 -static_probability  \
0.243165 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 1.23232e-05 -static_probability  \
0.246446 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_bits_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.969265 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.196026 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[24]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.165835 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[23]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[22]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[17]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.196026 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[16]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[21]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.165835 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[20]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[19]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[18]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins iso14443a_inst/part3/initialisation_inst/is_AC_SELECT_for_us_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/cached_sync_timing_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/our_cid_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/our_cid_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.993305 [get_pins {pause_n_latch_sync/sync_inst/q_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.993305 [get_pins                                                             \
adapter_inst/signal_control_inst/pause_n_synchronised_old_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
0.0635521 [get_pins {iso14443a_inst/part4/tx_count_minus_1_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins adapter_inst/signal_control_abort_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.23888e-05 -static_probability  \
0.459251 [get_pins {iso14443a_inst/part2/sd_inst/seq_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00146242 -static_probability   \
0.239093 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.563419 [get_pins {adapter_inst/rx_buffer_reg[4][0]/Q}]
set_switching_activity -period 1 -toggle_rate 9.56107e-07 -static_probability  \
3.52432e-05 [get_pins iso14443a_inst/part4/send_reply_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.00575778 -static_probability   \
0.787787 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part2/sd_inst/counter_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000137786 -static_probability  \
0.162507 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00292377 -static_probability   \
0.324704 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/rx_buffer_reg[1][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.656238 [get_pins {adapter_inst/rx_buffer_reg[4][1]/Q}]
set_switching_activity -period 1 -toggle_rate 3.47917e-05 -static_probability  \
0.0320264 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.98022 [get_pins {iso14443a_inst/part4/rx_buffer_reg[1][3]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.640327 [get_pins iso14443a_inst/part3/framing_inst/s_inst/idle_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.000365339 -static_probability  \
0.321478 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/replyStdBlock_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/replyStdBlock_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0114125 [get_pins                                                            \
iso14443a_inst/part3/initialisation_inst/uid_matching_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.000730678 -static_probability  \
0.295507 [get_pins {iso14443a_inst/part2/sd_inst/counter_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-07 -static_probability   \
1.95736e-05 [get_pins adapter_inst/signal_control_start_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins {adapter_inst/signal_control_inst/cached_cmd_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0317451 [get_pins {iso14443a_inst/part4/reply_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.980274 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/our_cid_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.94837 [get_pins {iso14443a_inst/part4/reply_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.20967e-05 -static_probability  \
0.81682 [get_pins {iso14443a_inst/part2/sd_inst/seq_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 4.51495e-07 -static_probability  \
0.510357 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/rx_buffer_reg[1][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.960541 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0394594 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00378748 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0394594 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[16]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.98022 [get_pins {iso14443a_inst/part4/rx_buffer_reg[1][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/tx_count_minus_1_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0197338 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[19]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[17]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/our_cid_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/rx_buffer_reg[1][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_auto_read_timing1_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0197338 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.039654 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.019827 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.019827 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/rx_buffer_reg[2][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.039654 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.019827 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][7]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.019827 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.039654 [get_pins {iso14443a_inst/part4/rx_buffer_reg[2][3]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.463123 [get_pins iso14443a_inst/part2/sd_inst/idle_reg/Q]
set_switching_activity -period 1 -toggle_rate 3.10204e-05 -static_probability  \
0.850674 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.55102e-05 -static_probability  \
0.853304 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0197256 [get_pins {iso14443a_inst/part4/rx_buffer_reg[0][5]/Q}]
set_switching_activity -period 1 -toggle_rate 7.75509e-06 -static_probability  \
0.853304 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/bit_count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 7.72853e-06 -static_probability  \
0.702813 [get_pins iso14443a_inst/part3/framing_inst/s_inst/cache_data_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part3/framing_inst/ds_inst/seen_error_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[24]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[22]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.361861 [get_pins {adapter_inst/signal_control_inst/cached_cmd_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[21]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[18]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[23]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[20]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/cached_auto_read_timing2_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/rx_buffer_reg[1][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/rx_buffer_reg[1][6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.0196491 [get_pins {iso14443a_inst/part4/rx_buffer_reg[1][5]/Q}]
set_switching_activity -period 1 -toggle_rate 4.24936e-07 -static_probability  \
0.492227 [get_pins iso14443a_inst/part4/our_block_num_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.07379e-06 -static_probability  \
0.0394444 [get_pins                                                            \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.972006 [get_pins                                                             \
iso14443a_inst/part3/initialisation_inst/tx_append_crc_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part3/framing_inst/fd_inst/error_detected_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.20967e-05 -static_probability  \
0.816819 [get_pins {iso14443a_inst/part2/sd_inst/prev_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.03578e-06 -static_probability  \
0.00626474 [get_pins iso14443a_inst/part2/sd_inst/prev_is_soc_reg/Q]
set_switching_activity -period 1 -toggle_rate 9.82665e-07 -static_probability  \
0.955625 [get_pins iso14443a_inst/part3/framing_inst/fe_inst/crc_byte_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.16452e-05 -static_probability  \
0.516541 [get_pins iso14443a_inst/part2/sd_inst/out_iface_data_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/status_flags_reg[unexpected_pause]/Q}]
set_switching_activity -period 1 -toggle_rate 2.70366e-05 -static_probability  \
0.279217 [get_pins iso14443a_inst/part3/framing_inst/crc_inst/crc_data_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.01845e-06 -static_probability  \
0.0394444 [get_pins                                                            \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 4.0369e-06 -static_probability   \
0.0394444 [get_pins                                                            \
{iso14443a_inst/part3/framing_inst/fe_inst/bits_remaining_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/tx_buffer_reg[1][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part4/tx_buffer_reg[1][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.969265 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.57618e-06 -static_probability  \
0.484556 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.8152e-06 -static_probability   \
0.388696 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.07156e-06 -static_probability  \
0.266706 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.09812e-06 -static_probability  \
0.268644 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 3.55884e-06 -static_probability  \
0.514826 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 3.71819e-06 -static_probability  \
0.370333 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.89488e-06 -static_probability  \
0.378648 [get_pins {iso14443a_inst/part4/app_rx_iface_data_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 1.16326e-05 -static_probability  \
0.266673 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.997586 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][7]/Q}]
set_switching_activity -period 1 -toggle_rate 4.06345e-06 -static_probability  \
0.6106 [get_pins                                                               \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.997586 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.65194e-05 -static_probability  \
0.316889 [get_pins                                                             \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_reg/Q]
set_switching_activity -period 1 -toggle_rate 4.92926e-05 -static_probability  \
0.745257 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.54039e-05 -static_probability  \
0.567501 [get_pins iso14443a_inst/part3/framing_inst/fe_inst/parity_reg/Q]
set_switching_activity -period 1 -toggle_rate 3.45261e-07 -static_probability  \
0.00786189 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][1]/Q}]
set_switching_activity -period 1 -toggle_rate 3.71819e-07 -static_probability  \
0.996244 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.00814379 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][5]/Q}]
set_switching_activity -period 1 -toggle_rate 1.77411e-05 -static_probability  \
0.822818 [get_pins                                                             \
iso14443a_inst/part3/framing_inst/fd_inst/expected_parity_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.12468e-07 -static_probability  \
0.00711143 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][4]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.997705 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00699628 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][2]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.00458213 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][5]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.00458213 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][3]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.995299 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[1][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.33715e-06 -static_probability  \
0.265476 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.16857e-06 -static_probability  \
0.209948 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.996081 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.972006 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.23888e-05 -static_probability  \
0.459252 [get_pins {iso14443a_inst/part2/sd_inst/prev_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.80598e-06 -static_probability  \
6.65557e-05 [get_pins iso14443a_inst/part4/check_need_to_forward_to_app_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.03578e-06 -static_probability  \
0.993851 [get_pins                                                             \
iso14443a_inst/part3/framing_inst/fd_inst/data_received_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00378748 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.54039e-06 -static_probability  \
0.226553 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][6]/Q}]
set_switching_activity -period 1 -toggle_rate 1.88565e-06 -static_probability  \
0.316167 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.46463e-05 -static_probability  \
0.228063 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.996204 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[0][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][7]/Q}]
set_switching_activity -period 1 -toggle_rate 1.91221e-06 -static_probability  \
0.220326 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][3]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.530572 [get_pins {iso14443a_inst/part4/tx_buffer_reg[1][7]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.561387 [get_pins {iso14443a_inst/part4/tx_buffer_reg[1][6]/Q}]
set_switching_activity -period 1 -toggle_rate 1.96533e-06 -static_probability  \
0.25579 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/new_signals_reg[sens_enable]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/new_signals_reg[adc_enable]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/tx_buffer_reg[1][3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.07156e-06 -static_probability  \
0.236041 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[0][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/rx_buffer_reg[1][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[2][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[3][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/tx_iface_data_bits_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.74489e-05 -static_probability  \
0.461549 [get_pins                                                             \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.89488e-06 -static_probability  \
0.378647 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.8152e-06 -static_probability   \
0.388695 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.948e-06 -static_probability    \
0.316172 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.997586 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_pins {adapter_inst/rx_buffer_reg[7][7]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_pins {adapter_inst/rx_buffer_reg[7][6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_pins {adapter_inst/rx_buffer_reg[7][5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_pins {adapter_inst/rx_buffer_reg[7][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[7][3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_pins {adapter_inst/rx_buffer_reg[7][2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.09812e-06 -static_probability  \
0.268643 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[7][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00241416 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.57618e-06 -static_probability  \
0.484557 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 3.55884e-06 -static_probability  \
0.514827 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.07156e-06 -static_probability  \
0.266705 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00470918 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00470918 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][3]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.997705 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[4][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.997586 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00470918 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.00241416 [get_pins                                                           \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[2][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins                                                                      \
{iso14443a_inst/part3/initialisation_inst/ac_reply_buffer_reg[3][2]/Q}]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
0.0365047 [get_pins                                                            \
iso14443a_inst/part4/check_need_to_forward_to_app_after_next_byte_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/new_signals_reg[adc_read]/Q}]
set_switching_activity -period 1 -toggle_rate 2.54962e-06 -static_probability  \
0.2225 [get_pins {iso14443a_inst/part4/tx_buffer_reg[0][7]/Q}]
set_switching_activity -period 1 -toggle_rate 1.01985e-05 -static_probability  \
0.239119 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 6.93177e-06 -static_probability  \
0.242577 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 6.69275e-06 -static_probability  \
0.19079 [get_pins                                                              \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 4.6743e-06 -static_probability   \
0.235027 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 4.40871e-06 -static_probability  \
0.275314 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 3.34637e-06 -static_probability  \
0.251123 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.54962e-06 -static_probability  \
0.212055 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/s_inst/cached_data_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/new_signals_reg[sens_read]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins adapter_inst/signal_control_inst/starts_adc_read_reg/Q]
set_switching_activity -period 1 -toggle_rate 3.71819e-06 -static_probability  \
0.370333 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins                                                                      \
{adapter_inst/signal_control_inst/new_signals_reg[sens_config][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {iso14443a_inst/part4/tx_buffer_reg[1][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.161158 [get_pins {adapter_inst/rx_buffer_reg[10][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[14][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[8][0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.226304 [get_pins {adapter_inst/rx_buffer_reg[6][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[6][6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.279766 [get_pins {adapter_inst/rx_buffer_reg[6][5]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.111906 [get_pins {adapter_inst/rx_buffer_reg[6][2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.226304 [get_pins {adapter_inst/rx_buffer_reg[6][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[12][1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.130512 [get_pins {adapter_inst/rx_buffer_reg[9][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[9][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[9][5]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.130512 [get_pins {adapter_inst/rx_buffer_reg[9][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.29436 [get_pins {adapter_inst/rx_buffer_reg[9][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[9][2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.29436 [get_pins {adapter_inst/rx_buffer_reg[9][1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.163847 [get_pins {adapter_inst/rx_buffer_reg[9][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[11][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[11][6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[11][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[11][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[11][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[11][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {adapter_inst/rx_buffer_reg[11][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[11][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[5][5]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.22572 [get_pins {adapter_inst/rx_buffer_reg[5][2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.169933 [get_pins {adapter_inst/rx_buffer_reg[5][0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_pins {adapter_inst/rx_buffer_reg[7][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][2]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/rx_buffer_reg[13][6]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.616828 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 3.95722e-06 -static_probability  \
0.611378 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0.5        \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[4][0]/Q}]
set_switching_activity -period 1 -toggle_rate 3.71819e-06 -static_probability  \
0.611897 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 3.13391e-06 -static_probability  \
0.611119 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 3.08079e-06 -static_probability  \
0.609821 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.8152e-06 -static_probability   \
0.6106 [get_pins                                                               \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 2.4965e-06 -static_probability   \
0.612157 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 2.28403e-06 -static_probability  \
0.611378 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 1.77942e-06 -static_probability  \
0.612416 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 1.7263e-06 -static_probability   \
0.612935 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 1.56695e-06 -static_probability  \
0.612935 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 1.24825e-06 -static_probability  \
0.613195 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 1.11546e-06 -static_probability  \
0.614233 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 7.43639e-07 -static_probability  \
0.616049 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 6.37404e-07 -static_probability  \
0.617087 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fe_inst/cached_crc_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {iso14443a_inst/part3/initialisation_inst/tx_buffer_reg[1][1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167859 [get_pins {adapter_inst/rx_buffer_reg[6][4]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.111906 [get_pins {adapter_inst/rx_buffer_reg[6][3]/Q}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.170351 [get_pins {adapter_inst/rx_buffer_reg[6][1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167413 [get_pins {adapter_inst/rx_buffer_reg[5][7]/Q}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.22572 [get_pins {adapter_inst/rx_buffer_reg[5][6]/Q}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167413 [get_pins {adapter_inst/rx_buffer_reg[5][4]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.72096 [get_pins {adapter_inst/rx_buffer_reg[5][3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.941693 [get_pins {adapter_inst/rx_buffer_reg[5][1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.23232e-05 -static_probability  \
0.228337 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fd_inst/bit_count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.993305 [get_pins {pause_n_latch_sync/sync_inst/tmp_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0189043 [get_pins iso14443a_inst/part4/allow_pps_reg/Q]
set_switching_activity -period 1 -toggle_rate 3.84036e-05 -static_probability  \
0.46132 [get_pins                                                              \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 3.8802e-05 -static_probability   \
0.465594 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 3.91738e-05 -static_probability  \
0.48946 [get_pins                                                              \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 3.78725e-05 -static_probability  \
0.46061 [get_pins                                                              \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 3.33044e-05 -static_probability  \
0.42148 [get_pins                                                              \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 3.34637e-05 -static_probability  \
0.404265 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 3.2428e-05 -static_probability   \
0.417606 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 3.64648e-05 -static_probability  \
0.461265 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/crc_inst/crc_a_inst/lfsr_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 1.03578e-06 -static_probability  \
0.433965 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.0200456 [get_pins                                                            \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 2.12468e-06 -static_probability  \
0.0200456 [get_pins                                                            \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 3.79521e-05 -static_probability  \
0.55389 [get_pins {iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000110829 -static_probability  \
0.593504 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000242851 -static_probability  \
0.183844 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000395934 -static_probability  \
0.342642 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000792905 -static_probability  \
0.769529 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00158584 -static_probability   \
0.769529 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00317069 -static_probability   \
0.660355 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00625259 -static_probability   \
0.657007 [get_pins                                                             \
{iso14443a_inst/part3/framing_inst/fdt_inst/count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.573311 [get_pins                                                             \
iso14443a_inst/part3/framing_inst/fdt_inst/seen_pause_reg/Q]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.297107 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.343784 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.465836 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.520958 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.171488 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.348662 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.34947 [get_pins                                                              \
{adapter_inst/signal_control_inst/cached_adc_value_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.463716 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.177174 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.172296 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.463716 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.465836 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.643819 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.471523 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.345904 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.466645 [get_pins                                                             \
{adapter_inst/signal_control_inst/cached_adc_value_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.00981135 [get_pins                                                           \
iso14443a_inst/part3/initialisation_inst/tx_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.417567 [get_pins                                                             \
iso14443a_inst/part3/framing_inst/fe_inst/out_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.07156e-06 -static_probability  \
0.014533 [get_pins {iso14443a_inst/part3/framing_inst/fe_inst/state_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 8.76431e-06 -static_probability  \
0.112756 [get_pins {iso14443a_inst/part3/framing_inst/fe_inst/state_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.08359e-05 -static_probability  \
0.371462 [get_pins {iso14443a_inst/part3/framing_inst/fe_inst/state_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.41741 [get_pins {iso14443a_inst/part2/tx_inst/state_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.00254484 [get_pins {iso14443a_inst/part2/tx_inst/state_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 9.08301e-05 -static_probability  \
0.0937655 [get_pins pause_n_latch_sync/pause_n_latched_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
0.342309 [get_pins iso14443a_inst/part4/forward_from_app_reg/Q]
set_switching_activity -period 1 -toggle_rate 9.56107e-07 -static_probability  \
0.349862 [get_pins iso14443a_inst/part4/tx_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.16857e-06 -static_probability  \
0.287613 [get_pins {adapter_inst/tx_idx_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 8.23314e-07 -static_probability  \
0.643369 [get_pins {adapter_inst/tx_idx_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.0534633 [get_pins {adapter_inst/tx_idx_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.84176e-06 -static_probability  \
0.66592 [get_pins {adapter_inst/tx_idx_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
0.306259 [get_pins adapter_inst/tx_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
3.13125e-05 [get_pins adapter_inst/send_reply_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins adapter_inst/last_rx_had_invalid_magic_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins adapter_inst/rx_error_flag_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part4/app_rx_iface_error_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/status_flags_reg[error]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/status_flags_reg[already_busy]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.297483 [get_pins {adapter_inst/status_flags_reg[conv_complete]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00302831 -static_probability   \
0.556858 [get_pins {adapter_inst/signal_control_inst/counter_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00151469 -static_probability   \
0.555818 [get_pins {adapter_inst/signal_control_inst/counter_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000757051 -static_probability  \
0.556635 [get_pins {adapter_inst/signal_control_inst/counter_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000423024 -static_probability  \
0.39665 [get_pins {adapter_inst/signal_control_inst/counter_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000201021 -static_probability  \
0.478216 [get_pins {adapter_inst/signal_control_inst/counter_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 8.28891e-05 -static_probability  \
0.341262 [get_pins {adapter_inst/signal_control_inst/counter_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 2.50712e-05 -static_probability  \
0.233621 [get_pins {adapter_inst/signal_control_inst/counter_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 1.24559e-05 -static_probability  \
0.231188 [get_pins {adapter_inst/signal_control_inst/counter_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 5.89599e-06 -static_probability  \
0.221995 [get_pins {adapter_inst/signal_control_inst/counter_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 3.08079e-06 -static_probability  \
0.221946 [get_pins {adapter_inst/signal_control_inst/counter_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 1.83254e-06 -static_probability  \
0.183305 [get_pins {adapter_inst/signal_control_inst/counter_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 8.23314e-07 -static_probability  \
0.178449 [get_pins {adapter_inst/signal_control_inst/counter_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00605662 -static_probability   \
0.446413 [get_pins {adapter_inst/signal_control_inst/counter_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.000115503 [get_pins {adapter_inst/signal_control_inst/counter_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[16]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[17]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[18]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[19]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[20]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[21]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[22]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[23]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/signal_control_inst/counter_reg[24]/Q}]
set_switching_activity -period 1 -toggle_rate 0.0120232 -static_probability    \
0.44433 [get_pins {adapter_inst/signal_control_inst/counter_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-07 -static_probability  \
0.000127242 [get_pins {adapter_inst/signal_control_inst/state_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-07 -static_probability  \
0.000127242 [get_pins {adapter_inst/signal_control_inst/state_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-07 -static_probability  \
0.000127242 [get_pins {adapter_inst/signal_control_inst/state_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins adapter_inst/signal_control_inst/unexpected_pause_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
9.80009e-06 [get_pins adapter_inst/signal_control_result_read_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.172351 [get_pins                                                             \
adapter_inst/signal_control_inst/cached_adc_conversion_complete_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/reply_cmd_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/reply_cmd_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/reply_cmd_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/reply_cmd_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/reply_cmd_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins {adapter_inst/reply_cmd_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.527312 [get_pins {adapter_inst/reply_cmd_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.596501 [get_pins {adapter_inst/reply_cmd_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.46994e-06 -static_probability  \
0.542869 [get_pins {adapter_inst/rx_count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 1.11546e-06 -static_probability  \
0.385431 [get_pins {adapter_inst/rx_count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 5.04612e-07 -static_probability  \
0.269717 [get_pins {adapter_inst/rx_count_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.161559 [get_pins {adapter_inst/rx_count_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 5.23203e-06 -static_probability  \
0.694554 [get_pins {adapter_inst/rx_count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 9.6673e-06 -static_probability   \
0.000356283 [get_pins iso14443a_inst/part4/app_rx_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
3.13125e-05 [get_pins iso14443a_inst/part4/app_rx_iface_eoc_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
0.42055 [get_pins iso14443a_inst/part4/forward_to_app_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.49873e-07 -static_probability  \
3.13125e-05 [get_pins iso14443a_inst/part4/app_rx_iface_soc_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part3/initialisation_inst/state_star_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part4/rx_deselect_reg/Q]
set_switching_activity -period 1 -toggle_rate 5.78976e-06 -static_probability  \
0.000213371 [get_pins iso14443a_inst/part4/app_tx_iface_req_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.07156e-06 -static_probability  \
7.63557e-05 [get_pins                                                          \
iso14443a_inst/part3/framing_inst/crc_inst/crc_start_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.000159723 -static_probability  \
0.00588643 [get_pins                                                           \
iso14443a_inst/part3/framing_inst/crc_inst/crc_sample_reg/Q]
set_switching_activity -period 1 -toggle_rate 9.82665e-07 -static_probability  \
0.427186 [get_pins iso14443a_inst/part3/framing_inst/crc_inst/crc_type_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part3/initialisation_inst/rx_error_flag_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.0257911 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 3.18702e-07 -static_probability  \
0.0255326 [get_pins                                                            \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.972606 [get_pins                                                             \
{iso14443a_inst/part3/initialisation_inst/rx_count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
5.86943e-06 [get_pins                                                          \
iso14443a_inst/part3/initialisation_inst/pkt_received_reg/Q]
set_switching_activity -period 1 -toggle_rate 7.75509e-06 -static_probability  \
0.000285796 [get_pins                                                          \
iso14443a_inst/part3/framing_inst/s_inst/in_iface_req_reg/Q]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.978621 [get_pins {iso14443a_inst/part3/initialisation_inst/state_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 9.29548e-07 -static_probability  \
0.801042 [get_pins {iso14443a_inst/part4/rx_count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 9.56107e-07 -static_probability  \
0.0833222 [get_pins {iso14443a_inst/part4/rx_count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.73553e-06 -static_probability  \
0.824889 [get_pins {iso14443a_inst/part4/rx_count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part4/rx_error_flag_reg/Q]
set_switching_activity -period 1 -toggle_rate 9.56107e-07 -static_probability  \
3.52432e-05 [get_pins iso14443a_inst/part4/pkt_received_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.969601 [get_pins {iso14443a_inst/part3/initialisation_inst/state_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.258425 [get_pins {adapter_inst/cached_adc_value_reg[15]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.347959 [get_pins {adapter_inst/cached_adc_value_reg[14]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_pins {adapter_inst/cached_adc_value_reg[13]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.521939 [get_pins {adapter_inst/cached_adc_value_reg[12]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_pins {adapter_inst/cached_adc_value_reg[11]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.347959 [get_pins {adapter_inst/cached_adc_value_reg[10]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.347959 [get_pins {adapter_inst/cached_adc_value_reg[9]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_pins {adapter_inst/cached_adc_value_reg[8]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_pins {adapter_inst/cached_adc_value_reg[7]/Q}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.17398 [get_pins {adapter_inst/cached_adc_value_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_pins {adapter_inst/cached_adc_value_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_pins {adapter_inst/cached_adc_value_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.606384 [get_pins {adapter_inst/cached_adc_value_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.432405 [get_pins {adapter_inst/cached_adc_value_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.347959 [get_pins {adapter_inst/cached_adc_value_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.432405 [get_pins {adapter_inst/cached_adc_value_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part4/app_resend_last_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.16452e-05 -static_probability  \
0.516175 [get_pins iso14443a_inst/part3/framing_inst/fd_inst/last_bit_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.227e-05 -static_probability    \
0.0564017 [get_pins                                                            \
iso14443a_inst/part3/framing_inst/fd_inst/next_bit_is_parity_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.23232e-05 -static_probability  \
0.000454151 [get_pins                                                          \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 9.85321e-05 -static_probability  \
0.00363129 [get_pins                                                           \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part3/framing_inst/ds_inst/out_iface_error_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part3/framing_inst/fd_inst/out_iface_error_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_pins iso14443a_inst/part2/sd_inst/out_iface_soc_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
0.529109 [get_pins iso14443a_inst/part2/sd_inst/in_frame_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.000110802 -static_probability  \
0.00408351 [get_pins iso14443a_inst/part2/sd_inst/out_iface_data_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_pins                                                          \
iso14443a_inst/part3/framing_inst/ds_inst/out_iface_eoc_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_pins                                                          \
iso14443a_inst/part3/framing_inst/fd_inst/out_iface_eoc_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_pins iso14443a_inst/part2/sd_inst/out_iface_eoc_reg/Q]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_pins iso14443a_inst/part2/sd_inst/out_iface_error_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.000114308 -static_probability  \
0.00421271 [get_pins iso14443a_inst/part2/sd_inst/seq_valid_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_pins iso14443a_inst/part2/sd_inst/detected_soc_reg/Q]
set_switching_activity -period 1 -toggle_rate 6.20407e-05 -static_probability  \
0.00228645 [get_pins                                                           \
iso14443a_inst/part3/framing_inst/fe_inst/in_iface_req_reg/Q]
set_switching_activity -period 1 -toggle_rate 7.14424e-05 -static_probability  \
0.477087 [get_pins iso14443a_inst/part2/tx_inst/bc_inst/encoded_data_reg/Q]
set_switching_activity -period 1 -toggle_rate 1.06234e-06 -static_probability  \
3.91473e-05 [get_pins                                                          \
iso14443a_inst/part3/framing_inst/fdt_inst/trigger_reg/Q]
set_switching_activity -period 1 -toggle_rate 8.90242e-05 -static_probability  \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[6]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000178048 -static_probability  \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[5]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000356097 -static_probability  \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[4]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000712193 -static_probability  \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[3]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00142439 -static_probability   \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00284877 -static_probability   \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00569755 -static_probability   \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/bc_inst/count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0.000712193 -static_probability  \
0.209977 [get_pins iso14443a_inst/part2/tx_inst/sc_inst/subcarrier_reg/Q]
set_switching_activity -period 1 -toggle_rate 0.00142439 -static_probability   \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/sc_inst/count_reg[2]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00284877 -static_probability   \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/sc_inst/count_reg[1]/Q}]
set_switching_activity -period 1 -toggle_rate 0.00569755 -static_probability   \
0.209977 [get_pins {iso14443a_inst/part2/tx_inst/sc_inst/count_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 8.79618e-05 -static_probability  \
0.00324173 [get_pins iso14443a_inst/part2/tx_inst/in_iface_req_reg/Q]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
9.80009e-06 [get_pins {adc_sync/q_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
9.80009e-06 [get_pins {adc_sync/tmp_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_pins {reset_synchroniser/shift_reg_reg[0]/Q}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[31]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[30]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[29]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[28]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[27]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[26]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[25]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[24]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[23]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[22]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[21]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[20]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[19]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[18]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[17]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[16]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[15]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[14]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[13]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[12]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[11]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[10]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/rx_magic[9]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[8]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[7]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[6]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[5]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[4]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/rx_magic[0]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167413 [get_nets {adapter_inst/set_signal_req_args[sync][15]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.22572 [get_nets {adapter_inst/set_signal_req_args[sync][14]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signal_req_args[sync][13]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167413 [get_nets {adapter_inst/set_signal_req_args[sync][12]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.72096 [get_nets {adapter_inst/set_signal_req_args[sync][11]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.22572 [get_nets {adapter_inst/set_signal_req_args[sync][10]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.941693 [get_nets {adapter_inst/set_signal_req_args[sync][9]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.169933 [get_nets {adapter_inst/set_signal_req_args[sync][8]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.226304 [get_nets {adapter_inst/set_signal_req_args[sync][7]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signal_req_args[sync][6]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-07 -static_probability  \
0.279766 [get_nets {adapter_inst/set_signal_req_args[sync][5]}]
set_switching_activity -period 1 -toggle_rate 1.59351e-07 -static_probability  \
0.167859 [get_nets {adapter_inst/set_signal_req_args[sync][4]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.111906 [get_nets {adapter_inst/set_signal_req_args[sync][3]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.111906 [get_nets {adapter_inst/set_signal_req_args[sync][2]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.170351 [get_nets {adapter_inst/set_signal_req_args[sync][1]}]
set_switching_activity -period 1 -toggle_rate 1.8591e-07 -static_probability   \
0.226304 [get_nets {adapter_inst/set_signal_req_args[sync][0]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.161158 [get_nets {adapter_inst/auto_read_timing1[24]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.130512 [get_nets {adapter_inst/auto_read_timing1[23]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing1[22]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing1[21]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.130512 [get_nets {adapter_inst/auto_read_timing1[20]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.29436 [get_nets {adapter_inst/auto_read_timing1[19]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing1[18]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.29436 [get_nets {adapter_inst/auto_read_timing1[17]}]
set_switching_activity -period 1 -toggle_rate 1.32793e-07 -static_probability  \
0.163847 [get_nets {adapter_inst/auto_read_timing1[16]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[24]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[23]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[22]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[21]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[20]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[19]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[18]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[17]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[16]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[15]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[14]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[13]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[12]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[11]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[10]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[9]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[8]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[7]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[6]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[5]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[4]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/auto_read_timing2[3]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/auto_read_timing2[1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/auto_read_timing2[0]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_nets {adapter_inst/set_signals_mask[sens_config][2]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_nets {adapter_inst/set_signals_mask[sens_config][1]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_nets {adapter_inst/set_signals_mask[sens_config][0]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_nets {adapter_inst/set_signals_mask[sens_enable]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/set_signals_mask[sens_read]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_nets {adapter_inst/set_signals_mask[adc_enable]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 1          \
[get_nets {adapter_inst/set_signals_mask[adc_read]}]
set_switching_activity -period 1 -toggle_rate 2.39027e-07 -static_probability  \
0.297673 [get_nets {adapter_inst/set_signals_mask[padding]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[sens_config][2]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[sens_config][1]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[sens_config][0]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[sens_enable]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[sens_read]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[adc_enable]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[adc_read]}]
set_switching_activity -period 1 -toggle_rate 0 -static_probability 0          \
[get_nets {adapter_inst/set_signals_value[padding]}]
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
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.297107 [get_nets {adapter_inst/signal_control_adc_value[15]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.343784 [get_nets {adapter_inst/signal_control_adc_value[14]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.465836 [get_nets {adapter_inst/signal_control_adc_value[13]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.520958 [get_nets {adapter_inst/signal_control_adc_value[12]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.171488 [get_nets {adapter_inst/signal_control_adc_value[11]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.348662 [get_nets {adapter_inst/signal_control_adc_value[10]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.34947 [get_nets {adapter_inst/signal_control_adc_value[9]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.463716 [get_nets {adapter_inst/signal_control_adc_value[8]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.177174 [get_nets {adapter_inst/signal_control_adc_value[7]}]
set_switching_activity -period 1 -toggle_rate 5.3117e-08 -static_probability   \
0.172296 [get_nets {adapter_inst/signal_control_adc_value[6]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.463716 [get_nets {adapter_inst/signal_control_adc_value[5]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.465836 [get_nets {adapter_inst/signal_control_adc_value[4]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.643819 [get_nets {adapter_inst/signal_control_adc_value[3]}]
set_switching_activity -period 1 -toggle_rate 7.96756e-08 -static_probability  \
0.471523 [get_nets {adapter_inst/signal_control_adc_value[2]}]
set_switching_activity -period 1 -toggle_rate 1.06234e-07 -static_probability  \
0.345904 [get_nets {adapter_inst/signal_control_adc_value[1]}]
set_switching_activity -period 1 -toggle_rate 2.65585e-08 -static_probability  \
0.466645 [get_nets {adapter_inst/signal_control_adc_value[0]}]
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
