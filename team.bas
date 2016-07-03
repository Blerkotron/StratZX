'team code

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
