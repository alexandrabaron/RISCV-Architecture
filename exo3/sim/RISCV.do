onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider SOC
add wave -noupdate /RV32i_tb/clk_r
add wave -noupdate /RV32i_tb/resetn_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/imem_data_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/imem_add_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/dmem_add_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/dmem_di_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/dmem_do_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/dmem_re_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/dmem_we_w
add wave -noupdate -divider CORE
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/instruction_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/stall_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/pc_next_sel_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/alu_control_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/reg_we_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/alu_src1_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/alu_src2_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/imm_gen_sel_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/wb_sel_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/rd_add_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/alu_zero_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/alu_lt_w
add wave -noupdate -divider Datapath
add wave -noupdate -divider FETCH
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_counter_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_plus4_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_next_w
add wave -noupdate -divider ID
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_counter_dec_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/rs1_add_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/rs2_add_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/rd_add_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/opcode_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/func7_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/rs1_data_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/rs2_data_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/imm_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/wb_data_w
add wave -noupdate -divider {Register files}
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/we_i
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/rd_add_i
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/rs1_add_i
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/rs2_add_i
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/rd_data_i
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/rs1_data_o
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/rs2_data_o
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/regfile_inst/register_r
add wave -noupdate -divider EXE
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_counter_exec_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/alu_op1_data_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/alu_op2_data_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/alu_do_w
add wave -noupdate -divider MEM
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_counter_mem_r
add wave -noupdate -divider WB
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/dp/pc_counter_wb_r
add wave -noupdate -divider ControlPath
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/inst_dec_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/inst_exec_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/inst_mem_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/inst_wb_r
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/branch_taken_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/stall_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/rd_add_dec_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/rd_add_exec_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/rd_add_mem_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/rd_add_wb_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/rs1_dec_w
add wave -noupdate /RV32i_tb/RV32i_soc_inst/RV32i_core/cp/rs2_dec_w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 425
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {586 ps}
