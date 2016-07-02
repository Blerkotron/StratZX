'basic reusable utilities

'includes
#include <keys.bas>

'keyboard read constants
const IUP as ubyte = 7
const IDOWN as ubyte = 6
const ILEFT as ubyte = 5
const IRIGHT as ubyte = 8
const IFIRE as ubyte = 0
const INULL as ubyte = 99

'input globals
dim joy as ubyte = 0
dim joyval as ubyte
dim upKey as uinteger = KEYQ
dim downKey as uinteger = KEYA
dim leftKey as uinteger = KEYO
dim rightKey as uinteger = KEYP
dim fireKey as uinteger = KEYM

'function declarations
declare function getLeftValue(value as ubyte) as ubyte
declare function getRightValue(value as ubyte) as ubyte
declare function setLeftValue(value as ubyte, left as ubyte) as ubyte
declare function setRightValue(value as ubyte, right as ubyte) as ubyte
declare function setLeftRightValue(left as ubyte, right as ubyte) as ubyte

'simple 'wait for a keypress' sub
sub anyKey()
	while inkey$ <> ""
	end while
	while inkey$ = ""
	end while
end sub

'simple 'get a keypress' function
function getKeypress() as string
	dim pressedKey as string
	
	while inkey$ <> ""
	end while
	
	do
		pressedKey = inkey$
	loop until pressedKey <> ""
	
	return pressedKey
end function

'turn joystick on or off
sub setJoystick(useJoystick as ubyte)
	if useJoystick = 1 then
		joy = 1
	else
		joy = 0
	end if
end sub

'redefine the keys
sub setPlayerKeys(u as uinteger, d as uinteger, l as uinteger, r as uinteger, f as uinteger)
	upKey = u
	downKey = d
	leftKey = l
	rightKey = r
	fireKey = f
end sub

'player input read routine
function readPlayerInput() as ubyte
	
	'determine if we're reading keyboard/key joystick or kempston
	if joy = 0 then
	
		'keyboard/key joystick read
		if MultiKeys(fireKey) <> 0 then return IFIRE
		elseif MultiKeys(leftKey) <> 0 then return ILEFT
		elseif MultiKeys(rightKey) <> 0 then return IRIGHT
		elseif MultiKeys(upKey) <> 0 then return IUP
		elseif MultiKeys(downKey) <> 0 then return IDOWN
		end if
	else
	
		'kempston read
		joyval = IN 31
		if (16 and joyval) <> 0 then return IFIRE
		elseif (2 bAND joyval) <> 0 then return ILEFT
		elseif (1 bAND joyval) <> 0 then return IRIGHT
		elseif (8 bAND joyval) <> 0 then return IUP
		elseif (4 bAND joyval) <> 0 then return IDOWN
		end if
	end if
	
	'if we got to here then nothing is pressed
	return INULL
	
end function

'retrieves the four-bit value in the leftmost half of a byte
function getLeftValue(value as ubyte) as ubyte
	return value >> 4
end function

'retrieves the four-bit value in the rightmost half of a byte
function getRightValue(value as ubyte) as ubyte
	return (value << 4) >> 4
end function

'sets the four-bit value in the leftmost half of a byte
function setLeftValue(value as ubyte, left as ubyte) as ubyte
	return (left << 4) + getRightValue(value)
end function

'sets the four-bit value in the rightmost half of a byte
function setRightValue(value as ubyte, right as ubyte) as ubyte
	return right + getLeftValue(value)
end function

'sets four-bit values in both the left and right halves of a byte
function setLeftRightValue(left as ubyte, right as ubyte) as ubyte
	return setLeftValue(right, left)
end function
