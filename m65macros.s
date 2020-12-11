.macro BasicUpstart65(addr) {
	* = $2001
		.var addrStr = toIntString(addr)

		.byte $09,$20 //End of command marker (first byte after the 00 terminator)
		.byte $0a,$00 //10
		.byte $fe,$02,$30,$00 //BANK 0
		.byte <end, >end //End of command marker (first byte after the 00 terminator)
		.byte $14,$00 //20
		.byte $9e //SYS
		.text addrStr
		.byte $00
	end:
		.byte $00,$00	//End of basic terminators
}

.macro enable40Mhz() {
		lda #$41
		sta $00 //40 Mhz mode
}

.macro enableVIC3Registers () {
		lda #$00
		tax 
		tay 
		taz 
		map
		eom

		lda #$A5	//Enable VIC III
		sta $d02f
		lda #$96
		sta $d02f
}

.macro enableVIC4Registers () {
		lda #$00
		tax 
		tay 
		taz 
		map
		eom

		lda #$47	//Enable VIC IV
		sta $d02f
		lda #$53
		sta $d02f


}

.macro disableC65ROM() {
		lda #$70
		sta $d640
		eom
}

.macro mapMemory(source, target) {
	.var sourceMB = (source & $ff00000) >> 20
	.var sourceOffset = ((source & $00fff00) - target)
	.var sourceOffHi = sourceOffset >> 16
	.var sourceOffLo = (sourceOffset & $0ff00 ) >> 8
	.var bitLo = pow(2, (((target) & $ff00) >> 12) / 2) << 4
	.var bitHi = pow(2, (((target-$8000) & $ff00) >> 12) / 2) << 4
	
	.if(target<$8000) {
		lda #sourceMB
		ldx #$0f
		ldy #$00
		ldz #$00
	} else {
		lda #$00
		ldx #$00
		ldy #sourceMB
		ldz #$0f
	}
	map 

	//Set offset map
	.if(target<$8000) {
		lda #sourceOffLo
		ldx #[sourceOffHi + bitLo]
		ldy #$00
		ldz #$00
	} else {
		lda #$00
		ldx #$00
		ldy #sourceOffLo
		ldz #[sourceOffHi + bitHi]
	}	
	map 
	eom
}

.macro VIC4_SetCharLocation(addr) {
	lda #[addr & $ff]
	sta $d068
	lda #[[addr & $ff00]>>8]
	sta $d069
	lda #[[addr & $ff0000]>>16]
	sta $d06a
}

.macro VIC4_SetScreenLocation(addr) {
	lda #[addr & $ff]
	sta $d060
	lda #[[addr & $ff00]>>8]
	sta $d061
	lda #[[addr & $ff0000]>>16]
	sta $d062
	lda #[[[addr & $ff0000]>>24] & $0f]
	sta $d063
}
