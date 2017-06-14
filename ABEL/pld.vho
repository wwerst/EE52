-- VHDL netlist for dram
-- Date: Wed Jun 14 01:47:11 2017
-- Copyright (c) Lattice Semiconductor Corporation
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND5_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND5_dram;

ARCHITECTURE behav OF PGAND5_dram IS 
BEGIN

    PROCESS (A4, A3, A2, A1, 
		A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A4 AND A3 AND A2 AND 
            A1 AND A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGBUFI_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGBUFI_dram;

ARCHITECTURE behav OF PGBUFI_dram IS 
BEGIN

    PROCESS (A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF :=  A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND2_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND2_dram;

ARCHITECTURE behav OF PGAND2_dram IS 
BEGIN

    PROCESS (A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A1 AND A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGXOR2_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGXOR2_dram;

ARCHITECTURE behav OF PGXOR2_dram IS 
BEGIN

    PROCESS (A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A1 XOR A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGDFFR_dram IS 
    GENERIC (
        HLCQ : TIME := 1 ns;
        LHCQ : TIME := 1 ns;
        HLRQ : TIME := 1 ns;
        SUD0 : TIME := 0 ns;
        SUD1 : TIME := 0 ns;
        HOLDD0 : TIME := 0 ns;
        HOLDD1 : TIME := 0 ns;
        POSC1 : TIME := 0 ns;
        POSC0 : TIME := 0 ns;
        NEGC1 : TIME := 0 ns;
        NEGC0 : TIME := 0 ns;
        RECRC : TIME := 0 ns;
        HOLDRC : TIME := 0 ns
    );
    PORT (
        RNESET : IN std_logic;
        CD : IN std_logic;
        CLK : IN std_logic;
        D0 : IN std_logic;
        Q0 : OUT std_logic
    );
END PGDFFR_dram;

ARCHITECTURE behav OF PGDFFR_dram IS 
BEGIN

    PROCESS (RNESET, CD, CLK, D0)
	variable iQ0 : std_logic;
	variable pQ0 : std_logic;

	begin

		if (CD OR NOT (RNESET)) = '1' then
			if NOT (iQ0='0') then
			  iQ0 := '0';
			  Q0 <= transport iQ0  after HLRQ;
			end if;
		elsif (CD OR NOT (RNESET)) = '0' AND CLK= '1' AND CLK'EVENT then
			pQ0 := iQ0;
			if (D0'EVENT) then
				iQ0 := D0'LAST_VALUE;
			elsif NOT (D0'EVENT) then
				iQ0 := D0;
			end if;
      if pQ0 = iQ0 then 
         Q0 <= transport iQ0;
      elsif iQ0 = '1' then Q0 <= transport iQ0 after LHCQ;
      elsif iQ0 = '0' then Q0 <= transport iQ0 after HLCQ;
      else
          Q0 <= transport iQ0;
      end if;
		end if;
    END PROCESS;

	process(CLK, CD)
	 begin
		if CD'EVENT AND CD='0' AND CLK='1' then
			assert (CLK'LAST_EVENT >= HOLDRC) 
			report("HOLD TIME VIOLAION ON CD (HOLDRC)  ")
            severity WARNING;
		end if;
		if CLK'EVENT  AND CLK ='1' AND CD ='0' then
			assert ( CD'LAST_EVENT >= RECRC) 
			report("RECOVERY TIME VIOLATION on CD(RECRC) ")
            severity WARNING;
		end if;
	end process;

	process(CLK,RNESET)
	 begin
		if RNESET'EVENT AND NOT(RNESET)='0' AND CLK='1' then
			assert (CLK'LAST_EVENT >= HOLDRC) 
			report("HOLD TIME VIOLAION ON RNESET (HOLDRC)  ")
            severity WARNING;
		end if;
		if CLK'EVENT  AND CLK ='1' AND NOT(RNESET) ='0' then
			assert ( RNESET'LAST_EVENT >= RECRC) 
			report("RECOVERY TIME VIOLATION on RNESET(RECRC) ")
            severity WARNING;
		end if;
	end process;

	process(D0, CLK)

	variable R_EDGE1 : TIME := 0 ns;
	variable R_EDGE0 : TIME := 0 ns;
	variable F_EDGE1 : TIME := 0 ns;
	variable F_EDGE0 : TIME := 0 ns;

	begin
		if CLK='1' AND CLK'LAST_VALUE='0' AND NOT(D0'EVENT) then
		   if D0='1' then
			R_EDGE1 := NOW;
			assert((R_EDGE1-F_EDGE1) >= NEGC1) 
			report("NEGATIVE PULSE WIDTH VIOLATION (NEGC1) ON CLK at ")
            severity WARNING;
			elsif D0='0' then
			 R_EDGE0 := NOW;
			 assert((R_EDGE0-F_EDGE0) >= NEGC0) 
			 report("NEGATIVE PULSE WIDTH VIOLATION (NEGC0) ON CLK at ")
             severity WARNING;
			end if;
		end if;

		if CLK ='0' AND CLK'LAST_VALUE = '1' AND NOT(D0'EVENT) then
			if D0='1' then
			  F_EDGE1 := NOW;
			  assert ((F_EDGE1-R_EDGE1) >= POSC1) 
			  report("POSITIVE PULSE WIDTH VIOLATION (POSC1) ON CLK at ")
              severity WARNING;
			elsif D0='0' then
			  F_EDGE0 := NOW;
			  assert ((F_EDGE0-R_EDGE0) >= POSC0) 
			  report("POSITIVE PULSE WIDTH VIOLATION (POSC0) ON CLK at ")
              severity WARNING;
			end if;
		end if;

	end process;

	process(D0, CLK)

	begin
		if CLK = '1' AND CLK'EVENT then 
			if D0='1' then
               assert(D0'LAST_EVENT >= SUD1) 
 			   report("DATA SET-UP VIOLATION (SUD1) ")
               severity WARNING;
			elsif D0='0' then
               assert(D0'LAST_EVENT >= SUD0) 
 			   report("DATA SET-UP VIOLATION (SUD0) ")
               severity WARNING;
			end if;
		end if;

		if CLK='1' AND D0'EVENT then 
			if D0'LAST_VALUE ='1' then
			   assert(CLK'LAST_EVENT >= HOLDD1)
			   report("DATA HOLD VIOLATION (HOLDD1) ")
               severity WARNING;
			elsif D0'LAST_VALUE='0' then
			   assert(CLK'LAST_EVENT >= HOLDD0)
			   report("DATA HOLD VIOLATION (HOLDD0) ")
               severity WARNING;
			end if;
		end if;

	end process;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGINVI_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A0 : IN std_logic;
        ZN0 : OUT std_logic
    );
END PGINVI_dram;

ARCHITECTURE behav OF PGINVI_dram IS 
BEGIN

    PROCESS (A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := NOT A0;
        if ZDF ='1' then
            ZN0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            ZN0 <= transport ZDF after TFALL;
        else
            ZN0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND3_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND3_dram;

ARCHITECTURE behav OF PGAND3_dram IS 
BEGIN

    PROCESS (A2, A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A2 AND A1 AND A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND4_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND4_dram;

ARCHITECTURE behav OF PGAND4_dram IS 
BEGIN

    PROCESS (A3, A2, A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A3 AND A2 AND A1 AND 
            A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGORF73_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGORF73_dram;

ARCHITECTURE behav OF PGORF73_dram IS 
BEGIN

    PROCESS (A2, A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A2 OR A1 OR A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGORF72_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGORF72_dram;

ARCHITECTURE behav OF PGORF72_dram IS 
BEGIN

    PROCESS (A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A1 OR A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND8_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A7 : IN std_logic;
        A6 : IN std_logic;
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND8_dram;

ARCHITECTURE behav OF PGAND8_dram IS 
BEGIN

    PROCESS (A7, A6, A5, A4, 
		A3, A2, A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A7 AND A6 AND A5 AND 
            A4 AND A3 AND A2 AND A1 AND 
            A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGORF76_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGORF76_dram;

ARCHITECTURE behav OF PGORF76_dram IS 
BEGIN

    PROCESS (A5, A4, A3, A2, 
		A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A5 OR A4 OR A3 OR 
            A2 OR A1 OR A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGORF74_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGORF74_dram;

ARCHITECTURE behav OF PGORF74_dram IS 
BEGIN

    PROCESS (A3, A2, A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A3 OR A2 OR A1 OR 
            A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND6_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND6_dram;

ARCHITECTURE behav OF PGAND6_dram IS 
BEGIN

    PROCESS (A5, A4, A3, A2, 
		A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A5 AND A4 AND A3 AND 
            A2 AND A1 AND A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGORF75_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGORF75_dram;

ARCHITECTURE behav OF PGORF75_dram IS 
BEGIN

    PROCESS (A4, A3, A2, A1, 
		A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A4 OR A3 OR A2 OR 
            A1 OR A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PGAND7_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A6 : IN std_logic;
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PGAND7_dram;

ARCHITECTURE behav OF PGAND7_dram IS 
BEGIN

    PROCESS (A6, A5, A4, A3, 
		A2, A1, A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF := A6 AND A5 AND A4 AND 
            A3 AND A2 AND A1 AND A0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PXIN_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        XI0 : IN std_logic;
        Z0 : OUT std_logic
    );
END PXIN_dram;

ARCHITECTURE behav OF PXIN_dram IS 
BEGIN

    PROCESS (XI0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF :=  XI0;
        if ZDF ='1' then
            Z0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            Z0 <= transport ZDF after TFALL;
        else
            Z0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PXOUT_dram IS 
    GENERIC (
        TRISE : TIME := 1 ns;
        TFALL : TIME := 1 ns
    );
    PORT (
        A0 : IN std_logic;
        XO0 : OUT std_logic
    );
END PXOUT_dram;

ARCHITECTURE behav OF PXOUT_dram IS 
BEGIN

    PROCESS (A0)
    VARIABLE ZDF : std_logic;
    BEGIN
        ZDF :=  A0;
        if ZDF ='1' then
            XO0 <= transport ZDF after TRISE;
        elsif ZDF ='0' then
            XO0 <= transport ZDF after TFALL;
        else
            XO0 <= transport ZDF;
        end if;
    END PROCESS;
END behav;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE work.all;

ENTITY dram IS 
    PORT (
        XRESET : IN std_logic;
        RCLK : IN std_logic;
        NWE : IN std_logic;
        NRESET : IN std_logic;
        NCS : IN std_logic;
        MCLK : IN std_logic;
        JTAG_NTRST : IN std_logic;
        ST4 : OUT std_logic;
        ST3 : OUT std_logic;
        ST2 : OUT std_logic;
        ST1 : OUT std_logic;
        ST0 : OUT std_logic;
        R_A_EN : OUT std_logic;
        REFRQST : OUT std_logic;
        RAS : OUT std_logic;
        NWAIT : OUT std_logic;
        NTRST : OUT std_logic;
        DRAM_WE : OUT std_logic;
        C_A_EN : OUT std_logic;
        CAS : OUT std_logic
    );
END dram;


ARCHITECTURE dram_STRUCTURE OF dram IS
SIGNAL VCC : std_logic := '1';
SIGNAL GND : std_logic := '0';
SIGNAL  REFRQST_PIN_grpi, ST0_PIN_grpi, ST1_PIN_grpi, ST2_PIN_grpi,
	 ST3_PIN_grpi, ST4_PIN_grpi, BUF_932_ck1f, BUF_933_ck2f,
	 L2L_KEYWD_RESETb, IO12_IBUFO, IO9_IBUFO, IO1_IBUFO,
	 IO8_IBUFO, IO11_IBUFO, IO0_IBUFO, IO20_OBUFI,
	 ST4_PIN_iomux, IO19_OBUFI, ST3_PIN_iomux, IO18_OBUFI,
	 ST2_PIN_iomux, IO17_OBUFI, ST1_PIN_iomux, IO16_OBUFI,
	 ST0_PIN_iomux, IO6_OBUFI, OR_869_iomux, IO13_OBUFI,
	 REFRQST_PIN_iomux, IO3_OBUFI, OR_866_iomux, IO10_OBUFI,
	 NWAIT_PIN_iomux, IO2_OBUFI, NTRST_PIN_iomux, IO5_OBUFI,
	 OR_867_iomux, IO7_OBUFI, OR_868_iomux, IO4_OBUFI,
	 OR_865_iomux, REFRQST_PIN, A1_CD, A1_CLK,
	 A1_P4_xa, NTRST_PIN, A1_X2O, A1_P8_xa,
	 A1_X1O, A1_G2, A1_G1, A1_P12,
	 A1_IN2B, A1_IN3, A1_IN4, A1_IN8B,
	 A1_IN9, A1_P8, JTAG_NTRSTX_grp, A1_P4,
	 A1_IN0, A1_IN1, OR_865, OR_867,
	 OR_869, OR_866, A3_P16, A3_P15,
	 A3_P14, A3_IN4, A3_P11, A3_P10,
	 A3_IN3, A3_P7, A3_P6, A3_IN2B,
	 A3_P3, A3_IN3B, A3_P2, A3_IN2,
	 A3_P1, A3_IN4B, A3_IN8, A3_IN9,
	 NWAIT_PIN, A6_CLK, A6_P4_xa, A6_X2O,
	 A6_G1, A6_F1, OR_868, A6_P7,
	 A6_P6, A6_IN7, A6_P5, A6_IN3B,
	 A6_IN4, A6_P4, A6_P3, A6_IN8,
	 A6_P2, A6_IN2, A6_IN4B, A6_IN9,
	 ST3_PIN, ST2_PIN, B0_CLK, B0_X3O,
	 B0_P4_xa, B0_X2O, B0_P8_xa, BUF_933,
	 B0_X1O, B0_P13_xa, BUF_932, B0_X0O,
	 B0_G3, B0_G2, B0_G1, B0_G0,
	 B0_F5, B0_F1, B0_F0, B0_P19,
	 B0_IN10B, B0_IN12B, B0_IN13B, B0_P18,
	 B0_P17, B0_P16, B0_IN11B, B0_P15,
	 B0_IN17B, B0_P14, B0_IN14, RCLKX_grp,
	 B0_P13, B0_IN7, MCLKX_grp, B0_P8,
	 B0_IN15, B0_P7, B0_IN3, B0_IN6,
	 B0_IN16, B0_P4, B0_P3, B0_IN14B,
	 B0_P2, B0_IN3B, ST2_PIN_ffb, B0_P1,
	 B0_IN6B, B0_IN16B, ST3_PIN_ffb, B0_P0,
	 B0_IN11, B0_IN17, ST4_PIN, B1_CLK,
	 B1_X0O, B1_G3, B1_F4, B1_P12,
	 B1_P11, B1_P10, B1_IN16, B1_P9,
	 B1_IN6B, B1_IN7B, B1_IN10, B1_IN12B,
	 B1_IN13B, ST4_PIN_ffb, B1_P8, B1_IN6,
	 B1_IN7, B1_IN12, B1_IN13, B1_IN14,
	 B1_IN16B, ST1_PIN, ST0_PIN, L2L_KEYWD_RESET_glbb,
	 B7_CLK, B7_X1O, B7_P13_xa, B7_X0O,
	 B7_G3, B7_G2, B7_F4, B7_F1,
	 B7_F0, B7_P13, B7_P12, B7_P11,
	 B7_P10, B7_IN12, B7_P9, B7_IN10B,
	 B7_P7, B7_P6, B7_IN10, NWEX_grp,
	 NCSX_grp, B7_P5, B7_IN12B, B7_IN13B,
	 B7_P3, B7_IN16B, B7_IN17, B7_P2,
	 B7_IN8B, B7_P1, B7_IN9B, B7_IN11,
	 ST0_PIN_ffb, NRESETX_grp, ST1_PIN_ffb, B7_P0,
	 B7_IN9, B7_IN11B, B7_IN14, B7_IN16,
	 B7_IN17B : std_logic;


  COMPONENT PGAND5_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND5_dram use entity work.PGAND5_dram(behav);

  COMPONENT PGBUFI_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGBUFI_dram use entity work.PGBUFI_dram(behav);

  COMPONENT PGAND2_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND2_dram use entity work.PGAND2_dram(behav);

  COMPONENT PGXOR2_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGXOR2_dram use entity work.PGXOR2_dram(behav);

  COMPONENT PGDFFR_dram
    GENERIC (HLCQ, LHCQ, HLRQ, SUD0, 
        SUD1, HOLDD0, HOLDD1, POSC1, 
        POSC0, NEGC1, NEGC0, RECRC, 
        HOLDRC : TIME);
    PORT (
        RNESET : IN std_logic;
        CD : IN std_logic;
        CLK : IN std_logic;
        D0 : IN std_logic;
        Q0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGDFFR_dram use entity work.PGDFFR_dram(behav);

  COMPONENT PGINVI_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A0 : IN std_logic;
        ZN0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGINVI_dram use entity work.PGINVI_dram(behav);

  COMPONENT PGAND3_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND3_dram use entity work.PGAND3_dram(behav);

  COMPONENT PGAND4_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND4_dram use entity work.PGAND4_dram(behav);

  COMPONENT PGORF73_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGORF73_dram use entity work.PGORF73_dram(behav);

  COMPONENT PGORF72_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGORF72_dram use entity work.PGORF72_dram(behav);

  COMPONENT PGAND8_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A7 : IN std_logic;
        A6 : IN std_logic;
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND8_dram use entity work.PGAND8_dram(behav);

  COMPONENT PGORF76_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGORF76_dram use entity work.PGORF76_dram(behav);

  COMPONENT PGORF74_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGORF74_dram use entity work.PGORF74_dram(behav);

  COMPONENT PGAND6_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND6_dram use entity work.PGAND6_dram(behav);

  COMPONENT PGORF75_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGORF75_dram use entity work.PGORF75_dram(behav);

  COMPONENT PGAND7_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A6 : IN std_logic;
        A5 : IN std_logic;
        A4 : IN std_logic;
        A3 : IN std_logic;
        A2 : IN std_logic;
        A1 : IN std_logic;
        A0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PGAND7_dram use entity work.PGAND7_dram(behav);

  COMPONENT PXIN_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        XI0 : IN std_logic;
        Z0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PXIN_dram use entity work.PXIN_dram(behav);

  COMPONENT PXOUT_dram
    GENERIC (TRISE, TFALL : TIME);
    PORT (
        A0 : IN std_logic;
        XO0 : OUT std_logic
    );
  END COMPONENT;
  for all :  PXOUT_dram use entity work.PXOUT_dram(behav);

BEGIN

GLB_A1_P12 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A1_P12, A4 => A1_IN2B, A3 => A1_IN3, A2 => A1_IN4, 
	A1 => A1_IN8B, A0 => A1_IN9);
GLB_A1_P8 : PGBUFI_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A1_P8, A0 => VCC);
GLB_A1_P4 : PGAND2_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A1_P4, A1 => A1_IN0, A0 => A1_IN1);
GLB_A1_G2 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A1_G2, A0 => GND);
GLB_A1_G1 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A1_G1, A0 => GND);
GLB_A1_CD : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => A1_CD, A0 => A1_P12);
GLB_A1_CLK : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A1_CLK, A0 => BUF_932_ck1f);
GLB_A1_P4_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => A1_P4_xa, A0 => A1_P4);
GLB_NTRST_PIN : PGBUFI_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => NTRST_PIN, A0 => A1_X2O);
GLB_A1_P8_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => A1_P8_xa, A0 => A1_P8);
GLB_A1_IN9 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A1_IN9, A0 => ST1_PIN_grpi);
GLB_A1_IN4 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A1_IN4, A0 => ST4_PIN_grpi);
GLB_A1_IN3 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A1_IN3, A0 => ST3_PIN_grpi);
GLB_A1_IN1 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A1_IN1, A0 => NRESETX_grp);
GLB_A1_IN0 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A1_IN0, A0 => JTAG_NTRSTX_grp);
GLB_A1_X2O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A1_X2O, A1 => A1_P4_xa, A0 => A1_G1);
GLB_A1_X1O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A1_X1O, A1 => A1_P8_xa, A0 => A1_G2);
GLB_REFRQST_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => REFRQST_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => A1_CD, CLK => A1_CLK, 
	D0 => A1_X1O);
GLB_A1_IN8B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A1_IN8B, A0 => ST0_PIN_grpi);
GLB_A1_IN2B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A1_IN2B, A0 => ST2_PIN_grpi);
GLB_A3_P16 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P16, A2 => A3_IN2, A1 => A3_IN4B, A0 => A3_IN9);
GLB_A3_P15 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P15, A2 => A3_IN2, A1 => A3_IN3B, A0 => A3_IN4);
GLB_A3_P14 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P14, A3 => A3_IN3B, A2 => A3_IN4, A1 => A3_IN8, 
	A0 => A3_IN9);
