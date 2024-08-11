# Physical_Design_2024
This is Chandan Kumar N S (MS2024007). <br/>
Course - Physical Design of ASICs ( VLS508) <br/>
# Outline
1.[LAB 1](#lab-1)<br/>
2.[LAB 2](#lab-2)<br/>
3.[LAB 3](lab-3)<br/>
# LAB 1
  ## TASK 1
  ### Write a C Program and compile it on gcc compiler.
  This repository contains a simple C program that calculates the sum of n numbers. <br/>
  The following steps outline how to compile a C program using GCC. <br/>
  ## Step 1 

Open the terminal and ensure you are in the home directory. Launch any text editor to create a new file named 'file_name.c' for writing the C program. I have used the gedit editor.<br/>
## i. Code Snippet : 
``` c
#include<stdio.h>
int main(){
int i,n=100,sum=0;
for(i=0;i<=n;++i)
sum+=i;
}
printf("sum of numbers from 1 to %d is %d\n",n,sum);
return 0;
}
```
## Step 2
Save the program. Compile the code using the GCC compiler with the following command.<br/>
```
gcc file_name.c
```
## Output
The output can be viewed by opening the .out file. By default, the compiler creates a file named 'a.out' in the same directory. This name can be changed using the following command.<br/>
```
gcc -o output_filename.out filename.c
```
The below image shows the c program and also the output i got for different values of n which is 100, 15, 1000 and the result is saved in "output.out" file.<br/>
For verification we can use the mathematical formula for the sum of n numbers is : <br/>
Sum = (n(n+1))/2<br/>

![output](https://github.com/user-attachments/assets/ea37bd1b-cb44-4fad-9c2a-e77e7c5ce9c9)

## TASK 2
### Compiling the same C Program in RISC-V gcc compiler
The procedure for compiling a C program using RISC-V gcc compiler is as follows :<br/>
## Step 1
First, we display the content of our code. Next, using the command in figure, compile the code with the RISC-V gcc compiler. Running this command will generate an output file named filename.o
```
cat filename.c
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o filename.o filename.c
ls -ltr filename.o
```
![riscv1](https://github.com/user-attachments/assets/771995a4-f216-4763-87c3-e18ecdd567fd)

## Step 2
Now using the command in figure, we'll get assembly code of our c programme. We'll get a bunch of code. We'll again run the same command adding | less in the end
```
riscv64-unknown-elf-objdump -d filename.o
riscv64-unknown-elf-objdump -d filename.o | less
```
![riscv2](https://github.com/user-attachments/assets/aa1acc2b-273c-4262-9751-e660543179a7)
## Step 3
We'll obtain the output. Since we are particularly interested in the main section, we'll focus on that segment. To count the number of instructions, subtract the address of the first instruction in the current section from the address of the first instruction in the next section. Divide the result by 4, as the increment is 4 at each step. This calculation will reveal that there are 15 sets of instructions when using the -O1 optimization level.

![ricv3](https://github.com/user-attachments/assets/6b5e54bc-4b35-478a-876c-5c228dd6dd12)

![calculator1](https://github.com/user-attachments/assets/b6eb3e66-38cf-4002-8161-ed9a4a5520a4)
## Step 4
Now change the formula from '-O1' to '-Ofast' as in step 1 and re compile using the same commands in the terminal.
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o filename.o filename.c
ls -ltr filename.o
riscv64-unknown-elf-objdump -d filename.o
riscv64-unknown-elf-objdump -d filename.o | less
```
![riscv4](https://github.com/user-attachments/assets/0c684187-3cb7-49ee-9328-86cb0efd6b11)

When you calculate the number of instructions using the method described in step 3, you'll find that there are 12 instructions in this case.

![riscv5output](https://github.com/user-attachments/assets/2d950739-5552-4151-a7d3-61932aa325a5)

By comparing both -Ofast and -O1. -Ofast optimization level, the number of instructions is reduced. This is because -Ofast applies a broader range of aggressive optimizations that streamline the code, eliminate redundancies, and leverage parallelism, leading to a lower instruction count compared to -O1.

# LAB 2
## TASK 1
### Debbugging with Spike Simulator and Running the Object File Generated by RISC-V Compiler in Spike Simulator
The following are the steps to be followed. <br/>
## Step 1
Compile sum1ton.c (C source file) into sum1ton.o (Object file) for RISC-V with -Ofast optimization.
```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sumton.o sumton.c
```
## Step 2
Get the Object dump using following command.
```
riscv64-unknown-elf-objdump -d sumton.o | less
```

![ris0](https://github.com/user-attachments/assets/8bd7ace0-1561-457c-b93d-22b69f448ff5)

We get the following output:

The assembly level of main section of the program sumoneton.c is shown below in the snapshot for reference.

![ris1](https://github.com/user-attachments/assets/ef052c00-d788-4b94-b853-416bcd40d409)

## Step 3
Again re-compile the c program using gcc compiler and spike simulator. We get the below shown output.

```
spike pk sumton.o
```

![ris2](https://github.com/user-attachments/assets/44c7da2e-0359-4ec6-87cb-80c657f112ce)

## Step 4
For debugging the code, we open debugger using spike.
```
 spike -d pk sum1ton.o
```
we want to run our program counter till 100b0
```
 until pc 0 100b0
```   
After the running of the commands manually after this, you must see "bbl loader", this ensures assembly code has run till 100b0 address now see the objdump to see what is the next instruction, in my case<br/>
* First command is lui a2, 0x7a which changes a2 register value<br/>

It allow the Spike debugger to run until the main function, specifically until the 100b0 instruction. After that, we will manually continue debugging and inspect the a2 register before and after the execution. We observe that the
instruction lui a2, 0x7a updates the a2 register from 0x0000000000000000 to 0x000000000007a000.<br/>
```
reg 0 a2
```
![ris3](https://github.com/user-attachments/assets/c1abdae1-72d2-41d3-bfa2-9f007047acd7)

* we will manually debug the next instruction i.e., lui a0, 0x21 and addi sp, sp, -16. This instruction decrements the stack pointer (sp) by 16. Before executing this instruction, the sp register held the value 0x0000003ffffffb50, which is then updated to 0x0000003ffffffb40.<br/>
 ```
reg 0 sp
```

* In the assembly code we can see that the value of the stack pointer is being reduced by 10 in hexadecimal we is equivalent to being reduced by 16 in decimal notation. 

![rrrrr](https://github.com/user-attachments/assets/cdc09ade-6cfa-4332-adfc-d184f9427662)
# LAB 3
## TASK 1
### To Identify various RISC-V instruction type (R, I, S, B, U, J) and exact 32-bit instruction code in the instruction type format for the given RISC-V instructions.
### Various format types of RISC-V instruction are:
- R-format
- I-format
- S-format
- B-format
- U-format
- J-format

<img width="772" alt="3808 1535301636" src="https://github.com/user-attachments/assets/d6bb6e93-1cd1-4a3f-8bc1-2841d8d30f11">

### 1. R Type :
Used for arithmetic and logical operations that involve only registers.
![R](https://github.com/user-attachments/assets/5615e6f4-648f-4e0f-a33c-0181d9859e80)

- `funct7` (7 bits): Specifies the function of the instruction (e.g., ADD, SUB).
- `rs2` (5 bits): Source register 2.
- `rs1` (5 bits): Source register 1.
- `funct3` (3 bits): Specifies the function within the operation.
- `rd` (5 bits): Destination register.
- `opcode` (7 bits): Operation code indicating the type of instruction

### 2. I Type :  
Used for instructions that include an immediate value or involve load operations.
![I](https://github.com/user-attachments/assets/13bdecb2-7b55-4c22-afba-7a6fdb8636c9)

- `imm[11:0]` (12 bits): Immediate value, sign-extended to 32 bits.
- `rs1` (5 bits): Source register 1.
- `funct3` (3 bits): Specifies the function of the instruction.
- `rd` (5 bits): Destination register.
- `opcode` (7 bits): Operation code

### 3. S Type : 
Used for store operations
![S](https://github.com/user-attachments/assets/fd39c8cc-0ef8-4745-bd62-a58428aa1d0e)

- `imm[11:5]` (7 bits): Upper part of the immediate value.
- `rs2` (5 bits): Source register 2.
- `rs1` (5 bits): Source register 1.
- `funct3` (3 bits): Specifies the function of the instruction.
- `imm[4:0]` (5 bits): Lower part of the immediate value.
- `opcode` (7 bits): Operation code.

### 4. B Type : 
Used for branch operations.
![B](https://github.com/user-attachments/assets/5faf17d8-47c5-4ae6-8e76-84951ea323ac)

- `imm[12]` (1 bit): Most significant bit of the immediate value.
- `imm[10:5]` (6 bits): Upper part of the immediate value.
- `rs2` (5 bits): Source register 2.
- `rs1` (5 bits): Source register 1.
- `funct3` (3 bits): Specifies the function of the instruction.
- `imm[4:1]` (4 bits): Lower part of the immediate value.
- `imm[11]` (1 bit): Sign bit of the immediate value.
- `opcode` (7 bits): Operation code

### 5. U Type :
Used for instructions involving upper immediate values
![U](https://github.com/user-attachments/assets/3e9c9d86-6e71-46dd-980b-6e048a3494ed)

- `imm[31:12]` (20 bits): Immediate value, shifted left 12 bits.
- `rd` (5 bits): Destination register.
- `opcode` (7 bits): Operation code

### 6. J Type :
Used for jump instructions.
![J](https://github.com/user-attachments/assets/350ce493-7c33-4bfd-8390-5422b3e94e90)

- `imm[19]` (1 bit): Most significant bit of the immediate value.
- `imm[10:1]` (10 bits): Lower part of the immediate value.
- `imm[11]` (1 bit): Sign bit of the immediate value.
- `imm[18:12]` (7 bits): Upper part of the immediate value.
- `rd` (5 bits): Destination register.
- `opcode` (7 bits): Operation code.

## Instruction Analysis:

| S. No. | Assembly Instruction | Instruction format |         32 bit Instruction Code        | Hexadecimal representation|
|--------|----------------------|--------------------|----------------------------------------|---------------------------|
| 1.     | ADD r4, r4, r4       | R                  | 0000000 00100 00100 000 00100 0110011  |        0x00420233         |
| 2.     | SUB r4, r4, r4       | R                  | 0100000 00100 00100 000 00100 0110011  |        0x40420233         |
| 3.     | AND r4, r4, r4       | R                  | 0000000 00100 00100 111 00100 0110011  |        0x00427233         |
| 4.     | OR r8, r4, r5        | R                  | 0000000 00101 00100 110 01000 0110011  |        0x00526433         |
| 5.     | XOR r8, r4, r4       | R                  | 0000000 00100 00100 100 01000 0110011  |        0x00C323B3         |
| 6.     | SLT r00, r1, r4      | R                  | 0000000 00100 00001 010 00000 0110011  |        0x00424433         |
| 7.     | ADDI r02, r2, 5      | I                  | 000000000101 00010 000 00010 0010011   |        0x00510113         |
| 8.     | SW r2, r0, 4         | S                  | 0000000 00000 00010 010 00100 0100011  |        0x00012223         |
| 9.     | SRL r06, r01, r1     | R                  | 0000000 00001 00001 101 00110 0110011  |        0x0010D333         |
| 10.    | BNE r0, r0, 20       | B                  | 0000000 01000 00000 001 00000 1100011  |        0x00801063         |
| 11.    | BEQ r0, r0, 15       | B                  | 0000000 01111 00000 000 00000 1100011  |        0x00F00063         |
| 12.    | LW r03, r01, 2       | I                  | 000000000010 00001 010 00011 0000011   |        0x0020A183         |
| 13.    | SLL r05, r01, r1     | R                  | 0000000 00001 00001 001 00101 0110011  |        0x001092B3         |

## TASK 2
### By making use of RISCV Core: Verilog Netlist and Testbench, perform an experiment of Functional Simulation.

Table to show standard RISC-V ISA and Hardcore ISA for each operation:<br/>

|Assembly Instruction	      | Standard  RISCV  ISA	 | Hardcoded  ISA  |
|----------------|-------------------|--------------|
|ADD R4, R4, R4	 |32'h00420233       |32'h02208300  |
|SUB R4, R4, R4	 |32'h40420233       |32'h02209380  |
|AND R4, R4, R4	 |32'h00427233       |32'h0230a400  |
|OR R8, R4, R5	  |32'h00526433	      |32'h02513480  |
|XOR R8, R4, R4  |32'h00C323B3       |32'h0240c500  |
|SLT R00, R1, R4 |32'h00424433	      |32'h02415580  |
|ADDI R02, R2, 5 |32'h00510113	      |32'h00520600  |
|SW R2, R0, 4	 	 |32'h00012223	      |32'h00209181  |
|SRL R06, R01, R1|32'h0010D333	      |32'h00208681  |
|BNE R0, R0, 20  |32'h00801063	      |32'h00f00002  |
|BEQ R0, R0, 15  |32'h00F00063       |32'h00210700  |
|LW R03, R01, 2	 |32'h0020A183 	     |32'h01409002  |
|SLL R05, R01, R1|32'h001092B3 	     |32'h00520601  |<br/>

From below we can see all instructions are Hardcoded.<br/>
![codes](https://github.com/user-attachments/assets/edc7df00-b896-4099-a4e4-3fd1f2da505f)

To compile and to get gtkwave of the iiitb_rv32i.v file and it's testbench iiitb_rv32i_tb.v file use below commands:<br/>

1. Create a new directory:
   ```
   mkdir risc_v_sim
   cd risc_v_sim
   ```

2. Create Verilog and testbench files:
   ```
   touch rv32i.v rv32i_tb.v
   ```

3. Copy RISC-V core and testbench code from the [reference repository](https://github.com/vinayrayapati/rv32i/).

4. Run simulation:
   ```
   iverilog -o rv32i rv32i.v rv32i_tb.v
   ./rv32i
   ```

5. View waveforms:
   ```
   gtkwave iiitb_rv32i.vcd
   ```
   ![terminal_1](https://github.com/user-attachments/assets/94ff016f-7cc9-409a-9a03-d937ce670a79)
   ![terminal_2](https://github.com/user-attachments/assets/8d284c8c-b045-4c22-9921-3f072c4ef663)
   
   ## Analyzing the Output Waveform of Instructions Covered:

## - **Instruction 1: ADD r5, r4, r5**

![add1](https://github.com/user-attachments/assets/2b15946e-57bf-433c-9249-4cc362e4bdff)

## - **Instruction 2: SUB r5, r5, r4**

![sub1](https://github.com/user-attachments/assets/d7f332b2-8c3c-4f13-9ac3-5c68f29aab9c)

## - **Instruction 3: AND r4, r5, r5**

![and](https://github.com/user-attachments/assets/801e7a9a-2b45-4af3-8676-b429babcc6fc)


## - **Instruction 4: OR r8, r4, r5**

![or](https://github.com/user-attachments/assets/0d6d5680-308a-49ea-ab12-6ac382e4b992)

## - **Instruction 5: XOR r8, r5, r4**

![xor](https://github.com/user-attachments/assets/81a21174-70b7-4137-bc97-c915e9120d85)

## - **Instruction 6: SLT r10, r2, r4**

![slt](https://github.com/user-attachments/assets/ce333dc6-63b2-4449-946c-b3b41d2b51ab)

## - **Instruction 7: ADDI r12, r3, 5**

![addi](https://github.com/user-attachments/assets/8f1bf456-4033-4c1f-af4b-f5d27bcc7afb)

## - **Instruction 8: SW r3, r1, 4**

![sw](https://github.com/user-attachments/assets/89a0fc5a-660c-4781-84bc-d50b57fb4593)

## - **Instruction 9: SRL r16, r11, r2**

![srl](https://github.com/user-attachments/assets/81005e54-78bd-460a-a9d9-8a3574e531f0)

## - **Instruction 10: BNE r0, r1, 20**

![bne](https://github.com/user-attachments/assets/b88dd569-7bb4-4189-95f4-e1e5e976d4ff)

## - **Instruction 11: BEQ r0, r0, 15**

![beq](https://github.com/user-attachments/assets/44e3faf6-eb8f-459c-87e5-2debf3c21cd6)

## - **Instruction 12: LW r13, r11, 2**

![lw](https://github.com/user-attachments/assets/8147dded-50be-419c-b9a5-823ddc1946e3)

## - **Instruction 13: SLL r15, r11, r2**

The above command was not able to be executed as there was not enough memory spaces and the program was compiled with a warning ( as shown in the snapshot shown below ) :<br/>
                                                                                                                                                                          
![error thing](https://github.com/user-attachments/assets/73b911de-e825-419b-90d8-50558bfa55fd)

As per the verilog code BEQ, LW, SLL instructions got 19 as the output at alu_out because in the code it is marked as the comment if we tried to uncomment and execute we get the error as shown in above snap shot. 

This experiment demonstrated the functional simulation of various RISC-V instructions using a Verilog netlist and testbench. We observed the behavior of each instruction through waveform analysis, providing insights into the RISC-V core's operation.<br/>

The comparison between standard RISC-V ISA encoding and the hardcoded ISA used in the simulation highlights the differences in instruction representation, which is crucial for understanding the implementation details of this particular RISC-V core. <br/> 

















​
 



  
  
  
  
