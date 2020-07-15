/*
	Constants
*/
.cpu _65c02					//Turns on 65c02 support in KickAsm

.const z = -999				//allows (base page),z addressing mode
.const sy = -998				//allows (base page, s),y addressing mode
.const AT_IZEROPAGEZ = 13 	//Adds a pseudo addressing mode
.const AT_INDIRECTX = -5 	//Adds a pseudo addressing mode

/*
	Functions
*/
.function GetAdressingModeType(arg) {
	.if(arg == AT_NONE) .return "AT_NONE"
	.if(arg == AT_IMMEDIATE) .return "AT_IMMEDIATE"
	.if(arg == AT_INDIRECT) .return "AT_INDIRECT"
	.if(arg == AT_INDIRECTX) .return "AT_INDIRECTX"
	.if(arg == AT_ABSOLUTE) .return "AT_ABSOLUTE"
	.if(arg == AT_ABSOLUTEX) .return "AT_ABSOLUTEX"
	.if(arg == AT_ABSOLUTEY) .return "AT_ABSOLUTEY"
	.if(arg == AT_IZEROPAGEX) .return "AT_IZEROPAGEX"
	.if(arg == AT_IZEROPAGEY) .return "AT_IZEROPAGEY"
	.if(arg == AT_IZEROPAGEZ) .return "AT_IZEROPAGEZ"
	.return arg
}
/*
	PseudoCommands
*/
.pseudocommand adc arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':adc' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':adc ($nn),z' requires zeropage address"
	.byte $72, value
}

.pseudocommand and arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':and' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':and ($nn),z' requires zeropage address"
	.byte $32, value
}

.pseudocommand asr arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $43
	} else .if(type == AT_ABSOLUTE) {
		.if(value > $ff ) .error "'asr a' requires zeropage address"
		.byte $44, value
	} else .if(type == AT_ABSOLUTEX) {
		.if(value > $ff ) .error "'asr $nn,x' requires zeropage address"
		.byte $54, value
	} else {
		.error "invalid adressingmode. 'asr' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}

.pseudocommand asw arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.byte $cb, <value, >value
	} else {
		.error "invalid adressingmode. 'asw' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}


.pseudocommand bcc arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $93, <offset, >offset
	} else {
		.error "invalid adressingmode. ':bcc' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bcs arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $b3, <offset, >offset
	} else {
		.error "invalid adressingmode. ':bcs' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand beq arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $f3, <offset, >offset
	} else {
		.error "invalid adressingmode. ':beq' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bmi arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $33, <offset, >offset
	} else {
		.error "invalid adressingmode. ':bmi' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bne arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $d3, <offset, >offset
	} else {
		.error "invalid adressingmode. ':bne' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bpl arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $13, <offset, >offset
	} else {
		.error "invalid adressingmode. ':bpl' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bra arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $83, <offset, >offset		
	} else {
		.error "invalid adressingmode. ':bra' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bsr arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $63, <offset, >offset		
	} else {
		.error "invalid adressingmode. ':bsr' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bvc arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $53, <offset, >offset		
	} else {
		.error "invalid adressingmode. ':bvc' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand bvs arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.var offset = value - * - 2
		.byte $73, <offset, >offset		
	} else {
		.error "invalid adressingmode. ':bvs' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand cle arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $02
	} else {
		.error "invalid adressingmode. 'cle' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand cmp arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':cmp' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':cmp ($nn),z' requires zeropage address"
	.byte $d2, value
}