GLB_A3_P11 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P11, A3 => A3_IN2, A2 => A3_IN3, A1 => A3_IN4B, 
	A0 => A3_IN8);
GLB_A3_P10 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P10, A3 => A3_IN2, A2 => A3_IN3, A1 => A3_IN4B, 
	A0 => A3_IN9);
GLB_A3_P7 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P7, A2 => A3_IN2B, A1 => A3_IN4B, A0 => A3_IN9);
GLB_A3_P6 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P6, A3 => A3_IN2B, A2 => A3_IN3B, A1 => A3_IN4B, 
	A0 => A3_IN8);
GLB_A3_P3 : PGAND2_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P3, A1 => A3_IN2, A0 => A3_IN3B);
GLB_A3_P2 : PGAND2_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P2, A1 => A3_IN2, A0 => A3_IN4B);
GLB_A3_P1 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A3_P1, A2 => A3_IN4B, A1 => A3_IN8, A0 => A3_IN9);
GLB_OR_865 : PGORF73_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => OR_865, A2 => A3_P14, A1 => A3_P15, A0 => A3_P16);
GLB_OR_867 : PGORF72_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => OR_867, A1 => A3_P10, A0 => A3_P11);
GLB_OR_869 : PGORF72_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => OR_869, A1 => A3_P6, A0 => A3_P7);
GLB_OR_866 : PGORF73_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => OR_866, A2 => A3_P1, A1 => A3_P2, A0 => A3_P3);
GLB_A3_IN4 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A3_IN4, A0 => ST4_PIN_grpi);
GLB_A3_IN3 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A3_IN3, A0 => ST3_PIN_grpi);
GLB_A3_IN2 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A3_IN2, A0 => ST2_PIN_grpi);
GLB_A3_IN9 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A3_IN9, A0 => ST1_PIN_grpi);
GLB_A3_IN8 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A3_IN8, A0 => ST0_PIN_grpi);
GLB_A3_IN2B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A3_IN2B, A0 => ST2_PIN_grpi);
GLB_A3_IN3B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A3_IN3B, A0 => ST3_PIN_grpi);
GLB_A3_IN4B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A3_IN4B, A0 => ST4_PIN_grpi);
GLB_A6_P7 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A6_P7, A2 => A6_IN2, A1 => A6_IN3B, A0 => A6_IN4);
GLB_A6_P6 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A6_P6, A2 => A6_IN3B, A1 => A6_IN4, A0 => A6_IN7);
GLB_A6_P5 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A6_P5, A3 => A6_IN3B, A2 => A6_IN4, A1 => A6_IN8, 
	A0 => A6_IN9);
