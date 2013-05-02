--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_0_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_reset_n : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_write : OUT STD_LOGIC;
                 signal cpu_0_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_0_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity cpu_0_jtag_debug_module_arbitrator;


architecture europa of cpu_0_jtag_debug_module_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_allgrants :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_cpu_0_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT cpu_0_jtag_debug_module_end_xfer;
    end if;

  end process;

  cpu_0_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  --assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_0_jtag_debug_module_readdata_from_sa <= cpu_0_jtag_debug_module_readdata;
  internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(24 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1000010000000100000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  cpu_0_jtag_debug_module_arb_share_set_values <= std_logic_vector'("001");
  --cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  cpu_0_jtag_debug_module_non_bursting_master_requests <= ((internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module OR internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) OR internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module) OR internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  --cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  cpu_0_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  cpu_0_jtag_debug_module_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(cpu_0_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_0_jtag_debug_module_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(cpu_0_jtag_debug_module_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_0_jtag_debug_module_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  cpu_0_jtag_debug_module_allgrants <= (((or_reduce(cpu_0_jtag_debug_module_grant_vector)) OR (or_reduce(cpu_0_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_0_jtag_debug_module_grant_vector))) OR (or_reduce(cpu_0_jtag_debug_module_grant_vector));
  --cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  cpu_0_jtag_debug_module_end_xfer <= NOT ((cpu_0_jtag_debug_module_waits_for_read OR cpu_0_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_end_xfer AND (((NOT cpu_0_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  cpu_0_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module AND cpu_0_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module AND NOT cpu_0_jtag_debug_module_non_bursting_master_requests));
  --cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_0_jtag_debug_module_arb_counter_enable) = '1' then 
        cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(cpu_0_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module AND NOT cpu_0_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        cpu_0_jtag_debug_module_slavearbiterlockenable <= or_reduce(cpu_0_jtag_debug_module_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= cpu_0_jtag_debug_module_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  cpu_0_jtag_debug_module_slavearbiterlockenable2 <= or_reduce(cpu_0_jtag_debug_module_arb_share_counter_next_value);
  --cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= cpu_0_jtag_debug_module_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  cpu_0_instruction_master_arbiterlock <= cpu_0_jtag_debug_module_slavearbiterlockenable AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_0_instruction_master_arbiterlock2 <= cpu_0_jtag_debug_module_slavearbiterlockenable2 AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_0_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module))))));
    end if;

  end process;

  --cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  cpu_0_instruction_master_continuerequest <= last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module AND internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  --cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  cpu_0_jtag_debug_module_any_continuerequest <= cpu_0_instruction_master_continuerequest OR cpu_0_data_master_continuerequest;
  internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module AND NOT ((((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_instruction_master_arbiterlock));
  --local readdatavalid cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module <= (internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_read) AND NOT cpu_0_jtag_debug_module_waits_for_read;
  --cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  cpu_0_jtag_debug_module_writedata <= cpu_0_data_master_writedata;
  internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_instruction_master_address_to_slave(24 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1000010000000100000000000")))) AND (cpu_0_instruction_master_read))) AND cpu_0_instruction_master_read;
  --cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_0_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module))))));
    end if;

  end process;

  --cpu_0_data_master_continuerequest continued request, which is an e_mux
  cpu_0_data_master_continuerequest <= last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module AND internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module AND NOT ((((cpu_0_instruction_master_read AND ((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))))) OR cpu_0_data_master_arbiterlock));
  --local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module <= (internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module AND cpu_0_instruction_master_read) AND NOT cpu_0_jtag_debug_module_waits_for_read;
  --allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_jtag_debug_module_allow_new_arb_cycle <= NOT cpu_0_data_master_arbiterlock AND NOT cpu_0_instruction_master_arbiterlock;
  --cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_jtag_debug_module_master_qreq_vector(0) <= internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  --cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_grant_vector(0);
  --cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_arb_winner(0) AND internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  --cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_jtag_debug_module_master_qreq_vector(1) <= internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  --cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_grant_vector(1);
  --cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module <= cpu_0_jtag_debug_module_arb_winner(1) AND internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  --cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  cpu_0_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((cpu_0_jtag_debug_module_master_qreq_vector & cpu_0_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT cpu_0_jtag_debug_module_master_qreq_vector & NOT cpu_0_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (cpu_0_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  cpu_0_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((cpu_0_jtag_debug_module_allow_new_arb_cycle AND or_reduce(cpu_0_jtag_debug_module_grant_vector)))) = '1'), cpu_0_jtag_debug_module_grant_vector, cpu_0_jtag_debug_module_saved_chosen_master_vector);
  --saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_0_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        cpu_0_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(cpu_0_jtag_debug_module_grant_vector)) = '1'), cpu_0_jtag_debug_module_grant_vector, cpu_0_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  cpu_0_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((cpu_0_jtag_debug_module_chosen_master_double_vector(1) OR cpu_0_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((cpu_0_jtag_debug_module_chosen_master_double_vector(0) OR cpu_0_jtag_debug_module_chosen_master_double_vector(2)))));
  --cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  cpu_0_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(cpu_0_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(cpu_0_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --cpu_0/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(cpu_0_jtag_debug_module_grant_vector)) = '1' then 
        cpu_0_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(cpu_0_jtag_debug_module_end_xfer) = '1'), cpu_0_jtag_debug_module_chosen_master_rot_left, cpu_0_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  cpu_0_jtag_debug_module_begintransfer <= cpu_0_jtag_debug_module_begins_xfer;
  --cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  cpu_0_jtag_debug_module_reset_n <= reset_n;
  --assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_0_jtag_debug_module_resetrequest_from_sa <= cpu_0_jtag_debug_module_resetrequest;
  cpu_0_jtag_debug_module_chipselect <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module OR internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  --cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  cpu_0_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(cpu_0_jtag_debug_module_begins_xfer) = '1'), cpu_0_jtag_debug_module_unreg_firsttransfer, cpu_0_jtag_debug_module_reg_firsttransfer);
  --cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  cpu_0_jtag_debug_module_unreg_firsttransfer <= NOT ((cpu_0_jtag_debug_module_slavearbiterlockenable AND cpu_0_jtag_debug_module_any_continuerequest));
  --cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_0_jtag_debug_module_begins_xfer) = '1' then 
        cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  cpu_0_jtag_debug_module_beginbursttransfer_internal <= cpu_0_jtag_debug_module_begins_xfer;
  --cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  cpu_0_jtag_debug_module_arbitration_holdoff_internal <= cpu_0_jtag_debug_module_begins_xfer AND cpu_0_jtag_debug_module_firsttransfer;
  --cpu_0_jtag_debug_module_write assignment, which is an e_mux
  cpu_0_jtag_debug_module_write <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_write;
  shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --cpu_0_jtag_debug_module_address mux, which is an e_mux
  cpu_0_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master <= cpu_0_instruction_master_address_to_slave;
  --d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_cpu_0_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end if;

  end process;

  --cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  cpu_0_jtag_debug_module_waits_for_read <= cpu_0_jtag_debug_module_in_a_read_cycle AND cpu_0_jtag_debug_module_begins_xfer;
  --cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  cpu_0_jtag_debug_module_in_a_read_cycle <= ((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module AND cpu_0_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cpu_0_jtag_debug_module_in_a_read_cycle;
  --cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  cpu_0_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  cpu_0_jtag_debug_module_in_a_write_cycle <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cpu_0_jtag_debug_module_in_a_write_cycle;
  wait_for_cpu_0_jtag_debug_module_counter <= std_logic'('0');
  --cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  cpu_0_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_0_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  cpu_0_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_cpu_0_jtag_debug_module <= internal_cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_granted_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_requests_cpu_0_jtag_debug_module <= internal_cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
--synthesis translate_off
    --cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_granted_cpu_0_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_granted_cpu_0_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_0_data_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_byteenable_sdram_0_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_granted_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_data_master_requests_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_de2_ps2_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_niosInterface_1_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                 signal d1_skygen_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal de2_ps2_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal niosInterface_1_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;
                 signal skygen_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : OUT STD_LOGIC;
                 signal cpu_0_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_data_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_0_data_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_0_data_master_arbitrator;


architecture europa of cpu_0_data_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_0_data_master_address_last_time :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_0_data_master_byteenable_last_time :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_data_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_rdv_counter_inc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_0_data_master_next_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_0_data_master_read_last_time :  STD_LOGIC;
                signal cpu_0_data_master_run :  STD_LOGIC;
                signal cpu_0_data_master_write_last_time :  STD_LOGIC;
                signal cpu_0_data_master_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_rdv_count_enable :  STD_LOGIC;
                signal dbs_rdv_counter_overflow :  STD_LOGIC;
                signal internal_cpu_0_data_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_cpu_0_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_data_master_latency_counter :  STD_LOGIC;
                signal internal_cpu_0_data_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_0_data_master_latency_counter :  STD_LOGIC;
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_dbs_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_0_data_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_requests_cpu_0_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_granted_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_0_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 OR NOT cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 OR NOT cpu_0_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_de2_ps2_0_avalon_slave_0_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_0_data_master_dbs_address(1) AND internal_cpu_0_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 OR NOT cpu_0_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_0_data_master_dbs_address(1) AND internal_cpu_0_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave OR NOT cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave OR NOT ((cpu_0_data_master_read OR cpu_0_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_read OR cpu_0_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 OR NOT cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 OR NOT cpu_0_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_niosInterface_1_0_avalon_slave_0_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 OR NOT cpu_0_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((cpu_0_data_master_qualified_request_sdram_0_s1 OR (((cpu_0_data_master_write AND NOT(or_reduce(cpu_0_data_master_byteenable_sdram_0_s1))) AND internal_cpu_0_data_master_dbs_address(1)))) OR NOT cpu_0_data_master_requests_sdram_0_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_data_master_granted_sdram_0_s1 OR NOT cpu_0_data_master_qualified_request_sdram_0_s1)))))));
  --cascaded wait assignment, which is an e_assign
  cpu_0_data_master_run <= r_0 AND r_1;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_sdram_0_s1 OR NOT cpu_0_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_sdram_0_s1 OR NOT cpu_0_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 OR (((cpu_0_data_master_write AND NOT(or_reduce(cpu_0_data_master_byteenable_skygen_0_avalon_slave_0))) AND internal_cpu_0_data_master_dbs_address(1)))) OR NOT cpu_0_data_master_requests_skygen_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 OR NOT cpu_0_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_skygen_0_avalon_slave_0_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 OR NOT cpu_0_data_master_write)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_0_data_master_address_to_slave <= cpu_0_data_master_address(24 DOWNTO 0);
  --cpu_0_data_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_data_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_0_data_master_read_but_no_slave_selected <= (cpu_0_data_master_read AND cpu_0_data_master_run) AND NOT cpu_0_data_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_0_data_master_is_granted_some_slave <= ((((cpu_0_data_master_granted_cpu_0_jtag_debug_module OR cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0) OR cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave) OR cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0) OR cpu_0_data_master_granted_sdram_0_s1) OR cpu_0_data_master_granted_skygen_0_avalon_slave_0;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_0_data_master_readdatavalid <= cpu_0_data_master_read_data_valid_sdram_0_s1 AND dbs_rdv_counter_overflow;
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_0_data_master_readdatavalid <= (((((((((((((((cpu_0_data_master_read_but_no_slave_selected OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR ((cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 AND dbs_counter_overflow))) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR cpu_0_data_master_read_but_no_slave_selected) OR pre_flush_cpu_0_data_master_readdatavalid) OR ((cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 AND dbs_counter_overflow));
  --cpu_0/data_master readdata mux, which is an e_mux
  cpu_0_data_master_readdata <= ((((((A_REP(NOT ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module AND cpu_0_data_master_read)) , 32) OR cpu_0_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_read)) , 32) OR Std_Logic_Vector'(de2_ps2_0_avalon_slave_0_readdata_from_sa(7 DOWNTO 0) & dbs_8_reg_segment_2 & dbs_8_reg_segment_1 & dbs_8_reg_segment_0)))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read)) , 32) OR jtag_uart_0_avalon_jtag_slave_readdata_from_sa))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 AND cpu_0_data_master_read)) , 32) OR niosInterface_1_0_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT cpu_0_data_master_read_data_valid_sdram_0_s1, 32) OR Std_Logic_Vector'(sdram_0_s1_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)))) AND ((A_REP(NOT ((cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 AND cpu_0_data_master_read)) , 32) OR Std_Logic_Vector'(skygen_0_avalon_slave_0_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)));
  --actual waitrequest port, which is an e_assign
  internal_cpu_0_data_master_waitrequest <= NOT cpu_0_data_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_data_master_latency_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_cpu_0_data_master_latency_counter <= p1_cpu_0_data_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_0_data_master_latency_counter <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((cpu_0_data_master_run AND cpu_0_data_master_read))) = '1'), (std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(latency_load_value))), A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_latency_counter)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_latency_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  --read latency load values, which is an e_mux
  latency_load_value <= std_logic'('0');
  --input to dbs-8 stored 0, which is an e_mux
  p1_dbs_8_reg_segment_0 <= de2_ps2_0_avalon_slave_0_readdata_from_sa;
  --dbs register for dbs-8 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_0_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_8_reg_segment_0 <= p1_dbs_8_reg_segment_0;
      end if;
    end if;

  end process;

  --input to dbs-8 stored 1, which is an e_mux
  p1_dbs_8_reg_segment_1 <= de2_ps2_0_avalon_slave_0_readdata_from_sa;
  --dbs register for dbs-8 segment 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_1 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_0_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        dbs_8_reg_segment_1 <= p1_dbs_8_reg_segment_1;
      end if;
    end if;

  end process;

  --input to dbs-8 stored 2, which is an e_mux
  p1_dbs_8_reg_segment_2 <= de2_ps2_0_avalon_slave_0_readdata_from_sa;
  --dbs register for dbs-8 segment 2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_2 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_0_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        dbs_8_reg_segment_2 <= p1_dbs_8_reg_segment_2;
      end if;
    end if;

  end process;

  --dbs count increment, which is an e_mux
  cpu_0_data_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((cpu_0_data_master_requests_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((cpu_0_data_master_requests_skygen_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_0_data_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_0_data_master_dbs_address)) + (std_logic_vector'("0") & (cpu_0_data_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_data_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_0_data_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_de2_ps2_0_avalon_slave_0_end_xfer))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_requests_sdram_0_s1)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(cpu_0_data_master_byteenable_sdram_0_s1)))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))))) OR (((((NOT std_logic_vector'("00000000000000000000000000000000")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_requests_skygen_0_avalon_slave_0)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_write)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT(or_reduce(cpu_0_data_master_byteenable_skygen_0_avalon_slave_0)))))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_skygen_0_avalon_slave_0_end_xfer)))))) OR ((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")))));
  --irq assign, which is an e_assign
  cpu_0_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(jtag_uart_0_avalon_jtag_slave_irq_from_sa));
  --input to latent dbs-16 stored 0, which is an e_mux
  p1_dbs_latent_16_reg_segment_0 <= sdram_0_s1_readdata_from_sa;
  --dbs register for latent dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_data_master_dbs_rdv_counter(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
      end if;
    end if;

  end process;

  --mux write dbs 1, which is an e_mux
  cpu_0_data_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_dbs_address(1))) = '1'), cpu_0_data_master_writedata(31 DOWNTO 16), A_WE_StdLogicVector((std_logic'((NOT (internal_cpu_0_data_master_dbs_address(1)))) = '1'), cpu_0_data_master_writedata(15 DOWNTO 0), A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_dbs_address(1))) = '1'), cpu_0_data_master_writedata(31 DOWNTO 16), cpu_0_data_master_writedata(15 DOWNTO 0))));
  --p1 dbs rdv counter, which is an e_assign
  cpu_0_data_master_next_dbs_rdv_counter <= A_EXT (((std_logic_vector'("0") & (cpu_0_data_master_dbs_rdv_counter)) + (std_logic_vector'("0") & (cpu_0_data_master_dbs_rdv_counter_inc))), 2);
  --cpu_0_data_master_rdv_inc_mux, which is an e_mux
  cpu_0_data_master_dbs_rdv_counter_inc <= std_logic_vector'("10");
  --master any slave rdv, which is an e_mux
  dbs_rdv_count_enable <= cpu_0_data_master_read_data_valid_sdram_0_s1;
  --dbs rdv counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_data_master_dbs_rdv_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_rdv_count_enable) = '1' then 
        cpu_0_data_master_dbs_rdv_counter <= cpu_0_data_master_next_dbs_rdv_counter;
      end if;
    end if;

  end process;

  --dbs rdv counter overflow, which is an e_assign
  dbs_rdv_counter_overflow <= cpu_0_data_master_dbs_rdv_counter(1) AND NOT cpu_0_data_master_next_dbs_rdv_counter(1);
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= skygen_0_avalon_slave_0_readdata_from_sa;
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_data_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --vhdl renameroo for output signals
  cpu_0_data_master_address_to_slave <= internal_cpu_0_data_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_dbs_address <= internal_cpu_0_data_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_0_data_master_latency_counter <= internal_cpu_0_data_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_0_data_master_waitrequest <= internal_cpu_0_data_master_waitrequest;
--synthesis translate_off
    --cpu_0_data_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_address_last_time <= std_logic_vector'("0000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_0_data_master_address_last_time <= cpu_0_data_master_address;
      end if;

    end process;

    --cpu_0/data_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_0_data_master_waitrequest AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
      end if;

    end process;

    --cpu_0_data_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_0_data_master_address /= cpu_0_data_master_address_last_time))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("cpu_0_data_master_address did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_byteenable check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_byteenable_last_time <= std_logic_vector'("0000");
      elsif clk'event and clk = '1' then
        cpu_0_data_master_byteenable_last_time <= cpu_0_data_master_byteenable;
      end if;

    end process;

    --cpu_0_data_master_byteenable matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_0_data_master_byteenable /= cpu_0_data_master_byteenable_last_time))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("cpu_0_data_master_byteenable did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_0_data_master_read_last_time <= cpu_0_data_master_read;
      end if;

    end process;

    --cpu_0_data_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_0_data_master_read) /= std_logic'(cpu_0_data_master_read_last_time)))))) = '1' then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("cpu_0_data_master_read did not heed wait!!!"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_0_data_master_write_last_time <= cpu_0_data_master_write;
      end if;

    end process;

    --cpu_0_data_master_write matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_0_data_master_write) /= std_logic'(cpu_0_data_master_write_last_time)))))) = '1' then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("cpu_0_data_master_write did not heed wait!!!"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_data_master_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_data_master_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_0_data_master_writedata_last_time <= cpu_0_data_master_writedata;
      end if;

    end process;

    --cpu_0_data_master_writedata matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line6 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((cpu_0_data_master_writedata /= cpu_0_data_master_writedata_last_time)))) AND cpu_0_data_master_write)) = '1' then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("cpu_0_data_master_writedata did not heed wait!!!"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_0_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_instruction_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_granted_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_0_instruction_master_requests_sdram_0_s1 : IN STD_LOGIC;
                 signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_0_instruction_master_readdatavalid : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity cpu_0_instruction_master_arbitrator;


architecture europa of cpu_0_instruction_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_0_instruction_master_address_last_time :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_rdv_counter_inc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_is_granted_some_slave :  STD_LOGIC;
                signal cpu_0_instruction_master_next_dbs_rdv_counter :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_read_but_no_slave_selected :  STD_LOGIC;
                signal cpu_0_instruction_master_read_last_time :  STD_LOGIC;
                signal cpu_0_instruction_master_run :  STD_LOGIC;
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_rdv_count_enable :  STD_LOGIC;
                signal dbs_rdv_counter_overflow :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_cpu_0_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_instruction_master_latency_counter :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_waitrequest :  STD_LOGIC;
                signal latency_load_value :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_cpu_0_instruction_master_latency_counter :  STD_LOGIC;
                signal p1_dbs_latent_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal pre_flush_cpu_0_instruction_master_readdatavalid :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_instruction_master_requests_cpu_0_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_granted_cpu_0_jtag_debug_module OR NOT cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module OR NOT cpu_0_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_0_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_qualified_request_sdram_0_s1 OR NOT cpu_0_instruction_master_requests_sdram_0_s1)))))));
  --cascaded wait assignment, which is an e_assign
  cpu_0_instruction_master_run <= r_0 AND r_1;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_0_instruction_master_granted_sdram_0_s1 OR NOT cpu_0_instruction_master_qualified_request_sdram_0_s1))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_0_instruction_master_qualified_request_sdram_0_s1 OR NOT cpu_0_instruction_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_0_instruction_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_read)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_0_instruction_master_address_to_slave <= cpu_0_instruction_master_address(24 DOWNTO 0);
  --cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_instruction_master_read_but_no_slave_selected <= std_logic'('0');
    elsif clk'event and clk = '1' then
      cpu_0_instruction_master_read_but_no_slave_selected <= (cpu_0_instruction_master_read AND cpu_0_instruction_master_run) AND NOT cpu_0_instruction_master_is_granted_some_slave;
    end if;

  end process;

  --some slave is getting selected, which is an e_mux
  cpu_0_instruction_master_is_granted_some_slave <= cpu_0_instruction_master_granted_cpu_0_jtag_debug_module OR cpu_0_instruction_master_granted_sdram_0_s1;
  --latent slave read data valids which may be flushed, which is an e_mux
  pre_flush_cpu_0_instruction_master_readdatavalid <= cpu_0_instruction_master_read_data_valid_sdram_0_s1 AND dbs_rdv_counter_overflow;
  --latent slave read data valid which is not flushed, which is an e_mux
  cpu_0_instruction_master_readdatavalid <= (((cpu_0_instruction_master_read_but_no_slave_selected OR pre_flush_cpu_0_instruction_master_readdatavalid) OR cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module) OR cpu_0_instruction_master_read_but_no_slave_selected) OR pre_flush_cpu_0_instruction_master_readdatavalid;
  --cpu_0/instruction_master readdata mux, which is an e_mux
  cpu_0_instruction_master_readdata <= ((A_REP(NOT ((cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module AND cpu_0_instruction_master_read)) , 32) OR cpu_0_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT cpu_0_instruction_master_read_data_valid_sdram_0_s1, 32) OR Std_Logic_Vector'(sdram_0_s1_readdata_from_sa(15 DOWNTO 0) & dbs_latent_16_reg_segment_0)));
  --actual waitrequest port, which is an e_assign
  internal_cpu_0_instruction_master_waitrequest <= NOT cpu_0_instruction_master_run;
  --latent max counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_instruction_master_latency_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      internal_cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end if;

  end process;

  --latency counter load mux, which is an e_mux
  p1_cpu_0_instruction_master_latency_counter <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(((cpu_0_instruction_master_run AND cpu_0_instruction_master_read))) = '1'), (std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(latency_load_value))), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_latency_counter)) = '1'), ((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_latency_counter))) - std_logic_vector'("000000000000000000000000000000001")), std_logic_vector'("000000000000000000000000000000000"))));
  --read latency load values, which is an e_mux
  latency_load_value <= std_logic'('0');
  --input to latent dbs-16 stored 0, which is an e_mux
  p1_dbs_latent_16_reg_segment_0 <= sdram_0_s1_readdata_from_sa;
  --dbs register for latent dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_latent_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_rdv_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_instruction_master_dbs_rdv_counter(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
      end if;
    end if;

  end process;

  --dbs count increment, which is an e_mux
  cpu_0_instruction_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_0_instruction_master_requests_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_0_instruction_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_0_instruction_master_dbs_address)) + (std_logic_vector'("0") & (cpu_0_instruction_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_0_instruction_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_0_instruction_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --p1 dbs rdv counter, which is an e_assign
  cpu_0_instruction_master_next_dbs_rdv_counter <= A_EXT (((std_logic_vector'("0") & (cpu_0_instruction_master_dbs_rdv_counter)) + (std_logic_vector'("0") & (cpu_0_instruction_master_dbs_rdv_counter_inc))), 2);
  --cpu_0_instruction_master_rdv_inc_mux, which is an e_mux
  cpu_0_instruction_master_dbs_rdv_counter_inc <= std_logic_vector'("10");
  --master any slave rdv, which is an e_mux
  dbs_rdv_count_enable <= cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  --dbs rdv counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_0_instruction_master_dbs_rdv_counter <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_rdv_count_enable) = '1' then 
        cpu_0_instruction_master_dbs_rdv_counter <= cpu_0_instruction_master_next_dbs_rdv_counter;
      end if;
    end if;

  end process;

  --dbs rdv counter overflow, which is an e_assign
  dbs_rdv_counter_overflow <= cpu_0_instruction_master_dbs_rdv_counter(1) AND NOT cpu_0_instruction_master_next_dbs_rdv_counter(1);
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_0_instruction_master_granted_sdram_0_s1 AND cpu_0_instruction_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_0_s1_waitrequest_from_sa)))));
  --vhdl renameroo for output signals
  cpu_0_instruction_master_address_to_slave <= internal_cpu_0_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_dbs_address <= internal_cpu_0_instruction_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_latency_counter <= internal_cpu_0_instruction_master_latency_counter;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_waitrequest <= internal_cpu_0_instruction_master_waitrequest;
