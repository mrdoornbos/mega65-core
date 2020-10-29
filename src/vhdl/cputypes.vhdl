library ieee;
use Std.TextIO.all;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

package cputypes is

  type mega65_target_t is (
    simulation,
    mega65r1, mega65r2, mega65r3,
    megaphoner1,
    nexys4, nexys4ddr, nexys4ddr_widget,
    wukong
    );
  
  type sample_vector_t is array(0 to 15) of signed(15 downto 0);
  type sprite_vector_8 is array(0 to 7) of unsigned(7 downto 0);
  
  type addressingmode is (
    M_impl,M_InnX,M_nn,M_immnn,M_A,M_nnnn,M_nnrr,
    M_rr,M_InnY,M_InnZ,M_rrrr,M_nnX,M_nnnnY,M_nnnnX,M_Innnn,
    M_InnnnX,M_InnSPY,M_nnY,M_immnnnn);

  type mode_list is array(addressingmode'low to addressingmode'high) of integer;
  
  type instruction is (
    -- 4510 opcodes
    I_ADC,I_AND,I_ASL,I_ASR,I_ASW,I_BBR,I_BBS,I_BCC,
    I_BCS,I_BEQ,I_BIT,I_BMI,I_BNE,I_BPL,I_BRA,I_BRK,
    I_BSR,I_BVC,I_BVS,I_CLC,I_CLD,I_CLE,I_CLI,I_CLV,
    I_CMP,I_CPX,I_CPY,I_CPZ,I_DEC,I_DEW,I_DEX,I_DEY,    
    I_DEZ,I_EOM,I_EOR,I_INC,I_INW,I_INX,I_INY,I_INZ,    
    I_JMP,I_JSR,I_LDA,I_LDX,I_LDY,I_LDZ,I_LSR,I_MAP,
    I_NEG,I_ORA,I_PHA,I_PHP,I_PHW,I_PHX,I_PHY,I_PHZ,
    I_PLA,I_PLP,I_PLX,I_PLY,I_PLZ,I_RMB,I_ROL,I_ROR,
    I_ROW,I_RTI,I_RTS,I_SBC,I_SEC,I_SED,I_SEE,I_SEI,    
    I_SMB,I_STA,I_STX,I_STY,I_STZ,I_TAB,I_TAX,I_TAY,
    I_TAZ,I_TBA,I_TRB,I_TSB,I_TSX,I_TSY,I_TXA,I_TXS,
    I_TYA,I_TYS,I_TZA,

    -- 6502 illegals
    I_SLO,I_RLA,I_SRE,I_RRA,I_SAX,I_LAX,I_DCP,I_ISC,
    I_ANC,I_ALR,I_ARR,I_ANE,I_SBX,I_SHA,I_SHY,I_SHX,
    I_TAS,I_LAS,I_NOP,I_KIL
    
    );

  type ilut9bit is array(0 to 511) of instruction;
  
  type microcodeops is record

    -- ALU control (flag setting is automatically handled based on ALU_mode)
    mcALU_in_mem : std_logic;
    mcALU_in_bitmask : std_logic;
    mcALU_in_a : std_logic;
    mcALU_in_x : std_logic;
    mcALU_in_y : std_logic;
    mcALU_in_z : std_logic;
    mcALU_in_spl : std_logic;
    mcALU_mode : alu_function_t;
    mcALU_set_a : std_logic;
    mcALU_set_x : std_logic;
    mcALU_set_y : std_logic;
    mcALU_set_z : std_logic;
    mcALU_set_p : std_logic;
    mcALU_set_mem : std_logic;
    mcALU_set_spl : std_logic;

    mcADDCarry : std_logic;
    mcRecordCarry : std_logic;
    mcAssumeCarrySet : std_logic;
    mcAssumeCarryClear : std_logic;
    mcAllowBCD : std_logic;
    mcRecordN : std_logic;
    mcRecordZ : std_logic;
    mcALU_set_mem : std_logic;
    mcTRBSetZ : std_logic;
    
    -- Do we write registers or results to memory?
    mcStoreA : std_logic;
    mcStoreX : std_logic;
    mcStoreY : std_logic;
    mcStoreZ : std_logic;

    mcPop : std_logic;
    mcPush : std_logic;
    
    mcBreakFlag : std_logic;    
      
  end record;

  type microcoderom_t is array (instruction) of microcodeops;

  -- Used for HyperRAM cache
  type cache_row_t is array (0 to 7) of unsigned(7 downto 0);
  
end cputypes;