GLB_A6_P4 : PGBUFI_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A6_P4, A0 => VCC);
GLB_A6_P3 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A6_P3, A2 => A6_IN2, A1 => A6_IN4B, A0 => A6_IN8);
GLB_A6_P2 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => A6_P2, A2 => A6_IN2, A1 => A6_IN4B, A0 => A6_IN9);
GLB_A6_G1 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A6_G1, A0 => A6_F1);
GLB_A6_F1 : PGORF73_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => A6_F1, A2 => A6_P5, A1 => A6_P6, A0 => A6_P7);
GLB_OR_868 : PGORF72_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => OR_868, A1 => A6_P2, A0 => A6_P3);
GLB_A6_CLK : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A6_CLK, A0 => BUF_933_ck2f);
GLB_A6_P4_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => A6_P4_xa, A0 => A6_P4);
GLB_A6_IN7 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A6_IN7, A0 => ST3_PIN_grpi);
GLB_A6_IN4 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A6_IN4, A0 => ST4_PIN_grpi);
GLB_A6_IN8 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A6_IN8, A0 => ST0_PIN_grpi);
GLB_A6_IN9 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A6_IN9, A0 => ST1_PIN_grpi);
GLB_A6_IN2 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => A6_IN2, A0 => ST2_PIN_grpi);
GLB_A6_X2O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => A6_X2O, A1 => A6_P4_xa, A0 => A6_G1);
GLB_NWAIT_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => NWAIT_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => GND, CLK => A6_CLK, 
	D0 => A6_X2O);
