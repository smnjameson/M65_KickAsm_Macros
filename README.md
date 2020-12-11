
# Mega65 - KickAssembler 45GS02 Pseudocommands
A 45gs02 syntax highlighting file for use in Sublime Text when using the Kick Assembler from KickC, and some macros to simplify some Mega65 operations. 

## Usage
Simply put m65macros.asm somewhere in your project structure and import it at the top of your entry file:
```
	#import "m65macros.asm"
```
## Using the Kick Assembler found in KickC

In order to properly assemble 45gs02, you will need to use the Kick Assembler jar made by Jesper Gravgaard, found in KickC @

https://gitlab.com/camelot/kickc/-/blob/master/repo/cml/kickass/kickassembler/5.16-65ce02.i/kickassembler-5.16-65ce02.i.jar

When assembling, make sure you run the Assembler file to invoke the correct class as follows:

java -cp kickass.jar kickass.KickAssembler65CE02  


## SublimeText Syntax File

Included in this repo is the KickAssembler (Mega65).sublime-syntax which can be dropped into the users package folder in sublime to provide syntax highlighting for all the commands. You can then go to view->syntax and select it from the drop down list for any given file.

#### Location on Windows 10
```
%AppData%\Sublime Text 3\Packages\User
```
