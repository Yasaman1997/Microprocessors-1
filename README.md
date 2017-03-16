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
