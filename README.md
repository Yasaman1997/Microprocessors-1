# Atmel-ATmega16


<p align="center">
  <img src="http://uupload.ir/files/2wv_avr-studio-logo.jpg">
</p>

AVR ATmega16 Microcontroller programming and simulation using AtmelStudio and Proteus.

# Introduction: Instruction Set and Addressing Modes
The following is a quick start on basic concepts of ATmega16 microcontroller.

# Introduction: Instruction Set
This is a set of instructions for ATmega16 microcontroller which decides what operations the microcontroller can perform. Each instruction can control some parts of microcontroller.

# Introduction: Addressing Modes
Instructions can be categorized based on **how they access data** and **how they perform operations** on those data. This category consist of about 10 modes that controls this access and operation.

# Introduction: Instruction Format
Each instruction in ATmega16 consists of two parts:
* Opcode: Indicates to ALU what to do.
* Operands: Numbers on which the ALU operates.

# ATmega16 Addressing Modes Details
There are 5 sections in ATmega16 which have relationships with **data and program**. So the addressing mode category will spread over these 5 areas and they are mentioned down here:
* Register File (32 Registers - A part of SRAM which is built into the CPU - **32** bytes | 32 registers of 1 Byte)
* I/O Registers (64 Registers - A part of SRAM which is built into the CPU - **64** bytes | 64 registers of 1 Byte)
* SRAM (Data Memory - Separate from those mentioned above - out of CPU - **1024** Bytes considering 96 bytes for the above sections)
* EEPROM (**512** bytes)
* Flash Memory (AKA Program Memory - **16** Kbytes of On-chip In-system reprogrammable flash memory)

## Register Direct (Single Register)
<p align="center">
  <img src="http://uupload.ir/files/2xms_register_direct.png">
</p>

* Can operate on any 32 registers of the register file.

* Operations:
1. Read contents of registers 
2. Operate on contents
3. Store back in same register

* Usage examples:
1. INC R0
2. DEC R5
3. LSL R9


## Register Direct (Two Registers)
<p align="center">
  <img src="http://uupload.ir/files/7nky_register_direct(two_regs).png">
</p>

* Two registers are included in this mode:
1. Rs: Source Register
2. Rd: Destination Register

* Operations:
1. Read two registers
2. Operate on the content
3. Store the result in the destination register

* Usage Examples:
1. ADD R1,R3
2. SUB R5,R7

## Immediate Mode
* Constant value is in the instruction.
* Operates on the register and that constant value and stores the result back in the register.
* Usage Examples:
1. SUBI R4,8 (Subtract with Immediate: R4 = R4 - 8)
2. ADIW R26,5 (Add Immediate to Word: R27:R26 = R27:R26 + 5)