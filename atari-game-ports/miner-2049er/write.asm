	;; 
	;; Write Miner 2049er Score to disk
	;;
	;; @author  Thomas Cherryhomes
	;; @email   thom dot cherryhomes at gmail dot com
	;; @license gpl v. 3
	;;

	ORG $5A00

DDEVIC	=	$0300	;peripheral bus ID number
DUNIT	=	$0301	;unit number
DCOMND	=	$0302	;bus command ordinal
DSTATS	=	$0303	;command type/status return
DBUFLO	=	$0304	;data buffer pointer
DBUFHI	=	$0305
DTIMLO	=	$0306	;device timeout in seconds
DBYTLO	=	$0308	;number of bytes transferred
DBYTHI	=	$0309
DAUX1	=	$030A	;command auxiliary bytes
DAUX2	=	$030B

SIOV	=	$E459   ; SIO Vector

	LDA #$31		; Drive 1
	STA DDEVIC
	LDA #$01		; Unit 1 (D1:)
	STA DUNIT
	LDA #'W'		; Write
	STA DCOMND
	LDA #$80		; ->Drive
	STA DSTATS
	LDA #$00		; $0800
	STA DBUFLO
	LDA #$08
	STA DBUFHI
	LDA #$80		; 128 bytes
	STA DBYTLO
	LDA #$00
	STA DBYTHI
	LDA #$CF		; Sector $02CF
	STA DAUX1
	LDA #$02
	JSR SIOV		; Do it

	LDA #$80		
	STA DSTATS
	LDA #$80		; $0880
	STA DBUFLO
	LDA #$08
	STA DBUFHI
	LDA #$89		; Sector $02D0
	STA DAUX1
	JSR SIOV		; do it

	JMP $92B9		; Finish and back to High scores screen

	ORG $02E0
	.WORD $2000
