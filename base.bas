'base code

'base data
dim baseX(MAXBASES) as ubyte
dim baseY(MAXBASES) as ubyte
dim baseAlignment(MAXBASES) as ubyte
dim baseType(MAXBASES) as ubyte
dim baseHP(MAXBASES) as ubyte
dim baseAP(MAXBASES) as ubyte

'declarations
declare sub captureBase(baseNum as ubyte, alignment as ubyte)

'disable a base
sub disableBase(baseNum as ubyte)
	baseX(baseNum) = DISABLED
	baseY(baseNum) = DISABLED
	baseAlignment(baseNum) = DISABLED
	baseType(baseNum) = DISABLED
	baseHP(baseNum) = DISABLED
	baseAP(baseNum) = DISABLED
end sub

'create a base
sub createBase(baseNum as ubyte, y as ubyte, x as ubyte)
	baseX(baseNum) = x
	baseY(baseNum) = y
	captureBase(baseNum, BASENEUTRAL)
end sub

'capture a base
sub captureBase(baseNum as ubyte, alignment as ubyte)
	baseAlignment(baseNum) = alignment
	baseType(baseNum) = BASETYPENONE
	baseHP(baseNum) = BASESTARTHP
	baseAP(baseNum) = BASESTARTAP
end sub
