'constants

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

'unit constants
const MAXUNITS as ubyte = 10
const MAXUNITSARRAY as ubyte = (MAXBASES + MAXUNITS) * 2
const MAXSTARTUNITS as ubyte = 3

const BADOFFSET as ubyte = MAXUNITS + MAXBASES

const UNITEMPTY as ubyte = 0
const UNITPLANEGOOD as ubyte = 1
const UNITTANKGOOD as ubyte = 2
const UNITINFANTRYGOOD as ubyte = 3
const UNITPLANEBAD as ubyte = 4
const UNITTANKBAD as ubyte = 5
const UNITINFANTRYBAD as ubyte = 6
const UNITBASE as ubyte = 7
const UNITBASEGOOD as ubyte = 8
const UNITBASEBAD as ubyte = 9

const DISABLED as ubyte = 99

'unit stats
const UNITPLANESTARTHP as ubyte = 80
const UNITTANKSTARTHP as ubyte = 100
const UNITINFANTRYSTARTHP as ubyte = 60

const UNITPLANESTARTAP as ubyte = 2
const UNITTANKSTARTAP as ubyte = 1
const UNITINFANTRYSTARTAP as ubyte = 2
