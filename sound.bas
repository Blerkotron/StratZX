'sound code

'constants
const SFXMOVEUNIT as ubyte = 1
const SFXBATTLE as ubyte = 2
const SFXTAKEOVER as ubyte = 3
const SFXCANNOTMOVE as ubyte = 4

sub playSound(type as ubyte)
	
	'sound effects
	if type = SFXMOVEUNIT then
		beep .1, 20
	elseif type = SFXBATTLE then
		beep .1, 5
	elseif type = SFXTAKEOVER then
		beep .1, 10
	elseif type = SFXCANNOTMOVE then
		beep .1, 0
	end if
	
end sub