--synthesis translate_off
    --cpu_0_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_instruction_master_address_last_time <= std_logic_vector'("0000000000000000000000000");
      elsif clk'event and clk = '1' then
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
      end if;

    end process;

    --cpu_0/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_cpu_0_instruction_master_waitrequest AND (cpu_0_instruction_master_read);
      end if;

    end process;

    --cpu_0_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line7 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_0_instruction_master_address /= cpu_0_instruction_master_address_last_time))))) = '1' then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("cpu_0_instruction_master_address did not heed wait!!!"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --cpu_0_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_0_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
      end if;

    end process;

    --cpu_0_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_0_instruction_master_read) /= std_logic'(cpu_0_instruction_master_read_last_time)))))) = '1' then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("cpu_0_instruction_master_read did not heed wait!!!"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity de2_ps2_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal de2_ps2_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_de2_ps2_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal de2_ps2_0_avalon_slave_0_address : OUT STD_LOGIC;
                 signal de2_ps2_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal de2_ps2_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal de2_ps2_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal de2_ps2_0_avalon_slave_0_reset : OUT STD_LOGIC
              );
end entity de2_ps2_0_avalon_slave_0_arbitrator;


architecture europa of de2_ps2_0_avalon_slave_0_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal de2_ps2_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal de2_ps2_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal de2_ps2_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal wait_for_de2_ps2_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT de2_ps2_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  de2_ps2_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0);
  --assign de2_ps2_0_avalon_slave_0_readdata_from_sa = de2_ps2_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  de2_ps2_0_avalon_slave_0_readdata_from_sa <= de2_ps2_0_avalon_slave_0_readdata;
  internal_cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(24 DOWNTO 1) & A_ToStdLogicVector(std_logic'('0'))) = std_logic_vector'("1000010000001000010001000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write)))) AND cpu_0_data_master_read;
  --de2_ps2_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  de2_ps2_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000100"), std_logic_vector'("00000000000000000000000000000001")), 3);
  --de2_ps2_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  de2_ps2_0_avalon_slave_0_non_bursting_master_requests <= internal_cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0;
  --de2_ps2_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  de2_ps2_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --de2_ps2_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  de2_ps2_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(de2_ps2_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (de2_ps2_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(de2_ps2_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (de2_ps2_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --de2_ps2_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  de2_ps2_0_avalon_slave_0_allgrants <= de2_ps2_0_avalon_slave_0_grant_vector;
  --de2_ps2_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  de2_ps2_0_avalon_slave_0_end_xfer <= NOT ((de2_ps2_0_avalon_slave_0_waits_for_read OR de2_ps2_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0 <= de2_ps2_0_avalon_slave_0_end_xfer AND (((NOT de2_ps2_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --de2_ps2_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  de2_ps2_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0 AND de2_ps2_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0 AND NOT de2_ps2_0_avalon_slave_0_non_bursting_master_requests));
  --de2_ps2_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      de2_ps2_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(de2_ps2_0_avalon_slave_0_arb_counter_enable) = '1' then 
        de2_ps2_0_avalon_slave_0_arb_share_counter <= de2_ps2_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --de2_ps2_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      de2_ps2_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((de2_ps2_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_de2_ps2_0_avalon_slave_0 AND NOT de2_ps2_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        de2_ps2_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(de2_ps2_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master de2_ps2_0/avalon_slave_0 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= de2_ps2_0_avalon_slave_0_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --de2_ps2_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  de2_ps2_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(de2_ps2_0_avalon_slave_0_arb_share_counter_next_value);
  --cpu_0/data_master de2_ps2_0/avalon_slave_0 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= de2_ps2_0_avalon_slave_0_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --de2_ps2_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  de2_ps2_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0, which is an e_mux
  cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 <= (internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_read) AND NOT de2_ps2_0_avalon_slave_0_waits_for_read;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0;
  --cpu_0/data_master saved-grant de2_ps2_0/avalon_slave_0, which is an e_assign
  cpu_0_data_master_saved_grant_de2_ps2_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0;
  --allow new arb cycle for de2_ps2_0/avalon_slave_0, which is an e_assign
  de2_ps2_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  de2_ps2_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  de2_ps2_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~de2_ps2_0_avalon_slave_0_reset assignment, which is an e_assign
  de2_ps2_0_avalon_slave_0_reset <= NOT reset_n;
  de2_ps2_0_avalon_slave_0_chipselect <= internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0;
  --de2_ps2_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  de2_ps2_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(de2_ps2_0_avalon_slave_0_begins_xfer) = '1'), de2_ps2_0_avalon_slave_0_unreg_firsttransfer, de2_ps2_0_avalon_slave_0_reg_firsttransfer);
  --de2_ps2_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  de2_ps2_0_avalon_slave_0_unreg_firsttransfer <= NOT ((de2_ps2_0_avalon_slave_0_slavearbiterlockenable AND de2_ps2_0_avalon_slave_0_any_continuerequest));
  --de2_ps2_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      de2_ps2_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(de2_ps2_0_avalon_slave_0_begins_xfer) = '1' then 
        de2_ps2_0_avalon_slave_0_reg_firsttransfer <= de2_ps2_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --de2_ps2_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  de2_ps2_0_avalon_slave_0_beginbursttransfer_internal <= de2_ps2_0_avalon_slave_0_begins_xfer;
  --de2_ps2_0_avalon_slave_0_read assignment, which is an e_mux
  de2_ps2_0_avalon_slave_0_read <= internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_read;
  --de2_ps2_0_avalon_slave_0_address mux, which is an e_mux
  de2_ps2_0_avalon_slave_0_address <= Vector_To_Std_Logic(Std_Logic_Vector'(A_SRL(cpu_0_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & cpu_0_data_master_dbs_address(1 DOWNTO 0)));
  --d1_de2_ps2_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_de2_ps2_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_de2_ps2_0_avalon_slave_0_end_xfer <= de2_ps2_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --de2_ps2_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  de2_ps2_0_avalon_slave_0_waits_for_read <= de2_ps2_0_avalon_slave_0_in_a_read_cycle AND de2_ps2_0_avalon_slave_0_begins_xfer;
  --de2_ps2_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  de2_ps2_0_avalon_slave_0_in_a_read_cycle <= internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= de2_ps2_0_avalon_slave_0_in_a_read_cycle;
  --de2_ps2_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  de2_ps2_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(de2_ps2_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --de2_ps2_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  de2_ps2_0_avalon_slave_0_in_a_write_cycle <= internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= de2_ps2_0_avalon_slave_0_in_a_write_cycle;
  wait_for_de2_ps2_0_avalon_slave_0_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 <= internal_cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0;
--synthesis translate_off
    --de2_ps2_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity jtag_uart_0_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                 signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal jtag_uart_0_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity jtag_uart_0_avalon_jtag_slave_arbitrator;


architecture europa of jtag_uart_0_avalon_jtag_slave_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_jtag_uart_0_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT jtag_uart_0_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  jtag_uart_0_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave);
  --assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_readdata_from_sa <= jtag_uart_0_avalon_jtag_slave_readdata;
  internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(24 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("1000010000001000010000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa <= jtag_uart_0_avalon_jtag_slave_dataavailable;
  --assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa <= jtag_uart_0_avalon_jtag_slave_readyfordata;
  --assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa <= jtag_uart_0_avalon_jtag_slave_waitrequest;
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_arb_share_set_values <= std_logic_vector'("001");
  --jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  --jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(jtag_uart_0_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_0_avalon_jtag_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(jtag_uart_0_avalon_jtag_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_0_avalon_jtag_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_allgrants <= jtag_uart_0_avalon_jtag_slave_grant_vector;
  --jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_end_xfer <= NOT ((jtag_uart_0_avalon_jtag_slave_waits_for_read OR jtag_uart_0_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave <= jtag_uart_0_avalon_jtag_slave_end_xfer AND (((NOT jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave AND jtag_uart_0_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave AND NOT jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests));
  --jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_0_avalon_jtag_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_0_avalon_jtag_slave_arb_counter_enable) = '1' then 
        jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((jtag_uart_0_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave AND NOT jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= or_reduce(jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 <= or_reduce(jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value);
  --cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave, which is an e_mux
  cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave <= (internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read) AND NOT jtag_uart_0_avalon_jtag_slave_waits_for_read;
  --jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  --cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  --allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  jtag_uart_0_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  jtag_uart_0_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_reset_n <= reset_n;
  jtag_uart_0_avalon_jtag_slave_chipselect <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  --jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(jtag_uart_0_avalon_jtag_slave_begins_xfer) = '1'), jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer, jtag_uart_0_avalon_jtag_slave_reg_firsttransfer);
  --jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer <= NOT ((jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable AND jtag_uart_0_avalon_jtag_slave_any_continuerequest));
  --jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_0_avalon_jtag_slave_begins_xfer) = '1' then 
        jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal <= jtag_uart_0_avalon_jtag_slave_begins_xfer;
  --~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_read_n <= NOT ((internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read));
  --~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_write_n <= NOT ((internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_write));
  shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_waits_for_read <= jtag_uart_0_avalon_jtag_slave_in_a_read_cycle AND internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_in_a_read_cycle <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  --jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  jtag_uart_0_avalon_jtag_slave_waits_for_write <= jtag_uart_0_avalon_jtag_slave_in_a_write_cycle AND internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_in_a_write_cycle <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wait_for_jtag_uart_0_avalon_jtag_slave_counter <= std_logic'('0');
  --assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_0_avalon_jtag_slave_irq_from_sa <= jtag_uart_0_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave <= internal_cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  --vhdl renameroo for output signals
  jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa <= internal_jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity niosInterface_1_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal niosInterface_1_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_niosInterface_1_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal niosInterface_1_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                 signal niosInterface_1_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal niosInterface_1_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal niosInterface_1_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal niosInterface_1_0_avalon_slave_0_reset_n : OUT STD_LOGIC;
                 signal niosInterface_1_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal niosInterface_1_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
end entity niosInterface_1_0_avalon_slave_0_arbitrator;


architecture europa of niosInterface_1_0_avalon_slave_0_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal niosInterface_1_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal niosInterface_1_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal niosInterface_1_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_niosInterface_1_0_avalon_slave_0_from_cpu_0_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_niosInterface_1_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT niosInterface_1_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  niosInterface_1_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0);
  --assign niosInterface_1_0_avalon_slave_0_readdata_from_sa = niosInterface_1_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  niosInterface_1_0_avalon_slave_0_readdata_from_sa <= niosInterface_1_0_avalon_slave_0_readdata;
  internal_cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(24 DOWNTO 7) & std_logic_vector'("0000000")) = std_logic_vector'("1000010000001000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --niosInterface_1_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  niosInterface_1_0_avalon_slave_0_arb_share_set_values <= std_logic_vector'("001");
  --niosInterface_1_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  niosInterface_1_0_avalon_slave_0_non_bursting_master_requests <= internal_cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0;
  --niosInterface_1_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  niosInterface_1_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --niosInterface_1_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  niosInterface_1_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(niosInterface_1_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (niosInterface_1_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(niosInterface_1_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (niosInterface_1_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --niosInterface_1_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  niosInterface_1_0_avalon_slave_0_allgrants <= niosInterface_1_0_avalon_slave_0_grant_vector;
  --niosInterface_1_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  niosInterface_1_0_avalon_slave_0_end_xfer <= NOT ((niosInterface_1_0_avalon_slave_0_waits_for_read OR niosInterface_1_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0 <= niosInterface_1_0_avalon_slave_0_end_xfer AND (((NOT niosInterface_1_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --niosInterface_1_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  niosInterface_1_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0 AND niosInterface_1_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0 AND NOT niosInterface_1_0_avalon_slave_0_non_bursting_master_requests));
  --niosInterface_1_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      niosInterface_1_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(niosInterface_1_0_avalon_slave_0_arb_counter_enable) = '1' then 
        niosInterface_1_0_avalon_slave_0_arb_share_counter <= niosInterface_1_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --niosInterface_1_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      niosInterface_1_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((niosInterface_1_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_niosInterface_1_0_avalon_slave_0 AND NOT niosInterface_1_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        niosInterface_1_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(niosInterface_1_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master niosInterface_1_0/avalon_slave_0 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= niosInterface_1_0_avalon_slave_0_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --niosInterface_1_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  niosInterface_1_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(niosInterface_1_0_avalon_slave_0_arb_share_counter_next_value);
  --cpu_0/data_master niosInterface_1_0/avalon_slave_0 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= niosInterface_1_0_avalon_slave_0_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --niosInterface_1_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  niosInterface_1_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 AND NOT ((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register)))));
  --local readdatavalid cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0, which is an e_mux
  cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 <= (internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 AND cpu_0_data_master_read) AND NOT niosInterface_1_0_avalon_slave_0_waits_for_read;
  --niosInterface_1_0_avalon_slave_0_writedata mux, which is an e_mux
  niosInterface_1_0_avalon_slave_0_writedata <= cpu_0_data_master_writedata;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0;
  --cpu_0/data_master saved-grant niosInterface_1_0/avalon_slave_0, which is an e_assign
  cpu_0_data_master_saved_grant_niosInterface_1_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0;
  --allow new arb cycle for niosInterface_1_0/avalon_slave_0, which is an e_assign
  niosInterface_1_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  niosInterface_1_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  niosInterface_1_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --niosInterface_1_0_avalon_slave_0_reset_n assignment, which is an e_assign
  niosInterface_1_0_avalon_slave_0_reset_n <= reset_n;
  niosInterface_1_0_avalon_slave_0_chipselect <= internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0;
  --niosInterface_1_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  niosInterface_1_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(niosInterface_1_0_avalon_slave_0_begins_xfer) = '1'), niosInterface_1_0_avalon_slave_0_unreg_firsttransfer, niosInterface_1_0_avalon_slave_0_reg_firsttransfer);
  --niosInterface_1_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  niosInterface_1_0_avalon_slave_0_unreg_firsttransfer <= NOT ((niosInterface_1_0_avalon_slave_0_slavearbiterlockenable AND niosInterface_1_0_avalon_slave_0_any_continuerequest));
  --niosInterface_1_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      niosInterface_1_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(niosInterface_1_0_avalon_slave_0_begins_xfer) = '1' then 
        niosInterface_1_0_avalon_slave_0_reg_firsttransfer <= niosInterface_1_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --niosInterface_1_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  niosInterface_1_0_avalon_slave_0_beginbursttransfer_internal <= niosInterface_1_0_avalon_slave_0_begins_xfer;
  --niosInterface_1_0_avalon_slave_0_read assignment, which is an e_mux
  niosInterface_1_0_avalon_slave_0_read <= internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 AND cpu_0_data_master_read;
  --niosInterface_1_0_avalon_slave_0_write assignment, which is an e_mux
  niosInterface_1_0_avalon_slave_0_write <= internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 AND cpu_0_data_master_write;
  shifted_address_to_niosInterface_1_0_avalon_slave_0_from_cpu_0_data_master <= cpu_0_data_master_address_to_slave;
  --niosInterface_1_0_avalon_slave_0_address mux, which is an e_mux
  niosInterface_1_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_niosInterface_1_0_avalon_slave_0_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000010")), 5);
  --d1_niosInterface_1_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_niosInterface_1_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_niosInterface_1_0_avalon_slave_0_end_xfer <= niosInterface_1_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --niosInterface_1_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  niosInterface_1_0_avalon_slave_0_waits_for_read <= niosInterface_1_0_avalon_slave_0_in_a_read_cycle AND niosInterface_1_0_avalon_slave_0_begins_xfer;
  --niosInterface_1_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  niosInterface_1_0_avalon_slave_0_in_a_read_cycle <= internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= niosInterface_1_0_avalon_slave_0_in_a_read_cycle;
  --niosInterface_1_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  niosInterface_1_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(niosInterface_1_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --niosInterface_1_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  niosInterface_1_0_avalon_slave_0_in_a_write_cycle <= internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= niosInterface_1_0_avalon_slave_0_in_a_write_cycle;
  wait_for_niosInterface_1_0_avalon_slave_0_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 <= internal_cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0;
--synthesis translate_off
    --niosInterface_1_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module;


architecture europa of rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module;


architecture europa of rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity sdram_0_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_instruction_master_read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_0_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_readdatavalid : IN STD_LOGIC;
                 signal sdram_0_s1_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal cpu_0_data_master_byteenable_sdram_0_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_0_instruction_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                 signal d1_sdram_0_s1_end_xfer : OUT STD_LOGIC;
                 signal sdram_0_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal sdram_0_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal sdram_0_s1_chipselect : OUT STD_LOGIC;
                 signal sdram_0_s1_read_n : OUT STD_LOGIC;
                 signal sdram_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_0_s1_reset_n : OUT STD_LOGIC;
                 signal sdram_0_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal sdram_0_s1_write_n : OUT STD_LOGIC;
                 signal sdram_0_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sdram_0_s1_arbitrator;


architecture europa of sdram_0_s1_arbitrator is
component rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module;

component rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module;

                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_sdram_0_s1_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_byteenable_sdram_0_s1_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_rdv_fifo_empty_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_saved_grant_sdram_0_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sdram_0_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_byteenable_sdram_0_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_data_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal internal_cpu_0_instruction_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal internal_sdram_0_s1_waitrequest_from_sa :  STD_LOGIC;
                signal last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 :  STD_LOGIC;
                signal last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal sdram_0_s1_allgrants :  STD_LOGIC;
                signal sdram_0_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal sdram_0_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sdram_0_s1_any_continuerequest :  STD_LOGIC;
                signal sdram_0_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_arb_counter_enable :  STD_LOGIC;
                signal sdram_0_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_0_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_0_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_0_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal sdram_0_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal sdram_0_s1_begins_xfer :  STD_LOGIC;
                signal sdram_0_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal sdram_0_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_end_xfer :  STD_LOGIC;
                signal sdram_0_s1_firsttransfer :  STD_LOGIC;
                signal sdram_0_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_in_a_read_cycle :  STD_LOGIC;
                signal sdram_0_s1_in_a_write_cycle :  STD_LOGIC;
                signal sdram_0_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal sdram_0_s1_non_bursting_master_requests :  STD_LOGIC;
                signal sdram_0_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal sdram_0_s1_reg_firsttransfer :  STD_LOGIC;
                signal sdram_0_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_slavearbiterlockenable :  STD_LOGIC;
                signal sdram_0_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal sdram_0_s1_unreg_firsttransfer :  STD_LOGIC;
                signal sdram_0_s1_waits_for_read :  STD_LOGIC;
                signal sdram_0_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_sdram_0_s1_from_cpu_0_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_sdram_0_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT sdram_0_s1_end_xfer;
    end if;

  end process;

  sdram_0_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_0_data_master_qualified_request_sdram_0_s1 OR internal_cpu_0_instruction_master_qualified_request_sdram_0_s1));
  --assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_0_s1_readdatavalid_from_sa <= sdram_0_s1_readdatavalid;
  --assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_0_s1_readdata_from_sa <= sdram_0_s1_readdata;
  internal_cpu_0_data_master_requests_sdram_0_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(24 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0100000000000000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_sdram_0_s1_waitrequest_from_sa <= sdram_0_s1_waitrequest;
  --sdram_0_s1_arb_share_counter set values, which is an e_mux
  sdram_0_s1_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_0_instruction_master_granted_sdram_0_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  sdram_0_s1_non_bursting_master_requests <= ((internal_cpu_0_data_master_requests_sdram_0_s1 OR internal_cpu_0_instruction_master_requests_sdram_0_s1) OR internal_cpu_0_data_master_requests_sdram_0_s1) OR internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  sdram_0_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  sdram_0_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sdram_0_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_0_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sdram_0_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_0_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --sdram_0_s1_allgrants all slave grants, which is an e_mux
  sdram_0_s1_allgrants <= (((or_reduce(sdram_0_s1_grant_vector)) OR (or_reduce(sdram_0_s1_grant_vector))) OR (or_reduce(sdram_0_s1_grant_vector))) OR (or_reduce(sdram_0_s1_grant_vector));
  --sdram_0_s1_end_xfer assignment, which is an e_assign
  sdram_0_s1_end_xfer <= NOT ((sdram_0_s1_waits_for_read OR sdram_0_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sdram_0_s1 <= sdram_0_s1_end_xfer AND (((NOT sdram_0_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  sdram_0_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sdram_0_s1 AND sdram_0_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_sdram_0_s1 AND NOT sdram_0_s1_non_bursting_master_requests));
  --sdram_0_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_0_s1_arb_counter_enable) = '1' then 
        sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(sdram_0_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_sdram_0_s1)) OR ((end_xfer_arb_share_counter_term_sdram_0_s1 AND NOT sdram_0_s1_non_bursting_master_requests)))) = '1' then 
        sdram_0_s1_slavearbiterlockenable <= or_reduce(sdram_0_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master sdram_0/s1 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= sdram_0_s1_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sdram_0_s1_slavearbiterlockenable2 <= or_reduce(sdram_0_s1_arb_share_counter_next_value);
  --cpu_0/data_master sdram_0/s1 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= sdram_0_s1_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --cpu_0/instruction_master sdram_0/s1 arbiterlock, which is an e_assign
  cpu_0_instruction_master_arbiterlock <= sdram_0_s1_slavearbiterlockenable AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master sdram_0/s1 arbiterlock2, which is an e_assign
  cpu_0_instruction_master_arbiterlock2 <= sdram_0_s1_slavearbiterlockenable2 AND cpu_0_instruction_master_continuerequest;
  --cpu_0/instruction_master granted sdram_0/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_instruction_master_saved_grant_sdram_0_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_0_s1_arbitration_holdoff_internal OR NOT internal_cpu_0_instruction_master_requests_sdram_0_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1))))));
    end if;

  end process;

  --cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  cpu_0_instruction_master_continuerequest <= last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 AND internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  sdram_0_s1_any_continuerequest <= cpu_0_instruction_master_continuerequest OR cpu_0_data_master_continuerequest;
  internal_cpu_0_data_master_qualified_request_sdram_0_s1 <= internal_cpu_0_data_master_requests_sdram_0_s1 AND NOT (((((cpu_0_data_master_read AND to_std_logic((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter)))))))))) OR (((NOT(or_reduce(internal_cpu_0_data_master_byteenable_sdram_0_s1))) AND cpu_0_data_master_write))) OR cpu_0_instruction_master_arbiterlock));
  --unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  sdram_0_s1_move_on_to_next_transaction <= sdram_0_s1_readdatavalid_from_sa;
  --rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1 : rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module
    port map(
      data_out => cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1,
      empty => open,
      fifo_contains_ones_n => cpu_0_data_master_rdv_fifo_empty_sdram_0_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_cpu_0_data_master_granted_sdram_0_s1,
      read => sdram_0_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT sdram_0_s1_waits_for_read;

  cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register <= NOT cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  --local readdatavalid cpu_0_data_master_read_data_valid_sdram_0_s1, which is an e_mux
  cpu_0_data_master_read_data_valid_sdram_0_s1 <= ((sdram_0_s1_readdatavalid_from_sa AND cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1)) AND NOT cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  --sdram_0_s1_writedata mux, which is an e_mux
  sdram_0_s1_writedata <= cpu_0_data_master_dbs_write_16;
  internal_cpu_0_instruction_master_requests_sdram_0_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_0_instruction_master_address_to_slave(24 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0100000000000000000000000")))) AND (cpu_0_instruction_master_read))) AND cpu_0_instruction_master_read;
  --cpu_0/data_master granted sdram_0/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_0_data_master_saved_grant_sdram_0_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_0_s1_arbitration_holdoff_internal OR NOT internal_cpu_0_data_master_requests_sdram_0_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1))))));
    end if;

  end process;

  --cpu_0_data_master_continuerequest continued request, which is an e_mux
  cpu_0_data_master_continuerequest <= last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 AND internal_cpu_0_data_master_requests_sdram_0_s1;
  internal_cpu_0_instruction_master_qualified_request_sdram_0_s1 <= internal_cpu_0_instruction_master_requests_sdram_0_s1 AND NOT ((((cpu_0_instruction_master_read AND to_std_logic((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000"))) OR ((std_logic_vector'("00000000000000000000000000000001")<(std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_latency_counter)))))))))) OR cpu_0_data_master_arbiterlock));
  --rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1 : rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module
    port map(
      data_out => cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1,
      empty => open,
      fifo_contains_ones_n => cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => internal_cpu_0_instruction_master_granted_sdram_0_s1,
      read => sdram_0_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= in_a_read_cycle AND NOT sdram_0_s1_waits_for_read;

  cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register <= NOT cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  --local readdatavalid cpu_0_instruction_master_read_data_valid_sdram_0_s1, which is an e_mux
  cpu_0_instruction_master_read_data_valid_sdram_0_s1 <= ((sdram_0_s1_readdatavalid_from_sa AND cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1)) AND NOT cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  --allow new arb cycle for sdram_0/s1, which is an e_assign
  sdram_0_s1_allow_new_arb_cycle <= NOT cpu_0_data_master_arbiterlock AND NOT cpu_0_instruction_master_arbiterlock;
  --cpu_0/instruction_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  sdram_0_s1_master_qreq_vector(0) <= internal_cpu_0_instruction_master_qualified_request_sdram_0_s1;
  --cpu_0/instruction_master grant sdram_0/s1, which is an e_assign
  internal_cpu_0_instruction_master_granted_sdram_0_s1 <= sdram_0_s1_grant_vector(0);
  --cpu_0/instruction_master saved-grant sdram_0/s1, which is an e_assign
  cpu_0_instruction_master_saved_grant_sdram_0_s1 <= sdram_0_s1_arb_winner(0) AND internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --cpu_0/data_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  sdram_0_s1_master_qreq_vector(1) <= internal_cpu_0_data_master_qualified_request_sdram_0_s1;
  --cpu_0/data_master grant sdram_0/s1, which is an e_assign
  internal_cpu_0_data_master_granted_sdram_0_s1 <= sdram_0_s1_grant_vector(1);
  --cpu_0/data_master saved-grant sdram_0/s1, which is an e_assign
  cpu_0_data_master_saved_grant_sdram_0_s1 <= sdram_0_s1_arb_winner(1) AND internal_cpu_0_data_master_requests_sdram_0_s1;
  --sdram_0/s1 chosen-master double-vector, which is an e_assign
  sdram_0_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((sdram_0_s1_master_qreq_vector & sdram_0_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT sdram_0_s1_master_qreq_vector & NOT sdram_0_s1_master_qreq_vector))) + (std_logic_vector'("000") & (sdram_0_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  sdram_0_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((sdram_0_s1_allow_new_arb_cycle AND or_reduce(sdram_0_s1_grant_vector)))) = '1'), sdram_0_s1_grant_vector, sdram_0_s1_saved_chosen_master_vector);
  --saved sdram_0_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_0_s1_allow_new_arb_cycle) = '1' then 
        sdram_0_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(sdram_0_s1_grant_vector)) = '1'), sdram_0_s1_grant_vector, sdram_0_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  sdram_0_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((sdram_0_s1_chosen_master_double_vector(1) OR sdram_0_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((sdram_0_s1_chosen_master_double_vector(0) OR sdram_0_s1_chosen_master_double_vector(2)))));
  --sdram_0/s1 chosen master rotated left, which is an e_assign
  sdram_0_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(sdram_0_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(sdram_0_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --sdram_0/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(sdram_0_s1_grant_vector)) = '1' then 
        sdram_0_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(sdram_0_s1_end_xfer) = '1'), sdram_0_s1_chosen_master_rot_left, sdram_0_s1_grant_vector);
      end if;
    end if;

  end process;

  --sdram_0_s1_reset_n assignment, which is an e_assign
  sdram_0_s1_reset_n <= reset_n;
  sdram_0_s1_chipselect <= internal_cpu_0_data_master_granted_sdram_0_s1 OR internal_cpu_0_instruction_master_granted_sdram_0_s1;
  --sdram_0_s1_firsttransfer first transaction, which is an e_assign
  sdram_0_s1_firsttransfer <= A_WE_StdLogic((std_logic'(sdram_0_s1_begins_xfer) = '1'), sdram_0_s1_unreg_firsttransfer, sdram_0_s1_reg_firsttransfer);
  --sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  sdram_0_s1_unreg_firsttransfer <= NOT ((sdram_0_s1_slavearbiterlockenable AND sdram_0_s1_any_continuerequest));
  --sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_0_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_0_s1_begins_xfer) = '1' then 
        sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sdram_0_s1_beginbursttransfer_internal <= sdram_0_s1_begins_xfer;
  --sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  sdram_0_s1_arbitration_holdoff_internal <= sdram_0_s1_begins_xfer AND sdram_0_s1_firsttransfer;
  --~sdram_0_s1_read_n assignment, which is an e_mux
  sdram_0_s1_read_n <= NOT ((((internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_sdram_0_s1 AND cpu_0_instruction_master_read))));
  --~sdram_0_s1_write_n assignment, which is an e_mux
  sdram_0_s1_write_n <= NOT ((internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_write));
  shifted_address_to_sdram_0_s1_from_cpu_0_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_0_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_0_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --sdram_0_s1_address mux, which is an e_mux
  sdram_0_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), (A_SRL(shifted_address_to_sdram_0_s1_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000001"))), (A_SRL(shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master,std_logic_vector'("00000000000000000000000000000001")))), 22);
  shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_0_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_0_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --d1_sdram_0_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sdram_0_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end if;

  end process;

  --sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  sdram_0_s1_waits_for_read <= sdram_0_s1_in_a_read_cycle AND internal_sdram_0_s1_waitrequest_from_sa;
  --sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  sdram_0_s1_in_a_read_cycle <= ((internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_read)) OR ((internal_cpu_0_instruction_master_granted_sdram_0_s1 AND cpu_0_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sdram_0_s1_in_a_read_cycle;
  --sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  sdram_0_s1_waits_for_write <= sdram_0_s1_in_a_write_cycle AND internal_sdram_0_s1_waitrequest_from_sa;
  --sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  sdram_0_s1_in_a_write_cycle <= internal_cpu_0_data_master_granted_sdram_0_s1 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sdram_0_s1_in_a_write_cycle;
  wait_for_sdram_0_s1_counter <= std_logic'('0');
  --~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  sdram_0_s1_byteenable_n <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_sdram_0_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_0_data_master_byteenable_sdram_0_s1)), -SIGNED(std_logic_vector'("00000000000000000000000000000001")))), 2);
  (cpu_0_data_master_byteenable_sdram_0_s1_segment_1(1), cpu_0_data_master_byteenable_sdram_0_s1_segment_1(0), cpu_0_data_master_byteenable_sdram_0_s1_segment_0(1), cpu_0_data_master_byteenable_sdram_0_s1_segment_0(0)) <= cpu_0_data_master_byteenable;
  internal_cpu_0_data_master_byteenable_sdram_0_s1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_0_data_master_byteenable_sdram_0_s1_segment_0, cpu_0_data_master_byteenable_sdram_0_s1_segment_1);
  --vhdl renameroo for output signals
  cpu_0_data_master_byteenable_sdram_0_s1 <= internal_cpu_0_data_master_byteenable_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_sdram_0_s1 <= internal_cpu_0_data_master_granted_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_sdram_0_s1 <= internal_cpu_0_data_master_qualified_request_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_sdram_0_s1 <= internal_cpu_0_data_master_requests_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_granted_sdram_0_s1 <= internal_cpu_0_instruction_master_granted_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_qualified_request_sdram_0_s1 <= internal_cpu_0_instruction_master_qualified_request_sdram_0_s1;
  --vhdl renameroo for output signals
  cpu_0_instruction_master_requests_sdram_0_s1 <= internal_cpu_0_instruction_master_requests_sdram_0_s1;
  --vhdl renameroo for output signals
  sdram_0_s1_waitrequest_from_sa <= internal_sdram_0_s1_waitrequest_from_sa;
--synthesis translate_off
    --sdram_0/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_data_master_granted_sdram_0_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_0_instruction_master_granted_sdram_0_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line9.all);
          deallocate (write_line9);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line10 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_saved_grant_sdram_0_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_0_instruction_master_saved_grant_sdram_0_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line10, now);
          write(write_line10, string'(": "));
          write(write_line10, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line10.all);
          deallocate (write_line10);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity skygen_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                 signal cpu_0_data_master_read : IN STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                 signal cpu_0_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal skygen_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_0_data_master_granted_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_0_data_master_requests_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_skygen_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal skygen_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal skygen_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal skygen_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal skygen_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal skygen_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal skygen_0_avalon_slave_0_reset_n : OUT STD_LOGIC;
                 signal skygen_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal skygen_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity skygen_0_avalon_slave_0_arbitrator;


architecture europa of skygen_0_avalon_slave_0_arbitrator is
                signal cpu_0_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_0_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_continuerequest :  STD_LOGIC;
                signal cpu_0_data_master_saved_grant_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_0_data_master_requests_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal shifted_address_to_skygen_0_avalon_slave_0_from_cpu_0_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal skygen_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal skygen_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal skygen_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal skygen_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal wait_for_skygen_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT skygen_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  skygen_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0);
  --assign skygen_0_avalon_slave_0_readdata_from_sa = skygen_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  skygen_0_avalon_slave_0_readdata_from_sa <= skygen_0_avalon_slave_0_readdata;
  internal_cpu_0_data_master_requests_skygen_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(cpu_0_data_master_address_to_slave(24 DOWNTO 19) & std_logic_vector'("0000000000000000000")) = std_logic_vector'("1000000000000000000000000")))) AND ((cpu_0_data_master_read OR cpu_0_data_master_write));
  --skygen_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  skygen_0_avalon_slave_0_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001")), 3);
  --skygen_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  skygen_0_avalon_slave_0_non_bursting_master_requests <= internal_cpu_0_data_master_requests_skygen_0_avalon_slave_0;
  --skygen_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  skygen_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --skygen_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  skygen_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(skygen_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (skygen_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(skygen_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (skygen_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --skygen_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  skygen_0_avalon_slave_0_allgrants <= skygen_0_avalon_slave_0_grant_vector;
  --skygen_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  skygen_0_avalon_slave_0_end_xfer <= NOT ((skygen_0_avalon_slave_0_waits_for_read OR skygen_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0 <= skygen_0_avalon_slave_0_end_xfer AND (((NOT skygen_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --skygen_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  skygen_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0 AND skygen_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0 AND NOT skygen_0_avalon_slave_0_non_bursting_master_requests));
  --skygen_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      skygen_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(skygen_0_avalon_slave_0_arb_counter_enable) = '1' then 
        skygen_0_avalon_slave_0_arb_share_counter <= skygen_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --skygen_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      skygen_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((skygen_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_skygen_0_avalon_slave_0 AND NOT skygen_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        skygen_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(skygen_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu_0/data_master skygen_0/avalon_slave_0 arbiterlock, which is an e_assign
  cpu_0_data_master_arbiterlock <= skygen_0_avalon_slave_0_slavearbiterlockenable AND cpu_0_data_master_continuerequest;
  --skygen_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  skygen_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(skygen_0_avalon_slave_0_arb_share_counter_next_value);
  --cpu_0/data_master skygen_0/avalon_slave_0 arbiterlock2, which is an e_assign
  cpu_0_data_master_arbiterlock2 <= skygen_0_avalon_slave_0_slavearbiterlockenable2 AND cpu_0_data_master_continuerequest;
  --skygen_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  skygen_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --cpu_0_data_master_continuerequest continued request, which is an e_assign
  cpu_0_data_master_continuerequest <= std_logic'('1');
  internal_cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_skygen_0_avalon_slave_0 AND NOT ((((cpu_0_data_master_read AND ((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_latency_counter))) /= std_logic_vector'("00000000000000000000000000000000")))) OR (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))))) OR (((NOT(or_reduce(internal_cpu_0_data_master_byteenable_skygen_0_avalon_slave_0))) AND cpu_0_data_master_write))));
  --local readdatavalid cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0, which is an e_mux
  cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 <= (internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_read) AND NOT skygen_0_avalon_slave_0_waits_for_read;
  --skygen_0_avalon_slave_0_writedata mux, which is an e_mux
  skygen_0_avalon_slave_0_writedata <= cpu_0_data_master_dbs_write_16;
  --master is always granted when requested
  internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0;
  --cpu_0/data_master saved-grant skygen_0/avalon_slave_0, which is an e_assign
  cpu_0_data_master_saved_grant_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_skygen_0_avalon_slave_0;
  --allow new arb cycle for skygen_0/avalon_slave_0, which is an e_assign
  skygen_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  skygen_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  skygen_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --skygen_0_avalon_slave_0_reset_n assignment, which is an e_assign
  skygen_0_avalon_slave_0_reset_n <= reset_n;
  skygen_0_avalon_slave_0_chipselect <= internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0;
  --skygen_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  skygen_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(skygen_0_avalon_slave_0_begins_xfer) = '1'), skygen_0_avalon_slave_0_unreg_firsttransfer, skygen_0_avalon_slave_0_reg_firsttransfer);
  --skygen_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  skygen_0_avalon_slave_0_unreg_firsttransfer <= NOT ((skygen_0_avalon_slave_0_slavearbiterlockenable AND skygen_0_avalon_slave_0_any_continuerequest));
  --skygen_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      skygen_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(skygen_0_avalon_slave_0_begins_xfer) = '1' then 
        skygen_0_avalon_slave_0_reg_firsttransfer <= skygen_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --skygen_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  skygen_0_avalon_slave_0_beginbursttransfer_internal <= skygen_0_avalon_slave_0_begins_xfer;
  --skygen_0_avalon_slave_0_read assignment, which is an e_mux
  skygen_0_avalon_slave_0_read <= internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_read;
  --skygen_0_avalon_slave_0_write assignment, which is an e_mux
  skygen_0_avalon_slave_0_write <= internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_write;
  shifted_address_to_skygen_0_avalon_slave_0_from_cpu_0_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_0_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_0_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --skygen_0_avalon_slave_0_address mux, which is an e_mux
  skygen_0_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_skygen_0_avalon_slave_0_from_cpu_0_data_master,std_logic_vector'("00000000000000000000000000000001")), 18);
  --d1_skygen_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_skygen_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_skygen_0_avalon_slave_0_end_xfer <= skygen_0_avalon_slave_0_end_xfer;
    end if;

  end process;

  --skygen_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  skygen_0_avalon_slave_0_waits_for_read <= skygen_0_avalon_slave_0_in_a_read_cycle AND skygen_0_avalon_slave_0_begins_xfer;
  --skygen_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  skygen_0_avalon_slave_0_in_a_read_cycle <= internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= skygen_0_avalon_slave_0_in_a_read_cycle;
  --skygen_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  skygen_0_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(skygen_0_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --skygen_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  skygen_0_avalon_slave_0_in_a_write_cycle <= internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0 AND cpu_0_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= skygen_0_avalon_slave_0_in_a_write_cycle;
  wait_for_skygen_0_avalon_slave_0_counter <= std_logic'('0');
  --skygen_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  skygen_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_0_data_master_byteenable_skygen_0_avalon_slave_0)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 2);
  (cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_1(1), cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_1(0), cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_0(1), cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_0(0)) <= cpu_0_data_master_byteenable;
  internal_cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_0, cpu_0_data_master_byteenable_skygen_0_avalon_slave_0_segment_1);
  --vhdl renameroo for output signals
  cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_byteenable_skygen_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_granted_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_granted_skygen_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_0_data_master_requests_skygen_0_avalon_slave_0 <= internal_cpu_0_data_master_requests_skygen_0_avalon_slave_0;
--synthesis translate_off
    --skygen_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity new_doom_reset_clk_0_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity new_doom_reset_clk_0_domain_synch_module;


architecture europa of new_doom_reset_clk_0_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity new_doom is 
        port (
              -- 1) global signals:
                 signal clk_0 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_de2_ps2_0
                 signal PS2_Clk_to_the_de2_ps2_0 : IN STD_LOGIC;
                 signal PS2_Data_to_the_de2_ps2_0 : IN STD_LOGIC;

              -- the_niosInterface_1_0
                 signal ctrl_from_the_niosInterface_1_0 : OUT STD_LOGIC;
                 signal hardware_data_to_the_niosInterface_1_0 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal nios_data_from_the_niosInterface_1_0 : OUT STD_LOGIC_VECTOR (255 DOWNTO 0);

              -- the_sdram_0
                 signal zs_addr_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal zs_ba_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_cas_n_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_cke_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_cs_n_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_dq_to_and_from_the_sdram_0 : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal zs_dqm_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_ras_n_from_the_sdram_0 : OUT STD_LOGIC;
                 signal zs_we_n_from_the_sdram_0 : OUT STD_LOGIC;

              -- the_skygen_0
                 signal Cur_Row_in_to_the_skygen_0 : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal FB_angle_in_to_the_skygen_0 : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal SRAM_ADDR_from_the_skygen_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal SRAM_CE_N_from_the_skygen_0 : OUT STD_LOGIC;
                 signal SRAM_DQ_to_and_from_the_skygen_0 : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_LB_N_from_the_skygen_0 : OUT STD_LOGIC;
                 signal SRAM_OE_N_from_the_skygen_0 : OUT STD_LOGIC;
                 signal SRAM_UB_N_from_the_skygen_0 : OUT STD_LOGIC;
                 signal SRAM_WE_N_from_the_skygen_0 : OUT STD_LOGIC;
                 signal Sky_pixel_from_the_skygen_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal Sram_mux_out_from_the_skygen_0 : OUT STD_LOGIC
              );
end entity new_doom;


architecture europa of new_doom is
component cpu_0_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_reset_n : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_write : OUT STD_LOGIC;
                    signal cpu_0_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_0_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component cpu_0_jtag_debug_module_arbitrator;

component cpu_0_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_byteenable_sdram_0_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_granted_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_data_master_requests_skygen_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_de2_ps2_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_niosInterface_1_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                    signal d1_skygen_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal de2_ps2_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal niosInterface_1_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;
                    signal skygen_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : OUT STD_LOGIC;
                    signal cpu_0_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_data_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_0_data_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_0_data_master_arbitrator;

component cpu_0_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_instruction_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_granted_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_0_instruction_master_requests_sdram_0_s1 : IN STD_LOGIC;
                    signal cpu_0_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_0_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_0_s1_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_0_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_0_instruction_master_readdatavalid : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_0_instruction_master_arbitrator;

component cpu_0 is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdatavalid : IN STD_LOGIC;
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_readdatavalid : IN STD_LOGIC;
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component cpu_0;

component de2_ps2_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal de2_ps2_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_de2_ps2_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal de2_ps2_0_avalon_slave_0_address : OUT STD_LOGIC;
                    signal de2_ps2_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal de2_ps2_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal de2_ps2_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal de2_ps2_0_avalon_slave_0_reset : OUT STD_LOGIC
                 );
end component de2_ps2_0_avalon_slave_0_arbitrator;

component de2_ps2_0 is 
           port (
                 -- inputs:
                    signal PS2_Clk : IN STD_LOGIC;
                    signal PS2_Data : IN STD_LOGIC;
                    signal address : IN STD_LOGIC_VECTOR (0 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component de2_ps2_0;

component jtag_uart_0_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave : OUT STD_LOGIC;
                    signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal jtag_uart_0_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component jtag_uart_0_avalon_jtag_slave_arbitrator;

component jtag_uart_0 is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component jtag_uart_0;

component niosInterface_1_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal niosInterface_1_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_niosInterface_1_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal niosInterface_1_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal niosInterface_1_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal niosInterface_1_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal niosInterface_1_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal niosInterface_1_0_avalon_slave_0_reset_n : OUT STD_LOGIC;
                    signal niosInterface_1_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal niosInterface_1_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component niosInterface_1_0_avalon_slave_0_arbitrator;

component niosInterface_1_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal hardware_data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal ctrl : OUT STD_LOGIC;
                    signal nios_data : OUT STD_LOGIC_VECTOR (255 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component niosInterface_1_0;

component sdram_0_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal cpu_0_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_instruction_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_instruction_master_read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_0_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_readdatavalid : IN STD_LOGIC;
                    signal sdram_0_s1_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_0_data_master_byteenable_sdram_0_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_granted_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_qualified_request_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_0_instruction_master_requests_sdram_0_s1 : OUT STD_LOGIC;
                    signal d1_sdram_0_s1_end_xfer : OUT STD_LOGIC;
                    signal sdram_0_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal sdram_0_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal sdram_0_s1_chipselect : OUT STD_LOGIC;
                    signal sdram_0_s1_read_n : OUT STD_LOGIC;
                    signal sdram_0_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_0_s1_reset_n : OUT STD_LOGIC;
                    signal sdram_0_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal sdram_0_s1_write_n : OUT STD_LOGIC;
                    signal sdram_0_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sdram_0_s1_arbitrator;

component sdram_0 is 
           port (
                 -- inputs:
                    signal az_addr : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal az_be_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal az_cs : IN STD_LOGIC;
                    signal az_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal az_rd_n : IN STD_LOGIC;
                    signal az_wr_n : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal za_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal za_valid : OUT STD_LOGIC;
                    signal za_waitrequest : OUT STD_LOGIC;
                    signal zs_addr : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n : OUT STD_LOGIC;
                    signal zs_cke : OUT STD_LOGIC;
                    signal zs_cs_n : OUT STD_LOGIC;
                    signal zs_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n : OUT STD_LOGIC;
                    signal zs_we_n : OUT STD_LOGIC
                 );
end component sdram_0;

component skygen_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_0_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_0_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_0_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_0_data_master_latency_counter : IN STD_LOGIC;
                    signal cpu_0_data_master_read : IN STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register : IN STD_LOGIC;
                    signal cpu_0_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal skygen_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_0_data_master_granted_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_0_data_master_requests_skygen_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_skygen_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal skygen_0_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal skygen_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal skygen_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal skygen_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal skygen_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal skygen_0_avalon_slave_0_reset_n : OUT STD_LOGIC;
                    signal skygen_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal skygen_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component skygen_0_avalon_slave_0_arbitrator;

component skygen_0 is 
           port (
                 -- inputs:
                    signal Cur_Row_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal FB_angle_in : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal SRAM_ADDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_CE_N : OUT STD_LOGIC;
                    signal SRAM_DQ : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_LB_N : OUT STD_LOGIC;
                    signal SRAM_OE_N : OUT STD_LOGIC;
                    signal SRAM_UB_N : OUT STD_LOGIC;
                    signal SRAM_WE_N : OUT STD_LOGIC;
                    signal Sky_pixel : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal Sram_mux_out : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component skygen_0;

component new_doom_reset_clk_0_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component new_doom_reset_clk_0_domain_synch_module;

                signal clk_0_reset_n :  STD_LOGIC;
                signal cpu_0_data_master_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_0_data_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_0_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_data_master_byteenable_sdram_0_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_data_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal cpu_0_data_master_debugaccess :  STD_LOGIC;
                signal cpu_0_data_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_granted_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_data_master_latency_counter :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_read :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register :  STD_LOGIC;
                signal cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_data_master_readdatavalid :  STD_LOGIC;
                signal cpu_0_data_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_data_master_requests_skygen_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_0_data_master_waitrequest :  STD_LOGIC;
                signal cpu_0_data_master_write :  STD_LOGIC;
                signal cpu_0_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_instruction_master_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_0_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_0_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_0_instruction_master_granted_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_granted_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_latency_counter :  STD_LOGIC;
                signal cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_qualified_request_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_read :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register :  STD_LOGIC;
                signal cpu_0_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_instruction_master_readdatavalid :  STD_LOGIC;
                signal cpu_0_instruction_master_requests_cpu_0_jtag_debug_module :  STD_LOGIC;
                signal cpu_0_instruction_master_requests_sdram_0_s1 :  STD_LOGIC;
                signal cpu_0_instruction_master_waitrequest :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal cpu_0_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_0_jtag_debug_module_chipselect :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_0_jtag_debug_module_reset_n :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_write :  STD_LOGIC;
                signal cpu_0_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_cpu_0_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_de2_ps2_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_jtag_uart_0_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_niosInterface_1_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_sdram_0_s1_end_xfer :  STD_LOGIC;
                signal d1_skygen_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_address :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_chipselect :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_read :  STD_LOGIC;
                signal de2_ps2_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal de2_ps2_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal de2_ps2_0_avalon_slave_0_reset :  STD_LOGIC;
                signal internal_SRAM_ADDR_from_the_skygen_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_SRAM_CE_N_from_the_skygen_0 :  STD_LOGIC;
                signal internal_SRAM_LB_N_from_the_skygen_0 :  STD_LOGIC;
                signal internal_SRAM_OE_N_from_the_skygen_0 :  STD_LOGIC;
                signal internal_SRAM_UB_N_from_the_skygen_0 :  STD_LOGIC;
                signal internal_SRAM_WE_N_from_the_skygen_0 :  STD_LOGIC;
                signal internal_Sky_pixel_from_the_skygen_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_Sram_mux_out_from_the_skygen_0 :  STD_LOGIC;
                signal internal_ctrl_from_the_niosInterface_1_0 :  STD_LOGIC;
                signal internal_nios_data_from_the_niosInterface_1_0 :  STD_LOGIC_VECTOR (255 DOWNTO 0);
                signal internal_zs_addr_from_the_sdram_0 :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal internal_zs_ba_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_cas_n_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_cke_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_cs_n_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_dqm_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_ras_n_from_the_sdram_0 :  STD_LOGIC;
                signal internal_zs_we_n_from_the_sdram_0 :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_address :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_irq :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal module_input6 :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (4 DOWNTO 0);
                signal niosInterface_1_0_avalon_slave_0_chipselect :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_read :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal niosInterface_1_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal niosInterface_1_0_avalon_slave_0_reset_n :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_write :  STD_LOGIC;
                signal niosInterface_1_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal reset_n_sources :  STD_LOGIC;
                signal sdram_0_s1_address :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal sdram_0_s1_byteenable_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_0_s1_chipselect :  STD_LOGIC;
                signal sdram_0_s1_read_n :  STD_LOGIC;
                signal sdram_0_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_0_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_0_s1_readdatavalid :  STD_LOGIC;
                signal sdram_0_s1_reset_n :  STD_LOGIC;
                signal sdram_0_s1_waitrequest :  STD_LOGIC;
                signal sdram_0_s1_waitrequest_from_sa :  STD_LOGIC;
                signal sdram_0_s1_write_n :  STD_LOGIC;
                signal sdram_0_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal skygen_0_avalon_slave_0_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal skygen_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal skygen_0_avalon_slave_0_chipselect :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_read :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal skygen_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal skygen_0_avalon_slave_0_reset_n :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_write :  STD_LOGIC;
                signal skygen_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);

begin

  --the_cpu_0_jtag_debug_module, which is an e_instance
  the_cpu_0_jtag_debug_module : cpu_0_jtag_debug_module_arbitrator
    port map(
      cpu_0_data_master_granted_cpu_0_jtag_debug_module => cpu_0_data_master_granted_cpu_0_jtag_debug_module,
      cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_data_master_requests_cpu_0_jtag_debug_module => cpu_0_data_master_requests_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_granted_cpu_0_jtag_debug_module => cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_requests_cpu_0_jtag_debug_module => cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
      cpu_0_jtag_debug_module_address => cpu_0_jtag_debug_module_address,
      cpu_0_jtag_debug_module_begintransfer => cpu_0_jtag_debug_module_begintransfer,
      cpu_0_jtag_debug_module_byteenable => cpu_0_jtag_debug_module_byteenable,
      cpu_0_jtag_debug_module_chipselect => cpu_0_jtag_debug_module_chipselect,
      cpu_0_jtag_debug_module_debugaccess => cpu_0_jtag_debug_module_debugaccess,
      cpu_0_jtag_debug_module_readdata_from_sa => cpu_0_jtag_debug_module_readdata_from_sa,
      cpu_0_jtag_debug_module_reset_n => cpu_0_jtag_debug_module_reset_n,
      cpu_0_jtag_debug_module_resetrequest_from_sa => cpu_0_jtag_debug_module_resetrequest_from_sa,
      cpu_0_jtag_debug_module_write => cpu_0_jtag_debug_module_write,
      cpu_0_jtag_debug_module_writedata => cpu_0_jtag_debug_module_writedata,
      d1_cpu_0_jtag_debug_module_end_xfer => d1_cpu_0_jtag_debug_module_end_xfer,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_debugaccess => cpu_0_data_master_debugaccess,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_jtag_debug_module_readdata => cpu_0_jtag_debug_module_readdata,
      cpu_0_jtag_debug_module_resetrequest => cpu_0_jtag_debug_module_resetrequest,
      reset_n => clk_0_reset_n
    );


  --the_cpu_0_data_master, which is an e_instance
  the_cpu_0_data_master : cpu_0_data_master_arbitrator
    port map(
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_dbs_write_16 => cpu_0_data_master_dbs_write_16,
      cpu_0_data_master_irq => cpu_0_data_master_irq,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_readdata => cpu_0_data_master_readdata,
      cpu_0_data_master_readdatavalid => cpu_0_data_master_readdatavalid,
      cpu_0_data_master_waitrequest => cpu_0_data_master_waitrequest,
      clk => clk_0,
      cpu_0_data_master_address => cpu_0_data_master_address,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_byteenable_sdram_0_s1 => cpu_0_data_master_byteenable_sdram_0_s1,
      cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 => cpu_0_data_master_byteenable_skygen_0_avalon_slave_0,
      cpu_0_data_master_granted_cpu_0_jtag_debug_module => cpu_0_data_master_granted_cpu_0_jtag_debug_module,
      cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_granted_sdram_0_s1 => cpu_0_data_master_granted_sdram_0_s1,
      cpu_0_data_master_granted_skygen_0_avalon_slave_0 => cpu_0_data_master_granted_skygen_0_avalon_slave_0,
      cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_qualified_request_sdram_0_s1 => cpu_0_data_master_qualified_request_sdram_0_s1,
      cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 => cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_read_data_valid_sdram_0_s1 => cpu_0_data_master_read_data_valid_sdram_0_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 => cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0,
      cpu_0_data_master_requests_cpu_0_jtag_debug_module => cpu_0_data_master_requests_cpu_0_jtag_debug_module,
      cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_requests_sdram_0_s1 => cpu_0_data_master_requests_sdram_0_s1,
      cpu_0_data_master_requests_skygen_0_avalon_slave_0 => cpu_0_data_master_requests_skygen_0_avalon_slave_0,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      cpu_0_jtag_debug_module_readdata_from_sa => cpu_0_jtag_debug_module_readdata_from_sa,
      d1_cpu_0_jtag_debug_module_end_xfer => d1_cpu_0_jtag_debug_module_end_xfer,
      d1_de2_ps2_0_avalon_slave_0_end_xfer => d1_de2_ps2_0_avalon_slave_0_end_xfer,
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer => d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
      d1_niosInterface_1_0_avalon_slave_0_end_xfer => d1_niosInterface_1_0_avalon_slave_0_end_xfer,
      d1_sdram_0_s1_end_xfer => d1_sdram_0_s1_end_xfer,
      d1_skygen_0_avalon_slave_0_end_xfer => d1_skygen_0_avalon_slave_0_end_xfer,
      de2_ps2_0_avalon_slave_0_readdata_from_sa => de2_ps2_0_avalon_slave_0_readdata_from_sa,
      jtag_uart_0_avalon_jtag_slave_irq_from_sa => jtag_uart_0_avalon_jtag_slave_irq_from_sa,
      jtag_uart_0_avalon_jtag_slave_readdata_from_sa => jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
      niosInterface_1_0_avalon_slave_0_readdata_from_sa => niosInterface_1_0_avalon_slave_0_readdata_from_sa,
      reset_n => clk_0_reset_n,
      sdram_0_s1_readdata_from_sa => sdram_0_s1_readdata_from_sa,
      sdram_0_s1_waitrequest_from_sa => sdram_0_s1_waitrequest_from_sa,
      skygen_0_avalon_slave_0_readdata_from_sa => skygen_0_avalon_slave_0_readdata_from_sa
    );


  --the_cpu_0_instruction_master, which is an e_instance
  the_cpu_0_instruction_master : cpu_0_instruction_master_arbitrator
    port map(
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_dbs_address => cpu_0_instruction_master_dbs_address,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_readdata => cpu_0_instruction_master_readdata,
      cpu_0_instruction_master_readdatavalid => cpu_0_instruction_master_readdatavalid,
      cpu_0_instruction_master_waitrequest => cpu_0_instruction_master_waitrequest,
      clk => clk_0,
      cpu_0_instruction_master_address => cpu_0_instruction_master_address,
      cpu_0_instruction_master_granted_cpu_0_jtag_debug_module => cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_granted_sdram_0_s1 => cpu_0_instruction_master_granted_sdram_0_s1,
      cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module => cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_qualified_request_sdram_0_s1 => cpu_0_instruction_master_qualified_request_sdram_0_s1,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module => cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1 => cpu_0_instruction_master_read_data_valid_sdram_0_s1,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_instruction_master_requests_cpu_0_jtag_debug_module => cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
      cpu_0_instruction_master_requests_sdram_0_s1 => cpu_0_instruction_master_requests_sdram_0_s1,
      cpu_0_jtag_debug_module_readdata_from_sa => cpu_0_jtag_debug_module_readdata_from_sa,
      d1_cpu_0_jtag_debug_module_end_xfer => d1_cpu_0_jtag_debug_module_end_xfer,
      d1_sdram_0_s1_end_xfer => d1_sdram_0_s1_end_xfer,
      reset_n => clk_0_reset_n,
      sdram_0_s1_readdata_from_sa => sdram_0_s1_readdata_from_sa,
      sdram_0_s1_waitrequest_from_sa => sdram_0_s1_waitrequest_from_sa
    );


  --the_cpu_0, which is an e_ptf_instance
  the_cpu_0 : cpu_0
    port map(
      d_address => cpu_0_data_master_address,
      d_byteenable => cpu_0_data_master_byteenable,
      d_read => cpu_0_data_master_read,
      d_write => cpu_0_data_master_write,
      d_writedata => cpu_0_data_master_writedata,
      i_address => cpu_0_instruction_master_address,
      i_read => cpu_0_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => cpu_0_data_master_debugaccess,
      jtag_debug_module_readdata => cpu_0_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => cpu_0_jtag_debug_module_resetrequest,
      clk => clk_0,
      d_irq => cpu_0_data_master_irq,
      d_readdata => cpu_0_data_master_readdata,
      d_readdatavalid => cpu_0_data_master_readdatavalid,
      d_waitrequest => cpu_0_data_master_waitrequest,
      i_readdata => cpu_0_instruction_master_readdata,
      i_readdatavalid => cpu_0_instruction_master_readdatavalid,
      i_waitrequest => cpu_0_instruction_master_waitrequest,
      jtag_debug_module_address => cpu_0_jtag_debug_module_address,
      jtag_debug_module_begintransfer => cpu_0_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => cpu_0_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => cpu_0_jtag_debug_module_debugaccess,
      jtag_debug_module_select => cpu_0_jtag_debug_module_chipselect,
      jtag_debug_module_write => cpu_0_jtag_debug_module_write,
      jtag_debug_module_writedata => cpu_0_jtag_debug_module_writedata,
      reset_n => cpu_0_jtag_debug_module_reset_n
    );


  --the_de2_ps2_0_avalon_slave_0, which is an e_instance
  the_de2_ps2_0_avalon_slave_0 : de2_ps2_0_avalon_slave_0_arbitrator
    port map(
      cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_granted_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_qualified_request_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_read_data_valid_de2_ps2_0_avalon_slave_0,
      cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0 => cpu_0_data_master_requests_de2_ps2_0_avalon_slave_0,
      d1_de2_ps2_0_avalon_slave_0_end_xfer => d1_de2_ps2_0_avalon_slave_0_end_xfer,
      de2_ps2_0_avalon_slave_0_address => de2_ps2_0_avalon_slave_0_address,
      de2_ps2_0_avalon_slave_0_chipselect => de2_ps2_0_avalon_slave_0_chipselect,
      de2_ps2_0_avalon_slave_0_read => de2_ps2_0_avalon_slave_0_read,
      de2_ps2_0_avalon_slave_0_readdata_from_sa => de2_ps2_0_avalon_slave_0_readdata_from_sa,
      de2_ps2_0_avalon_slave_0_reset => de2_ps2_0_avalon_slave_0_reset,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      de2_ps2_0_avalon_slave_0_readdata => de2_ps2_0_avalon_slave_0_readdata,
      reset_n => clk_0_reset_n
    );


  --the_de2_ps2_0, which is an e_ptf_instance
  the_de2_ps2_0 : de2_ps2_0
    port map(
      readdata => de2_ps2_0_avalon_slave_0_readdata,
      PS2_Clk => PS2_Clk_to_the_de2_ps2_0,
      PS2_Data => PS2_Data_to_the_de2_ps2_0,
      address(0) => de2_ps2_0_avalon_slave_0_address,
      chipselect => de2_ps2_0_avalon_slave_0_chipselect,
      clk => clk_0,
      read => de2_ps2_0_avalon_slave_0_read,
      reset => de2_ps2_0_avalon_slave_0_reset
    );


  --the_jtag_uart_0_avalon_jtag_slave, which is an e_instance
  the_jtag_uart_0_avalon_jtag_slave : jtag_uart_0_avalon_jtag_slave_arbitrator
    port map(
      cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
      cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave => cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
      d1_jtag_uart_0_avalon_jtag_slave_end_xfer => d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
      jtag_uart_0_avalon_jtag_slave_address => jtag_uart_0_avalon_jtag_slave_address,
      jtag_uart_0_avalon_jtag_slave_chipselect => jtag_uart_0_avalon_jtag_slave_chipselect,
      jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa => jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
      jtag_uart_0_avalon_jtag_slave_irq_from_sa => jtag_uart_0_avalon_jtag_slave_irq_from_sa,
      jtag_uart_0_avalon_jtag_slave_read_n => jtag_uart_0_avalon_jtag_slave_read_n,
      jtag_uart_0_avalon_jtag_slave_readdata_from_sa => jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa => jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
      jtag_uart_0_avalon_jtag_slave_reset_n => jtag_uart_0_avalon_jtag_slave_reset_n,
      jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
      jtag_uart_0_avalon_jtag_slave_write_n => jtag_uart_0_avalon_jtag_slave_write_n,
      jtag_uart_0_avalon_jtag_slave_writedata => jtag_uart_0_avalon_jtag_slave_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      jtag_uart_0_avalon_jtag_slave_dataavailable => jtag_uart_0_avalon_jtag_slave_dataavailable,
      jtag_uart_0_avalon_jtag_slave_irq => jtag_uart_0_avalon_jtag_slave_irq,
      jtag_uart_0_avalon_jtag_slave_readdata => jtag_uart_0_avalon_jtag_slave_readdata,
      jtag_uart_0_avalon_jtag_slave_readyfordata => jtag_uart_0_avalon_jtag_slave_readyfordata,
      jtag_uart_0_avalon_jtag_slave_waitrequest => jtag_uart_0_avalon_jtag_slave_waitrequest,
      reset_n => clk_0_reset_n
    );


  --the_jtag_uart_0, which is an e_ptf_instance
  the_jtag_uart_0 : jtag_uart_0
    port map(
      av_irq => jtag_uart_0_avalon_jtag_slave_irq,
      av_readdata => jtag_uart_0_avalon_jtag_slave_readdata,
      av_waitrequest => jtag_uart_0_avalon_jtag_slave_waitrequest,
      dataavailable => jtag_uart_0_avalon_jtag_slave_dataavailable,
      readyfordata => jtag_uart_0_avalon_jtag_slave_readyfordata,
      av_address => jtag_uart_0_avalon_jtag_slave_address,
      av_chipselect => jtag_uart_0_avalon_jtag_slave_chipselect,
      av_read_n => jtag_uart_0_avalon_jtag_slave_read_n,
      av_write_n => jtag_uart_0_avalon_jtag_slave_write_n,
      av_writedata => jtag_uart_0_avalon_jtag_slave_writedata,
      clk => clk_0,
      rst_n => jtag_uart_0_avalon_jtag_slave_reset_n
    );


  --the_niosInterface_1_0_avalon_slave_0, which is an e_instance
  the_niosInterface_1_0_avalon_slave_0 : niosInterface_1_0_avalon_slave_0_arbitrator
    port map(
      cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_granted_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_qualified_request_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_read_data_valid_niosInterface_1_0_avalon_slave_0,
      cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0 => cpu_0_data_master_requests_niosInterface_1_0_avalon_slave_0,
      d1_niosInterface_1_0_avalon_slave_0_end_xfer => d1_niosInterface_1_0_avalon_slave_0_end_xfer,
      niosInterface_1_0_avalon_slave_0_address => niosInterface_1_0_avalon_slave_0_address,
      niosInterface_1_0_avalon_slave_0_chipselect => niosInterface_1_0_avalon_slave_0_chipselect,
      niosInterface_1_0_avalon_slave_0_read => niosInterface_1_0_avalon_slave_0_read,
      niosInterface_1_0_avalon_slave_0_readdata_from_sa => niosInterface_1_0_avalon_slave_0_readdata_from_sa,
      niosInterface_1_0_avalon_slave_0_reset_n => niosInterface_1_0_avalon_slave_0_reset_n,
      niosInterface_1_0_avalon_slave_0_write => niosInterface_1_0_avalon_slave_0_write,
      niosInterface_1_0_avalon_slave_0_writedata => niosInterface_1_0_avalon_slave_0_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_data_master_writedata => cpu_0_data_master_writedata,
      niosInterface_1_0_avalon_slave_0_readdata => niosInterface_1_0_avalon_slave_0_readdata,
      reset_n => clk_0_reset_n
    );


  --the_niosInterface_1_0, which is an e_ptf_instance
  the_niosInterface_1_0 : niosInterface_1_0
    port map(
      ctrl => internal_ctrl_from_the_niosInterface_1_0,
      nios_data => internal_nios_data_from_the_niosInterface_1_0,
      readdata => niosInterface_1_0_avalon_slave_0_readdata,
      address => niosInterface_1_0_avalon_slave_0_address,
      chipselect => niosInterface_1_0_avalon_slave_0_chipselect,
      clk => clk_0,
      hardware_data => hardware_data_to_the_niosInterface_1_0,
      read => niosInterface_1_0_avalon_slave_0_read,
      reset_n => niosInterface_1_0_avalon_slave_0_reset_n,
      write => niosInterface_1_0_avalon_slave_0_write,
      writedata => niosInterface_1_0_avalon_slave_0_writedata
    );


  --the_sdram_0_s1, which is an e_instance
  the_sdram_0_s1 : sdram_0_s1_arbitrator
    port map(
      cpu_0_data_master_byteenable_sdram_0_s1 => cpu_0_data_master_byteenable_sdram_0_s1,
      cpu_0_data_master_granted_sdram_0_s1 => cpu_0_data_master_granted_sdram_0_s1,
      cpu_0_data_master_qualified_request_sdram_0_s1 => cpu_0_data_master_qualified_request_sdram_0_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1 => cpu_0_data_master_read_data_valid_sdram_0_s1,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_requests_sdram_0_s1 => cpu_0_data_master_requests_sdram_0_s1,
      cpu_0_instruction_master_granted_sdram_0_s1 => cpu_0_instruction_master_granted_sdram_0_s1,
      cpu_0_instruction_master_qualified_request_sdram_0_s1 => cpu_0_instruction_master_qualified_request_sdram_0_s1,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1 => cpu_0_instruction_master_read_data_valid_sdram_0_s1,
      cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_instruction_master_requests_sdram_0_s1 => cpu_0_instruction_master_requests_sdram_0_s1,
      d1_sdram_0_s1_end_xfer => d1_sdram_0_s1_end_xfer,
      sdram_0_s1_address => sdram_0_s1_address,
      sdram_0_s1_byteenable_n => sdram_0_s1_byteenable_n,
      sdram_0_s1_chipselect => sdram_0_s1_chipselect,
      sdram_0_s1_read_n => sdram_0_s1_read_n,
      sdram_0_s1_readdata_from_sa => sdram_0_s1_readdata_from_sa,
      sdram_0_s1_reset_n => sdram_0_s1_reset_n,
      sdram_0_s1_waitrequest_from_sa => sdram_0_s1_waitrequest_from_sa,
      sdram_0_s1_write_n => sdram_0_s1_write_n,
      sdram_0_s1_writedata => sdram_0_s1_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_dbs_write_16 => cpu_0_data_master_dbs_write_16,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_write => cpu_0_data_master_write,
      cpu_0_instruction_master_address_to_slave => cpu_0_instruction_master_address_to_slave,
      cpu_0_instruction_master_dbs_address => cpu_0_instruction_master_dbs_address,
      cpu_0_instruction_master_latency_counter => cpu_0_instruction_master_latency_counter,
      cpu_0_instruction_master_read => cpu_0_instruction_master_read,
      reset_n => clk_0_reset_n,
      sdram_0_s1_readdata => sdram_0_s1_readdata,
      sdram_0_s1_readdatavalid => sdram_0_s1_readdatavalid,
      sdram_0_s1_waitrequest => sdram_0_s1_waitrequest
    );


  --the_sdram_0, which is an e_ptf_instance
  the_sdram_0 : sdram_0
    port map(
      za_data => sdram_0_s1_readdata,
      za_valid => sdram_0_s1_readdatavalid,
      za_waitrequest => sdram_0_s1_waitrequest,
      zs_addr => internal_zs_addr_from_the_sdram_0,
      zs_ba => internal_zs_ba_from_the_sdram_0,
      zs_cas_n => internal_zs_cas_n_from_the_sdram_0,
      zs_cke => internal_zs_cke_from_the_sdram_0,
      zs_cs_n => internal_zs_cs_n_from_the_sdram_0,
      zs_dq => zs_dq_to_and_from_the_sdram_0,
      zs_dqm => internal_zs_dqm_from_the_sdram_0,
      zs_ras_n => internal_zs_ras_n_from_the_sdram_0,
      zs_we_n => internal_zs_we_n_from_the_sdram_0,
      az_addr => sdram_0_s1_address,
      az_be_n => sdram_0_s1_byteenable_n,
      az_cs => sdram_0_s1_chipselect,
      az_data => sdram_0_s1_writedata,
      az_rd_n => sdram_0_s1_read_n,
      az_wr_n => sdram_0_s1_write_n,
      clk => clk_0,
      reset_n => sdram_0_s1_reset_n
    );


  --the_skygen_0_avalon_slave_0, which is an e_instance
  the_skygen_0_avalon_slave_0 : skygen_0_avalon_slave_0_arbitrator
    port map(
      cpu_0_data_master_byteenable_skygen_0_avalon_slave_0 => cpu_0_data_master_byteenable_skygen_0_avalon_slave_0,
      cpu_0_data_master_granted_skygen_0_avalon_slave_0 => cpu_0_data_master_granted_skygen_0_avalon_slave_0,
      cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0 => cpu_0_data_master_qualified_request_skygen_0_avalon_slave_0,
      cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0 => cpu_0_data_master_read_data_valid_skygen_0_avalon_slave_0,
      cpu_0_data_master_requests_skygen_0_avalon_slave_0 => cpu_0_data_master_requests_skygen_0_avalon_slave_0,
      d1_skygen_0_avalon_slave_0_end_xfer => d1_skygen_0_avalon_slave_0_end_xfer,
      skygen_0_avalon_slave_0_address => skygen_0_avalon_slave_0_address,
      skygen_0_avalon_slave_0_byteenable => skygen_0_avalon_slave_0_byteenable,
      skygen_0_avalon_slave_0_chipselect => skygen_0_avalon_slave_0_chipselect,
      skygen_0_avalon_slave_0_read => skygen_0_avalon_slave_0_read,
      skygen_0_avalon_slave_0_readdata_from_sa => skygen_0_avalon_slave_0_readdata_from_sa,
      skygen_0_avalon_slave_0_reset_n => skygen_0_avalon_slave_0_reset_n,
      skygen_0_avalon_slave_0_write => skygen_0_avalon_slave_0_write,
      skygen_0_avalon_slave_0_writedata => skygen_0_avalon_slave_0_writedata,
      clk => clk_0,
      cpu_0_data_master_address_to_slave => cpu_0_data_master_address_to_slave,
      cpu_0_data_master_byteenable => cpu_0_data_master_byteenable,
      cpu_0_data_master_dbs_address => cpu_0_data_master_dbs_address,
      cpu_0_data_master_dbs_write_16 => cpu_0_data_master_dbs_write_16,
      cpu_0_data_master_latency_counter => cpu_0_data_master_latency_counter,
      cpu_0_data_master_read => cpu_0_data_master_read,
      cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register => cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
      cpu_0_data_master_write => cpu_0_data_master_write,
      reset_n => clk_0_reset_n,
      skygen_0_avalon_slave_0_readdata => skygen_0_avalon_slave_0_readdata
    );


  --the_skygen_0, which is an e_ptf_instance
  the_skygen_0 : skygen_0
    port map(
      SRAM_ADDR => internal_SRAM_ADDR_from_the_skygen_0,
      SRAM_CE_N => internal_SRAM_CE_N_from_the_skygen_0,
      SRAM_DQ => SRAM_DQ_to_and_from_the_skygen_0,
      SRAM_LB_N => internal_SRAM_LB_N_from_the_skygen_0,
      SRAM_OE_N => internal_SRAM_OE_N_from_the_skygen_0,
      SRAM_UB_N => internal_SRAM_UB_N_from_the_skygen_0,
      SRAM_WE_N => internal_SRAM_WE_N_from_the_skygen_0,
      Sky_pixel => internal_Sky_pixel_from_the_skygen_0,
      Sram_mux_out => internal_Sram_mux_out_from_the_skygen_0,
      readdata => skygen_0_avalon_slave_0_readdata,
      Cur_Row_in => Cur_Row_in_to_the_skygen_0,
      FB_angle_in => FB_angle_in_to_the_skygen_0,
      address => skygen_0_avalon_slave_0_address,
      byteenable => skygen_0_avalon_slave_0_byteenable,
      chipselect => skygen_0_avalon_slave_0_chipselect,
      clk => clk_0,
      read => skygen_0_avalon_slave_0_read,
      reset_n => skygen_0_avalon_slave_0_reset_n,
      write => skygen_0_avalon_slave_0_write,
      writedata => skygen_0_avalon_slave_0_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  new_doom_reset_clk_0_domain_synch : new_doom_reset_clk_0_domain_synch_module
    port map(
      data_out => clk_0_reset_n,
      clk => clk_0,
      data_in => module_input6,
      reset_n => reset_n_sources
    );

  module_input6 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_0_jtag_debug_module_resetrequest_from_sa))))));
  --vhdl renameroo for output signals
  SRAM_ADDR_from_the_skygen_0 <= internal_SRAM_ADDR_from_the_skygen_0;
  --vhdl renameroo for output signals
  SRAM_CE_N_from_the_skygen_0 <= internal_SRAM_CE_N_from_the_skygen_0;
  --vhdl renameroo for output signals
  SRAM_LB_N_from_the_skygen_0 <= internal_SRAM_LB_N_from_the_skygen_0;
  --vhdl renameroo for output signals
  SRAM_OE_N_from_the_skygen_0 <= internal_SRAM_OE_N_from_the_skygen_0;
  --vhdl renameroo for output signals
  SRAM_UB_N_from_the_skygen_0 <= internal_SRAM_UB_N_from_the_skygen_0;
  --vhdl renameroo for output signals
  SRAM_WE_N_from_the_skygen_0 <= internal_SRAM_WE_N_from_the_skygen_0;
  --vhdl renameroo for output signals
  Sky_pixel_from_the_skygen_0 <= internal_Sky_pixel_from_the_skygen_0;
  --vhdl renameroo for output signals
  Sram_mux_out_from_the_skygen_0 <= internal_Sram_mux_out_from_the_skygen_0;
  --vhdl renameroo for output signals
  ctrl_from_the_niosInterface_1_0 <= internal_ctrl_from_the_niosInterface_1_0;
  --vhdl renameroo for output signals
  nios_data_from_the_niosInterface_1_0 <= internal_nios_data_from_the_niosInterface_1_0;
  --vhdl renameroo for output signals
  zs_addr_from_the_sdram_0 <= internal_zs_addr_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_ba_from_the_sdram_0 <= internal_zs_ba_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_cas_n_from_the_sdram_0 <= internal_zs_cas_n_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_cke_from_the_sdram_0 <= internal_zs_cke_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_cs_n_from_the_sdram_0 <= internal_zs_cs_n_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_dqm_from_the_sdram_0 <= internal_zs_dqm_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_ras_n_from_the_sdram_0 <= internal_zs_ras_n_from_the_sdram_0;
  --vhdl renameroo for output signals
  zs_we_n_from_the_sdram_0 <= internal_zs_we_n_from_the_sdram_0;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component new_doom is 
           port (
                 -- 1) global signals:
                    signal clk_0 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_de2_ps2_0
                    signal PS2_Clk_to_the_de2_ps2_0 : IN STD_LOGIC;
                    signal PS2_Data_to_the_de2_ps2_0 : IN STD_LOGIC;

                 -- the_niosInterface_1_0
                    signal ctrl_from_the_niosInterface_1_0 : OUT STD_LOGIC;
                    signal hardware_data_to_the_niosInterface_1_0 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal nios_data_from_the_niosInterface_1_0 : OUT STD_LOGIC_VECTOR (255 DOWNTO 0);

                 -- the_sdram_0
                    signal zs_addr_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_cke_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_cs_n_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_dq_to_and_from_the_sdram_0 : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm_from_the_sdram_0 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n_from_the_sdram_0 : OUT STD_LOGIC;
                    signal zs_we_n_from_the_sdram_0 : OUT STD_LOGIC;

                 -- the_skygen_0
                    signal Cur_Row_in_to_the_skygen_0 : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal FB_angle_in_to_the_skygen_0 : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal SRAM_ADDR_from_the_skygen_0 : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_CE_N_from_the_skygen_0 : OUT STD_LOGIC;
                    signal SRAM_DQ_to_and_from_the_skygen_0 : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_LB_N_from_the_skygen_0 : OUT STD_LOGIC;
                    signal SRAM_OE_N_from_the_skygen_0 : OUT STD_LOGIC;
                    signal SRAM_UB_N_from_the_skygen_0 : OUT STD_LOGIC;
                    signal SRAM_WE_N_from_the_skygen_0 : OUT STD_LOGIC;
                    signal Sky_pixel_from_the_skygen_0 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal Sram_mux_out_from_the_skygen_0 : OUT STD_LOGIC
                 );
end component new_doom;

                signal Cur_Row_in_to_the_skygen_0 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal FB_angle_in_to_the_skygen_0 :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal PS2_Clk_to_the_de2_ps2_0 :  STD_LOGIC;
                signal PS2_Data_to_the_de2_ps2_0 :  STD_LOGIC;
                signal SRAM_ADDR_from_the_skygen_0 :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal SRAM_CE_N_from_the_skygen_0 :  STD_LOGIC;
                signal SRAM_DQ_to_and_from_the_skygen_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal SRAM_LB_N_from_the_skygen_0 :  STD_LOGIC;
                signal SRAM_OE_N_from_the_skygen_0 :  STD_LOGIC;
                signal SRAM_UB_N_from_the_skygen_0 :  STD_LOGIC;
                signal SRAM_WE_N_from_the_skygen_0 :  STD_LOGIC;
                signal Sky_pixel_from_the_skygen_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal Sram_mux_out_from_the_skygen_0 :  STD_LOGIC;
                signal clk :  STD_LOGIC;
                signal clk_0 :  STD_LOGIC;
                signal ctrl_from_the_niosInterface_1_0 :  STD_LOGIC;
                signal hardware_data_to_the_niosInterface_1_0 :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal nios_data_from_the_niosInterface_1_0 :  STD_LOGIC_VECTOR (255 DOWNTO 0);
                signal reset_n :  STD_LOGIC;
                signal zs_addr_from_the_sdram_0 :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal zs_ba_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_cas_n_from_the_sdram_0 :  STD_LOGIC;
                signal zs_cke_from_the_sdram_0 :  STD_LOGIC;
                signal zs_cs_n_from_the_sdram_0 :  STD_LOGIC;
                signal zs_dq_to_and_from_the_sdram_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal zs_dqm_from_the_sdram_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_ras_n_from_the_sdram_0 :  STD_LOGIC;
                signal zs_we_n_from_the_sdram_0 :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : new_doom
    port map(
      SRAM_ADDR_from_the_skygen_0 => SRAM_ADDR_from_the_skygen_0,
      SRAM_CE_N_from_the_skygen_0 => SRAM_CE_N_from_the_skygen_0,
      SRAM_DQ_to_and_from_the_skygen_0 => SRAM_DQ_to_and_from_the_skygen_0,
      SRAM_LB_N_from_the_skygen_0 => SRAM_LB_N_from_the_skygen_0,
      SRAM_OE_N_from_the_skygen_0 => SRAM_OE_N_from_the_skygen_0,
      SRAM_UB_N_from_the_skygen_0 => SRAM_UB_N_from_the_skygen_0,
      SRAM_WE_N_from_the_skygen_0 => SRAM_WE_N_from_the_skygen_0,
      Sky_pixel_from_the_skygen_0 => Sky_pixel_from_the_skygen_0,
      Sram_mux_out_from_the_skygen_0 => Sram_mux_out_from_the_skygen_0,
      ctrl_from_the_niosInterface_1_0 => ctrl_from_the_niosInterface_1_0,
      nios_data_from_the_niosInterface_1_0 => nios_data_from_the_niosInterface_1_0,
      zs_addr_from_the_sdram_0 => zs_addr_from_the_sdram_0,
      zs_ba_from_the_sdram_0 => zs_ba_from_the_sdram_0,
      zs_cas_n_from_the_sdram_0 => zs_cas_n_from_the_sdram_0,
      zs_cke_from_the_sdram_0 => zs_cke_from_the_sdram_0,
      zs_cs_n_from_the_sdram_0 => zs_cs_n_from_the_sdram_0,
      zs_dq_to_and_from_the_sdram_0 => zs_dq_to_and_from_the_sdram_0,
      zs_dqm_from_the_sdram_0 => zs_dqm_from_the_sdram_0,
      zs_ras_n_from_the_sdram_0 => zs_ras_n_from_the_sdram_0,
      zs_we_n_from_the_sdram_0 => zs_we_n_from_the_sdram_0,
      Cur_Row_in_to_the_skygen_0 => Cur_Row_in_to_the_skygen_0,
      FB_angle_in_to_the_skygen_0 => FB_angle_in_to_the_skygen_0,
      PS2_Clk_to_the_de2_ps2_0 => PS2_Clk_to_the_de2_ps2_0,
      PS2_Data_to_the_de2_ps2_0 => PS2_Data_to_the_de2_ps2_0,
      clk_0 => clk_0,
      hardware_data_to_the_niosInterface_1_0 => hardware_data_to_the_niosInterface_1_0,
      reset_n => reset_n
    );


  process
  begin
    clk_0 <= '0';
    loop
       wait for 10 ns;
       clk_0 <= not clk_0;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
