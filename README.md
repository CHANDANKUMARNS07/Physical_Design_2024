# Physical_Design_2024
This is Chandan Kumar N S (MS2024007). <br/>
Course - Physical Design of ASICs ( VLS508) <br/>
# Outline
1.[LAB 1](#lab-1)<br/>
2.[LAB 2](#lab-2)<br/>
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















​
 



  
  
  
  
