'Strat v0.1

'go
start()

'includes
#include "constants.bas"
#include "utilities.bas"
#include "units.bas"
#include "level.bas"

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

	'clear the screen
	cls
		
	'initialise game
	resetGame()
	generateMap()
	generateUnits()
	
	'draw map
	drawFullMap()
	drawAllUnits()
	
	'TODO
	anyKey()

end sub
