'Strat v0.1

'go
start()

'includes
#include "constants.bas"
#include "utilities.bas"
#include "units.bas"
#include "level.bas"
#include "ai.bas"
#include "battle.bas"

'start
sub start()
	
	'init
	init()
	
	'main loop
	do
	
		'do menu
		doMenu()
		
		'play game
		playGame()
		
	loop
	
end sub

'initialise
sub init()
	
	'clear
	border 0
	paper 0
	ink 7
	bright 1
	flash 0
	inverse 0
	over 0
	
	'caps
	poke 23658,8
	
	'seed
	randomize
	
end sub

'do menu
sub doMenu()
	cls
	print at 2, 11; ink 7; paper 1; "STRAT v0.1"
	print at 22, 10; ink 5; "PRESS ANY KEY"
	anyKey()
end sub

'play game
sub playGame()
	dim winner as ubyte = DISABLED
	
	'clear the screen
	cls
		
	'initialise game
	resetGame()
	generateMap()
	generateUnits()
	
	'draw map
	drawFullMap()
	drawAllUnits()
	
	'main game loop
	do
	
		'player turn
		playerTurn()
		
		'check for a winner
		winner = getWinner()
		if winner = DISABLED then
		
			'computer turn
			computerTurn()
			
			'check for a winner
			winner = getWinner()
			
		end if
		
		'TODO: remove this
		anyKey()
		winner = GOODOFFSET

	loop until winner <> DISABLED
	
	'game over
	doGameOver(winner)
	
end sub

'player turn
sub playerTurn()
	dim unit as ubyte
	
	'get the first unit
	unit = getFirstUnit(GOODOFFSET)

	'main player turn loop
	while unit <> DISABLED
	
		'highlight the unit
		drawUnit(unitY(unit), unitX(unit), TRUE)
		
		'TODO
		anyKey()
		drawUnit(unitY(unit), unitX(unit), FALSE)
		
		'get the next unit
		unit = getNextUnit(GOODOFFSET, unit)
		
	end while
	
end sub

'computer turn
sub computerTurn()
	'TODO
end sub

'game over
sub doGameOver(winner as ubyte)
	cls
	print at 2, 11; ink 7; paper 1; "GAME OVER!"
	print at 22, 10; ink 5; "PRESS ANY KEY"
	anyKey()
end sub
