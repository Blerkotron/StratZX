'team code

'declarations
declare function checkMove(offset as ubyte, unit as ubyte, dir as ubyte) as ubyte

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
	
	'if we have units then we don't need to do the next bit
	if c = 0 then
	
		'count the number of bases we still have active
		for n = 0 to MAXBASES - 1
			if (offset = GOODOFFSET and baseAlignment(n) = BASEGOOD) or (offset = BADOFFSET and baseAlignment(n) = BASEBAD) then
				c = c + 1
			end if
		next n
		
	end if
	
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

'determine if a unit can move to a square in a particular direction
function checkMove(offset as ubyte, unit as ubyte, dir as ubyte) as ubyte
	dim result as ubyte = FALSE
	
	'check we're not off the board
	if (dir = IUP and unitY(unit) = 0) or (dir = IDOWN and unitY(unit) = (MAPHEIGHT - 1)) or (dir = ILEFT and unitX(unit) = 0) or (dir = IRIGHT and unitX(unit) = (MAPWIDTH - 1)) then
		return CANNOTMOVE
	end if
	
	'calculate new board position
	dim newX, newY as ubyte 
	newX = unitX(unit)
	newY = unitY(unit)
	if dir = IUP then
		newY = newY - 1
	elseif dir = IDOWN then
		newY = newY + 1
	elseif dir = ILEFT then
		newX = newX - 1
	elseif dir = IRIGHT then
		newX = newX + 1
	end if
	
	'calculate what's 'friendly' and what's 'enemy'
	dim fPlane, fTank, fInfanty, fBase, ePlane, eTank, eInfantry, eBase as ubyte
	if offset = GOODOFFSET then
		fPlane = UNITPLANEGOOD
		fTank = UNITTANKGOOD
		fInfanty = UNITINFANTRYGOOD
		fBase = BASEGOOD
		ePlane = UNITPLANEBAD
		eTank = UNITTANKBAD
		eInfantry = UNITINFANTRYBAD
		eBase = BASEBAD
	else
		fPlane = UNITPLANEBAD
		fTank = UNITTANKBAD
		fInfanty = UNITINFANTRYBAD
		fBase = BASEBAD
		ePlane = UNITPLANEGOOD
		eTank = UNITTANKGOOD
		eInfantry = UNITINFANTRYGOOD
		eBase = BASEGOOD
	end if
	
	'check we're not running into one of our own units or bases
	if spriteMap(newY, newX) = fPlane or spriteMap(newY, newX) = fTank or spriteMap(newY, newX) = fInfanty or spriteMap(newY, newX) = fBase then
		return CANNOTMOVE
	end if
	
	'check if we're running into a unit battle
	if spriteMap(newY, newX) = ePlane or spriteMap(newY, newX) = eTank or spriteMap(newY, newX) = eInfantry then
		return BATTLE
	end if
	
	'check if we're running into a base takeover
	if spriteMap(newY, newX) = BASENEUTRAL or spriteMap(newY, newX) = eBase then
		return TAKEOVER
	end if
	
	'check if we're allowed to move onto that flavour of tile
	if unitCanEnterTile(unit, levelMap(newY, newX)) = FALSE then
		return CANNOTMOVE
	end if
	
	'if we got to here then we're good to go
	return CANMOVE
	
end function

