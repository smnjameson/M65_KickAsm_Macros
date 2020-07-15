//Example usages of new commands:

#import "m65opcodes.asm"
	
	:adc ($12), z
	:and ($f8), z

	asr 
	asr $c0
	asr $c0, x

	asw $ff

	bbr0 $ff, myLabel
	bbr1 $ff, myLabel
	bbr2 $ff, myLabel
	bbr3 $ff, myLabel
	bbr4 $ff, myLabel
	bbr5 $ff, myLabel
	bbr6 $ff, myLabel
	bbr7 $ff, myLabel

	bbs0 $ff, myLabel
	bbs1 $ff, myLabel
	bbs2 $ff, myLabel
	bbs3 $ff, myLabel
	bbs4 $ff, myLabel
	bbs5 $ff, myLabel
	bbs6 $ff, myLabel
	bbs7 $ff, myLabel

	:bcc myLabel
	:bcs myLabel
	:beq myLabel

	bit $ff, x
	bit $ffff, x
	bit #$aa 

	:bmi myLabel
	:bne myLabel
	:bpl myLabel

	bra myLabel
	:bra myLabel

	:bvc myLabel
	:bvs myLabel

	bsr myLabel

myLabel:

	cle

	:cmp ($f8), z

	cpz #$23
	cpz $45
	cpz $6789

	dec
	dew $f8
	dez 

	eom

	:eor ($f8), z

	inc 
	inw $ed
	inz

	jmp ($ffff, x)

	:jsr ($ffff)
	:jsr ($ffff, x)

	:lda ($ff), z
	ldasp ($ff), y

	ldz #$12
	ldz $3456
	ldz $789a, x

	map 
	neg

	:ora ($f8), z

	phw #$3211
	phw $beef
	phx
	phy
	phz
	plx
	ply
	plz

	rmb0 $fe
	rmb1 $fa
	rmb2 $fa
	rmb3 $fa
	rmb4 $fa
	rmb5 $fa
	rmb6 $fa
	rmb7 $fa

	row $beef

	:rts #$12

	:sbc ($ee), z

	see

	smb0 $aa
	smb1 $aa
	smb2 $aa
	smb3 $aa
	smb4 $aa
	smb5 $aa
	smb6 $aa
	smb7 $aa

	stasp ($ff), y
	:sta ($ee), z
	:stx $beef, y
	:sty $beef, x	
	stz $fe
	stz $beef
	stz $be, x
	stz $beef, x

	tab
	taz
	tba 

	trb $fe
	trb $beef
	tsb $fe
	tsb $beef

	tsy 
	tys 
	tza
