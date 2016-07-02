'units code

'unit data
dim unitX(MAXUNITSARRAY) as ubyte
dim unitY(MAXUNITSARRAY) as ubyte
dim unitType(MAXUNITSARRAY) as ubyte
dim unitHP(MAXUNITSARRAY) as ubyte
dim unitAP(MAXUNITSARRAY) as ubyte

'disable a unit
sub disableUnit(x as ubyte)
	unitX(x) = DISABLED
	unitY(x) = DISABLED
	unitType(x) = DISABLED
	unitHP(x) = DISABLED
	unitAP(x) = DISABLED
end sub

'create a unit
sub createUnit(unitNum as ubyte, utype as ubyte, y as ubyte, x as ubyte)

	'set up unit
	unitX(unitNum) = x
	unitY(unitNum) = y
	unitType(unitNum) = utype
	if utype = UNITPLANEGOOD or utype = UNITPLANEBAD then
		unitHP(unitNum) = UNITPLANESTARTHP
		unitAP(unitNum) = UNITPLANESTARTAP
	elseif utype = UNITTANKGOOD or utype = UNITTANKBAD then
		unitHP(unitNum) = UNITTANKSTARTHP
		unitAP(unitNum) = UNITTANKSTARTAP
	else
		unitHP(unitNum) = UNITINFANTRYSTARTHP
		unitAP(unitNum) = UNITINFANTRYSTARTAP
	end if
	
end sub