GLB_A6_IN3B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A6_IN3B, A0 => NCSX_grp);
GLB_A6_IN4B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => A6_IN4B, A0 => ST4_PIN_grpi);
GLB_B0_P19 : PGAND8_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P19, A7 => B0_IN3B, A6 => B0_IN6B, A5 => B0_IN10B, 
	A4 => B0_IN11B, A3 => B0_IN12B, A2 => B0_IN13B, A1 => B0_IN14, 
	A0 => B0_IN16B);
GLB_B0_P18 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P18, A4 => B0_IN6, A3 => B0_IN11B, A2 => B0_IN14, 
	A1 => B0_IN16B, A0 => B0_IN17);
GLB_B0_P17 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P17, A4 => B0_IN6B, A3 => B0_IN11B, A2 => B0_IN14, 
	A1 => B0_IN16, A0 => B0_IN17);
GLB_B0_P16 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P16, A3 => B0_IN3B, A2 => B0_IN11B, A1 => B0_IN14, 
	A0 => B0_IN17);
GLB_B0_P15 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P15, A4 => B0_IN3, A3 => B0_IN6, A2 => B0_IN14, 
	A1 => B0_IN16, A0 => B0_IN17B);
GLB_B0_P14 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P14, A4 => B0_IN6B, A3 => B0_IN11, A2 => B0_IN14, 
	A1 => B0_IN16B, A0 => B0_IN17);