.pseudocommand cpz arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_IMMEDIATE) {
		.byte $c2, value
	} else .if(type == AT_ABSOLUTE) {
		.if(value <= $ff ) {
			.byte $d4, value
		} else {
			.byte $dc, <value, >value
		}
	} else {
		.error "invalid adressingmode. 'cpz' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}

.pseudocommand dew arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.if(value > $ff ) .error "':dew $nn' requires zeropage address"
		.byte $c3, value
	} else {
		.error "invalid adressingmode. 'dew' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand dez arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $3b
	} else {
		.error "invalid adressingmode. 'dez' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand eom arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $ea
	} else {
		.error "invalid adressingmode. 'eom' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand eor arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':eor' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':eor ($nn),z' requires zeropage address"
	.byte $52, value
}
.pseudocommand inw arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.if(value > $ff ) .error "':inw $nn' requires zeropage address"
		.byte $e3, value
	} else {
		.error "invalid adressingmode. 'inw' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand inz arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $1b
	} else {
		.error "invalid adressingmode. 'inz' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand jsr arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_INDIRECT) {
		.byte $22, <value, >value
	} else .if(type == -5) {
		.byte $23, <value, >value
	} else {
		.error "invalid adressingmode. ':jsr' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand lda arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':lda' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':lda ($nn),z' requires zeropage address"
	.byte $b2, value
}
.pseudocommand ldasp arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEY) .error "':ldasp' only accepts AT_IZEROPAGEY"
	.if(value > $ff ) .error "':ldasp ($nn),y' requires zeropage address"
	.byte $e2, value
}
.pseudocommand ldz arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_IMMEDIATE) {
		.byte $a3, value
	} else .if(type == AT_ABSOLUTE) {
		.byte $ab, <value, >value
	} else .if(type == AT_ABSOLUTEX) {
		.byte $bb, <value, >value
	} else {
		.error "invalid adressingmode. 'ldz' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand map arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $5c
	} else {
		.error "invalid adressingmode. 'map' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand neg arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $42
	} else {
		.error "invalid adressingmode. 'neg' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand ora arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':ora' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':ora ($nn),z' requires zeropage address"
	.byte $12, value
}

.pseudocommand phw arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_IMMEDIATE) {
		.byte $f4, <value, >value
	} else .if(type == AT_ABSOLUTE) {
		.byte $fc, <value, >value
	} else {
		.error "invalid adressingmode. 'phw' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}

.pseudocommand phz arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $db
	} else {
		.error "invalid adressingmode. 'phz' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand plz arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $fb
	} else {
		.error "invalid adressingmode. 'plz' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand row arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_ABSOLUTE) {
		.byte $eb, <value, >value
	} else {
		.error "invalid adressingmode. 'row' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand rts arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_IMMEDIATE) {
		.byte $62, value
	} else {
		.error "invalid adressingmode. ':rts' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand sbc arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':sbc' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':sbc ($nn),z' requires zeropage address"
	.byte $f2, value
}
.pseudocommand see arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $03
	} else {
		.error "invalid adressingmode. 'see' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand sta arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEZ) .error "':sta' only accepts AT_IZEROPAGEZ"
	.if(value > $ff ) .error "':sta ($nn),z' requires zeropage address"
	.byte $92, value
}
.pseudocommand stasp arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_IZEROPAGEY) .error "':stasp' only accepts AT_IZEROPAGEY"
	.if(value > $ff ) .error "':stasp ($nn),y' requires zeropage address"
	.byte $82, value
}
.pseudocommand stx arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_ABSOLUTEY) .error "':stx' only accepts AT_ABSOLUTEY"
	.byte $9b, <value, >value
}
.pseudocommand sty arg {
	.var value = arg.getValue()
	.var type = arg.getType()
	.if(type != AT_ABSOLUTEX) .error "':sty' only accepts AT_ABSOLUTEX"
	.byte $8b, <value, >value
}
.pseudocommand tab arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $5b
	} else {
		.error "invalid adressingmode. 'tab' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand taz arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $4b
	} else {
		.error "invalid adressingmode. 'taz' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand tba arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $7b
	} else {
		.error "invalid adressingmode. 'tba' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand tsy arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $0b
	} else {
		.error "invalid adressingmode. 'tsy' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand tys arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $2b
	} else {
		.error "invalid adressingmode. 'tys' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
.pseudocommand tza arg {
	.var value = arg.getValue()
	.var type = arg.getType()	
	.if(type == AT_NONE) {
		.byte $6b
	} else {
		.error "invalid adressingmode. 'tba' doesn't support "+GetAdressingModeType(type)+" mode"
	}
}
