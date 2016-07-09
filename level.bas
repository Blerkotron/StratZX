'level code

'level data
dim levelMap(MAPHEIGHT, MAPWIDTH) as ubyte
dim spriteMap(MAPHEIGHT, MAPWIDTH) as ubyte

'declarations
declare sub drawTile(y as ubyte, x as ubyte)
declare sub drawUnit(unit as ubyte, selected as ubyte)
declare sub drawBase(base as ubyte, selected as ubyte)

'generate a whole new level
sub generateGame()
	resetGame()
	generateMap()
	generateUnitsAndBases()
end sub

'reset level
sub resetGame()
	dim x, y as ubyte
	
	'clear the map
	for y = 0 to MAPHEIGHT - 1
		for x = 0 to MAPWIDTH - 1
			levelMap(y, x) = MAPEMPTY
			spriteMap(y, x) = SPRITEEMPTY
		next x
	next y
	
	'clear the unit arrays
	for x = 0 to MAXUNITSARRAY - 1
		disableUnit(x)
	next x
	
end sub

'generate a random map
sub generateMap()
	dim n, x, y, u as ubyte
	
	'seed random stuff
	for n = 0 to MAXGENERATIONS - 1
	
		'location and unit type
		x = int(rnd * MAPWIDTH)
		y = int(rnd * MAPHEIGHT)
		u = int(rnd * MAXTERRAIN) + 1
		
		'set into level map
		levelMap(y, x) = u
		
	next n
	
end sub

'generate an initial set of random bases and units
sub generateUnitsAndBases()
	dim x, y, u, n as ubyte
	
	'seed random bases
	for n = 0 to MAXBASES - 1
		do
			x = int(rnd * MAPWIDTH)
			y = int(rnd * MAPHEIGHT)
		loop until spriteMap(y, x) = SPRITEEMPTY
		
		'make a base and put it on the map
		createBase(n, y, x)
		spriteMap(y, x) = BASENEUTRAL
		
	next n
	
	'seed random goodies
	u = UNITPLANEGOOD
	for n = 0 to MAXSTARTUNITS - 1
		do
			x = int(rnd * MAPWIDTH)
			y = int(rnd * MAPHEIGHT)
		loop until spriteMap(y, x) = SPRITEEMPTY
		
		'make a unit and put it on the map
		createUnit(n, u, y, x)
		spriteMap(y, x) = u
		
		u = u + 1
		if u > UNITINFANTRYGOOD then
			u = UNITPLANEGOOD
		end if
	next n
	
	'seed random baddies
	u = UNITPLANEBAD
	for n = 0 to MAXSTARTUNITS - 1
		do
			x = int(rnd * MAPWIDTH)
			y = int(rnd * MAPHEIGHT)
		loop until spriteMap(y, x) = SPRITEEMPTY
		
		'make a unit and put it on the map
		createUnit(n + BADOFFSET, u, y, x)
		spriteMap(y, x) = u
		
		u = u + 1
		if u > UNITINFANTRYBAD then
			u = UNITPLANEBAD
		end if
	next n
	
end sub

'draw the entire level - map, units, bases
sub drawLevel()
	drawFullMap()
	drawAllUnits()
	drawAllBases()
end sub

'draw whole map to screen
sub drawFullMap()
	dim x, y as ubyte
	
	for y = 0 to MAPHEIGHT - 1
		for x = 0 to MAPWIDTH - 1
			drawTile(y, x)
		next x
	next y
	
end sub

'draw a single tile to the screen
sub drawTile(y as ubyte, x as ubyte)
	if levelMap(y, x) = MAPEMPTY then
		print at y * 2, x * 2; paper 4; ink 0; bright 0; "  "; at (y * 2) + 1, x * 2; "  "
	elseif levelMap(y, x) = MAPTREES then
		print at y * 2, x * 2; paper 4; ink 0; bright 0; "^^"; at (y * 2) + 1, x * 2; "^^"
	elseif levelMap(y, x) = MAPWATER then
		print at y * 2, x * 2; paper 1; ink 7; bright 0; "~~"; at (y * 2) + 1, x * 2; "~~"
	elseif levelMap(y, x) = MAPMOUNTAIN then
		print at y * 2, x * 2; paper 3; ink 7; bright 0; "/\"; at (y * 2) + 1, x * 2; "--"
	end if
end sub

'draw all units
sub drawAllUnits()
	dim n as ubyte
	for n = 0 to MAXUNITSARRAY - 1
		if isUnitAlive(n) = TRUE then 
			drawUnit(n, FALSE)
		end if
	next n
end sub

'draw a single unit to the screen
sub drawUnit(unit as ubyte, selected as ubyte)
	dim y, x as ubyte
	y = unitY(unit) * 2
	x = unitX(unit) * 2
	
	if unitType(unit) = UNITPLANEGOOD then
		print at y, x; paper 6; ink 1; bright 1; flash selected; "PL"; at y + 1, x; "AN"
	elseif unitType(unit) = UNITTANKGOOD then
		print at y, x; paper 6; ink 1; bright 1; flash selected;"TA"; at y + 1, x; "NK"
	elseif unitType(unit) = UNITINFANTRYGOOD then
		print at y, x; paper 6; ink 1; bright 1; flash selected;"IN"; at y + 1, x; "FA"
	elseif unitType(unit) = UNITPLANEBAD then
		print at y, x; paper 0; ink 2; bright 1; flash selected;"PL"; at y + 1, x; "AN"
	elseif unitType(unit) = UNITTANKBAD then
		print at y, x; paper 0; ink 2; bright 1; flash selected;"TA"; at y + 1, x; "NK"
	elseif unitType(unit) = UNITINFANTRYBAD then
		print at y, x; paper 0; ink 2; bright 1; flash selected;"IN"; at y + 1, x; "FA"
	end if
end sub

'draw all bases
sub drawAllBases()
	dim n as ubyte
	for n = 0 to MAXBASES - 1
		drawBase(n, FALSE)
	next n
end sub

'draw a single base to the screen
sub drawBase(base as ubyte, selected as ubyte)
	dim y, x as ubyte
	y = baseY(base) * 2
	x = baseX(base) * 2
	
	if baseAlignment(base) = BASENEUTRAL then
		print at y, x; paper 7; ink 0; bright 0; flash selected;"BA"; at y + 1, x; "SE"
	elseif baseAlignment(base) = BASEGOOD then
		print at y, x; paper 6; ink 1; bright 1; flash selected;"BA"; at y + 1, x; "SE"
	elseif baseAlignment(base) = BASEBAD then
		print at y, x; paper 0; ink 2; bright 1; flash selected;"BA"; at y + 1, x; "SE"
	end if
end sub

'move a unit in a direction, redrawing the maps, etc.
sub moveUnitDir(unit as ubyte, dir as ubyte, selected as ubyte)
		
		'undraw the sprite
		drawTile(unitY(unit), unitX(unit))
		
		'update the sprite map
		spriteMap(unitY(unit), unitX(unit)) = SPRITEEMPTY
		
		'calculate the new position
		if dir = IUP then
			unitY(unit) = unitY(unit) - 1
		elseif dir = IDOWN then
			unitY(unit) = unitY(unit) + 1
		elseif dir = ILEFT then
			unitX(unit) = unitX(unit) - 1
		elseif dir = IRIGHT then
			unitX(unit) = unitX(unit) + 1
		end if
		
		'redraw the sprite
		drawUnit(unit, selected)
		
		'update the sprite map
		spriteMap(unitY(unit), unitX(unit)) = unitType(unit)
		
end sub