GLB_B0_P13 : PGBUFI_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P13, A0 => B0_IN7);
GLB_B0_P8 : PGBUFI_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P8, A0 => B0_IN15);
GLB_B0_P7 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P7, A2 => B0_IN3, A1 => B0_IN6, A0 => B0_IN16);
GLB_B0_P4 : PGBUFI_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P4, A0 => VCC);
GLB_B0_P3 : PGBUFI_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P3, A0 => B0_IN14B);
GLB_B0_P2 : PGAND2_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P2, A1 => B0_IN3B, A0 => B0_IN16B);
GLB_B0_P1 : PGAND2_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P1, A1 => B0_IN6B, A0 => B0_IN16B);
GLB_B0_P0 : PGAND2_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B0_P0, A1 => B0_IN11, A0 => B0_IN17);
GLB_B0_G3 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_G3, A0 => GND);
GLB_B0_G2 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_G2, A0 => GND);
GLB_B0_G1 : PGORF72_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_G1, A1 => B0_F0, A0 => B0_F1);
GLB_B0_G0 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_G0, A0 => B0_F5);
GLB_B0_F5 : PGORF76_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B0_F5, A5 => B0_P14, A4 => B0_P15, A3 => B0_P16, 
	A2 => B0_P19, A1 => B0_P17, A0 => B0_P18);
GLB_B0_F1 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B0_F1, A0 => B0_P7);
GLB_B0_F0 : PGORF74_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B0_F0, A3 => B0_P0, A2 => B0_P1, A1 => B0_P2, 
	A0 => B0_P3);
GLB_B0_CLK : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_CLK, A0 => BUF_933_ck2f);
GLB_B0_P4_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => B0_P4_xa, A0 => B0_P4);
GLB_B0_P8_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => B0_P8_xa, A0 => B0_P8);
GLB_BUF_933 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => BUF_933, A0 => B0_X1O);
GLB_B0_P13_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => B0_P13_xa, A0 => B0_P13);
GLB_BUF_932 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.600000 ns, TFALL => 1.600000 ns)
	PORT MAP (Z0 => BUF_932, A0 => B0_X0O);
GLB_B0_IN14 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN14, A0 => NRESETX_grp);
GLB_B0_IN7 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN7, A0 => RCLKX_grp);
GLB_B0_IN15 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN15, A0 => MCLKX_grp);
GLB_B0_IN16 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN16, A0 => ST2_PIN_ffb);
GLB_B0_IN6 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN6, A0 => ST1_PIN_grpi);
GLB_B0_IN3 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN3, A0 => ST0_PIN_grpi);
GLB_B0_IN17 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN17, A0 => ST3_PIN_ffb);
GLB_B0_IN11 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B0_IN11, A0 => ST4_PIN_grpi);
GLB_B0_X3O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_X3O, A1 => GND, A0 => B0_G0);
GLB_B0_X2O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_X2O, A1 => B0_P4_xa, A0 => B0_G1);
GLB_B0_X1O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_X1O, A1 => B0_P8_xa, A0 => B0_G2);
GLB_B0_X0O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B0_X0O, A1 => B0_P13_xa, A0 => B0_G3);
GLB_ST3_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => ST3_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => GND, CLK => B0_CLK, 
	D0 => B0_X3O);
GLB_ST2_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => ST2_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => GND, CLK => B0_CLK, 
	D0 => B0_X2O);
