'constants

'general constants
const TRUE as ubyte = 1
const FALSE as ubyte = 0

'movement check constants
const CANNOTMOVE as ubyte = 0
const CANMOVE as ubyte = 1
const BATTLE as ubyte = 2
const TAKEOVER as ubyte = 3

'level constants
const MAPHEIGHT as ubyte = 12
const MAPWIDTH as ubyte = 16

const MAXGENERATIONS as ubyte = 40
const MAXBASES as ubyte = 6

const MAPEMPTY as ubyte = 0
const MAPTREES as ubyte = 1
const MAPWATER as ubyte = 2
const MAPMOUNTAIN as ubyte = 3
const MAXTERRAIN as ubyte = MAPMOUNTAIN

const SPRITEEMPTY as ubyte = 0

'unit constants
const MAXUNITS as ubyte = 10
const MAXUNITSARRAY as ubyte = (MAXBASES + MAXUNITS) * 2
const MAXSTARTUNITS as ubyte = 3

const GOODOFFSET as ubyte = 0
const BADOFFSET as ubyte = MAXUNITS + MAXBASES

const UNITPLANEGOOD as ubyte = 1
const UNITTANKGOOD as ubyte = 2
const UNITINFANTRYGOOD as ubyte = 3
const UNITPLANEBAD as ubyte = 4
const UNITTANKBAD as ubyte = 5
const UNITINFANTRYBAD as ubyte = 6

const DISABLED as ubyte = 99

'unit stats
const UNITPLANESTARTHP as ubyte = 80
const UNITTANKSTARTHP as ubyte = 100
const UNITINFANTRYSTARTHP as ubyte = 60

const UNITPLANESTARTAP as ubyte = 2
const UNITTANKSTARTAP as ubyte = 1
const UNITINFANTRYSTARTAP as ubyte = 2

'base constants
const BASENEUTRAL as ubyte = 1
const BASEGOOD as ubyte = 2
const BASEBAD as ubyte = 3

const BASETYPENONE as ubyte = 0
const BASETYPEPLANE as ubyte = 1
const BASETYPETANK as ubyte = 2
const BASETYPEINFANTRY as ubyte = 3

const BASESTARTHP as ubyte = 50
const BASESTARTAP as ubyte = 3
