# Physical_Design_2024
This is Chandan Kumar N S (MS2024007). <br/>
Course - Physical Design of ASICs ( VLS508) <br/>

# LAB - 1 
  ## TASK - 1
  ### Write a C Program and compile it on gcc compiler.
  This repository contains a simple C program that calculates the sum of n numbers. <br/>
  The following steps outline how to compile a C program using GCC. <br/>
  ## Step 1 

Open the terminal and ensure you are in the home directory. Launch any text editor to create a new file named 'file_name.c' for writing the C program. I have used the gedit editor.<br/>
## i. CODE SNIPPET: 
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

## TASK - 2
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








​
 



  
  
  
  