GLB_B0_IN13B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN13B, A0 => NWEX_grp);
GLB_B0_IN12B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN12B, A0 => NCSX_grp);
GLB_B0_IN10B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN10B, A0 => REFRQST_PIN_grpi);
GLB_B0_IN11B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN11B, A0 => ST4_PIN_grpi);
GLB_B0_IN17B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN17B, A0 => ST3_PIN_ffb);
GLB_B0_IN14B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN14B, A0 => NRESETX_grp);
GLB_B0_IN3B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN3B, A0 => ST0_PIN_grpi);
GLB_B0_IN16B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN16B, A0 => ST2_PIN_ffb);
GLB_B0_IN6B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B0_IN6B, A0 => ST1_PIN_grpi);
GLB_B1_P12 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B1_P12, A3 => B1_IN6B, A2 => B1_IN13B, A1 => B1_IN14, 
	A0 => B1_IN16);
GLB_B1_P11 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B1_P11, A3 => B1_IN7, A2 => B1_IN12B, A1 => B1_IN14, 
	A0 => B1_IN16);
GLB_B1_P10 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B1_P10, A3 => B1_IN12B, A2 => B1_IN13, A1 => B1_IN14, 
	A0 => B1_IN16);
GLB_B1_P9 : PGAND6_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B1_P9, A5 => B1_IN6B, A4 => B1_IN7B, A3 => B1_IN10, 
	A2 => B1_IN12B, A1 => B1_IN13B, A0 => B1_IN14);
GLB_B1_P8 : PGAND6_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B1_P8, A5 => B1_IN6, A4 => B1_IN7, A3 => B1_IN12, 
	A2 => B1_IN13, A1 => B1_IN14, A0 => B1_IN16B);
GLB_B1_G3 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B1_G3, A0 => B1_F4);
GLB_B1_F4 : PGORF75_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B1_F4, A4 => B1_P8, A3 => B1_P9, A2 => B1_P10, 
	A1 => B1_P11, A0 => B1_P12);
GLB_B1_CLK : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B1_CLK, A0 => BUF_933_ck2f);
GLB_B1_IN16 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN16, A0 => ST4_PIN_ffb);
GLB_B1_IN10 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN10, A0 => REFRQST_PIN_grpi);
GLB_B1_IN14 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN14, A0 => NRESETX_grp);
GLB_B1_IN13 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN13, A0 => ST2_PIN_grpi);
GLB_B1_IN12 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN12, A0 => ST3_PIN_grpi);
GLB_B1_IN7 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN7, A0 => ST0_PIN_grpi);
GLB_B1_IN6 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B1_IN6, A0 => ST1_PIN_grpi);
GLB_B1_X0O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B1_X0O, A1 => GND, A0 => B1_G3);
GLB_ST4_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => ST4_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => GND, CLK => B1_CLK, 
	D0 => B1_X0O);
GLB_B1_IN13B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B1_IN13B, A0 => ST2_PIN_grpi);
GLB_B1_IN12B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B1_IN12B, A0 => ST3_PIN_grpi);
GLB_B1_IN7B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B1_IN7B, A0 => ST0_PIN_grpi);
GLB_B1_IN6B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B1_IN6B, A0 => ST1_PIN_grpi);
GLB_B1_IN16B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B1_IN16B, A0 => ST4_PIN_ffb);
GLB_B7_P13 : PGAND3_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P13, A2 => B7_IN11B, A1 => B7_IN14, A0 => B7_IN16B);
GLB_B7_P12 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P12, A4 => B7_IN8B, A3 => B7_IN9, A2 => B7_IN11, 
	A1 => B7_IN14, A0 => B7_IN16B);
GLB_B7_P11 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P11, A4 => B7_IN9B, A3 => B7_IN11, A2 => B7_IN14, 
	A1 => B7_IN16B, A0 => B7_IN17B);
GLB_B7_P10 : PGAND7_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P10, A6 => B7_IN8B, A5 => B7_IN9B, A4 => B7_IN10B, 
	A3 => B7_IN12, A2 => B7_IN14, A1 => B7_IN16B, A0 => B7_IN17B);
GLB_B7_P9 : PGAND7_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P9, A6 => B7_IN8B, A5 => B7_IN9B, A4 => B7_IN10B, 
	A3 => B7_IN13B, A2 => B7_IN14, A1 => B7_IN16B, A0 => B7_IN17B);
GLB_B7_P7 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P7, A4 => B7_IN8B, A3 => B7_IN9, A2 => B7_IN14, 
	A1 => B7_IN16B, A0 => B7_IN17);
GLB_B7_P6 : PGAND6_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P6, A5 => B7_IN8B, A4 => B7_IN9B, A3 => B7_IN10, 
	A2 => B7_IN11B, A1 => B7_IN14, A0 => B7_IN16B);
GLB_B7_P5 : PGAND7_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P5, A6 => B7_IN8B, A5 => B7_IN9B, A4 => B7_IN11B, 
	A3 => B7_IN12B, A2 => B7_IN13B, A1 => B7_IN14, A0 => B7_IN16B);
GLB_B7_P3 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P3, A3 => B7_IN11B, A2 => B7_IN14, A1 => B7_IN16B, 
	A0 => B7_IN17);
GLB_B7_P2 : PGAND4_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P2, A3 => B7_IN8B, A2 => B7_IN14, A1 => B7_IN16, 
	A0 => B7_IN17B);
GLB_B7_P1 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P1, A4 => B7_IN9B, A3 => B7_IN11, A2 => B7_IN14, 
	A1 => B7_IN16, A0 => B7_IN17B);
GLB_B7_P0 : PGAND5_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => B7_P0, A4 => B7_IN9, A3 => B7_IN11B, A2 => B7_IN14, 
	A1 => B7_IN16, A0 => B7_IN17B);
GLB_B7_G3 : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B7_G3, A0 => B7_F4);
GLB_B7_G2 : PGORF72_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B7_G2, A1 => B7_F0, A0 => B7_F1);
GLB_B7_F4 : PGORF74_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B7_F4, A3 => B7_P9, A2 => B7_P10, A1 => B7_P11, 
	A0 => B7_P12);
