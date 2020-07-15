
# Mega65 - KickAssembler 45GS02 Pseudocommands

A set of pseudocommands for KickAssembler to allow you to use all the 45GS02 instructions.

## Usage
Simply put m65opcodes.asm somewhere in your project structure and import it at the top of your entry file:
```
	#import "m65opcodes.asm"
```

## Notes
Some opcodes require a colon prefix (generally when an existing opcode has new addressing modes that did not exist in the 65c02 instruction set), they are as follows:

* ALL base page indirect z-indexed
```
	:adc ($12), z
	:and ($f8), z
```
* All 16-bit relative branches 
```
	:bcc myLabel
	:bcs myLabel
	:beq myLabel
```
* Indirect JSR instructions 
```
	:jsr ($ffff)
	:jsr ($ffff, x)
```
* RTS using immediate addressing mode
```
	:rts #$12
```
* STX $nnnn, y and STY $nnnn,x 
```
	:stx $beef, y
	:sty $beef, x	
```
Additionally due to pseudocommand and Kick assembler restrictions the stack relative indirect indexed by Y mode of LDA and STA have their own mnemonic:
```
	ldasp ($ff), y
	stasp ($ff), y
``` 



## SublimeText Syntax File

Included in this repo is the KickAssembler (Mega65).sublime-syntax which can be dropped into the users package folder in sublime to provide syntax highlighting for all the commands. You can then go to view->syntax and select it from the drop down list for any given file.

#### Location on Windows 10
```
%AppData%\Sublime Text 3\Packages\User
```


## To Do
* add unique pseudo opcodes for the Mega65 32-bit instructions