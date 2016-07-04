'units code

'unit data
dim unitX(MAXUNITSARRAY) as ubyte
dim unitY(MAXUNITSARRAY) as ubyte
dim unitType(MAXUNITSARRAY) as ubyte
dim unitHP(MAXUNITSARRAY) as ubyte
dim unitAP(MAXUNITSARRAY) as ubyte

'declarations
declare function isUnitAlive(unit as ubyte) as ubyte

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

'given a team offset returns the first unit that should be dealt with
function getFirstUnit(offset as ubyte) as ubyte
	dim n as ubyte
	
	'loop to find the first active unit
	for n = offset to (offset + MAXUNITS) - 1
		if isUnitAlive(n) = TRUE then
			return n
		end if
	next n

	'no units active
	return DISABLED
	
end function

'given a team offset and a 'last unit' number, returns the next unit
'that should be dealt with
function getNextUnit(offset as ubyte, lastUnit as ubyte) as ubyte
	dim n as ubyte
	
	'check to see if this was the last possible unit first
	if lastUnit = (offset + MAXUNITS) - 1 then
		return DISABLED
	end if
	
	'loop to find the first active unit
	for n = (lastUnit + 1) to (offset + MAXUNITS) - 1
		if isUnitAlive(n) = TRUE then
			return n
		end if
	next n

	'no more units active
	return DISABLED

end function

'check if a unit is 'alive' or not
function isUnitAlive(unit as ubyte) as ubyte
	if unitHP(unit) > 0 and unitHP(unit) <> DISABLED then
		return TRUE
	else
		return FALSE
	end if
end function

'resets a unit's AP back to its starting value
sub resetAP(unit as ubyte)

	'AP depends on unit type
	if unitType(unit) = UNITPLANEGOOD or unitType(unit) = UNITPLANEBAD then
		unitAP(unit) = UNITPLANESTARTAP
	elseif unitType(unit) = UNITTANKGOOD or unitType(unit) = UNITTANKBAD then
		unitAP(unit) = UNITTANKSTARTAP
	else
		unitAP(unit) = UNITINFANTRYSTARTAP
	end if
	
end sub

'check if we're allowed to move onto that flavour of tile
function unitCanEnterTile(unit as ubyte, tileType as ubyte) as ubyte
	dim canEnter as ubyte = TRUE
	
	'depends on unit type - planes can go anywhere, but...
	if (unitType(unit) = UNITTANKGOOD or unitType(unit) = UNITTANKBAD) and (tileType = MAPWATER or tileType = MAPMOUNTAIN or tileType = MAPTREES) then
		canEnter = FALSE
	elseif (unitType(unit) = UNITINFANTRYGOOD or unitType(unit) = UNITINFANTRYBAD) and (tileType = MAPWATER) then
		canEnter = FALSE
	end if
	
	'done
	return canEnter
	
end function