GLB_B7_F1 : PGORF73_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B7_F1, A2 => B7_P5, A1 => B7_P6, A0 => B7_P7);
GLB_B7_F0 : PGORF74_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => B7_F0, A3 => B7_P0, A2 => B7_P1, A1 => B7_P2, 
	A0 => B7_P3);
GLB_B7_CLK : PGBUFI_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B7_CLK, A0 => BUF_933_ck2f);
GLB_B7_P13_xa : PGBUFI_dram
    GENERIC MAP (TRISE => 2.700000 ns, TFALL => 2.700000 ns)
	PORT MAP (Z0 => B7_P13_xa, A0 => B7_P13);
GLB_B7_IN12 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN12, A0 => NCSX_grp);
GLB_B7_IN10 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN10, A0 => REFRQST_PIN_grpi);
GLB_B7_IN17 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN17, A0 => ST1_PIN_ffb);
GLB_B7_IN11 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN11, A0 => ST4_PIN_grpi);
GLB_B7_IN16 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN16, A0 => ST0_PIN_ffb);
GLB_B7_IN14 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN14, A0 => NRESETX_grp);
GLB_B7_IN9 : PGBUFI_dram
    GENERIC MAP (TRISE => 1.100000 ns, TFALL => 1.100000 ns)
	PORT MAP (Z0 => B7_IN9, A0 => ST2_PIN_grpi);
GLB_B7_X1O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B7_X1O, A1 => GND, A0 => B7_G2);
GLB_B7_X0O : PGXOR2_dram
    GENERIC MAP (TRISE => 0.500000 ns, TFALL => 0.500000 ns)
	PORT MAP (Z0 => B7_X0O, A1 => B7_P13_xa, A0 => B7_G3);
GLB_ST1_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => ST1_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => GND, CLK => B7_CLK, 
	D0 => B7_X1O);
GLB_ST0_PIN : PGDFFR_dram
    GENERIC MAP (HLCQ => 1.400000 ns, LHCQ => 1.400000 ns, HLRQ => 6.300000 ns, SUD0 => 0.700000 ns, 
        SUD1 => 0.700000 ns, HOLDD0 => 2.000000 ns, HOLDD1 => 2.000000 ns, POSC1 => 4.000000 ns, 
        POSC0 => 4.000000 ns, NEGC1 => 4.000000 ns, NEGC0 => 4.000000 ns, RECRC => 0.000000 ns, 
        HOLDRC => 0.000000 ns)
	PORT MAP (Q0 => ST0_PIN, RNESET => L2L_KEYWD_RESET_glbb, CD => GND, CLK => B7_CLK, 
	D0 => B7_X0O);
GLB_B7_IN10B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN10B, A0 => REFRQST_PIN_grpi);
GLB_B7_IN13B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN13B, A0 => NWEX_grp);
GLB_B7_IN12B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN12B, A0 => NCSX_grp);
GLB_B7_IN16B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN16B, A0 => ST0_PIN_ffb);
GLB_B7_IN8B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN8B, A0 => ST3_PIN_grpi);
GLB_B7_IN9B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN9B, A0 => ST2_PIN_grpi);
GLB_B7_IN17B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN17B, A0 => ST1_PIN_ffb);
GLB_B7_IN11B : PGINVI_dram
    GENERIC MAP (TRISE => 0.900000 ns, TFALL => 0.900000 ns)
	PORT MAP (ZN0 => B7_IN11B, A0 => ST4_PIN_grpi);
IOC_L2L_KEYWD_RESET : PXIN_dram
    GENERIC MAP (TRISE => 3.000000 ns, TFALL => 3.000000 ns)
	PORT MAP (Z0 => L2L_KEYWD_RESETb, XI0 => XRESET);
IOC_IO12_IBUFO : PXIN_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => IO12_IBUFO, XI0 => RCLK);
IOC_IO9_IBUFO : PXIN_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => IO9_IBUFO, XI0 => NWE);
IOC_IO1_IBUFO : PXIN_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => IO1_IBUFO, XI0 => NRESET);
IOC_IO8_IBUFO : PXIN_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => IO8_IBUFO, XI0 => NCS);
IOC_IO11_IBUFO : PXIN_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => IO11_IBUFO, XI0 => MCLK);
IOC_IO0_IBUFO : PXIN_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => IO0_IBUFO, XI0 => JTAG_NTRST);
IOC_ST4 : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => ST4, A0 => IO20_OBUFI);
IOC_IO20_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO20_OBUFI, A0 => ST4_PIN_iomux);
IOC_ST3 : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => ST3, A0 => IO19_OBUFI);
IOC_IO19_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO19_OBUFI, A0 => ST3_PIN_iomux);
IOC_ST2 : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => ST2, A0 => IO18_OBUFI);
IOC_IO18_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO18_OBUFI, A0 => ST2_PIN_iomux);
IOC_ST1 : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => ST1, A0 => IO17_OBUFI);
IOC_IO17_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO17_OBUFI, A0 => ST1_PIN_iomux);
IOC_ST0 : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => ST0, A0 => IO16_OBUFI);
IOC_IO16_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO16_OBUFI, A0 => ST0_PIN_iomux);
IOC_R_A_EN : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => R_A_EN, A0 => IO6_OBUFI);
IOC_IO6_OBUFI : PGINVI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (ZN0 => IO6_OBUFI, A0 => OR_869_iomux);
IOC_REFRQST : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => REFRQST, A0 => IO13_OBUFI);
IOC_IO13_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO13_OBUFI, A0 => REFRQST_PIN_iomux);
IOC_RAS : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => RAS, A0 => IO3_OBUFI);
IOC_IO3_OBUFI : PGINVI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (ZN0 => IO3_OBUFI, A0 => OR_866_iomux);
IOC_NWAIT : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => NWAIT, A0 => IO10_OBUFI);
IOC_IO10_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO10_OBUFI, A0 => NWAIT_PIN_iomux);
IOC_NTRST : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => NTRST, A0 => IO2_OBUFI);
IOC_IO2_OBUFI : PGBUFI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (Z0 => IO2_OBUFI, A0 => NTRST_PIN_iomux);
IOC_DRAM_WE : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => DRAM_WE, A0 => IO5_OBUFI);
IOC_IO5_OBUFI : PGINVI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (ZN0 => IO5_OBUFI, A0 => OR_867_iomux);
IOC_C_A_EN : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => C_A_EN, A0 => IO7_OBUFI);
IOC_IO7_OBUFI : PGINVI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (ZN0 => IO7_OBUFI, A0 => OR_868_iomux);
IOC_CAS : PXOUT_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (XO0 => CAS, A0 => IO4_OBUFI);
IOC_IO4_OBUFI : PGINVI_dram
    GENERIC MAP (TRISE => 0.400000 ns, TFALL => 0.400000 ns)
	PORT MAP (ZN0 => IO4_OBUFI, A0 => OR_865_iomux);
