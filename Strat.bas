'Strat v0.1

'go
start()

'includes
#include "constants.bas"
#include "utilities.bas"
#include "sound.bas"
#include "base.bas"
#include "units.bas"
#include "level.bas"
#include "team.bas"
#include "ai.bas"
#include "battle.bas"

'declarations
declare sub playerTurn(offset as ubyte)
declare sub movePlayerUnit(offset as ubyte, unit as ubyte)
declare sub moveUnit(offset as ubyte, unit as ubyte, dir as ubyte)

'start
sub start()
	
	'init
	init()
	
	'main loop
	do
	
		'do menu
		doMenu()
		
		'play game
		playGame(TRUE)
		
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
sub playGame(twoPlayer as ubyte)
	dim winner as ubyte = DISABLED
	
	'clear the screen
	cls
		
	'generate a new game
	generateGame()
	
	'draw full level (map, units, bases)
	drawLevel()
	
	'main game loop
	do
	
		'player turn
		playerTurn(GOODOFFSET)
		
		'check for a winner
		winner = getWinner()
		if winner = DISABLED then
		
			'next turn depends on if we're one or two player
			if twoPlayer = FALSE then
			
				'computer turn
				computerTurn()
			
			else
			
				'player two turn
				playerTurn(BADOFFSET)
				
			end if
			
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
sub playerTurn(offset as ubyte)
	dim unit as ubyte
	
	'get the first unit
	unit = getFirstUnit(offset)

	'main player turn loop
	while unit <> DISABLED
	
		'move the unit
		movePlayerUnit(offset, unit)
		
		'get the next unit
		unit = getNextUnit(offset, unit)
		
	end while
	
	'handle player's bases
	'TODO
	
end sub

'move one of the player's units
sub movePlayerUnit(offset as ubyte, unit as ubyte)
	dim key as ubyte
	dim done as ubyte = FALSE
	
	'loop until out of AP or we quit
	while done <> TRUE and unitAP(unit) > 0

		'highlight the unit
		drawUnit(unit, TRUE)
		
		'read controls
		key = readSinglePlayerInput()
		if key = IFIRE then
			done = TRUE
		elseif key <> INULL then
			moveUnit(offset, unit, key)
		end if

	end while
		
	'reset the unit for next turn
	if isUnitAlive(unit) then
		drawUnit(unit, FALSE)
		resetAP(unit)
	end if
	
end sub

'move a unit in a direction, if possible
sub moveUnit(offset as ubyte, unit as ubyte, dir as ubyte)
	dim moveStatus as ubyte
	
	'determine if this is a legal move and how to handle it
	moveStatus = checkMove(offset, unit, dir)
	
	'action depends on the move status
	if moveStatus = CANMOVE then
		
		'move the unit on the screen and update the level maps
		moveUnitDir(unit, dir, TRUE)
		
		'and reduce the unit's AP
		unitAP(unit) = unitAP(unit) - 1
		
		'TODO
		playSound(SFXMOVEUNIT)
		
	elseif moveStatus = BATTLE then
		'TODO
		playSound(SFXBATTLE)
	elseif moveStatus = TAKEOVER then
		'TODO
		playSound(SFXTAKEOVER)
	else
		'TODO
		playSound(SFXCANNOTMOVE)
	end if
	
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
