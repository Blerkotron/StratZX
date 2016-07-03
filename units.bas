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

'checks the team array to see if a team has been completely
'wiped out or not
function isTeamDead(offset as ubyte) as ubyte
	dim n, c as ubyte

	'we're going to count the number of units still active
	c = 0
	
	'loop through the team's 'space' in the arrays
	for n = offset to (offset + MAXUNITS) - 1
		if isUnitAlive(n) = TRUE then
			c = c + 1
		end if
	next n
	
	'return FALSE if we still have units, TRUE otherwise
	if c > 0 then 
		return FALSE
	else
		return TRUE
	end if
	
end function

'checks the game state to see if one team or another has won
function getWinner() as ubyte
	
	'check for a goodie win
	if isTeamDead(BADOFFSET) then
		return GOODOFFSET
	elseif isTeamDead(GOODOFFSET) then
		return BADOFFSET
	else
		return DISABLED
	end if
	
end function

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