GRP_REFRQST_PIN_grpi : PGBUFI_dram
    GENERIC MAP (TRISE => 1.200000 ns, TFALL => 1.200000 ns)
	PORT MAP (Z0 => REFRQST_PIN_grpi, A0 => REFRQST_PIN);
GRP_REFRQST_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => REFRQST_PIN_iomux, A0 => REFRQST_PIN);
GRP_NTRST_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => NTRST_PIN_iomux, A0 => NTRST_PIN);
GRP_JTAG_NTRSTX_grp : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => JTAG_NTRSTX_grp, A0 => IO0_IBUFO);
GRP_NRESETX_grp : PGBUFI_dram
    GENERIC MAP (TRISE => 1.300000 ns, TFALL => 1.300000 ns)
	PORT MAP (Z0 => NRESETX_grp, A0 => IO1_IBUFO);
GRP_ST0_PIN_grpi : PGBUFI_dram
    GENERIC MAP (TRISE => 1.400000 ns, TFALL => 1.400000 ns)
	PORT MAP (Z0 => ST0_PIN_grpi, A0 => ST0_PIN);
GRP_ST0_PIN_ffb : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST0_PIN_ffb, A0 => ST0_PIN);
GRP_ST0_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST0_PIN_iomux, A0 => ST0_PIN);
GRP_ST1_PIN_grpi : PGBUFI_dram
    GENERIC MAP (TRISE => 1.400000 ns, TFALL => 1.400000 ns)
	PORT MAP (Z0 => ST1_PIN_grpi, A0 => ST1_PIN);
GRP_ST1_PIN_ffb : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST1_PIN_ffb, A0 => ST1_PIN);
GRP_ST1_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST1_PIN_iomux, A0 => ST1_PIN);
GRP_ST2_PIN_ffb : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST2_PIN_ffb, A0 => ST2_PIN);
GRP_ST2_PIN_grpi : PGBUFI_dram
    GENERIC MAP (TRISE => 1.400000 ns, TFALL => 1.400000 ns)
	PORT MAP (Z0 => ST2_PIN_grpi, A0 => ST2_PIN);
GRP_ST2_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST2_PIN_iomux, A0 => ST2_PIN);
GRP_ST3_PIN_ffb : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST3_PIN_ffb, A0 => ST3_PIN);
GRP_ST3_PIN_grpi : PGBUFI_dram
    GENERIC MAP (TRISE => 1.400000 ns, TFALL => 1.400000 ns)
	PORT MAP (Z0 => ST3_PIN_grpi, A0 => ST3_PIN);
GRP_ST3_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST3_PIN_iomux, A0 => ST3_PIN);
GRP_ST4_PIN_ffb : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST4_PIN_ffb, A0 => ST4_PIN);
GRP_ST4_PIN_grpi : PGBUFI_dram
    GENERIC MAP (TRISE => 1.400000 ns, TFALL => 1.400000 ns)
	PORT MAP (Z0 => ST4_PIN_grpi, A0 => ST4_PIN);
GRP_ST4_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => ST4_PIN_iomux, A0 => ST4_PIN);
GRP_BUF_932_ck1f : PGBUFI_dram
    GENERIC MAP (TRISE => 1.800000 ns, TFALL => 1.800000 ns)
	PORT MAP (Z0 => BUF_932_ck1f, A0 => BUF_932);
GRP_OR_869_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => OR_869_iomux, A0 => OR_869);
GRP_OR_867_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => OR_867_iomux, A0 => OR_867);
GRP_OR_866_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => OR_866_iomux, A0 => OR_866);
GRP_OR_865_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => OR_865_iomux, A0 => OR_865);
GRP_OR_868_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => OR_868_iomux, A0 => OR_868);
GRP_NWAIT_PIN_iomux : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => NWAIT_PIN_iomux, A0 => NWAIT_PIN);
GRP_NCSX_grp : PGBUFI_dram
    GENERIC MAP (TRISE => 1.200000 ns, TFALL => 1.200000 ns)
	PORT MAP (Z0 => NCSX_grp, A0 => IO8_IBUFO);
GRP_BUF_933_ck2f : PGBUFI_dram
    GENERIC MAP (TRISE => 1.800000 ns, TFALL => 1.800000 ns)
	PORT MAP (Z0 => BUF_933_ck2f, A0 => BUF_933);
GRP_MCLKX_grp : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => MCLKX_grp, A0 => IO11_IBUFO);
GRP_NWEX_grp : PGBUFI_dram
    GENERIC MAP (TRISE => 1.200000 ns, TFALL => 1.200000 ns)
	PORT MAP (Z0 => NWEX_grp, A0 => IO9_IBUFO);
GRP_RCLKX_grp : PGBUFI_dram
    GENERIC MAP (TRISE => 1.000000 ns, TFALL => 1.000000 ns)
	PORT MAP (Z0 => RCLKX_grp, A0 => IO12_IBUFO);
GRP_L2L_KEYWD_RESET_glb : PXIN_dram
    GENERIC MAP (TRISE => 1.500000 ns, TFALL => 1.500000 ns)
	PORT MAP (Z0 => L2L_KEYWD_RESET_glbb, XI0 => L2L_KEYWD_RESETb);
END dram_STRUCTURE;
