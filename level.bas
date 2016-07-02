'level code

'level data
dim levelMap(MAPHEIGHT, MAPWIDTH) as ubyte
dim unitMap(MAPHEIGHT, MAPWIDTH) as ubyte

'declarations
declare sub drawTile(y as ubyte, x as ubyte)
declare sub drawUnit(y as ubyte, x as ubyte, selected as ubyte)

'reset level
sub resetGame()
	dim x, y as ubyte
	
	'clear the map
	for y = 0 to MAPHEIGHT - 1
		for x = 0 to MAPWIDTH - 1
			levelMap(y, x) = MAPEMPTY
			unitMap(y, x) = UNITEMPTY
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

'generate an initial set of random units
sub generateUnits()
	dim x, y, u, n as ubyte
	
	'seed random bases
	for n = 0 to MAXBASES - 1
		do
			x = int(rnd * MAPWIDTH)
			y = int(rnd * MAPHEIGHT)
		loop until unitMap(y, x) = UNITEMPTY
		unitMap(y, x) = UNITBASE
	next n
	
	'seed random goodies
	u = UNITPLANEGOOD
	for n = 0 to MAXSTARTUNITS - 1
		do
			x = int(rnd * MAPWIDTH)
			y = int(rnd * MAPHEIGHT)
		loop until unitMap(y, x) = UNITEMPTY
		
		'make a unit and put it on the map
		createUnit(n, u, y, x)
		unitMap(y, x) = u
		
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
		loop until unitMap(y, x) = UNITEMPTY
		
		'make a unit and put it on the map
		createUnit(n + BADOFFSET, u, y, x)
		unitMap(y, x) = u
		
		u = u + 1
		if u > UNITINFANTRYBAD then
			u = UNITPLANEBAD
		end if
	next n
	
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
	dim y, x as ubyte
	
	for y = 0 to MAPHEIGHT - 1
		for x = 0 to MAPWIDTH - 1
			drawUnit(y, x, FALSE)
		next x
	next y
end sub

'draw a single unit to the screen
sub drawUnit(y as ubyte, x as ubyte, selected as ubyte)
	if unitMap(y, x) = UNITPLANEGOOD then
		print at y * 2, x * 2; paper 6; ink 1; bright 1; flash selected; "PL"; at (y * 2) + 1, x * 2; "AN"
	elseif unitMap(y, x) = UNITTANKGOOD then
		print at y * 2, x * 2; paper 6; ink 1; bright 1; flash selected;"TA"; at (y * 2) + 1, x * 2; "NK"
	elseif unitMap(y, x) = UNITINFANTRYGOOD then
		print at y * 2, x * 2; paper 6; ink 1; bright 1; flash selected;"IN"; at (y * 2) + 1, x * 2; "FA"
	elseif unitMap(y, x) = UNITPLANEBAD then
		print at y * 2, x * 2; paper 0; ink 2; bright 1; flash selected;"PL"; at (y * 2) + 1, x * 2; "AN"
	elseif unitMap(y, x) = UNITTANKBAD then
		print at y * 2, x * 2; paper 0; ink 2; bright 1; flash selected;"TA"; at (y * 2) + 1, x * 2; "NK"
	elseif unitMap(y, x) = UNITINFANTRYBAD then
		print at y * 2, x * 2; paper 0; ink 2; bright 1; flash selected;"IN"; at (y * 2) + 1, x * 2; "FA"
	elseif unitMap(y, x) = UNITBASE then
		print at y * 2, x * 2; paper 7; ink 0; bright 0; flash selected;"BA"; at (y * 2) + 1, x * 2; "SE"
	elseif unitMap(y, x) = UNITBASEGOOD then
		print at y * 2, x * 2; paper 6; ink 1; bright 1; flash selected;"BA"; at (y * 2) + 1, x * 2; "SE"
	elseif unitMap(y, x) = UNITBASEGOOD then
		print at y * 2, x * 2; paper 0; ink 2; bright 1; flash selected;"BA"; at (y * 2) + 1, x * 2; "SE"
	end if
end sub
