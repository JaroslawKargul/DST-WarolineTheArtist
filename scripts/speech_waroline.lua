-----------------------------------
-- This file is the template for other speech files. Once a new string is added here, simply run PropagateSpeech.bat
-- If you are adding strings that are character specific, or not required by all characters, you will still need to add the strings to speech_wilson.lua,
-- and then add the context string to speech_from_generic.lua. Once you run the PropagateSpeech.bat, you can go into your character's speech file and simply uncomment the new lines.
-- WAROLINE UPDATE: All updated strings (as of Dec. 26th) have the text "-- UPDATED" next to them (Total: 38 Changes)
-- There are some caveats about maintaining sane formatting in this file. 
--      -No single line lua tables
--      -Opening and closing brackets should be on their own line
--      -If wilson's speech has X unnamed strings in a table, then all other speech files must have at least X unnamed strings in that context too (example, CHESSPIECE_MOOSEGOOSE has 1 string in wilson, but 2 in wortox), this requirement could be relaxed if required by motifying po_vault.lua) 

return {
	ACTIONFAIL =
	{
        REPAIR =
        {
            WRONGPIECE = "Hmm... that wasn't right.",
        },
        BUILD =
        {
            MOUNTED = "I need to get down first.",
            HASPET = "I already have one pet, no need to be greedy.",
			DRAWING_TOOHUNGRY = "I should eat something before I starve to death drawing.",	-- UPDATED ("I cannot draw with an empty belly!",)
			DRAWING_TOOFARAWAY = "I cannot see my art subject clearly from here...",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "I don't think he'd like that.",
			GENERIC = "What am I supposed to shave there?",
			NOBITS = "Smoother than the pages of my sketchbook.",
            REFUSE = "only_used_by_woodie",
		},
		STORE =
		{
			GENERIC = "I should start organizing this stuff better.",
			NOTALLOWED = "That doesn't go there.",
			INUSE = "I can wait, no rush.",
            NOTMASTERCHEF = "I'm an artist, not a chef.",
		},
        CONSTRUCT =
        {
            INUSE = "I can wait, no rush.",
            NOTALLOWED = "That doesn't go there.",
            EMPTY = "It's like asking an artist to draw with no paper!",
            MISMATCH = "I think I have the wrong plans.",
        },
		RUMMAGE =
		{	
			GENERIC = "I have to try something else.",
			INUSE = "I can wait, no rush.",
            NOTMASTERCHEF = "I'm an artist, not a chef.",
		},
		UNLOCK =
        {
        	WRONGKEY = "I have to try something else.",
        },
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "I guess that wasn't the right key... Whoops?",
        	KLAUS = "I don't think that's a good idea right now!!",
			QUAGMIRE_WRONGKEY = "I'll need to find the right key for that.",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "Locked.",
		},
        COOK =
        {
            GENERIC = "Cooking was never my forte.",
            INUSE = "I can wait, no rush.",
            TOOFAR = "I'll have to get closer first.",
        },
        START_CARRAT_RACE =
        {
            NO_RACERS = "Where are the racers?",
        },
        
		DISMANTLE =
		{
			COOKING = "I'll have to wait for it to stop cooking.",
			INUSE = "I can wait, no rush.",
			NOTEMPTY = "Time to clean up all this junk.",
        },
        FISH_OCEAN =
		{
			TOODEEP = "This rod is too small for that.",
		},
        OCEAN_FISHING_POND =
		{
			WRONGGEAR = "This rod is too big for that.",
		},
        --wickerbottom specific action
        READ =
        {
            GENERIC = "only_used_by_wickerbottom",
            NOBIRDS = "only_used_by_wickerbottom"
        },

        GIVE =
        {
            GENERIC = "That doesn't seem to go there.",
            DEAD = "They won't need it where they're going.",
            SLEEPING = "Sshhh! I should let them sleep.",
            BUSY = "Hey, do you have a second?",
            ABIGAILHEART = "I tried.",
            GHOSTHEART = "I tried.",
            NOTGEM = "There's no way that goes there..",
            WRONGGEM = "That's the wrong gem.",
            NOTSTAFF = "Hmm... that can't be right.",
            MUSHROOMFARM_NEEDSSHROOM = "I need to put a mushroom on that.",
            MUSHROOMFARM_NEEDSLOG = "I need to use a new creepy-faced log on that.",
            MUSHROOMFARM_NOMOONALLOWED = "I guess these ones won't grow here.",
            SLOTFULL = "There's no room for that.",
            FOODFULL = "I should let it finish eating that first.",
            NOTDISH = "It won't like eating that.",
            DUPLICATE = "I know about that already.",
            NOTSCULPTABLE = "Even I can't make something out of that.",
            NOTATRIUMKEY = "It doesn't seem to fit.",
            CANTSHADOWREVIVE = "What am I doing wrong?",
            WRONGSHADOWFORM = "I don't think I assembled that correctly.",
            NOMOON = "It needs the moon to work.",
			PIGKINGGAME_MESSY = "I guess it is kinda messy around here...",
			PIGKINGGAME_DANGER = "It's too dangerous for games right now!",
			PIGKINGGAME_TOOLATE = "It's getting late, maybe tomorrow.",
        },
        GIVETOPLAYER =
        {
            FULL = "Bit of a hoarder, aren't you?",
            DEAD = "They won't need it where they're going.",
            SLEEPING = "Sshhh! I should let them sleep.",
            BUSY = "Hey, do you have a second?",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "Bit of a hoarder, aren't you?",
            DEAD = "They won't need it where they're going.",
            SLEEPING ="Sshhh! I should let them sleep.",
            BUSY = "Hey, do you have a second?",
        },
        WRITE =
        {
            GENERIC = "I shouldn't think too hard about it, or I'll be here all day.",
            INUSE = "Why don't you let me draw that? I am an artist after all.",
        },
        DRAW =
        {
            NOIMAGE = "I need to use some form of reference if I'm to draw.",
        },
        CHANGEIN =
        {
            GENERIC = "I'm dressed just fine.",
            BURNING = "I'd rather not...",
            INUSE = "I can wait, no rush.",
        },
        ATTUNE =
        {
            NOHEALTH = "I should seek a doctor before doing anything strenuous.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "Calm down, please!",
            INUSE = "Oh, was this one yours?",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "Calm down, please!",
			WAROLINE_DRAWING = "This fluffball doesn't need such equipment.",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "Oh, I've seen this before.",
            CANTLEARN = "I can't make heads or tails of it.",

            --MapRecorder/MapExplorer
            WRONGWORLD = "This map isn't for this place.",
			
			--MapSpotRevealer/messagebottle
			MESSAGEBOTTLEMANAGER_NOT_FOUND = "I can't read it in this darkness.",--Likely trying to read messagebottle treasure map in caves
        },
        WRAPBUNDLE =
        {
            EMPTY = "I need SOMETHING to wrap!",
        },
        PICKUP =
        {
			RESTRICTION = "I don't know how to use that.",
			INUSE = "Someone beat me to it.",
            NOTMINE_YOTC =
            {
                "Oh, that's not my Carrat.",
                "Oops, I think I've got the wrong Carrat.",
            },
        },
        SLAUGHTER =
        {
            TOOFAR = "I guess it's not fond of dying. Who is honestly?",
        },
        REPLATE =
        {
            MISMATCH = "That doesn't go with that!", 
            SAMEDISH = "I've already done that.", 
        },
        SAIL =
        {
        	REPAIR = "It's in perfect condition.",
        },
        ROW_FAIL =
        {
            BAD_TIMING0 = "Yech! I got splashed with water.",
            BAD_TIMING1 = "Woops! I'm not too good at rowing, am I?",
            BAD_TIMING2 = "Let's try that again.",
        },
        LOWER_SAIL_FAIL =
        {
            "How do you do this again??",
            "I got tangled up in the ropes!",
            "I'll get it soon enough...",
        },
        BATHBOMB =
        {
            GLASSED = "There no water to throw this in.",
            ALREADY_BOMBED = "One was enough.",
        },
		GIVE_TACKLESKETCH =
		{
			DUPLICATE = "I already know how to make that one.",
		},
		COMPARE_WEIGHABLE =
		{
            FISH_TOO_SMALL = "Aaaw, you're so tiny.",
            OVERSIZEDVEGGIES_TOO_SMALL = "It's light even for me.",
		},
        BEGIN_QUEST =
        {
            ONEGHOST = "only_used_by_wendy",
        },
		TELLSTORY = 
		{
			GENERIC = "only_used_by_walter",
			NOT_NIGHT = "only_used_by_walter",
			NO_FIRE = "only_used_by_walter",
		},
        SING_FAIL =
        {
            SAMESONG = "only_used_by_wathgrithr",
        },
        PLANTREGISTRY_RESEARCH_FAIL =
        {
            GENERIC = "An artist and now an experienced gardener!",
            FERTILIZER = "An artist and now a poop expert!",
        },
        FILL_OCEAN =
        {
            UNSUITABLE_FOR_PLANTS = "Even I know salt water can't be good for plants.",
        },
        POUR_WATER =
        {
            OUT_OF_WATER = "Out of water. I need to fill the watering can.",
        },
        POUR_WATER_GROUNDTILE =
        {
            OUT_OF_WATER = "I need to fill the watering can.",
        },
	},
	ACTIONFAIL_GENERIC = "Huh? What?",
	ANNOUNCE_BOAT_LEAK = "Oh no! My sketchbook is going to get wet!",
	ANNOUNCE_BOAT_SINK = "Abandon ship!",
	ANNOUNCE_DIG_DISEASE_WARNING = "It's looking better already.",
	ANNOUNCE_PICK_DISEASE_WARNING = "What's that stench?",
	ANNOUNCE_ADVENTUREFAIL = "Owie, do I have to try that again?...",
    ANNOUNCE_MOUNT_LOWHEALTH = "My beefalo isn't looking too well!",

    --waxwell and wickerbottom specific strings
    ANNOUNCE_TOOMANYBIRDS = "only_used_by_waxwell_and_wicker",
    ANNOUNCE_WAYTOOMANYBIRDS = "only_used_by_waxwell_and_wicker",

    --wolfgang specific
    ANNOUNCE_NORMALTOMIGHTY = "only_used_by_wolfang",
    ANNOUNCE_NORMALTOWIMPY = "only_used_by_wolfang",
    ANNOUNCE_WIMPYTONORMAL = "only_used_by_wolfang",
    ANNOUNCE_MIGHTYTONORMAL = "only_used_by_wolfang",

	ANNOUNCE_BEES = "BEES!",
	ANNOUNCE_BOOMERANG = "Ow! That really hurt!",
	ANNOUNCE_CHARLIE = "W-who's there? W-what do you want?!",
	ANNOUNCE_CHARLIE_ATTACK = "OWIE! SOMETHING BIT ME!",
	ANNOUNCE_CHARLIE_MISSED = "only_used_by_winona", --winona specific 
	ANNOUNCE_COLD = "Wish I had a hot cup of coffee right about now.",
	ANNOUNCE_HOT = "Goodness... this heat is out of control!",
	ANNOUNCE_CRAFTING_FAIL = "I'm missing a few things.",
	ANNOUNCE_DEERCLOPS = "Hopefully whatever's making those sounds is a pacifist.",	--"Whatever that was I just hope we can find an understanding through our love for artistry.", // "Sounds like my boss when the deadline is up.",
	ANNOUNCE_CAVEIN = "E-earthquake?!",
	ANNOUNCE_ANTLION_SINKHOLE = 
	{
		"The ground is shaking!",
		"I don't like the looks of this!",
		"What was the Earthquake Safety 101 again?!",
	},
	ANNOUNCE_ANTLION_TRIBUTE =
	{
        "Hope you like it.",
        "Yummy food for your tummy.",
        "Tasty, right?",
	},
	ANNOUNCE_SACREDCHEST_YES = "I guess I did something right?",
	ANNOUNCE_SACREDCHEST_NO = "I did something wrong, but what?",
    ANNOUNCE_DUSK = "How time flies when you're having fun.",
    
    --wx-78 specific
    ANNOUNCE_CHARGE = "only_used_by_wx78",
	ANNOUNCE_DISCHARGE = "only_used_by_wx78",

	ANNOUNCE_EAT =
	{
		GENERIC = "Mmmm!",
		PAINFUL = "Urk! Hope I don't have to taste this twice...",
		SPOILED = "Yech! I think something was growing on that.",
		STALE = "It was getting a bit hard to chew.",
		INVALID = "That can't be food!",
        YUCKY = "Eww! No!",
        
        --Warly specific ANNOUNCE_EAT strings
		COOKED = "only_used_by_warly",
		DRIED = "only_used_by_warly",
        PREPARED = "only_used_by_warly",
        RAW = "only_used_by_warly",
		SAME_OLD_1 = "only_used_by_warly",
		SAME_OLD_2 = "only_used_by_warly",
		SAME_OLD_3 = "only_used_by_warly",
		SAME_OLD_4 = "only_used_by_warly",
        SAME_OLD_5 = "only_used_by_warly",
		TASTY = "only_used_by_warly",
    },
    
    ANNOUNCE_ENCUMBERED =
    {
        "Pant... Huff...",
        "Can't we... just leave it here?...",
        "I... wish I could draw it lighter ...",
        "Huff...",
        "Why... am I... doing this again?...",
        "Ugh... I'm sweating so much...",
        "Hngh...!",
        "Pant... Pant...",
        "This... is the worst...",
    },
    ANNOUNCE_ATRIUM_DESTABILIZING = 
    {
		"Panic! PANIC!",
		"I don't want to stay here any longer!!",
		"Time for us to head outta here!",
	},
    ANNOUNCE_RUINS_RESET = "It feels like something changed...",
    ANNOUNCE_SNARED = "Wow! That almost skewered me!",
    ANNOUNCE_SNARED_IVY = "Who knew gardening was this dangerous?!",
    ANNOUNCE_REPELLED = "Hey, that's not fair!",
	ANNOUNCE_ENTER_DARK = "I'd like to get out of the darkness, please!",
	ANNOUNCE_ENTER_LIGHT = "Sweet light, never leave me again!",
	ANNOUNCE_FREEDOM = "I'm free!",
	ANNOUNCE_HIGHRESEARCH = "Smart, eh?",
	ANNOUNCE_HOUNDS = "Adowable little puppies incoming.",
	ANNOUNCE_WORMS = "Something's moving underground.",
	ANNOUNCE_HUNGRY = "I could really go for some food.",
	ANNOUNCE_HUNT_BEAST_NEARBY = "An adorable new friend is nearby, and an inspiration for a drawing maybe?",
	ANNOUNCE_HUNT_LOST_TRAIL = "Shoot! I lost the trail.",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "Shoot! This weather wasn't helping me.",
	ANNOUNCE_INV_FULL = "I should really start organizing my pockets better.",
	ANNOUNCE_KNOCKEDOUT = "What happened?...",
	ANNOUNCE_LOWRESEARCH = "That didn't help me much.",
	ANNOUNCE_MOSQUITOS = "Bugs begone!!",
    ANNOUNCE_NOWARDROBEONFIRE = "Not while it's on fire!",
    ANNOUNCE_NODANGERGIFT = "It's too dangerous for that right now!",
    ANNOUNCE_NOMOUNTEDGIFT = "I need to get down first.",
	ANNOUNCE_NODANGERSLEEP = "I'd rather not die in my sleep!",
	ANNOUNCE_NODAYSLEEP = "It's too early for sleep.",
	ANNOUNCE_NODAYSLEEP_CAVE = "I'm not tired at all.",
	ANNOUNCE_NOHUNGERSLEEP = "I need a midnight snack first.",
	ANNOUNCE_NOSLEEPONFIRE = "Umm... no.",
	ANNOUNCE_NODANGERSIESTA = "It's too dangerous for that right now!",
	ANNOUNCE_NONIGHTSIESTA = "It's too late for a siesta.",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "I don't think I could nap down here.",
	ANNOUNCE_NOHUNGERSIESTA = "I should eat something first.",
	ANNOUNCE_NODANGERAFK = "I can't run away now!",
	ANNOUNCE_NO_TRAP = "I got lucky!",
	ANNOUNCE_PECKED = "Owch! I am not your food!",
	ANNOUNCE_QUAKE = "An earthquake!!",
	ANNOUNCE_RESEARCH = "I'm learning more and more!",
	ANNOUNCE_SHELTER = "Phew, thank goodness for this shade.",
	ANNOUNCE_THORNS = "Owch! Thorns, I hate thorns!",
	ANNOUNCE_BURNT = "Gah! Hope I can still draw after that.",
	ANNOUNCE_TORCH_OUT = "There goes my light...",
	ANNOUNCE_THURIBLE_OUT = "It's out of fuel.",
	ANNOUNCE_FAN_OUT = "There geos my fan...",
    ANNOUNCE_COMPASS_OUT = "There goes my compass...",
	ANNOUNCE_TRAP_WENT_OFF = "Uh-oh, that can't be good.",
	ANNOUNCE_UNIMPLEMENTED = "Looks like a half-finished project.",
	ANNOUNCE_WORMHOLE = "I'd rather not talk about it...",
	ANNOUNCE_TOWNPORTALTELEPORT = "Wow! Teleportation!",
	ANNOUNCE_CANFIX = "\nDoesn't look too hard to fix.",
	ANNOUNCE_ACCOMPLISHMENT = "Success!",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "Success!",	
	ANNOUNCE_INSUFFICIENTFERTILIZER = "It needs more fertilizer.",
	ANNOUNCE_TOOL_SLIP = "Woah, that slipped right out of my hand!",
	ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "That was too close for comfort!",
	ANNOUNCE_TOADESCAPING = "It's trying to escape!",
	ANNOUNCE_TOADESCAPED = "Oh no, it escaped!",


	ANNOUNCE_DAMP = "I hope my sketchbook won't get ruined by this rain.",
	ANNOUNCE_WET = "It's raining heavily, huh?",
	ANNOUNCE_WETTER = "At this rate I'll catch a cold.",
	ANNOUNCE_SOAKED = "This can't get any worse...",

	ANNOUNCE_WASHED_ASHORE = "Well, thalassophobia is now on my list of fears.",

    ANNOUNCE_DESPAWN = "Am I going home??",
	ANNOUNCE_BECOMEGHOST = "oOooOooo!!",
	ANNOUNCE_GHOSTDRAIN = "My humanity is slipping away...",
	ANNOUNCE_PETRIFED_TREES = "Were those trees screaming?",
	ANNOUNCE_KLAUS_ENRAGE = "Time to run!!",
	ANNOUNCE_KLAUS_UNCHAINED = "It broke its chains!!",
	ANNOUNCE_KLAUS_CALLFORHELP = "Hey, don't bring over your friends!",

	ANNOUNCE_MOONALTAR_MINE =
	{
		GLASS_MED = "There's something stuck inside...",
		GLASS_LOW = "It's almost out!",
		GLASS_REVEAL = "What is that?",
		IDOL_MED = "There's something stuck inside...",
		IDOL_LOW = "It's almost out!",
		IDOL_REVEAL = "What is that?",
		SEED_MED = "There's something stuck inside...",
		SEED_LOW = "It's almost out!",
		SEED_REVEAL = "What is that?",
	},

    --hallowed nights
    ANNOUNCE_SPOOKED = "Gah! I hate jumpscares!",
	ANNOUNCE_BRAVERY_POTION = "I'd like to see those trees spook me now!",
	ANNOUNCE_MOONPOTION_FAILED = "Maybe it wasn't very effective?",

	--winter's feast
	ANNOUNCE_EATING_NOT_FEASTING = "I should share it with the others.",
	ANNOUNCE_WINTERS_FEAST_BUFF = "I'm feeling the holiday spirit!",
	ANNOUNCE_IS_FEASTING = "A Happy Winter's Feast to all!",
	ANNOUNCE_WINTERS_FEAST_BUFF_OVER = "I hate it when the holidays end...",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "I got you, don't worry!",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "There we go, you're looking good as new.",
    ANNOUNCE_REVIVED_FROM_CORPSE = "Thanks for that.",

    ANNOUNCE_FLARE_SEEN = "Who set that flare off?",
    ANNOUNCE_OCEAN_SILHOUETTE_INCOMING = "I hope that wasn't a Kraken...",

	--waroline specific
	ANNOUNCE_DRAWING_WET = "My art doesn't handle water too well...",
	ANNOUNCE_DRAWING_BURN = "Oh no! My precious art piece burned to ashes!",

    --willow specific
	ANNOUNCE_LIGHTFIRE =
	{
		"only_used_by_willow",
    },

    --winona specific
    ANNOUNCE_HUNGRY_SLOWBUILD = 
    {
	    "only_used_by_winona",
    },
    ANNOUNCE_HUNGRY_FASTBUILD = 
    {
	    "only_used_by_winona",
    },

    --wormwood specific
    ANNOUNCE_KILLEDPLANT = 
    {
        "only_used_by_wormwood",
    },
    ANNOUNCE_GROWPLANT = 
    {
        "only_used_by_wormwood",
    },
    ANNOUNCE_BLOOMING = 
    {
        "only_used_by_wormwood",
    },

    --wortox specfic
    ANNOUNCE_SOUL_EMPTY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_FEW =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_MANY =
    {
        "only_used_by_wortox",
    },
    ANNOUNCE_SOUL_OVERLOAD =
    {
        "only_used_by_wortox",
    },

    --walter specfic
	ANNOUNCE_SLINGHSOT_OUT_OF_AMMO =
	{
		"only_used_by_walter",
		"only_used_by_walter",
	},
	ANNOUNCE_STORYTELLING_ABORT_FIREWENTOUT =
	{
        "only_used_by_walter",
	},
	ANNOUNCE_STORYTELLING_ABORT_NOT_NIGHT =
	{
        "only_used_by_walter",
	},

    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "I should try a different recipe.",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "Oops, I forgot about that.",
    QUAGMIRE_ANNOUNCE_LOSE = "That can't be good news...",
    QUAGMIRE_ANNOUNCE_WIN = "Time to get out of this place!",

    ANNOUNCE_ROYALTY =
    {
        "Your majesty.",
        "Your highness.",
        "My liege!",
    },

    ANNOUNCE_ATTACH_BUFF_ELECTRICATTACK    = "It has a shocking aftertaste. Hahaha!",
    ANNOUNCE_ATTACH_BUFF_ATTACK            = "I'll give them the old one-two!",
    ANNOUNCE_ATTACH_BUFF_PLAYERABSORPTION  = "I feel tougher than a boulder!",
    ANNOUNCE_ATTACH_BUFF_WORKEFFECTIVENESS = "I feel so energized!",
    ANNOUNCE_ATTACH_BUFF_MOISTUREIMMUNITY  = "C'mon rain, give me your worst!",
    ANNOUNCE_ATTACH_BUFF_SLEEPRESISTANCE   = "Sleep is for the weak!",
    
    ANNOUNCE_DETACH_BUFF_ELECTRICATTACK    = "The taste of jello has left my mouth.",
    ANNOUNCE_DETACH_BUFF_ATTACK            = "Feels like my punches couldn't even put a hole through paper...",
    ANNOUNCE_DETACH_BUFF_PLAYERABSORPTION  = "I feel weaker than a pillow...",
    ANNOUNCE_DETACH_BUFF_WORKEFFECTIVENESS = "Oh god, am I working overtime again?...",
    ANNOUNCE_DETACH_BUFF_MOISTUREIMMUNITY  = "Ugh... I don't like this dampness.",
    ANNOUNCE_DETACH_BUFF_SLEEPRESISTANCE   = "Maybe... a little nap would be good... (YAWN!)",
    
	ANNOUNCE_OCEANFISHING_LINESNAP = "The line snapped!",
	ANNOUNCE_OCEANFISHING_LINETOOLOOSE = "I should reel it in!",
	ANNOUNCE_OCEANFISHING_GOTAWAY = "Darn it! It got away.",
	ANNOUNCE_OCEANFISHING_BADCAST = "I need to work on my casting...",
	ANNOUNCE_OCEANFISHING_IDLE_QUOTE = 
	{
		"I should find a better fishing spot.",
		"I guess the fish knew I was coming?",
		"So much for \"Plenty more fish in the sea.\"",
		"Nothing's biting...",
	},

	ANNOUNCE_WEIGHT = "Weight: {weight}",
	ANNOUNCE_WEIGHT_HEAVY  = "Weight: {weight}\nFishing is kinda fun.",

	-- these are just for testing for now, no need to write real strings yet
	ANNOUNCE_WINCH_CLAW_MISS = "That wasn't close enough.",
	ANNOUNCE_WINCH_CLAW_NO_ITEM = "It caught nothing.",

    --Wurt announce strings
    ANNOUNCE_KINGCREATED = "only_used_by_wurt",
    ANNOUNCE_KINGDESTROYED = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_THRONE = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_HOUSE = "only_used_by_wurt",
    ANNOUNCE_CANTBUILDHERE_WATCHTOWER = "only_used_by_wurt",
    ANNOUNCE_READ_BOOK = 
    {
        BOOK_SLEEP = "only_used_by_wurt",
        BOOK_BIRDS = "only_used_by_wurt",
        BOOK_TENTACLES =  "only_used_by_wurt",
        BOOK_BRIMSTONE = "only_used_by_wurt",
        BOOK_GARDENING = "only_used_by_wurt",
		BOOK_SILVICULTURE = "only_used_by_wurt",
		BOOK_HORTICULTURE = "only_used_by_wurt",
    },
    ANNOUNCE_WEAK_RAT = "This Carrat is not fit for the race.",

    ANNOUNCE_CARRAT_START_RACE = "Go, Carrats, go!",

    ANNOUNCE_CARRAT_ERROR_WRONG_WAY = {
        "You're going the wrong way!",
        "Go the other way!",
    },
    ANNOUNCE_CARRAT_ERROR_FELL_ASLEEP = "Is it sleeping??",    
    ANNOUNCE_CARRAT_ERROR_WALKING = "Run, run, run!",    
    ANNOUNCE_CARRAT_ERROR_STUNNED = "Get up and go!",

    ANNOUNCE_GHOST_QUEST = "only_used_by_wendy",
    ANNOUNCE_GHOST_HINT = "only_used_by_wendy",
    ANNOUNCE_GHOST_TOY_NEAR = {
        "only_used_by_wendy",
    },
	ANNOUNCE_SISTURN_FULL = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_DEATH = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_RETRIEVE = "only_used_by_wendy",
	ANNOUNCE_ABIGAIL_LOW_HEALTH = "only_used_by_wendy",
    ANNOUNCE_ABIGAIL_SUMMON = 
	{
		LEVEL1 = "only_used_by_wendy",
		LEVEL2 = "only_used_by_wendy",
		LEVEL3 = "only_used_by_wendy",
	},

    ANNOUNCE_GHOSTLYBOND_LEVELUP = 
	{
		LEVEL2 = "only_used_by_wendy",
		LEVEL3 = "only_used_by_wendy",
	},

    ANNOUNCE_NOINSPIRATION = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_TAUNT_BUFF = "only_used_by_wathgrithr",
    ANNOUNCE_BATTLESONG_INSTANT_PANIC_BUFF = "only_used_by_wathgrithr",

    ANNOUNCE_ARCHIVE_NEW_KNOWLEDGE = "I'm getting brand new ideas!",
    ANNOUNCE_ARCHIVE_OLD_KNOWLEDGE = "Meh. Nothing interesting.",
    ANNOUNCE_ARCHIVE_NO_POWER = "Now where's the plug for this place?",

    ANNOUNCE_PLANT_RESEARCHED =
    {
        "I'm learning more and more about agriculture.",
    },

    ANNOUNCE_PLANT_RANDOMSEED = "One way to find out what this will grow into.",

    ANNOUNCE_FERTILIZER_RESEARCHED = "It's plant food, also known as poop.",

	ANNOUNCE_FIRENETTLE_TOXIN = 
	{
		"My mouth is burning!",
		"That's burning hot!",
	},
	ANNOUNCE_FIRENETTLE_TOXIN_DONE = "Let's never do that again, please.",

	ANNOUNCE_TALK_TO_PLANTS = 
	{
        "You can do it, little plant!",
        "Grow up big and delicious!",
		"Do you like art, plant?",
        "If you grow up big, I will draw a sketch of you.",
        "So, what's new with you?",
	},

	BATTLECRY =
	{
		GENERIC = "You asked for it!",
		PIG = "You're on my menu, pig!",
		PREY = "Sorry, my hunger is forcing me to do this!",
		SPIDER = "Hey, I'm not for eating!",
		SPIDER_WARRIOR = "You're not so tough!",
		DEER = "Sorry about this!",
	},
	COMBAT_QUIT =
	{
		GENERIC = "Yeah, you better run.",
		PIG = "Don't come back!",
		PREY = "Phew! He's a fast little guy.",
		SPIDER = "I didn't want to kill you anyways.",
		SPIDER_WARRIOR = "I didn't want to kill you anyways.",
	},

	DESCRIBE =
	{
		MULTIPLAYER_PORTAL = "It has an attractive, yet deteriorating look to it. I love it!",
        MULTIPLAYER_PORTAL_MOONROCK = "Looks otherworldly. Kinda creepy, but cool.",
        MOONROCKIDOL = "I like the unique lunar look it's going for.",
        CONSTRUCTION_PLANS = "Looks like a portal of some sort?",

        ANTLION =
        {
            GENERIC = "You look a bit hungry.",
            VERYHAPPY = "Who can hate that adowable widdle face?",
            UNHAPPY = "You look VERY hungry.",
        },
        ANTLIONTRINKET = "Who would throw this in a pond?",
        SANDSPIKE = "Spiky!",
        SANDBLOCK = "Blocky!",
        GLASSSPIKE = "I almost got skewered by it.",
        GLASSBLOCK = "Hah, that didn't turn out half-bad.",
        ABIGAIL_FLOWER =
        {
            GENERIC ="What type of flower is that?",
			LEVEL1 = "Is it just me, or does it look different?",
			LEVEL2 = "I'm certain now that it's changing!",
			LEVEL3 = "I should let Wendy handle it, otherwise I might break it.",

			-- deprecated
            LONG = "It hurts my soul to look at that thing.",
            MEDIUM = "It's giving me the creeps.",
            SOON = "Something is up with that flower!",
            HAUNTED_POCKET = "I don't think I should hang on to this.",
            HAUNTED_GROUND = "I'd die to find out what it does.",
        },

        BALLOONS_EMPTY = "Take it from me: you never mess with a mime's balloons.",
        BALLOON = "Are your lungs filled with helium, Wes?",

        BERNIE_INACTIVE =
        {
            BROKEN = "It looks worse than usual.",
            GENERIC = "He's been through hell and back.",
        },

        BERNIE_ACTIVE = "Look at its adorable little dance. Aaaw!",
        BERNIE_BIG = "Have you been working out, Bernie?",

        BOOK_BIRDS = "I know a few of these birds.",
        BOOK_TENTACLES = "A whole book dedicated to tentacles.",
        BOOK_GARDENING = "It's about plants. I'd say it's interesting if that were true.",
		BOOK_SILVICULTURE = "It's more books about gardening, this is getting tiresome.",
		BOOK_HORTICULTURE = "Plants, plants and... Oh, even more plants!",
        BOOK_SLEEP = "A real snoozefest.",
        BOOK_BRIMSTONE = "It gets real interesting in the end.",

        PLAYER =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll put an end to your murderous ways, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
		DEFAULT =
        {
            GENERIC = "Hello, %s, how've you been?",
            ATTACKER = "What's up with you, %s?",
            MURDERER = "I never expected you of all people to resort to murder, %s!",
            REVIVER = "Thanks, %s, for all the help.",
            GHOST = "Don't worry, %s. I'll find you a heart.",
            FIRESTARTER = "Hey, %s, do you smell smoke?",
        },
        WILSON =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "Science won't help you now, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WOLFGANG =
        {
            GENERIC = "Looking strong, big guy.",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I know I stand no chance to your strength, but I'm willing to try!",
            REVIVER = "See, %s? Ghosts aren't that scary.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WAXWELL =
        {
            GENERIC = "You're a real sharp dresser, %s.",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I guess the others were right, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WX78 =
        {
            GENERIC = "Plotting your next scheme to take over humanity, %s?",
            ATTACKER = "%s is acting stranger than usual...",
            MURDERER = "Killer robot on the loose!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WILLOW =
        {
            GENERIC = "Hi there, %s. Please don't burn anymore of my sketches.",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll douse for flaming desire for murder, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Did you burn something again, %s?",
        },
        WENDY =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll put an end to your murderous ways, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WOODIE =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll put an end to your murderous ways, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            BEAVER = "You doing okay, %s?",
            BEAVERGHOST = "%s wants to return to the land of the living.",
            MOOSE = "You doing okay, %s?",
            MOOSEGHOST = "%s wants to return to the land of the living.",
            GOOSE = "You doing okay, %s?",
            GOOSEGHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WICKERBOTTOM =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "This blood-soaked chapter of your life ends here, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WES =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting stranger than usual...",
            MURDERER = "You can't mime your way out of murder, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WEBBER =
        {
            GENERIC = "It's spiderboy, %s.",
            ATTACKER = "%s is acting strange...",
            MURDERER = "Once a spider, always a spider!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WATHGRITHR =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "The warrior turned berserk!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WINONA =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll put an end to your murderous ways, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WORTOX =
        {
            GENERIC = "How's the life of an imp feel, %s?",
            ATTACKER = "%s is acting stranger than usual...",
            MURDERER = "You ain't eating my soul, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WORMWOOD =
        {
            GENERIC = "It's plantboy, %s.",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll snap you in half, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },
        WARLY =
        {
            GENERIC = "What's cooking, doc?",
            ATTACKER = "%s is acting strange...",
            MURDERER = "Your days of being a butcher are at an end, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },

        WURT =
        {
            GENERIC = "How're you doing, %s?",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll put an end to your murderous ways, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },

        WALTER =
        {
            GENERIC = "Hi there, %s!",
            ATTACKER = "%s is acting strange...",
            MURDERER = "I'll put an end to your murderous ways, %s!",
            REVIVER = "%s knows how to handle ghosts.",
            GHOST = "%s wants to return to the land of the living.",
            FIRESTARTER = "Do you smell smoke, %s?",
        },

        MIGRATION_PORTAL =
        {
            GENERIC = "It'll take me to my friends.",
            OPEN = "Watch out, I'm coming in!",
            FULL = "Darn, there's no room for me.",
        },
        GLOMMER = 
        {
            GENERIC = "You're kinda cute, I'd like to draw you.",
            SLEEPING = "It even sleeps adorably.",
        },
        GLOMMERFLOWER =
        {
            GENERIC = "That's a big flower.",
            DEAD = "It's not looking too well.",
        },
        GLOMMERWINGS = "How'd these tiny little wings keep him afloat?",
        GLOMMERFUEL = "It's pink, but smells like poop.",
        BELL = "Ring ring ring!",
        STATUEGLOMMER =
        {
            GENERIC = "Not bad, not bad.",
            EMPTY = "Who'd ruin such artistry?!",
        },

        LAVA_POND_ROCK = "I ain't touching that rock, it must be burning hot.",

		WEBBERSKULL = "He's got a thick skull.",
		WORMLIGHT = "It looks berry tasty. Hahaha!",
		WORMLIGHT_LESSER = "It's a bit shrivelled.",
		WORM =
		{
		    PLANT = "That looks interesting.",
		    DIRT = "Did that pile of dirt just move?",
		    WORM = "Yikes!",
		},
        WORMLIGHT_PLANT = "That looks interesting.",
		MOLE =
		{
			HELD = "You're coming with me.",
			UNDERGROUND = "I should let him do his thing.",
			ABOVEGROUND = "Found anything good yet?",
		},
		MOLEHILL = "That's a hole for a mole.",
		MOLEHAT = "Woah, this is great!",

		EEL = "Eel cook it first. Hahaha!",
		EEL_COOKED = "Smells good!",
		UNAGI = "I do love seafood.",
		EYETURRET = "Stop staring, it's rude!",
		EYETURRET_ITEM = "It fits my pocket, somehow.",
		MINOTAURHORN = "Got your nose!",
		MINOTAURCHEST = "Look at the adornments on that chest!",
		THULECITE_PIECES = "Even broken they are so stunning!",
		POND_ALGAE = "Yep, that's just algae.",
		GREENSTAFF = "A sparkly gem strapped with a stick, how original.",
		GIFT = "I could never say no to a beautifully wrapped gift.",
        GIFTWRAP = "I should gift something nice to <default>.",
		POTTEDFERN = "Plants look better in a pot than in the dirt.",
        SUCCULENT_POTTED = "Plants look better in a pot than in the dirt.",
		SUCCULENT_PLANT = "This lake looks real nice with all these succulents around.",
		SUCCULENT_PICKED = "I should plant it in a pot before it spoils.",
		SENTRYWARD = "Keeps an eye on our base.",
        TOWNPORTAL =
        {
			GENERIC = "I have no idea how that stone is balanced on top.",
			ACTIVE = "Magic is so useful!",
		},
        TOWNPORTALTALISMAN = 
        {
			GENERIC = "Looks like there's a gem inside.",
			ACTIVE = "I feel the urge to... touch it.",
		},
        WETPAPER = "At this pace it'll never dry.",
        WETPOUCH = "Ugh, what a waste of perfectly good paper!",
        MOONROCK_PIECES = "What happened here?",
        MOONBASE =
        {
            GENERIC = "Looks like something goes in the middle there.",
            BROKEN = "Looks broken, maybe I can fix it.",
            STAFFED = "Do I just wait?...",
            WRONGSTAFF = "It fits, but it doesn't look right.",
            MOONSTAFF = "It's getting kinda chilly around here.",
        },
        MOONDIAL = 
        {
			GENERIC = "It work... I don't know how.",
			NIGHT_NEW = "It's a new moon.",
			NIGHT_WAX = "The moon is waxing.",
			NIGHT_FULL = "It's a full moon.",
			NIGHT_WANE = "The moon is waning.",
			CAVE = "I don't think it'll work underground.",
			WEREBEAVER = "only_used_by_woodie", --woodie specific
        },
		THULECITE = "The color, the texture, the design is all so beautiful!",
		ARMORRUINS = "So pretty, I almost feel bad using it.",
		ARMORSKELETON = "Well, they're bones. That's about all I can say.",	--"I'm not an osteologist.",
		SKELETONHAT = "Wearing it gives me a headache.",
		RUINS_BAT = "This looks far more dangerous than a spear.",
		RUINSHAT = "Headgear appropriate for all occasions.",
		NIGHTMARE_TIMEPIECE =
		{
            CALM = "It's safe for now.",
            WARN = "It's getting a bit crazy around here.",
            WAXING = "I shouldn't stay here for long!",
            STEADY = "The magic flow is keeping steady.",
            WANING = "It's calming down a bit...",
            DAWN = "Just a little longer, the magic is almost gone.",
            NOMAGIC = "No dangerous magic here.",
		},
		BISHOP_NIGHTMARE = "In dire need of maintenance.",
		ROOK_NIGHTMARE = "How long has this been down here?",
		KNIGHT_NIGHTMARE = "I have no idea how it's still up and running.",
		MINOTAUR = "That thing is liable to run me over!",
		SPIDER_DROPPER = "White really isn't your color.",
		NIGHTMARELIGHT = "I don't know what it does, but I like the design.",
		NIGHTSTICK = "Better than a torch!",
		GREENGEM = "A sparkly green gem.",
		MULTITOOL_AXE_PICKAXE = "An axe and a pickaxe, that's so smart!",
		ORANGESTAFF = "Good, I can just teleport wherever I want now.",
		YELLOWAMULET = "It glows in the dark.",
		GREENAMULET = "Less materials, more efficiency.",
		SLURPERPELT = "It's kinda soft, like a pillow.",	

		SLURPER = "It's looking at me like I'm lunch.",
		SLURPER_PELT = "It's kinda soft, like a pillow.",	
		ARMORSLURPER = "Does this count as fashionable attire?",
		ORANGEAMULET = "No need to worry about dropping my pencils now!",
		YELLOWSTAFF = "Yet another gem stuck on a stick. I'm starting to see a pattern.",
		YELLOWGEM = "Yellow there, gem. Hahaha!",
		ORANGEGEM = "An orange gem. At least it's not a banana gem! Hahaha!",
        OPALSTAFF = "The moon turned the gem white!",
        OPALPRECIOUSGEM = "It feels important.",
        TELEBASE = 
		{
			VALID = "Seems to be working just fine.",
			GEMS = "I need to gather more purple gems.",
		},
		GEMSOCKET = 
		{
			VALID = "It's ready.",
			GEMS = "Needs a purple gem.",
		},
		STAFFLIGHT = "It's so soothing to look...",
        STAFFCOLDLIGHT = "Brr! It's getting colder than a freezer.",

        ANCIENT_ALTAR = "This looks so cool!",

        ANCIENT_ALTAR_BROKEN = "Aw, this one is broken.",

        ANCIENT_STATUE = "I would draw a few copies of this statue, but it's kinda unnerving to look at...",

        LICHEN = "It's like normal lichen, but they're in caves.",
		CUTLICHEN = "It tastes weird, I don't lichen it. Hahaha!",

		CAVE_BANANA = "It's a bunch o' bananas.",
		CAVE_BANANA_COOKED = "Not bad.",
		CAVE_BANANA_TREE = "I'd like a banana or two.",
		ROCKY = "Can you stand still so I can sketch you, please?",
		
		COMPASS =
		{
			GENERIC="Now I won't get lost.",
			N = "North.",
			S = "South.",
			E = "East.",
			W = "West.",
			NE = "Northeast.",
			SE = "Southeast.",
			NW = "Northwest.",
			SW = "Southwest.",
		},

        HOUNDSTOOTH = "They almost tore me to shreds!",
        ARMORSNURTLESHELL = "Great, now my clothes are covered in slime.",
        BAT = "I'll batter the bats with a bat!",
        BATBAT = "Lots of bat puns come to mind, bat I'll spare you.",
        BATWING = "What should I cook with these? I'll just wing it.",
        BATWING_COOKED = "How different can it be from chicken wings?",
        BATCAVE = "Only a bat could live in a place like that.",	--"I bat-ter not wake them up.",
        BEDROLL_FURRY = "So fluffy, like a giant pillow stuffed with bunnies.",
        BUNNYMAN = "I know this may be a bit forward, but can I pet you?",
        FLOWER_CAVE = "As long as I'm not in the dark, I won't complain.",
        GUANO = "Aha! This time it's bird poop.",
        LANTERN = "Not a safety hazard, like the torch.",
        LIGHTBULB = "It's soft and kinda edible.",
        MANRABBIT_TAIL = "This would look great as a keychain.",
        MUSHROOMHAT = "There's a first time for everything, right?",
        MUSHROOM_LIGHT2 =
        {
            ON = "A unique look for a lamp.",
            OFF = "Could use a few lightbulbs.",
            BURNT = "Hopefully we can salvage something from it.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "A unique look for a lamp.",
            OFF = "Could use a few lightbulbs.",
            BURNT = "Hopefully we can salvage something from it.",
        },
        SLEEPBOMB = "This'll come in handy.",
        MUSHROOMBOMB = "It's gonna blow!",
        SHROOM_SKIN = "That's a big piece of toadstool skin.",
        TOADSTOOL_CAP =
        {
            EMPTY = "I wonder how deep it goes?",
            INGROUND = "Something's is coming out of that hole!",
            GENERIC = "Look at the size of that mushroom! It'd make a nice sketch.",
        },
        TOADSTOOL =
        {
            GENERIC = "I don't have I have a chance against that!",
            RAGE = "Now he's really angry!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "I should chop that down, quickly!",
            BURNT = "Crispy.",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "Look at the size of that one!",
            BLOOM = "Ugh, it's starting to smell funny.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "That'd make a hearty mushroom stew.",
            BLOOM = "Ugh, it's starting to smell funny.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "Feels like something out of a fantasy book.",
            BLOOM = "Ugh, it's starting to smell funny.",
        },
        MUSHTREE_TALL_WEBBED = "It's under those spider's jurisdiction.",
        SPORE_TALL =
        {
            GENERIC = "Keep glowing my path for me.",
            HELD = "Wanna come with me?",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "Thanks for the light, little guy.",
            HELD = "Wanna come with me?",
        },
        SPORE_SMALL =
        {
            GENERIC = "I'd take any light source in this dreary place.",
            HELD = "Wanna come with me?",
        },
        RABBITHOUSE =
        {
            GENERIC = "Hey, that carrot's made of boards.",
            BURNT = "Cooked carrot house.",
        },
        SLURTLE = "He's after my rocks!",
        SLURTLE_SHELLPIECES = "There's no fixing that shell.",
        SLURTLEHAT = "Just a little bit slimy.",
        SLURTLEHOLE = "A nice place, but I wouldn't want to live here.",
        SLURTLESLIME = "Because you never know when you might need a handful of slime.",
        SNURTLE = "I feel bad hurting this poor little guy.",
        SPIDER_HIDER = "Stop hiding, you coward!",
        SPIDER_SPITTER = "This one is particularly annoying!",
        SPIDERHOLE = "I don't wanna disturb their sleep.",
        SPIDERHOLE_ROCK = "I don't wanna disturb their sleep.",
        STALAGMITE = "Cave rocks.",
        STALAGMITE_TALL = "Even more cave rocks.",

        TURF_CARPETFLOOR = "Comfy, I like it.",
        TURF_CHECKERFLOOR = "Real fancy.",
        TURF_DIRT = "Turf for the ground.",
        TURF_FOREST = "Turf for the ground.",
        TURF_GRASS = "Turf for the ground.",
        TURF_MARSH = "Turf for the ground.",
        TURF_METEOR = "Moon turf, nice change of pace.",
        TURF_PEBBLEBEACH = "Moon turf, nice change of pace.",
        TURF_ROAD = "Paving a road to somewhere.",
        TURF_ROCKY = "Turf for the ground.",
        TURF_SAVANNA = "Turf for the ground.",
        TURF_WOODFLOOR = "Wooden floorboards.",

		TURF_CAVE="Turf for the ground.",
		TURF_FUNGUS="Turf for the ground.",
		TURF_FUNGUS_MOON = "Turf for the ground.",
		TURF_ARCHIVE = "Turf for the ground.",
		TURF_SINKHOLE="Turf for the ground.",
		TURF_UNDERROCK="Turf for the ground.",
		TURF_MUD="Turf for the ground.",

		TURF_DECIDUOUS = "Turf for the ground.",
		TURF_SANDY = "Turf for the ground.",
		TURF_BADLANDS = "Turf for the ground.",
		TURF_DESERTDIRT = "Turf for the ground.",
		TURF_FUNGUS_GREEN = "Turf for the ground.",
		TURF_FUNGUS_RED = "Turf for the ground.",
		TURF_DRAGONFLY = "Fireproof, supposedly.",

		POWCAKE = "I refuse to count this as \"cake.\"",
        CAVE_ENTRANCE = "Somebody did a bad job covering that up.",
        CAVE_ENTRANCE_RUINS = "This looks incredibly important.",
       
       	CAVE_ENTRANCE_OPEN = 
        {
            GENERIC = "It's blocking my way down.",
            OPEN = "That was far too easy to open.",
            FULL = "I guess they're not accepting any visitors.",
        },
        CAVE_EXIT = 
        {
            GENERIC = "These vines are blocking my way out of here!",
            OPEN = "Up, up and away?",
            FULL = "I guess it's too full up there for another person.",
        },

		MAXWELLPHONOGRAPH = "Not my jam.",
		BOOMERANG = "Hopefully it doesn't smack my face on its way back.",
		PIGGUARD = "He doesn't like me getting close.",
		ABIGAIL =
		{
            LEVEL1 =
            {
                "You must be Abigail. Hello.",
                "You must be Abigail. Hello.",
            },
            LEVEL2 = 
            {
                "You must be Abigail. Hello.",
                "You must be Abigail. Hello.",
            },
            LEVEL3 = 
            {
                "You must be Abigail. Hello.",
                "You must be Abigail. Hello.",
            },
		},
		ADVENTURE_PORTAL = "Where does this lead to?",
		AMULET = "I ain't dying today!",
		ANIMAL_TRACK = "Animal tracks, hopefully not something that's gonna eat me.",
		ARMORGRASS = "A scratchy grass suit.",
		ARMORMARBLE = "It weighs like a boulder!",
		ARMORWOOD = "This'll be good enough.",
		ARMOR_SANITY = "I have to be insane to wear that.",
		ASH =
		{
			GENERIC = "I don't think this ash would be great for drawing.",
			REMAINS_GLOMMERFLOWER = "I don't think this ash would be great for drawing.",
			REMAINS_EYE_BONE = "I don't think this ash would be great for drawing.",
			REMAINS_THINGIE = "I don't think this ash would be great for drawing.",
		},
		AXE = "Works as a chopping implement and a potential weapon.",
		BABYBEEFALO = 
		{
			GENERIC = "You're so cute, I want to draw you!",
		    SLEEPING = "I can take my time drawing it now that it's not moving so much.",
        },
        BUNDLE = "My drawing tools are in there. I think?",
        BUNDLEWRAP = "I could really use some more space for all my sketchbooks.",
		BACKPACK = "Good, I was running out of space in my pockets.",
		BACONEGGS = "A great breakfast.",
		BANDAGE = "Is putting honey on my open wounds a good idea?",
		BASALT = "There's no breaking through that.",
		BEARDHAIR = "Why am I carrying this again?",
		BEARGER = "You sure love honey, huh?",
		BEARGERVEST = "This is a great coat.",
		ICEPACK = "Keeps my food fresh while exploring.",
		BEARGER_FUR = "This'd make a great blanket.",
		BEDROLL_STRAW = "I hope there are no bugs in this.",
		BEEQUEEN = "Looks like another Pokemon rip-off to me.",	--"Mother of all bees!",
		BEEQUEENHIVE = 
		{
			GENERIC = "Covered with honey.",
			GROWING = "Did that grow bigger?",
		},
        BEEQUEENHIVEGROWN = "A mother lode of honey!",
        BEEGUARD = "That stinger is looking mighty sharp!",
        HIVEHAT = "It feels weird to wear that.",
        MINISIGN =
        {
            GENERIC = "Heh! That was easy.",
            UNDRAWN = "Oooh, what should I draw??",
        },
        MINISIGN_ITEM = "I need to place it down first.",
		BEE =
		{
			GENERIC = "Keep up the good work, bee.",
			HELD = "It's not trying to sting me, I take that as a blessing.",
		},
		BEEBOX =
		{
			READY = "It's packed with honey.",
			FULLHONEY = "It's packed with honey.",
			GENERIC = "My own honey-makers.",
			NOHONEY = "I'll have to wait if I want more honey.",
			SOMEHONEY = "That's not a lot.",
			BURNT = "No! Not the honey!",
		},
		MUSHROOM_FARM =
		{
			STUFFED = "It's packed with mushrooms.",
			LOTS = "It's packed with mushrooms.",
			SOME = "I'll have to wait if I want more mushrooms.",
			EMPTY = "I need to get a mushroom for that.",
			ROTTEN = "I need to replace the log with another one.",
			BURNT = "Mushroom flambe.",
			SNOWCOVERED = "It won't grow anything with this snow.",
		},
		BEEFALO =
		{
			FOLLOWER = "He's following me.",
			GENERIC = "You're a cute animal. I'd like to draw you.",
			NAKED = "Sorry about that.",
			SLEEPING = "They're even cuter when they sleep.",
            --Domesticated states:
            DOMESTICATED = "I got my own little beefalo pet now.",
            ORNERY = "Maybe I showed him a bit too much tough love?",
            RIDER = "He loves walks!",
            PUDGY = "Maybe I overfed him a little bit.",
		},

		BEEFALOHAT = "All that wool came in good use.",
		BEEFALOWOOL = "Soft and warm.",
		BEEHAT = "I'll be safe from those bees's stingers now.",
        BEESWAX = "Honey-scented wax.",
		BEEHIVE = "A natural honey-making station.",
		BEEMINE = "I'd like to be far away when this thing goes off.",
		BEEMINE_MAXWELL = "I guess he doesn't like visitors.",
		BERRIES = "They'd make for good red paint.",
		BERRIES_COOKED = "They're even tastier cooked.",
        BERRIES_JUICY = "If used properly one could make light pink paint.",
        BERRIES_JUICY_COOKED = "Hmm... color purpureus, I think.",
		BERRYBUSH =
		{
			BARREN = "I have to fertilize it first.",
			WITHERED = "Hopefully the weather will get cooler soon.",
			GENERIC = "Time for berry-picking.",
			PICKED = "I'll be back for more berries, bush.",
			DISEASED = "Its condition has worsened.",
			DISEASING = "It doesn't look very well...",
			BURNING = "Fire, it's on fire!",
		},
		BERRYBUSH_JUICY =
		{
			BARREN = "I have to fertilize it first.",
			WITHERED = "Hopefully the weather will get cooler soon.",
			GENERIC = "Giving it a good push should drop those berries.",
			PICKED = "I'll be back for more berries, bush.",
			DISEASED = "Its condition has worsened.",
			DISEASING = "It doesn't look very well...",
			BURNING = "Fire, it's on fire!",
		},
		BIGFOOT = "Wow...",
		BIRDCAGE =
		{
			GENERIC = "I feel bad trapping a bird.",
			OCCUPIED = "Birds are so beautiful.",
			SLEEPING = "I should let him rest.",
			HUNGRY = "Oh, I should really feed you.",
			STARVING = "Oh! How could I forget to feed you!",
			DEAD = "Oh no! I completely forgot!",
			SKELETON = "Oh... no...",
		},
		BIRDTRAP = "Hopefully their wings won't get injured in the netting.",
		CAVE_BANANA_BURNT = "No more bananas from that tree.",
		BIRD_EGG = "Thanks for the eggs, bird.",
		BIRD_EGG_COOKED = "Breakfast!",
		BISHOP = "Look at its cool design!",
		BLOWDART_FIRE = "That's a forest fire just waiting to happen.",
		BLOWDART_SLEEP = "Night-night time.",
		BLOWDART_PIPE = "At least I don't have to get close to the monsters.",
		BLOWDART_YELLOW = "Zzzzzzap!",
		BLUEAMULET = "Blue looks good on me.",
		BLUEGEM = "My favorite gem.",
		BLUEPRINT = 
		{ 
            COMMON = "I could probably build that.",
            RARE = "Look at the unique adornments on this one!",
        },
        SKETCH = "It's an okay sketch, I could've made it better.",
		BLUE_CAP = "If it's blue, it means it's good. Right?",
		BLUE_CAP_COOKED = "Smells different.",
		BLUE_MUSHROOM =
		{
			GENERIC = "This one is blue.",
			INGROUND = "It's gone into hiding.",
			PICKED = "It should grow back.",
		},
		BOARDS = "Maybe I can craft myself a new easel?",
		BONESHARD = "Broken bone pieces.",
		BONESTEW = "A hearty meal!",
		BUGNET = "Catching the butterflies will be much easier for me to draw them!",
		BUSHHAT = "Bush camouflage, for observing nature undetected.",
		BUTTER = "It's... actually real butter!",
		BUTTERFLY =
		{
			GENERIC = "Hold still so I can draw you!",
			HELD = "Haha! Now I've got you.",
		},
		BUTTERFLYMUFFIN = "I'm more of a cupcake gal, but this muffin is okay.",
		BUTTERFLYWINGS = "I meant to catch you, not rip your wings off! Sorry!",
		BUZZARD = "I don't like the way it's looking at me.",

		SHADOWDIGGER = "Dig, dig, dig!",

		CACTUS = 
		{
			GENERIC = "You think those thorns are gonna stop me? You're right.",
			PICKED = "It still hurts.",
		},
		CACTUS_MEAT_COOKED = "Still juicy.",
		CACTUS_MEAT = "I'd better remove those thorns first before eating it.",
		CACTUS_FLOWER = "A beautiful color for a cactus flower.",

		COLDFIRE =
		{
			EMBERS = "It needs fuel quickly!",
			GENERIC = "Nice and cold.",
			HIGH = "Yikes! At this rate it'll spread!",
			LOW = "It's getting low, maybe I should throw a few logs.",
			NORMAL = "Nice and cold.",
			OUT = "No saving that fire.",
		},
		CAMPFIRE =
		{
			EMBERS = "That fire needs more fuel or it's going to go out.",
			GENERIC = "Nice and warm.",
			HIGH = "Yikes! At this rate it'll spread!",
			LOW = "It's getting low, maybe I should throw a few logs.",
			NORMAL = "Nice and warm.",
			OUT = "No saving that fire.",
		},
		CANE = "I take offence to your suggestion that I need a cane to walk properly.",
		CATCOON = "What strange color patterns. Stand still while I draw you.",
		CATCOONDEN = 
		{
			GENERIC = "Where'd it find that ball of yarn?",
			EMPTY = "I guess it decided to move?",
		},
		CATCOONHAT = "The design is quite nice.",
		COONTAIL = "I think pulling its tail off was a bit excessive.",
		CARROT = "Just a plain old carrot.",
		CARROT_COOKED = "Cooked little carrot slices.",
		CARROT_PLANTED = "Free carrots!",
		CARROT_SEEDS = "Seeds of... some kind.",
		CARTOGRAPHYDESK =
		{
			GENERIC = "Pssh! How hard can cartography be?",	--"Now this is my field of expertise!",
			BURNING = "Fire, it's on fire!",
			BURNT = "Great...",
		},
		WATERMELON_SEEDS = "Seeds of... some kind.",
		CAVE_FERN = "A cave fern, at first look the coloration is royal purple.",
		CHARCOAL = "It could be made into a charcoal pencil.",
        CHESSPIECE_PAWN = "The design is plain, but pretty.",
        CHESSPIECE_ROOK =
        {
            GENERIC = "Not a bad sculpture, if I do say so myself.",
            STRUGGLE = "T-they're moving!!",
        },
        CHESSPIECE_KNIGHT =
        {
            GENERIC = "Sculpting isn't that hard.",
            STRUGGLE = "T-they're moving!!",
        },
        CHESSPIECE_BISHOP =
        {
            GENERIC = "That turned out very nice.",
            STRUGGLE = "T-they're moving!!",
        },
        CHESSPIECE_MUSE = "Gives off a rather sinister but noble feeling.",
        CHESSPIECE_FORMAL = "He's the king, but he looks defeated",
        CHESSPIECE_HORNUCOPIA = "It's making me kinda hungry...",
        CHESSPIECE_PIPE = "Not a fan of smokes.",
        CHESSPIECE_DEERCLOPS = "Creepy...",
        CHESSPIECE_BEARGER = "I'd appreciate the statue's beauty more if it only didn't bring back frightful memories.",
        CHESSPIECE_MOOSEGOOSE =
        {
            "Looks a bit silly.",
        },
        CHESSPIECE_DRAGONFLY = "Memories I wish I could forget.",
		CHESSPIECE_MINOTAUR = "I'm glad I survived that encounter.",
        CHESSPIECE_BUTTERFLY = "Beautiful!",
        CHESSPIECE_ANCHOR = "To commemorate our first sailing expedition.",
        CHESSPIECE_MOON = "Not as beautiful as the real moon.",
        CHESSPIECE_CARRAT = "For the winner of the Carrat Races.",
        CHESSPIECE_MALBATROSS = "Looks a bit silly.",
        CHESSPIECE_CRABKING = "Not a bad job.",
        CHESSPIECE_TOADSTOOL = "It turned out very nice.",
        CHESSPIECE_STALKER = "Creepy...",
        CHESSPIECE_KLAUS = "Thanks for all those presents.",
        CHESSPIECE_BEEQUEEN = "A very nice statue.",
        CHESSPIECE_ANTLION = "I'll miss him...",
        CHESSJUNK1 = "I'm not great at mechanisms and stuff.",
        CHESSJUNK2 = "Bunch of loose wires and gears.",
        CHESSJUNK3 = "Cogs, loose wires... marbles? There's a lot of junk here.",
		CHESTER = "My own little adorable pencil carrier.",
		CHESTER_EYEBONE =
		{
			GENERIC = "Can you stop staring? You're making me blush.",
			WAITING = "It's getting some shut-eye.",
		},
		COOKEDMANDRAKE = "I can still hear his screams...",
		COOKEDMEAT = "I can't wait till dinnertime!",
		COOKEDMONSTERMEAT = "It's edible, I think?",
		COOKEDSMALLMEAT = "It's a bit on the small size.",        
		COOKPOT =
		{
			COOKING_LONG = "Might as well doodle while I wait.",
			COOKING_SHORT = "It should be just about done.",
			DONE = "Dinner time!",
			EMPTY = "Maybe I should cook something?",
			BURNT = "There was an accident in the kitchen.",
		},
		CORN = "Corn, my worst enemy!", --"I'll try to avoid telling you any corny jokes."
		CORN_COOKED = "Being unable to eat popcorn never stopped my friends from rubbing it in.",
		CORN_SEEDS = "Seeds of... some sort?",
        CANARY =
		{
			GENERIC = "You have a beautiful voice.",
			HELD = "It has saffron plumage.",
		},
        CANARY_POISONED = "I should let him get some fresh air.",

		CRITTERLAB = "Did something move in there?",
        CRITTER_GLOMLING = "You're adowable!",
        CRITTER_DRAGONLING = "Great to cuddle with on a cold winter night.",
		CRITTER_LAMB = "Baaah!",
        CRITTER_PUPPY = "At least you won't try to eat me, right?",
        CRITTER_KITTEN = "It's purring all its love on me.",
        CRITTER_PERDLING = "I love you so much!",
		CRITTER_LUNARMOTHLING = "Her wings are glowing brightly.",

		CROW =
		{
			GENERIC = "Hi there, bird.",	-- UPDATED
			HELD = "It has jet plumage.",
		},
		CUTGRASS = "Collect a handful of grass: CHECK!",
		CUTREEDS = "I can turn it into paper!",
		CUTSTONE = "So smooth.",
		DEADLYFEAST = "A meal to die for.",
		DEER =
		{
			GENERIC = "How does it see where to go?",
			ANTLER = "Did you just grow that antler?",
		},
        DEER_ANTLER = "It looks like a key, how weird.",
        DEER_GEMMED = "Poor deer.",
		DEERCLOPS = "I'd love to stay, but I gotta go!!",
		DEERCLOPS_EYEBALL = "Gruesome.",
		EYEBRELLAHAT =	"The design is unsettling, but it'll keep me dry.",
		DEPLETED_GRASS =
		{
			GENERIC = "It's a tuft of grass... probably.",
		},
        GOGGLESHAT = "It's a pair of goggles. Yep.",
        DESERTHAT = "Now I won't get sand in my eyes.",
		DEVTOOL = "It's... something?",
		DEVTOOL_NODEV = "It's... something?",
		DIRTPILE = "That's not an ordinary pile of dirt, is it?",
		DIVININGROD =
		{
			COLD = "It's weak.",
			GENERIC = "It's a radio on a stick. Any further questions?",
			HOT = "WOAH! It must be real close!",
			WARM = "Oh? It's picking up the pace!",
			WARMER = "I'm going the right way.",
		},
		DIVININGRODBASE =
		{
			GENERIC = "What's this for?",
			READY = "It's missing a key.",
			UNLOCKED = "The machine seems to be working now.",
		},
		DIVININGRODSTART = "I might need that.",
		DRAGONFLY = "That's the silliest dragon I've ever seen! Haha!",
		ARMORDRAGONFLY = "Fight fire with fire.",
		DRAGON_SCALES = "The scales shine beautifully in the sunlight.",
		DRAGONFLYCHEST = "I'm really fond of that chest's design.",
		DRAGONFLYFURNACE = 
		{
			HAMMERED = "Hammered.",
			GENERIC = "Phew! That's a lot of heat.", --no gems
			NORMAL = "My one-eyed furnace.", --one gem
			HIGH = "Phew! That's a lot of heat.", --two gems
		},
        
        HUTCH = "I know someone in the surface you could be real good friends with.",
        HUTCH_FISHBOWL =
        {
            GENERIC = "How'd you end up down here?",
            WAITING = "Oh...",
        },
		LAVASPIT = 
		{
			HOT = "Hot!",
			COOL = "The fire won't spread now.",
		},
		LAVA_POND = "I should keep my distance.",
		LAVAE = "Stay back!",
		LAVAE_COCOON = "He's fine... Probably.",
		LAVAE_PET = 
		{
			STARVING = "I should get him some food before it's too late.",
			HUNGRY = "Poor little thing is hungry.",
			CONTENT = "She seems happy.",
			GENERIC = "You're so adorable!",
		},
		LAVAE_EGG = 
		{
			GENERIC = "There's a baby lavae waiting to hatch.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "It's freezing cold!",
			COMFY = "It seems to be incubating with no problems.",
		},
		LAVAE_TOOTH = "Aaw, you lost your widdle tooth in the shell.",

		DRAGONFRUIT = "I've never had a dragonfruit before.",
		DRAGONFRUIT_COOKED = "The inside looks really weird.",
		DRAGONFRUIT_SEEDS = "Seeds of... some kind.",
		DRAGONPIE = "Mmmm! Delicious!",
		DRUMSTICK = "Your berry eating days are over!",
		DRUMSTICK_COOKED = "Yum!",
		DUG_BERRYBUSH =  "I should plant it down first.",
		DUG_BERRYBUSH_JUICY = "I should plant it down first.",
		DUG_GRASS = "I should plant it down first.",
		DUG_MARSH_BUSH = "I should plant it down first.",
		DUG_SAPLING = "I should plant it down first.",
		DURIAN = "Woah, that is a strong smell!",
		DURIAN_COOKED = "Ugh! It's even worse now!",
		DURIAN_SEEDS = "Seeds of... some kind.",
		EARMUFFSHAT = "Keeps my ears nice and warm.",
		EGGPLANT = "I love your color.",
		EGGPLANT_COOKED = "Smells good.",
		EGGPLANT_SEEDS = "Seeds of... some kind.",
		
		ENDTABLE = 
		{
			BURNT = "Burnt...",
			GENERIC = "Drawing vases on tables are easy.",
			EMPTY = "Drawing vases on tables are easy.",
			WILTED = "I should add new flowers when I get the chance.",	-- UPDATED
			FRESHLIGHT = "The light is a nice touch.",
			OLDLIGHT = "It needs a new lightbulb.", -- will be wilted soon, light radius will be very small at this point
		},
		DECIDUOUSTREE = 
		{
			BURNING = "It's on fire!!",
			BURNT = "Burnt...",
			CHOPPED = "I should dig up that stump.",
			POISON = "That tree's got eyes!",
			GENERIC = "So many colored leaves!",
		},
		ACORN = "I should plant it for more trees.",
        ACORN_SAPLING = "You'll be a tree soon.",
		ACORN_COOKED = "Squirrel food.",
		BIRCHNUTDRAKE = "It's after me!!",
		EVERGREEN =
		{
			BURNING = "It's on fire!!",
			BURNT = "Burnt...",
			CHOPPED = "I should dig up that stump.",
			GENERIC = "These trees and this beautiful meadow would make a great painting.",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "It's on fire!!",
			BURNT = "Burnt...",
			CHOPPED = "I should dig up that stump.",
			GENERIC = "Don't feel so sad, you're unique in your own special way.",
		},
		TWIGGYTREE = 
		{
			BURNING = "It's on fire!!",
			BURNT = "Burnt...",
			CHOPPED = "I should dig up that stump.",
			GENERIC = "Those branches could be real useful.",	
			DISEASED = "You don't look so good.",
		},
		TWIGGY_NUT_SAPLING = "You'll be a tree soon.",
        TWIGGY_OLD = "Those branches could be real useful.",
		TWIGGY_NUT = "I should plant it.",
		EYEPLANT = "Eye see you!",
		INSPECTSELF = "How do I look?",
		FARMPLOT =
		{
			GENERIC = "I should plant some seeds there.",
			GROWING = "Grow!",
			NEEDSFERTILIZER = "I need to fertilize the dirt first.",
			BURNT = "It's all burnt!",
		},
		FEATHERHAT = "I'M ONE WITH THE BIRDS!",
		FEATHER_CROW = "A jet feather.",
		FEATHER_ROBIN = "A crimson feather.",
		FEATHER_ROBIN_WINTER = "An azure feather.",
		FEATHER_CANARY = "A saffron feather.",
		FEATHERPENCIL = "It's not great for drawing, but it should do the job.",
        COOKBOOK = "For all my delicious creations.",
		FEM_PUPPET = "She's trapped!",
		FIREFLIES =
		{
			GENERIC = "A light in the dark is always welcome.",
			HELD = "They're making my pockets glow.",
		},
		FIREHOUND = "I don't like the looks of that one.",
		FIREPIT =
		{
			EMBERS = "That fire needs more fuel or it's going to go out.",
			GENERIC = "Nice and warm.",
			HIGH = "Yikes! At this rate it'll spread!",
			LOW = "It's getting low, maybe I should throw a few logs.",
			NORMAL = "Nice and warm.",
			OUT = "I can easily start a new fire there.",
		},
		COLDFIREPIT =
		{
			EMBERS = "That fire needs more fuel or it's going to go out.",
			GENERIC = "Nice and cold.",
			HIGH = "Yikes! At this rate it'll spread!",
			LOW = "It's getting low, maybe I should throw a few logs.",
			NORMAL = "Nice and warm.",
			OUT = "I can easily start a new fire there.",
		},
		FIRESTAFF = "I should be careful where I wave this thing about.",
		FIRESUPPRESSOR = 
		{	
			ON = "It gets the job done.",
			OFF = "It gets the job done.",
			LOWFUEL = "It's running out of juice.",
		},

		FISH = "Smells fishy to me. Hahaha!",
		FISHINGROD = "Time to catch me some fish.",
		FISHSTICKS = "Mmmm!",
		FISHTACOS = "Love it!",
		FISH_COOKED = "Wish I had a bit of lemon to go with it.",
		FLINT = "Very sharp, better be careful with it.",
		FLOWER = 
		{
            GENERIC = "This place is filled with such beautiful flowers!",
            ROSE = "Woah, a red rose, that's rare!",
        },
        FLOWER_WITHERED = "It won't live without sunlight.",
		FLOWERHAT = "I feel so peaceful wearing it.",
		FLOWER_EVIL = "How can something so beautiful be evil?",
		FOLIAGE = "What am I supposed to do with this?",
		FOOTBALLHAT = "I'll be honest: I'm not good at sports.",
        FOSSIL_PIECE = "I'm not an osteologist, but I can tell these are very old.",
        FOSSIL_STALKER =
        {
			GENERIC = "You can't rush art!",
			FUNNY = "I think I did something wrong halfway...",
			COMPLETE = "Looks like a... I am not sure, to be honest.",
        },
        STALKER = "I don't like this one bit!",
        STALKER_ATRIUM = "He seems really dedicated to stopping us!",
        STALKER_MINION = "I don't like these things at all!",
        THURIBLE = "Smells like oil paints.",
        ATRIUM_OVERGROWTH = "Some scribbles, I can't read it.",
		FROG =
		{
			DEAD = "Sorry.",
			GENERIC = "He's grouchy.",
			SLEEPING = "He looks kinda cute when he sleeps.",
		},
		FROGGLEBUNWICH = "It's not that bad actually.",
		FROGLEGS = "There's not a lot of meat on them legs.",
		FROGLEGS_COOKED = "Tastes fine.",
		FRUITMEDLEY = "Fruit galore.",
		FURTUFT = "It's a little tuft of fur.", 
		GEARS = "I'm not too good with anything mechanical.",
		GHOST = "That can't be real.",
		GOLDENAXE = "A bit too lavish for my taste.",	--"A bit tacky, isn't it?",
		GOLDENPICKAXE = "Using my golden pickaxe to mine more gold.",
		GOLDENPITCHFORK = "I suppose that's one use for gold.",
		GOLDENSHOVEL = "I hope the dirt appreciates this shovel's golden quality.",
		GOLDNUGGET = "My yearly pay isn't worth one-tenth of this nugget!",
		GRASS =
		{
			BARREN = "I have to fertilize it first.",
			WITHERED = "Hopefully the weather will get cooler soon.",
			BURNING = "Fire, it's on fire!",
			GENERIC = "I've always preferred natural grass over artificial.",	-- UPDATED ("You're mine, grass!")
			PICKED = "I got what I came here for.",
			DISEASED = "Its condition has worsened.",
			DISEASING = "It doesn't look very well...",
		},
		GRASSGEKKO = 
		{
			GENERIC = "It doesn't move much. Good, I can draw it easily.",	
			DISEASED = "You should look for a doctor.",
		},
		GREEN_CAP = "I'm not sure if I should eat it...",
		GREEN_CAP_COOKED = "I'm still not sure eating that is a good idea.",
		GREEN_MUSHROOM =
		{
			GENERIC = "Is it a 1-UP mushroom?",
			INGROUND = "It's gone into hiding.",
			PICKED = "It should grow back.",
		},
		GUNPOWDER = "I'll keep it far, FAR away from fire.",
		HAMBAT = "It's... creative, I have to admit.",
		HAMMER = "A great way to vent out all your anger.",		--"Wham, blam, crash, smash! Destruction!!",
		HEALINGSALVE = "It gets the job done.",
		HEATROCK =
		{
			FROZEN = "Freezing cold!",
			COLD = "Cool, like an iced tea.",
			GENERIC = "Well, it's a round rock.",
			WARM = "Warm, like a hot cocoa.",
			HOT = "Blazing hot!",
		},
		HOME = "Somebody's home.",
		HOMESIGN =
		{
			GENERIC = "The sign says: \"The sign says\".",
            UNWRITTEN = "It's blank, should I write something?",
			BURNT = "\"Only you can prevent forest fires.\"",
		},
		ARROWSIGN_POST =
		{
			GENERIC = "There's something written on it: \"There's something written on it\".",
            UNWRITTEN = "It's blank, should I write something?",
			BURNT = "\"Only you can prevent forest fires.\"",
		},
		ARROWSIGN_PANEL =
		{
			GENERIC = "There's something written on it: \"There's something written on it\".",
            UNWRITTEN = "It's blank, should I write something?",
			BURNT = "\"Only you can prevent forest fires.\"",
		},
		HONEY = "I hope it doesn't attract any honey bears.",
		HONEYCOMB = "That used to be a bee's home.",
		HONEYHAM = "Sweet honey heaven!",
		HONEYNUGGETS = "I'd rather have ketchup with my nuggets, but this'll do.",
		HORN = "Huh, it's pretty light.",
		HOUND = "Bad dog, shoo! Get outta here!",
		HOUNDCORPSE =
		{
			GENERIC = "That thing almost gored me!",
			BURNING = "Ugh, the smell of burning hound fur is not pleasant.",
			REVIVING = "Woah, what the hay?!",
		},
		HOUNDBONE = "Well, they're not picky eaters.",
		HOUNDMOUND = "How'd they even get so many bones?",
		ICEBOX = "Why is it that everytime I'm hungry the fridge is always empty?",	--"For keeping all my stale cup noodles.",
		ICEHAT = "What better way to cool down than a huge block of ice on one's head?",
		ICEHOUND = "I thought at least this one would be cool!",
		INSANITYROCK =
		{
			ACTIVE = "This is one horrible headache.",
			INACTIVE = "Did it just shrink into the ground?",
		},
		JAMMYPRESERVES = "Hope I don't get any jam on my jammies. Hahah!",

		KABOBS = "Stabbed it with a stick.",
		KILLERBEE =
		{
			GENERIC = "Time for me to leave!",
			HELD = "N-nice little bee?",
		},
		KNIGHT = "I could really use your gears.",
		KOALEFANT_SUMMER = "I don't know what it is, but I want to draw it!",
		KOALEFANT_WINTER = "This one's extra fluffy.",
		KRAMPUS = "Thief, stop taking my stuff!",
		KRAMPUS_SACK = "Just think of all the art supplies I could keep in that!",
		LEIF = "Would an apology suffice?",
		LEIF_SPARSE = "Would an apology suffice?",
		LIGHTER  = "Very meticulous flower patterns, it's quite beautiful.",
		LIGHTNING_ROD =
		{
			CHARGED = "Phew, that's one wildfire avoided.",
			GENERIC = "This ought to keep me safe from that lightning.",
		},
		LIGHTNINGGOAT = 
		{
			GENERIC = "Look at the size of those horns!",
			CHARGED = "What a shocking turn of events!",
		},
		LIGHTNINGGOATHORN = "Holding it makes my hair stand up.",
		GOATMILK = "It even comes with its own bottle.",
		LITTLE_WALRUS = "Your dad doesn't like visitors, does he?",
		LIVINGLOG = "Someone is having a worst day than me.",
		LOG =
		{
			BURNING = "Hot logs!",
			GENERIC = "Just imagine all the sculptures a professional woodcarver could make with it.",
		},
		LUCY = "Woodie's special axe, I shouldn't touch it withouth is permission.",
		LUREPLANT = "If you're trying to lure me into a trap try using something tasty next time, okay?",
		LUREPLANTBULB = "Well, you made an effort in luring me in a trap.",
		MALE_PUPPET = "That doesn't look like fun.",

		MANDRAKE_ACTIVE = "Feels like I'm listening to an indecisive customer who's constantly nagging!",	--"Worse than listening to a drunk Liam blathering on during a business dinner!",
		MANDRAKE_PLANTED = "I have a bad feeling about this...",
		MANDRAKE = "It's finally over, thank goodness.",

        MANDRAKESOUP = "Now I'm starting to feel a bit bad for the guy.",
        MANDRAKE_COOKED = "I can still hear his screams...",
        MAPSCROLL = "It's... blank! What a waste of perfectly good paper.",
        MARBLE = "Maybe I should finally try my hand on sculpting?",
        MARBLEBEAN = "Not the edible kind.",
        MARBLEBEAN_SAPLING = "You never know until you try, right?",
        MARBLESHRUB = "It actually worked!",
        MARBLEPILLAR = "I think they used the Classical architecture's Ionic order for its design.",
        MARBLETREE = "It's whimsical, I'll give you that.",
        MARSH_BUSH =
        {
			BURNT = "At least it won't prick my hands now.",
			BURNING = "Fire, it's on fire!",
			GENERIC = "I'm not sure if it's worth the pain.",
			PICKED = "My hands still hurt.",
        },
        BURNT_MARSH_BUSH = "At least it won't prick my hands now.",
        MARSH_PLANT = "Adds a bit of beauty to the pond's overall image.",
        MARSH_TREE =
        {
            BURNING = "Fire, it's on fire!",
            BURNT = "I don't think anybody's gonna miss it.",
            CHOPPED = "Your days of looking creepy are over.",
            GENERIC = "Not very welcoming.",
        },
        MAXWELL = "My, you are very tall.",
        MAXWELLHEAD = "Now, now, don't get ahead of yourself. Ha!",
        MAXWELLLIGHT = "Automated lighting?",
        MAXWELLLOCK = "Where'd I leave my keys...",
        MAXWELLTHRONE = "I think I'll stand, thank-you.",
        MEAT = "I should cook it first. Eating it raw would be foolish.",
        MEATBALLS = "Cooking is just one of my favorite pastimes.",
        MEATRACK =
        {
            DONE = "It's all dried up.",
            DRYING = "It still needs a bit of time.",
            DRYINGINRAIN = "This rain isn't helping things.",
            GENERIC = "I should hang something on it.",
            BURNT = "Darn it...",
            DONE_NOTMEAT = "It's all dried up.",
            DRYING_NOTMEAT = "It still needs a bit of time.",
            DRYINGINRAIN_NOTMEAT = "This rain isn't helping things.",
        },
        MEAT_DRIED = "A great snack to have if you're working overtime.",
        MERM = "I wouldn't borrow a cup of sugar from them.",
        MERMHEAD =
        {
            GENERIC = "That's grisly.",
            BURNT = "Now it smells even worse.",
        },
        MERMHOUSE =
        {
            GENERIC = "The neighbourhood is nice, but I wouldn't want to live here.",	--"Fine real estate, don't you think?",
            BURNT = "Ah, so arson is a common occurrence in these parts.",
        },
        MINERHAT = "A hands-free light source for night-time sketching.",
        MONKEY = "Keep your paws off my pockets.",	--"A monkey is 500 pounds, right?",
        MONKEYBARREL = "Did they make that themselves?",
        MONSTERLASAGNA = "Even Garfield wouldn't eat that.",
        FLOWERSALAD = "Cactus dinner, yummy.",
        ICECREAM = "I like mine with lots of sprinkles.",	--"Nothing better for a friday night like killing time in front of a TV with a bucket of ice cream.", // "They really ran out of ideas for generation V of Pokemon, didn't they?",
        WATERMELONICLE = "Slurp!",
        TRAILMIX = "My bag of snacks.",
        HOTCHILI = "That's hot!",
        GUACAMOLE = "Ha. Ha. Ha. And here I thought I was the one with bad puns.",
        MONSTERMEAT = "A nice shade of purple.",
        MONSTERMEAT_DRIED = "Drying it only made it smell worse.",
        MOOSE = "My goose is cooked...",
        MOOSE_NESTING_GROUND = "Looks like a nest to me.",
        MOOSEEGG = "I wouldn't want to meet the mother of THAT egg.",
        MOSSLING = "How can something so fluffy be so evil!",
        FEATHERFAN = "Great way to cool off.",
        MINIFAN = "It's not great, but it gets the job done.",
        GOOSE_FEATHER = "This'd make a great quill.",
        STAFF_TORNADO = "Here comes the vane.",
        MOSQUITO =
        {
            GENERIC = "I hate the buzzing of mosquitos.",
            HELD = "Keep quiet, you!",
        },
        MOSQUITOSACK = "The little bugger took a lot of my blood!",
        MOUND =
        {
            DUG = "Now I'm an official grave robber. Great.",
            GENERIC = "I should let them rest in peace.",
        },
        NIGHTLIGHT = "More like nightmare-inducing light.",
        NIGHTMAREFUEL = "This is giving me the heebie-jeebies!",
        NIGHTSWORD = "Fighting nightmares with nightmares, ironic isn't it?",
        NITRE = "Looks like another rock to me.",
        ONEMANBAND = "I hope your ears are ready to bleed.",
        OASISLAKE =
		{
			GENERIC = "I can see all kinds of junk down there.",
			EMPTY = "Looks like a pit of sand to me.",
		},
        PANDORASCHEST = "The design of this chest is very detailed.",
        PANFLUTE = "I really don't know how to play, but I'm willing to learn.",
        PAPYRUS = "Not great for drawing, but I guess it'll have to do.",
        WAXPAPER = "Covered in sweet beeswax.",
        PENGUIN = "Looking classy.",
        PERD = "Leave some berries for me!",
        PEROGIES = "I did a pretty good job cooking that.",
        PETALS = "Poor flower.",
        PETALS_EVIL = "Holding them is giving me a headache.",
        PHLEGM = "I'd rather leave it where it is.",
        PICKAXE = "This shouldn't be so hard, I did learn from Minecraft anyways.",
        PIGGYBACK = "I wonder how the other pigs feel about this...",
        PIGHEAD =
        {
            GENERIC = "That's macabre.",
            BURNT = "Now it smells even worse.",
        },
        PIGHOUSE =
        {
            FULL = "He's looking at me...",
            GENERIC = "Prime pig real estate.",
            LIGHTSOUT = "I think he got shy.",
            BURNT = "I hope you had insurance.",
        },
        PIGKING = "He could use a diet.",
        PIGMAN =
        {
            DEAD = "Rest in peace.",
            FOLLOWER = "We're best friends now.",
            GENERIC = "I think the neighbors could use a bath.",
            GUARD = "He doesn't like me getting close.",
            WEREPIG = "IT'S THE CURSE OF THE WEREPIG!",
        },
        PIGSKIN = "Your buns are mine.",
        PIGTENT = "Smells like a sty.",
        PIGTORCH = "I bet I could draw that without difficulty.",
        PINECONE = "Its chances of becoming a tree rest on my hands.",
        PINECONE_SAPLING = "Go, sapling, go!",
        LUMPY_SAPLING = "How'd this get here?",
        PITCHFORK = "That's a big fork.",
        PLANTMEAT = "It's green and it's meat.",
        PLANTMEAT_COOKED = "It's still green and now it's warm.",
        PLANT_NORMAL =
        {
            GENERIC = "Go, plant, go!",
            GROWING = "Staring at it won't make it grow faster.",
            READY = "Looks ready for picking.",
            WITHERED = "This heat killed it.",
        },
        POMEGRANATE = "Filled with little seeds.",
        POMEGRANATE_COOKED = "Cooking that wasn't easy.",
        POMEGRANATE_SEEDS = "Seeds of... some kind.",
        POND = "It's very murky.",
        POOP = "I can confidently, and disgustingly, say that this is poop.",
        FERTILIZER = "Now I have all the poop in one bucket.",
        PUMPKIN = "I'm rather good at carving pumpkins.",
        PUMPKINCOOKIE = "Not bad, not bad.",
        PUMPKIN_COOKED = "Yum!",
        PUMPKIN_LANTERN = "Turned out pretty great.",
        PUMPKIN_SEEDS = "Seeds of... some kind.",
        PURPLEAMULET = "Can you stop whispering, please?",
        PURPLEGEM = "This one gives me an uneasy feeling.",
        RABBIT =
        {
            GENERIC = "Well, hello there you cute little thing.",
            HELD = "I'll feed you as many carrots as you want.",
        },
        RABBITHOLE =
        {
            GENERIC = "A wabbit's widdle home.",
            SPRING = "The wabbit's widdle home is cwosed.",
        },
        RAINOMETER =
        {
            GENERIC = "Hopefully it won't rain today.",
            BURNT = "Cloudy with a chance of wildfires.",
        },
        RAINCOAT = "Take that, rain!",
        RAINHAT = "This'll help keep my glasses clear.",
        RATATOUILLE = "No rats, don't worry.",
        RAZOR = "Does it look like I have a beard?",
        REDGEM = "It has a stunning flaming-red color.",	--"Red, like a blazing flame.",
        RED_CAP = "Will eating it make me grow bigger?",
        RED_CAP_COOKED = "What does it do now?",
        RED_MUSHROOM =
        {
			GENERIC = "This one is red.",
			INGROUND = "It's gone into hiding.",
			PICKED = "It should grow back.",
        },
        REEDS =
        {
            BURNING = "Fire!",
            GENERIC = "I could make that into paper.",
            PICKED = "I got everything I needed from that.",
        },
        RELIC = "This could be valuable in a museum.",
        RUINS_RUBBLE = "It's broken, maybe I can use my creative skills to repair it?",
        RUBBLE = "Completely broken.",
        RESEARCHLAB =
        {
            GENERIC = "Just a bunch of logs and rocks stuck together. Any further questions?",
            BURNT = "I guess science isn't fireproof.",
        },
        RESEARCHLAB2 =
        {
            GENERIC = "Doesnt' seem that hard to operate.",
            BURNT = "I guess science isn't fireproof.",
        },
        RESEARCHLAB3 =
        {
            GENERIC = "Widdle bunnies come out of the top.",
            BURNT = "I guess magic isn't fireproof.",
        },
        RESEARCHLAB4 =
        {
            GENERIC = "I'm starting to mess with forces beyond my comprehension.",
            BURNT = "I guess magic isn't fireproof.",
        },
        RESURRECTIONSTATUE =
        {
            GENERIC = "What a dashing gentleman.",
            BURNT = "Woops.",
        },
        RESURRECTIONSTONE = "I have an irresistible urge to touch it.",
        ROBIN =
        {
            GENERIC = "Fly, robin, fly!",
            HELD = "How's life in my pocket?",
        },
        ROBIN_WINTER =
        {
            GENERIC = "Such beautiful white plumage.",
            HELD = "How's life in my pocket?",
        },
        ROBOT_PUPPET = "Must be tough, huh?",
        ROCK_LIGHT =
        {
            GENERIC = "I can feel a faint heat coming from it.",
            OUT = "I can feel a faint heat coming from it.",
            LOW = "It's getting low.",
            NORMAL = "Holy magma!",
        },
        CAVEIN_BOULDER =
        {
            GENERIC = "Hopefully I don't break my back.",
            RAISED = "There's no way I can reach that one.",
        },
        ROCK = "An assymetric boulder.",
        PETRIFIED_TREE = "I don't want to know what happened here.",
        ROCK_PETRIFIED_TREE = "I don't want to know what happened here.",
        ROCK_PETRIFIED_TREE_OLD = "I don't want to know what happened here.",
        ROCK_ICE =
        {
            GENERIC = "It's a huge block of ice.",
            MELTED = "A mere puddle, no use to me.",
        },
        ROCK_ICE_MELTED = "A mere puddle, no use to me.",
        ICE = "Ice for my tea, if I could make one.",
        ROCKS = "They're rocks, so?",
        ROOK = "I'd best not get its attention.",
        ROPE = "This rope may come in handy.",
        ROTTENEGG = "Ugh, the smell!",
        ROYAL_JELLY = "Sweeter than syrup!",
        JELLYBEAN = "So many different colors.",
        SADDLE_BASIC = "Yeehaw!",
        SADDLE_RACE = "Now we're riding like the wind.",
        SADDLE_WAR = "This one screams with hostility.",
        SADDLEHORN = "I can easily remove the saddle with this.",
        SALTLICK = "I guess nitre has natural salty properties?",
        BRUSH = "It's covered in beefalo hair.",
		SANITYROCK =
		{
			ACTIVE = "Nice obelisk, what do these carvings mean?",
			INACTIVE = "Did it just shrink into the ground?",
		},
		SAPLING =
		{
			BURNING = "Fire, it's on fire!",
			WITHERED = "Hopefully the weather will get cooler soon.",
			GENERIC = "I might need those twigs.",
			PICKED = "I got all the twigs from that one.",
			DISEASED = "Its condition has worsened.",
			DISEASING = "It doesn't look very well...",
		},
   		SCARECROW = 
   		{
			GENERIC = "It's even scaring me a little bit.",
			BURNING = "I don't like the way it's looking at me with a pained expression.",
			BURNT = "That was unpleasant.",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "Never sculpted before, first time for everything I guess.",
			BLOCK = "Got my material ready.",
			SCULPTURE = "Hey, that turned out pretty good.",
			BURNT = "Shoot...",
   		},
        SCULPTURE_KNIGHTHEAD = "That kinda looks like a head.",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "Bad craftmanship.",
			UNCOVERED = "Fixed it up a bit, though a piece is missing.",
			FINISHED = "Looks better than before.",
			READY = "Woah, it's shaking!",
		},
        SCULPTURE_BISHOPHEAD = "What a weird-looking rock.",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "Not gonna lie, it's ugly.",
			UNCOVERED = "Something's missing.",
			FINISHED = "It seemed to fit perfectly.",
			READY = "Woah, it's shaking!",
		},
        SCULPTURE_ROOKNOSE = "This doesn't look like a boulder, look at those weird patterns.",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "They tried.",
			UNCOVERED = "Looks incomplete.",
			FINISHED = "Got your nose back.",
			READY = "Woah, it's shaking!",
		},
        GARGOYLE_HOUND = "Naturally eerie.",
        GARGOYLE_WEREPIG = "Eeer... kinda charming.",
		SEEDS = "Hmm... should I try my hand in gardening?",
		SEEDS_COOKED = "Nothing's gonna grow out of them now.",
		SEWING_KIT = "I was never good at sewing.",
		SEWING_TAPE = "At least I don't have to work with needles and yarn.",
		SHOVEL = "If Minecraft taught me anything it's to NEVER dig straight down.",
		SILK = "Top quality silk from a spider's bum.",
		SKELETON = "That's good. Keep that pose right there while I draw you.",
		SCORCHED_SKELETON = "Smoky.",
		SKULLCHEST = "Are those human bones?",
		SMALLBIRD =
		{
			GENERIC = "Aaaw, you're cute.",
			HUNGRY = "He's hungry.",
			STARVING = "You must be really hungry.",
			SLEEPING = "He's like a tiny ball of adorableness.",
		},
		SMALLMEAT = "There's a little bit of meat on that bone.",
		SMALLMEAT_DRIED = "A tiny chewy snack.",
		SPAT = "Need a handkerchief?",
		SPEAR = "I wish there was a more peaceful way to resolve our problems.",
		SPEAR_WATHGRITHR = "I guess Wigfrid believes in a more straightforward approach to her problems.",
		WATHGRITHRHAT = "I love the unicorn on top.",
		SPIDER =
		{
			DEAD = "Sorry about that.",
			GENERIC = "Spiders aren't that bad, at least not until they try to eat you.",
			SLEEPING = "See? He's not harming anybody.",
		},
		SPIDERDEN = "I won't disturb them and they won't disturb me.",
		SPIDEREGGSACK = "This world could use more spiders.",
		SPIDERGLAND = "Spider goop.",
		SPIDERHAT = "Do I have to put it on my head?",
		SPIDERQUEEN = "Mother of all spiders!",
		SPIDER_WARRIOR =
		{
			DEAD = "Sorry about that.",
			GENERIC = "This one means trouble.",
			SLEEPING = "See? He's not harming anybody.",
		},
		SPOILED_FOOD = "That used to be food.",
        STAGEHAND =
        {
			AWAKE = "GAH! That scared me!!",
			HIDING = "Did something move under there?",
        },
        STATUE_MARBLE = 
        {
            GENERIC = "The vase is cracked.",	--Vase
            TYPE1 = "Tragic.",					--Tragedy
            TYPE2 = "Comedic!",					--Comedy
            TYPE3 = "It's cracked.", 	--bird bath type statue
        },
		STATUEHARP = "He got ahead of himself. Hah!",
		STATUEMAXWELL = "His whole look screams \"Bad Guy\".",	--"Signs of overconfidence and lust for power.",
		STEELWOOL = "It's kinda scratchy for wool.",
		STINGER = "Very sharp.",
		STRAWHAT = "Gives a bit of shade.",
		STUFFEDEGGPLANT = "An eggplant stuffed with more vegetables.",
		SWEATERVEST = "Keeps me nice and warm.",
		REFLECTIVEVEST = "Keeps me a bit cool on a hot summer day.",
		HAWAIIANSHIRT = "Meh, I don't need a holiday.",
		TAFFY = "Great way to shatter my teeth.",
		TALLBIRD = "Woah, that's a BIG bird.",
		TALLBIRDEGG = "A blue egg with white dots? Weird.",
		TALLBIRDEGG_COOKED = "Even the yolk is blue!",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "It's freezing!",
			GENERIC = "It'll hatch into an adorable baby bird.",
			HOT = "It's burning up!",
			LONG = "There's a long way to go...",
			SHORT = "I think it should hatch any minute now!",
		},
		TALLBIRDNEST =
		{
			GENERIC = "That egg looks really weird.",
			PICKED = "No egg there.",
		},
		TEENBIRD =
		{
			GENERIC = "Teen years are really hard.",
			HUNGRY = "Are you hungry?",
			STARVING = "Okay, okay, stop pecking me, I'll feed you!",
			SLEEPING = "Finally, some peace and quiet.",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "I have a bad feeling about this.",
			GENERIC = "Some sort of thing?",
			LOCKED = "Some sort of thing?",
			PARTIAL = "I got a few pieces back.",
		},
		TELEPORTATO_BOX = "It's a... thingamajig?",
		TELEPORTATO_CRANK = "What the hay is this?",
		TELEPORTATO_POTATO = "Not a real potato.",
		TELEPORTATO_RING = "I'm not sure what to say.",
		TELESTAFF = "Where will I end up next?",
		TENT = 
		{
			GENERIC = "I could really use some shut-eye.",
			BURNT = "No rest for the wicked.",
		},
		SIESTAHUT = 
		{
			GENERIC = "I could go for a nap.",
			BURNT = "No rest for the wicked.",
		},
		TENTACLE = "Keep your slimy tentacles to yourself!",
		TENTACLESPIKE = "Still covered with slime.",
		TENTACLESPOTS = "You don't want to know where it came from...",
		TENTACLE_PILLAR = "How big is this thing?!",
        TENTACLE_PILLAR_HOLE = "Am I really thinking about jumping down there?",
		TENTACLE_PILLAR_ARM = "Keep your slimy tentacles to yourself!",
		TENTACLE_GARDEN = "How big is this thing?!",
		TOPHAT = "The toppest of hats.",
		TORCH = "Hopefully I don't set anything on fire.",
		TRANSISTOR = "It does... something.",
		TRAP = "Those rabbits are mine!",
		TRAP_TEETH = "I hope I don't step on it.",
		TRAP_TEETH_MAXWELL = "It's a trap!",
		TREASURECHEST = 
		{
			GENERIC = "I can keep all my art supplies in there.",
			BURNT = "No! My supplies!",
		},
		TREASURECHEST_TRAP = "What?!",
		SACRED_CHEST = 
		{
			GENERIC = "Is that chest whispering?",
			LOCKED = "I feel judged...",
		},
		TREECLUMP = "Excuse me, trees, can you move?",
		
		TRINKET_1 = "They're stuck together.", --Melted Marbles
		TRINKET_2 = "Aw, it's not real.", --Fake Kazoo
		TRINKET_3 = "Who'd want to be buried with this?", --Gord's Knot
		TRINKET_4 = "I got gnomed!", --Gnome
		TRINKET_5 = "To infinity and beyond!", --Toy Rocketship
		TRINKET_6 = "This seems dangerous to touch.", --Frazzled Wires
		TRINKET_7 = "I loved this as a kid!", --Ball and Cup
		TRINKET_8 = "The real question is where's the tub?", --Rubber Bung
		TRINKET_9 = "They're all different size and color.", --Mismatched Buttons
		TRINKET_10 = "I'm used to cleaning Grandma's dentures.", --Dentures
		TRINKET_11 = "I don't believe you...", --Lying Robot
		TRINKET_12 = "What am I supposed to do with this?", --Dessicated Tentacle
		TRINKET_13 = "I got gnomed!", --Gnomette
		TRINKET_14 = "What a waste of such beautiful china.", --Leaky Teacup
		TRINKET_15 = "I've forgotten how to play chess.", --Pawn
		TRINKET_16 = "I've forgotten how to play chess.", --Pawn
		TRINKET_17 = "Makes eating even harder.", --Bent Spork
		TRINKET_18 = "Suspicious...", --Trojan Horse
		TRINKET_19 = "It's broken!", --Unbalanced Top
		TRINKET_20 = "My back is just fine, thanks.", --Backscratcher
		TRINKET_21 = "The eggs win.", --Egg Beater
		TRINKET_22 = "You find all kinds of junk in this place.", --Frayed Yarn
		TRINKET_23 = "I don't need the help.", --Shoehorn
		TRINKET_24 = "I love these things!", --Lucky Cat Jar
		TRINKET_25 = "A great gift for your enemies.", --Air Unfreshener
		TRINKET_26 = "A pretty smart invention.", --Potato Cup
		TRINKET_27 = "It's all in the name.", --Coat Hanger
		TRINKET_28 = "Maybe Maxwell can remind me how to play.", --Rook
        TRINKET_29 = "Maybe Maxwell can remind me how to play.", --Rook
        TRINKET_30 = "I can never remember how the knight moves.", --Knight
        TRINKET_31 = "I can never remember how the knight moves.", --Knight
        TRINKET_32 = "Fortune-telling, what a sham!", --Cubic Zirconia Ball
        TRINKET_33 = "Tacky.", --Spider Ring
        TRINKET_34 = "High-five!", --Monkey Paw
        TRINKET_35 = "Who just leaves their garbage around?!", --Empty Elixir
        TRINKET_36 = "Aw, the fangs are blunt.", --Faux fangs
        TRINKET_37 = "Ha ha, real scary.", --Broken Stake
        TRINKET_38 = "Huh, they don't work.", -- Binoculars Griftlands trinket
        TRINKET_39 = "One glove is better than none.", -- Lone Glove Griftlands trinket
        TRINKET_40 = "A cute design, but I think it's broken.", -- Snail Scale Griftlands trinket
        TRINKET_41 = "Is that a lava lamp?", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "For a second there I thought it was real.", -- Toy Cobra Hot Lava trinket
        TRINKET_43 = "Aw, it's kinda cute.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "Where'd this come from?", -- Broken Terrarium ONI trinket
        TRINKET_45 = "I can't get a clear audio.", -- Odd Radio ONI trinket
        TRINKET_46 = "I could've really used this hairdryer, but it's broken.", -- Hairdryer ONI trinket

        -- The numbers align with the trinket numbers above.
        LOST_TOY_1  = "Is this your lost toy?",
        LOST_TOY_2  = "Is this your lost toy?",
        LOST_TOY_7  = "Is this your lost toy?",
        LOST_TOY_10 = "Is this your lost toy?",
        LOST_TOY_11 = "Is this your lost toy?",
        LOST_TOY_14 = "Is this your lost toy?",
        LOST_TOY_18 = "Is this your lost toy?",
        LOST_TOY_19 = "Is this your lost toy?",
        LOST_TOY_42 = "Is this your lost toy?",
        LOST_TOY_43 = "Is this your lost toy?",
        
        HALLOWEENCANDY_1 = "I could never say no to a candy apple.",
        HALLOWEENCANDY_2 = "Sugar-coated corn.",
        HALLOWEENCANDY_3 = "Hey, this is just corn!",
        HALLOWEENCANDY_4 = "It's licorice.",
        HALLOWEENCANDY_5 = "Kitty kat candy.",
        HALLOWEENCANDY_6 = "They're not raisins, are they?...",
        HALLOWEENCANDY_7 = "What sick monster would give a child raisins?!",
        HALLOWEENCANDY_8 = "I haven't had a lollipop in a while.",
        HALLOWEENCANDY_9 = "I hate it when it gets stuck on my teeth.",
        HALLOWEENCANDY_10 = "I haven't had a lollipop in a while.",
        HALLOWEENCANDY_11 = "I'll share them with the pigs.",
        HALLOWEENCANDY_12 = "They're... moving.", --ONI meal lice candy
        HALLOWEENCANDY_13 = "Tougher than nails.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "It's spicy, but sweet.", --Hot Lava pepper candy
        CANDYBAG = "My bag o' candies!.",

		HALLOWEEN_ORNAMENT_1 = "BOO!",
		HALLOWEEN_ORNAMENT_2 = "Oh no! I've run out of bat puns!",
		HALLOWEEN_ORNAMENT_3 = "It keeps dangling on the tree.", 
		HALLOWEEN_ORNAMENT_4 = "Why is this covered in slime?!",
		HALLOWEEN_ORNAMENT_5 = "Aw, it's cute.",
		HALLOWEEN_ORNAMENT_6 = "I love this one.", 

		HALLOWEENPOTION_DRINKS_WEAK = "It's barely a drop.",
		HALLOWEENPOTION_DRINKS_POTENT = "Now this is a potion!",
        HALLOWEENPOTION_BRAVERY = "Liquid bravery.",
		HALLOWEENPOTION_MOON = "What'd happen if I drink it?",
		HALLOWEENPOTION_FIRE_FX = "I should throw it on a fire.", 
		MADSCIENCE_LAB = "Time to dabble with mad science!",
		LIVINGTREE_ROOT = "That creepy little tree wants to get out.", 
		LIVINGTREE_SAPLING = "You'll grow to be terrifying.",

        DRAGONHEADHAT = "Who wants to be the head?",
        DRAGONBODYHAT = "I could be the middle piece, if you want.",
        DRAGONTAILHAT = "Who's taking the back?",
        PERDSHRINE =
        {
            GENERIC = "I should offer it something.",
            EMPTY = "It needs a berry bush.",
            BURNT = "Shoot...",
        },
        REDLANTERN = "I love these little lanterns.",
        LUCKY_GOLDNUGGET = "I'm feeling luckier already.",
        FIRECRACKERS = "Explosive fun!",
        PERDFAN = "That's a big feather.",
        REDPOUCH = "I can feel something heavy inside.",
        WARGSHRINE = 
        {
            GENERIC = "I should offer it something.",
            EMPTY = "It needs a torch.",
			BURNING = "Shoot...",
            BURNT = "Shoot...",
        },
        CLAYWARG = 
        {
        	GENERIC = "It's moving!!",
        	STATUE = "I feel... watched.",
        },
        CLAYHOUND = 
        {
        	GENERIC = "I don't like this one bit!",
        	STATUE = "I don't like the looks of this...",
        },
        HOUNDWHISTLE = "This'll stop those mangy mutts in their tracks.",
        CHESSPIECE_CLAYHOUND = "A traumatizing experience.",
        CHESSPIECE_CLAYWARG = "I'd rather forget that memory.",

		PIGSHRINE =
		{
            GENERIC = "I should offer it something.",
            EMPTY = "It needs meat.",
            BURNT = "Shoot...",
		},
		PIG_TOKEN = "That's a weird-looking belt.",
		PIG_COIN = "Snouty currency.",
		YOTP_FOOD1 = "Mmmm!",
		YOTP_FOOD2 = "A little too much mud for my tastes.",
		YOTP_FOOD3 = "Fish heads, really?",

		PIGELITE1 = "Give me your best shot, pig!", --BLUE
		PIGELITE2 = "That gold's mine!", --RED
		PIGELITE3 = "I'll get you now!", --WHITE
		PIGELITE4 = "This is fun!", --GREEN

		PIGELITEFIGHTER1 = "Give me your best shot, pig!", --BLUE
		PIGELITEFIGHTER2 = "That gold's mine!", --RED
		PIGELITEFIGHTER3 = "I'll get you now!", --WHITE
		PIGELITEFIGHTER4 = "This is fun!", --GREEN

		CARRAT_GHOSTRACER = "Whose Carrat is that?",

        YOTC_CARRAT_RACE_START = "The starting line.",
        YOTC_CARRAT_RACE_CHECKPOINT = "The Carrats have to pass through this.",
        YOTC_CARRAT_RACE_FINISH =
        {
            GENERIC = "The finish line.",
            BURNT = "Darn it...",
            I_WON = "Ha! Hahaha! I win!",
            SOMEONE_ELSE_WON = "Ooh, good game, {winner}.",
        },

		YOTC_CARRAT_RACE_START_ITEM = "The starting line.",
        YOTC_CARRAT_RACE_CHECKPOINT_ITEM = "The Carrats have to pass through this.",
		YOTC_CARRAT_RACE_FINISH_ITEM = "The finish line.",

		YOTC_SEEDPACKET = "It's just seeds.",
		YOTC_SEEDPACKET_RARE = "They better be worth the price.",

		MINIBOATLANTERN = "A light afloat.",

        YOTC_CARRATSHRINE =
        {
            GENERIC = "I should offer it something.",
            EMPTY = "It needs a carrot.",
            BURNT = "Shoot...",
        },

        YOTC_CARRAT_GYM_DIRECTION = 
        {
            GENERIC = "We don't want him to lose his sense of direction.",
            RAT = "Keep up the good work.",
            BURNT = "It's torched.",
        },
        YOTC_CARRAT_GYM_SPEED = 
        {
            GENERIC = "Speed is key.",
            RAT = "Could you pick up the pace?",
            BURNT = "It's torched.",
        },
        YOTC_CARRAT_GYM_REACTION = 
        {
            GENERIC = "Gotta sharpen those reflexes.",
            RAT = "Not bad, not bad.",
            BURNT = "It's torched.",
        },
        YOTC_CARRAT_GYM_STAMINA = 
        {
            GENERIC = "This'll help with my Carrat's stamina.",
            RAT = "He's giving it his best.",
            BURNT = "It's torched.",
        }, 

        YOTC_CARRAT_GYM_DIRECTION_ITEM = "We don't want him to lose his sense of direction.",
        YOTC_CARRAT_GYM_SPEED_ITEM = "Speed is key.",
        YOTC_CARRAT_GYM_STAMINA_ITEM = "This'll help with my Carrat's stamina.",
        YOTC_CARRAT_GYM_REACTION_ITEM = "Gotta sharpen those reflexes.",

        YOTC_CARRAT_SCALE_ITEM = "Let's see your progress, Carrat...",           
        YOTC_CARRAT_SCALE = 
        {
            GENERIC = "Let's see your progress, Carrat...",        
            CARRAT = "Eeeh... he could use the extra training.",
            CARRAT_GOOD = "We actually have a good chance of winning this.",
            BURNT = "Burnt...",
        },                

		BISHOP_CHARGE_HIT = "Nargh!",
		TRUNKVEST_SUMMER = "Nosy coat.",
		TRUNKVEST_WINTER = "So fluffy and warm!",
		TRUNK_COOKED = "At least I got rid of all the nose hair.",
		TRUNK_SUMMER = "This is heavy.",
		TRUNK_WINTER = "Heavy and furry.",
		TUMBLEWEED = "Stop that tumbleweed!",
		TURKEYDINNER = "That's what you get for eating my berries.",
		TWIGS = "Very sturdy for a bunch of sticks.",
		UMBRELLA = "I hate it when my glasses get wet.",
		GRASS_UMBRELLA = "Protection from rain with style.",
		UNIMPLEMENTED = "It's... something?",
		WAFFLES = "I would even eat them for dinner.",
		WALL_HAY = 
		{	
			GENERIC = "It's better than nothing.",
			BURNT = "That won't help anyone.",
		},
		WALL_HAY_ITEM = "It's better than nothing.",
		WALL_STONE = "Now that's a good wall!",
		WALL_STONE_ITEM = "Now that's a good wall!",
		WALL_RUINS = "Nothing's gonna break through that!",
		WALL_RUINS_ITEM = "Nothing's gonna break through that!",
		WALL_WOOD = 
		{
			GENERIC = "It's an upgrade from grass walls.",
			BURNT = "That won't help anyone.",
		},
		WALL_WOOD_ITEM = "It's an upgrade from grass walls.",
		WALL_MOONROCK = "Protection at its finest.",
		WALL_MOONROCK_ITEM = "Total lunacy.",
		FENCE = "It's just a fence.",
        FENCE_ITEM = "It's just a fence.",
        FENCE_GATE = "How else will I get in and out?",
        FENCE_GATE_ITEM = "How else will I get in and out?",
		WALRUS = "You're very grumpy, sir!",
		WALRUSHAT = "I'm loving this plaid's design.",
		WALRUS_CAMP =
		{
			EMPTY = "Somebody was living here.",
			GENERIC = "When did they manage to build that igloo?",
		},
		WALRUS_TUSK = "You should brush your teeth better.",
		WARDROBE = 
		{
			GENERIC = "It holds all my clothes.",
            BURNING = "Noooo!",
			BURNT = "What a shame.",
		},
		WARG = "I'd rather keep my distance.",
		WASPHIVE = "It's got the word \"Killer\" on it, what do you think will happen??",
		WATERBALLOON = "Water fight!",
		WATERMELON = "Watermelon is great on a hot summer day.",
		WATERMELON_COOKED = "That's really good!",
		WATERMELONHAT = "That's what I call being creative.",
		WAXWELLJOURNAL = "Those illustrations must've been made by a professional.",
		WETGOOP = "I shouldn't eat that.",
        WHIP = "This is very cruel.",
		WINTERHAT = "At least my head is ready for winter.",
		WINTEROMETER = 
		{
			GENERIC = "Should I get my coat or my fan?",
			BURNT = "I'm guessing it's getting real hot.",
		},

        WINTER_TREE =
        {
            BURNT = "What a disaster.",
            BURNING = "Fire, the tree if on fire!!",
            CANDECORATE = "Aah, I love the holidays.",
            YOUNG = "It's almost grown.",
        },
		WINTER_TREESTAND = 
		{
			GENERIC = "We need to get a tree first.",
            BURNT = "What a disaster.",
		},
        WINTER_ORNAMENT = "I better be careful not to drop this.",
        WINTER_ORNAMENTLIGHT = "Can we hand some blue lights on the tree?",
        WINTER_ORNAMENTBOSS = "This one is special.",
		WINTER_ORNAMENTFORGE = "Aaw, it brings back memories.",
		WINTER_ORNAMENTGORGE = "I wonder where they are now?",

        WINTER_FOOD1 = "Mmmm! I love all cookies.", --gingerbread cookie
        WINTER_FOOD2 = "Mmmm! I love all cookies.", --sugar cookie
        WINTER_FOOD3 = "I just chew these.", --candy cane
        WINTER_FOOD4 = "It's harder than a rock!", --fruitcake
        WINTER_FOOD5 = "I'll have the whole thing.", --yule log cake
        WINTER_FOOD6 = "I love eating pudding on the holidays.", --plum pudding (UPDATED)
        WINTER_FOOD7 = "Watch me chug this whole thing down.", --apple cider
        WINTER_FOOD8 = "Aaaah!", --hot cocoa
        WINTER_FOOD9 = "Watch me chug this whole thing down.", --eggnog

		WINTERSFEASTOVEN =
		{
			GENERIC = "Reserved only for holiday meals.",
			COOKING = "Might as well doodle while I wait.",
			ALMOST_DONE_COOKING = "It's almost ready.",
			DISH_READY = "Who's ready for some good food?",
		},
		BERRYSAUCE = "Berry nice.",
		BIBINGKA = "That's pretty tasty!",
		CABBAGEROLLS = "It's not that bad for cabbage.",
		FESTIVEFISH = "Even the fish can enjoy the holidays.",
		GRAVY = "Good gravy...",
		LATKES = "Mmmm!",
		LUTEFISK = "I hope everyone's ready to eat.",
		MULLEDDRINK = "If it weren't for the holidays, I'd have this all for myself.",
		PANETTONE = "Delicious!",
		PAVLOVA = "This is great!",
		PICKLEDHERRING = "Who wants some?",
		POLISHCOOKIE = "These are so good, I might eat them all by myself.",
		PUMPKINPIE = "Who wants a slice?",
		ROASTTURKEY = "How's this supposed to feed a full table of people?",
		STUFFING = "Just the stuffing?",
		SWEETPOTATO = "I'll have it casserole. Hahaha!",
		TAMALES = "Yum!",
		TOURTIERE = "Good old meat pie.",

		TABLE_WINTERS_FEAST = 
		{
			GENERIC = "It's smaller than the family table.",
			HAS_FOOD = "Hope you're all hungry!",
			WRONG_TYPE = "Not the season for that.",
			BURNT = "What a disaster!",
		},

		GINGERBREADWARG = "That gingerbread is likely to eat ME!", 
		GINGERBREADHOUSE = "These houses are so adorable!", 
		GINGERBREADPIG = "Hey, where are you going?",
		CRUMBS = "You can't hide from me!",
		WINTERSFEASTFUEL = "Oooh, what's this?",

        KLAUS = "I'd prefer it if he was Santa Claus.",	-- UPDATED
        KLAUS_SACK = "Who just leaves their stuff laying about?",
		KLAUSSACKKEY = "This key ought to do the trick.",
		WORMHOLE =
		{
			GENERIC = "What is that weird moving mass over there?",
			OPEN = "Eeerr... those teeth look sharp.",
		},
		WORMHOLE_LIMITED = "I hope I don't catch a disease from that thing.",
		ACCOMPLISHMENT_SHRINE = "It's simple to use, just turn that little gear.",        
		LIVINGTREE = "Creepy, looks like something out of a Tim Burton film.",
		ICESTAFF = "A frigid ice launcher.",
		REVIVER = "I haven't had much experience with drawing hearts.",
		SHADOWHEART = "Looking at it makes me feel... sad.",
        ATRIUM_RUBBLE = 
        {
			LINE_1 = "Whatever those things are they look hungry.",
			LINE_2 = "Hmph. Somebody did a very bad job drawing this one.",
			LINE_3 = "A menacing black mass is surrounding the people.",
			LINE_4 = "They're transforming, they look in pain!",
			LINE_5 = "They seem to be thriving with their newly-found power.",
		},
        ATRIUM_STATUE = "I don't like this place, I don't like it one bit...",
        ATRIUM_LIGHT = 
        {
			ON = "At least I'm not in the dark anymore.",
			OFF = "Where's the switch to this thing?",
		},
        ATRIUM_GATE =
        {
			ON = "I have a bad feeling about this.",
			OFF = "It has a big hole in the middle, probably for a key.",
			CHARGING = "It's charging up!",
			DESTABILIZING = "It's-It's out of control!!",
			COOLDOWN = "Ow! It's hot, must've overheated.",
        },
        ATRIUM_KEY = "I can feel a strange power emanating from it.",
		LIFEINJECTOR = "Not a big fan of needles.",
		SKELETON_PLAYER =
		{
			MALE = "%s was erased from this world by %s.",
			FEMALE = "%s was erased from this world by %s.",
			ROBOT = "%s was erased from this world by %s.",
			DEFAULT = "%s was erased from this world by %s.",
		},
		HUMANMEAT = "N-no, just no.",
		HUMANMEAT_COOKED = "Urk, why'd I even cook this?!",
		HUMANMEAT_DRIED = "This violates so many laws.",
		ROCK_MOON = "Good thing it didn't land on my head!",
		MOONROCKNUGGET = "I love the way it glimmers in the moonlight.",
		MOONROCKCRATER = "A gem would look real nice in there.",
		MOONROCKSEED = "How does it levitate like that??",

        REDMOONEYE = "It's staring at me with a burning passion.",
        PURPLEMOONEYE = "I don't like the way it's looking at me.",
        GREENMOONEYE = "I know a friend with green eyes, beautiful.",
        ORANGEMOONEYE = "It's really stuck in there. I don't think I can get it out.",
        YELLOWMOONEYE = "This should help the others find the way.",
        BLUEMOONEYE = "It has a very cold stare.",

        --Arena Event
        LAVAARENA_BOARLORD = "That's the guy in charge here.",
        BOARRIOR = "You sure are big!",
        BOARON = "I can take him!",
        PEGHOOK = "That spit is corrosive!",
        TRAILS = "He's got a strong arm on him.",
        TURTILLUS = "Its shell is so spiky!",
        SNAPPER = "This one's got bite.",
		RHINODRILL = "He's got a nose for this kind of work.",
		BEETLETAUR = "I can smell him from here!",

        LAVAARENA_PORTAL = 
        {
            ON = "I'll just be going now.",
            GENERIC = "That's how we got here. Hopefully how we get back, too.",
        },
        LAVAARENA_KEYHOLE = "It needs a key.",
		LAVAARENA_KEYHOLE_FULL = "That should do it.",
        LAVAARENA_BATTLESTANDARD = "Everyone, break the Battle Standard!",
        LAVAARENA_SPAWNER = "This is where those enemies are coming from.",

        HEALINGSTAFF = "It conducts regenerative energy.",
        FIREBALLSTAFF = "It calls a meteor from above.",
        HAMMER_MJOLNIR = "It's a heavy hammer for hitting things.",
        SPEAR_GUNGNIR = "I could do a quick charge with that.",
        BLOWDART_LAVA = "That's a weapon I could use from range.",
        BLOWDART_LAVA2 = "It uses a strong blast of air to propel a projectile.",
        LAVAARENA_LUCY = "That weapon's for throwing.",
        WEBBER_SPIDER_MINION = "I guess they're fighting for us.",
        BOOK_FOSSIL = "This'll keep those monsters held for a little while.",
		LAVAARENA_BERNIE = "He might make a good distraction for us.",
		SPEAR_LANCE = "It gets to the point.",
		BOOK_ELEMENTAL = "I can't make out the text.",
		LAVAARENA_ELEMENTAL = "It's a rock monster!",

   		LAVAARENA_ARMORLIGHT = "Light, but not very durable.",
		LAVAARENA_ARMORLIGHTSPEED = "Lightweight and designed for mobility.",
		LAVAARENA_ARMORMEDIUM = "It offers a decent amount of protection.",
		LAVAARENA_ARMORMEDIUMDAMAGER = "That could help me hit a little harder.",
		LAVAARENA_ARMORMEDIUMRECHARGER = "I'd have energy for a few more stunts wearing that.",
		LAVAARENA_ARMORHEAVY = "That's as good as it gets.",
		LAVAARENA_ARMOREXTRAHEAVY = "This armor has been petrified for maximum protection.",

		LAVAARENA_FEATHERCROWNHAT = "Those fluffy feathers make me want to run!",
        LAVAARENA_HEALINGFLOWERHAT = "The blossom interacts well with healing magic.",
        LAVAARENA_LIGHTDAMAGERHAT = "My strikes would hurt a little more wearing that.",
        LAVAARENA_STRONGDAMAGERHAT = "It looks like it packs a wallop.",
        LAVAARENA_TIARAFLOWERPETALSHAT = "Looks like it amplifies healing expertise.",
        LAVAARENA_EYECIRCLETHAT = "It has a gaze full of science.",
        LAVAARENA_RECHARGERHAT = "Those crystals will quicken my abilities.",
        LAVAARENA_HEALINGGARLANDHAT = "This garland will restore a bit of my vitality.",
        LAVAARENA_CROWNDAMAGERHAT = "That could cause some major destruction.",

		LAVAARENA_ARMOR_HP = "That should keep me safe.",

		LAVAARENA_FIREBOMB = "It smells like brimstone.",
		LAVAARENA_HEAVYBLADE = "A sharp looking instrument.",

        --Quagmire
        QUAGMIRE_ALTAR = 
        {
        	GENERIC = "We'd better start cooking some offerings.",
        	FULL = "It's in the process of digestinating.",
    	},
		QUAGMIRE_ALTAR_STATUE1 = "It's an old statue.",
		QUAGMIRE_PARK_FOUNTAIN = "Been a long time since it was hooked up to water.",
		
        QUAGMIRE_HOE = "It's a farming instrument.",
        
        QUAGMIRE_TURNIP = "It's a raw turnip.",
        QUAGMIRE_TURNIP_COOKED = "Cooking is science in practice.",
        QUAGMIRE_TURNIP_SEEDS = "Seeds of... some kind.",
        
        QUAGMIRE_GARLIC = "The number one breath enhancer.",
        QUAGMIRE_GARLIC_COOKED = "Perfectly browned.",
        QUAGMIRE_GARLIC_SEEDS = "Seeds of... some kind.",
        
        QUAGMIRE_ONION = "Looks crunchy.",
        QUAGMIRE_ONION_COOKED = "A successful chemical reaction.",
        QUAGMIRE_ONION_SEEDS = "Seeds of... some kind.",
        
        QUAGMIRE_POTATO = "The apples of the earth.",
        QUAGMIRE_POTATO_COOKED = "A successful temperature experiment.",
        QUAGMIRE_POTATO_SEEDS = "Seeds of... some kind.",
        
        QUAGMIRE_TOMATO = "It's red because it's full of science.",
        QUAGMIRE_TOMATO_COOKED = "Cooking's easy if you understand chemistry.",
        QUAGMIRE_TOMATO_SEEDS = "Seeds of... some kind.",
        
        QUAGMIRE_FLOUR = "Ready for baking.",
        QUAGMIRE_WHEAT = "It looks a bit grainy.",
        QUAGMIRE_WHEAT_SEEDS = "Seeds of... some kind.",
        --NOTE: raw/cooked carrot uses regular carrot strings
        QUAGMIRE_CARROT_SEEDS = "Seeds of... some kind.",
        
        QUAGMIRE_ROTTEN_CROP = "I don't think the altar will want that.",
        
		QUAGMIRE_SALMON = "Mm, fresh fish.",
		QUAGMIRE_SALMON_COOKED = "Ready for the dinner table.",
		QUAGMIRE_CRABMEAT = "No imitations here.",
		QUAGMIRE_CRABMEAT_COOKED = "I can put a meal together in a pinch.",
		QUAGMIRE_SUGARWOODTREE = 
		{
			GENERIC = "It's full of delicious, delicious sap.",
			STUMP = "Where'd the tree go? I'm stumped.",
			TAPPED_EMPTY = "Here sappy, sappy, sap.",
			TAPPED_READY = "Sweet golden sap.",
			TAPPED_BUGS = "That's how you get ants.",
			WOUNDED = "It looks ill.",
		},
		QUAGMIRE_SPOTSPICE_SHRUB = 
		{
			GENERIC = "It reminds me of those tentacle monsters.",
			PICKED = "I can't get anymore out of that shrub.",
		},
		QUAGMIRE_SPOTSPICE_SPRIG = "I could grind it up to make a spice.",
		QUAGMIRE_SPOTSPICE_GROUND = "Flavorful.",
		QUAGMIRE_SAPBUCKET = "We can use it to gather sap from the trees.",
		QUAGMIRE_SAP = "It tastes sweet.",
		QUAGMIRE_SALT_RACK =
		{
			READY = "Salt has gathered on the rope.",
			GENERIC = "Science takes time.",
		},
		
		QUAGMIRE_POND_SALT = "A little salty spring.",
		QUAGMIRE_SALT_RACK_ITEM = "For harvesting salt from the pond.",

		QUAGMIRE_SAFE = 
		{
			GENERIC = "It's a safe. For keeping things safe.",
			LOCKED = "It won't open without the key.",
		},

		QUAGMIRE_KEY = "Safe bet this'll come in handy.",
		QUAGMIRE_KEY_PARK = "I'll park it in my pocket until I get to the park.",
        QUAGMIRE_PORTAL_KEY = "This looks science-y.",

		
		QUAGMIRE_MUSHROOMSTUMP =
		{
			GENERIC = "Are those mushrooms? I'm stumped.",
			PICKED = "I don't think it's growing back.",
		},
		QUAGMIRE_MUSHROOMS = "These are edible mushrooms.",
        QUAGMIRE_MEALINGSTONE = "The daily grind.",
		QUAGMIRE_PEBBLECRAB = "That rock's alive!",

		
		QUAGMIRE_RUBBLE_CARRIAGE = "On the road to nowhere.",
        QUAGMIRE_RUBBLE_CLOCK = "Someone beat the clock. Literally.",
        QUAGMIRE_RUBBLE_CATHEDRAL = "Preyed upon.",
        QUAGMIRE_RUBBLE_PUBDOOR = "No longer a-door-able.",
        QUAGMIRE_RUBBLE_ROOF = "Someone hit the roof.",
        QUAGMIRE_RUBBLE_CLOCKTOWER = "That clock's been punched.",
        QUAGMIRE_RUBBLE_BIKE = "Must have mis-spoke.",
        QUAGMIRE_RUBBLE_HOUSE =
        {
            "No one's here.",
            "Something destroyed this town.",
            "I wonder who they angered.",
        },
        QUAGMIRE_RUBBLE_CHIMNEY = "Something put a damper on that chimney.",
        QUAGMIRE_RUBBLE_CHIMNEY2 = "Something put a damper on that chimney.",
        QUAGMIRE_MERMHOUSE = "What an ugly little house.",
        QUAGMIRE_SWAMPIG_HOUSE = "It's seen better days.",
        QUAGMIRE_SWAMPIG_HOUSE_RUBBLE = "Some pig's house was ruined.",
        QUAGMIRE_SWAMPIGELDER =
        {
            GENERIC = "I guess you're in charge around here?",
            SLEEPING = "It's sleeping, for now.",
        },
        QUAGMIRE_SWAMPIG = "It's a super hairy pig.",
        
        QUAGMIRE_PORTAL = "Another dead end.",
        QUAGMIRE_SALTROCK = "Salt. The tastiest mineral.",
        QUAGMIRE_SALT = "It's full of salt.",
        --food--
        QUAGMIRE_FOOD_BURNT = "That one was an experiment.",
        QUAGMIRE_FOOD =
        {
        	GENERIC = "I should offer it on the Altar of Gnaw.",
            MISMATCH = "That's not what it wants.",
            MATCH = "Science says this will appease the sky God.",
            MATCH_BUT_SNACK = "It's more of a light snack, really.",
        },
        
        QUAGMIRE_FERN = "Probably chock full of vitamins.",
        QUAGMIRE_FOLIAGE_COOKED = "We cooked the foliage.",
        QUAGMIRE_COIN1 = "I'd like more than a penny for my thoughts.",
        QUAGMIRE_COIN2 = "A decent amount of coin.",
        QUAGMIRE_COIN3 = "Seems valuable.",
        QUAGMIRE_COIN4 = "We can use these to reopen the Gateway.",
        QUAGMIRE_GOATMILK = "Good if you don't think about where it came from.",
        QUAGMIRE_SYRUP = "Adds sweetness to the mixture.",
        QUAGMIRE_SAP_SPOILED = "Might as well toss it on the fire.",
        QUAGMIRE_SEEDPACKET = "Sow what?",
        
        QUAGMIRE_POT = "This pot holds more ingredients.",
        QUAGMIRE_POT_SMALL = "Let's get cooking!",
        QUAGMIRE_POT_SYRUP = "I need to sweeten this pot.",
        QUAGMIRE_POT_HANGER = "It has hang-ups.",
        QUAGMIRE_POT_HANGER_ITEM = "For suspension-based cookery.",
        QUAGMIRE_GRILL = "Now all I need is a backyard to put it in.",
        QUAGMIRE_GRILL_ITEM = "I'll have to grill someone about this.",
        QUAGMIRE_GRILL_SMALL = "Barbecurious.",
        QUAGMIRE_GRILL_SMALL_ITEM = "For grilling small meats.",
        QUAGMIRE_OVEN = "It needs ingredients to make the science work.",
        QUAGMIRE_OVEN_ITEM = "For scientifically burning things.",
        QUAGMIRE_CASSEROLEDISH = "A dish for all seasonings.",
        QUAGMIRE_CASSEROLEDISH_SMALL = "For making minuscule motleys.",
        QUAGMIRE_PLATE_SILVER = "A silver plated plate.",
        QUAGMIRE_BOWL_SILVER = "A bright bowl.",
        QUAGMIRE_CRATE = "Kitchen stuff.",
        
        QUAGMIRE_MERM_CART1 = "Any science in there?", --sammy's wagon
        QUAGMIRE_MERM_CART2 = "I could use some stuff.", --pipton's cart
        QUAGMIRE_PARK_ANGEL = "Take that, creature!",
        QUAGMIRE_PARK_ANGEL2 = "So lifelike.",
        QUAGMIRE_PARK_URN = "Ashes to ashes.",
        QUAGMIRE_PARK_OBELISK = "A monumental monument.",
        QUAGMIRE_PARK_GATE =
        {
            GENERIC = "Turns out a key was the key to getting in.",
            LOCKED = "Locked tight.",
        },
        QUAGMIRE_PARKSPIKE = "The scientific term is: \"Sharp pointy thing\".",
        QUAGMIRE_CRABTRAP = "A crabby trap.",
        QUAGMIRE_TRADER_MERM = "Maybe they'd be willing to trade.",
        QUAGMIRE_TRADER_MERM2 = "Maybe they'd be willing to trade.",
        
        QUAGMIRE_GOATMUM = "Reminds me of my old nanny.",
        QUAGMIRE_GOATKID = "This goat's much smaller.",
        QUAGMIRE_PIGEON =
        {
            DEAD = "They're dead.",
            GENERIC = "He's just winging it.",
            SLEEPING = "It's sleeping, for now.",
        },
        QUAGMIRE_LAMP_POST = "Huh. Reminds me of home.",

        QUAGMIRE_BEEFALO = "Science says it should have died by now.",
        QUAGMIRE_SLAUGHTERTOOL = "Laboratory tools for surgical butchery.",

        QUAGMIRE_SAPLING = "I can't get anything else out of that.",
        QUAGMIRE_BERRYBUSH = "Those berries are all gone.",

        QUAGMIRE_ALTAR_STATUE2 = "What are you looking at?",
        QUAGMIRE_ALTAR_QUEEN = "A monumental monument.",
        QUAGMIRE_ALTAR_BOLLARD = "As far as posts go, this one is adequate.",
        QUAGMIRE_ALTAR_IVY = "Kind of clingy.",

        QUAGMIRE_LAMP_SHORT = "Enlightening.",

        --v2 Winona
        WINONA_CATAPULT = 
        {
        	GENERIC = "I feel much safer with Winona's gadgets protecting our base.",	-- UPDATED
        	OFF = "Needs new batteries.",
        	BURNING = "Fire! Somebody do something!",
        	BURNT = "I hope Winona won't get too mad.",
        },
        WINONA_SPOTLIGHT = 
        {
        	GENERIC = "I was never cut out for the spotlight.",
        	OFF = "Needs new batteries.",
        	BURNING = "Fire! Somebody do something!",
        	BURNT = "I hope Winona won't get too mad.",
        },
        WINONA_BATTERY_LOW = 
        {
        	GENERIC = "A bit rickety, but it works like a charm.",
        	LOWPOWER = "It's running low on juice.",
        	OFF = "I could charge it up for her.",
        	BURNING = "Fire! Somebody do something!",
        	BURNT = "I hope Winona won't get too mad.",
        },
        WINONA_BATTERY_HIGH = 
        {
        	GENERIC = "Now THIS is a generator!",
        	LOWPOWER = "It's running low on juice.",
        	OFF = "I could charge it up for her.",
        	BURNING = "Fire! Somebody do something!",
        	BURNT ="I hope Winona won't get too mad.",
        },

        --Wormwood
        COMPOSTWRAP = "I'll leave that to Wormwood.",
        ARMOR_BRAMBLE = "I must remember not to wear it inside out.",
        TRAP_BRAMBLE = "Weaponized plants.",

        BOATFRAGMENT03 = "I hope my boat doesn't end up like that.",
        BOATFRAGMENT04 = "I hope my boat doesn't end up like that.",
        BOATFRAGMENT05 = "I hope my boat doesn't end up like that.",
		BOAT_LEAK = "I should stop dawdling and fix that quickly!!",
        MAST = "Ready to set sail!",
        SEASTACK = "I'd rather avoid crashing into that.",
        FISHINGNET = "Those fish won't know what hit 'em.",
        ANTCHOVIES = "They're so tiny.",
        STEERINGWHEEL = "The sea is ours to explore.",
        ANCHOR = "I mustn't forget to drop anchor.",
        BOATPATCH = "I'll grab a couple more, just to be safe.",
        DRIFTWOOD_TREE = 
        {
            BURNING = "That's burning fast!",
            BURNT = "Nothing but charcoal now.",
            CHOPPED = "Might as well dig that up.",
            GENERIC = "You're a long way from home.",
        },

        DRIFTWOOD_LOG = "Destined to drift in the sea forever.",

        MOON_TREE = 
        {
            BURNING = "Nooo!",
            BURNT = "Shoot...",
            CHOPPED = "That was really hard to cut down.",
            GENERIC = "This place is... captivating...",
        },
		MOON_TREE_BLOSSOM = "They keep dropping from those trees.",

        MOONBUTTERFLY = 
        {
        	GENERIC = "Look at it glow!",
        	HELD = "Your wings are beautiful.",
        },
		MOONBUTTERFLYWINGS = "Oh, darn it! I did it again.",
        MOONBUTTERFLY_SAPLING = "A tree growing from butterflies?? What?!",
        ROCK_AVOCADO_FRUIT = "I'd keep my teeth intact.",
        ROCK_AVOCADO_FRUIT_RIPE = "It actually tastes kinda nice.",
        ROCK_AVOCADO_FRUIT_RIPE_COOKED = "I removed the pit.",
        ROCK_AVOCADO_FRUIT_SPROUT = "This one is sprouting.",
        ROCK_AVOCADO_BUSH = 
        {
			BARREN = "I have to fertilize it first.",
			WITHERED = "Hopefully the weather will get cooler soon.",
			GENERIC = "Are those rocks?",
			PICKED = "I got a handful of rocks from that bush. Confused yet?",
			DISEASED = "Its condition has worsened.",
			DISEASING = "It doesn't look very well...",
			BURNING = "Fire, it's on fire!",
		},
        DEAD_SEA_BONES = "How'd these end up ashore?",
        HOTSPRING = 
        {
        	GENERIC = "A little too hot for a bath.",
        	BOMBED = "That smells really nice.",
        	GLASS = "It turned to glass!",
			EMPTY = "It's empty now, how does it fill back up?",
        },
        MOONGLASS = "Better be careful not to cut myself.",
        MOONGLASS_ROCK = "This place is filled with glass, I'd best watch my step.",
        BATHBOMB = "I should throw it in one of those springs.",
        TRAP_STARFISH =
        {
            GENERIC = "That's a big starfish.",
            CLOSED = "It almost bit off my leg!",
        },
        DUG_TRAP_STARFISH = "You won't chomp me this time!",
        SPIDER_MOON = 
        {
        	GENERIC = "Look at that, it's a nightmare.",
        	SLEEPING = "Time for me to run.",
        	DEAD = "Don't get up, please.",
        },
        MOONSPIDERDEN = "Are those... legs?",
		FRUITDRAGON =
		{
			GENERIC = "I'd like to take one of those home.",
			RIPE = "You look fierce.",
			SLEEPING = "Aaaaw, how can you get even cuter??",
		},
        PUFFIN =
        {
            GENERIC = "Oh, I love these bird's colored beaks.",
            HELD = "Bulky, aren't you?",
            SLEEPING = "It's having a little nap.",
        },

		MOONGLASSAXE = "How does it not shatter in one hit?",
		GLASSCUTTER = "I guess moon glass is very durable.",

        ICEBERG =
        {
            GENERIC = "I don't want to end up like the Titanic.",
            MELTED = "It's just a puddle in the sea. Confused?",
        },
        ICEBERG_MELTED = "It's just a puddle in the sea. Confused?",

        MINIFLARE = "I can use this if I ever get lost.",

		MOON_FISSURE = 
		{
			GENERIC = "It makes me feel at peace when I'm sitting next to it.", 
			NOLIGHT = "Huh, I guess there's no light today.",
		},
        MOON_ALTAR =
        {
            MOON_ALTAR_WIP = "It's begging me to finish it.",
            GENERIC = "A way back home, you say?",
        },

        MOON_ALTAR_IDOL = "I must find its other pieces.",
        MOON_ALTAR_GLASS = "It wants me to assemble it.",
        MOON_ALTAR_SEED = "A home? Where's you home?",

        MOON_ALTAR_ROCK_IDOL = "I can hear it calling to me.",
        MOON_ALTAR_ROCK_GLASS = "I can hear it calling to me.",
        MOON_ALTAR_ROCK_SEED = "I can hear it calling to me.",

        MOON_ALTAR_CROWN = "I should take this back to the moon.",
        MOON_ALTAR_COSMIC = "Now we play the Waiting Game...",	--TODO (When it gets more uses)

        MOON_ALTAR_ASTRAL = "Yet another one of these things?",
        MOON_ALTAR_ICON = "Back to the moon I go.",
        MOON_ALTAR_WARD = "I should find its other piece.",        

        SEAFARING_PROTOTYPER =
        {
            GENERIC = "I've never been a sailor, I guess today's the day.",
            BURNT = "Oops.",
        },
        BOAT_ITEM = "I should try catching a few fish whilst I'm out there.",
        STEERINGWHEEL_ITEM = "The sea is ours to explore.",
        ANCHOR_ITEM = "I mustn't forget to drop anchor. Or place this down.",
        MAST_ITEM = "Ready to set sail! As soon as I put this down.",
        MUTATEDHOUND = 
        {
        	DEAD = "Please, no more.",
        	GENERIC = "I am not sleeping tonight!!",
        	SLEEPING = "Run, legs, run!",
        },

        MUTATED_PENGUIN = 
        {
			DEAD = "Please, no more.",
			GENERIC = "I can see its insides!",
			SLEEPING = "Time for me to get outta here.",
		},
        CARRAT = 
        {
        	DEAD = "Poor little guy.",
        	GENERIC = "Hey, you're kinda cute.",
        	HELD = "Eeer... cute-ish.",
        	SLEEPING = "Sleep tight.",
        },

		BULLKELP_PLANT = 
        {
            GENERIC = "I'll kelp myself to some of it. Hahaha!",
            PICKED = "I already took it.",
        },
		BULLKELP_ROOT = "I should plant it in the water if I want more kelp.",
        KELPHAT = "Great, now my glasses are soaked.",
		KELP = "I could make sushi with this!",
		KELP_COOKED = "It's still very wet.",
		KELP_DRIED = "Very salty.",

		GESTALT = "They're whispering to me...",
        GESTALT_GUARD = "I should keep my distance if I don't want to get hurt.",

		COOKIECUTTER = "My boat is not your dinner!",
		COOKIECUTTERSHELL = "I told you to leave my boat alone.",
		COOKIECUTTERHAT = "A bit itchy.",
		SALTSTACK =
		{
			GENERIC = "I don't know if I want to risk it with all those things trying to eat my boat.",
			MINED_OUT = "I took it all. I'm a bit greedy, aren't I?",
			GROWING = "The salt grows back fast.",
		},
		SALTROCK = "I love salt on my food.",
		SALTBOX = "Keeps my food fresh and salty.",

		TACKLESTATION = "Love the dead fish smell to it.",
		TACKLESKETCH = "A mediocre sketch of a tackle.",

        MALBATROSS = "I'd love to draw you, but I'm currently trying to row away from here!",
        MALBATROSS_FEATHER = "Look at the size of that feather.",
        MALBATROSS_BEAK = "This just fell right off.",
        MAST_MALBATROSS_ITEM = "Now we're sailing with speed!",
        MAST_MALBATROSS = "Now we're sailing with speed!",
		MALBATROSS_FEATHERED_WEAVE = "I just want to cover myself with it and sleep.",

        GNARWAIL =
        {
            GENERIC = "Careful where you point that thing.",
            BROKENHORN = "Sorry about your nose!",
            FOLLOWER = "He's helping me catch fish.",
            BROKENHORN_FOLLOWER = "Forgive and forget.",
        },
        GNARWAIL_HORN = "I feel like a monster...",

        WALKINGPLANK = "I'd rather not.",
        OAR = "I was hoping we could build a mast or two.",
		OAR_DRIFTWOOD = "I was hoping we could build a mast or two.",

		OCEANFISHINGROD = "Now this is for serious deep-sea fishing.",
		OCEANFISHINGBOBBER_NONE = "I should get myself a bobber.",
        OCEANFISHINGBOBBER_BALL = "Nice bobber.",
        OCEANFISHINGBOBBER_OVAL = "Nice bobber.",
		OCEANFISHINGBOBBER_CROW = "A jet black bobber.",
		OCEANFISHINGBOBBER_ROBIN = "A crimson red bobber.",
		OCEANFISHINGBOBBER_ROBIN_WINTER = "An azure white bobber.",
		OCEANFISHINGBOBBER_CANARY = "A saffron yellow bobber.",
		OCEANFISHINGBOBBER_GOOSE = "A bobber from a goose's feather",
		OCEANFISHINGBOBBER_MALBATROSS = "Those fish don't stand a chance.",

		OCEANFISHINGLURE_SPINNER_RED = "This should help attract fish.",
		OCEANFISHINGLURE_SPINNER_GREEN = "This should help attract fish.",
		OCEANFISHINGLURE_SPINNER_BLUE = "This should help attract fish.",
		OCEANFISHINGLURE_SPOON_RED = "Only small fish will find this alluring.",
		OCEANFISHINGLURE_SPOON_GREEN = "Only small fish will find this alluring.",
		OCEANFISHINGLURE_SPOON_BLUE = "Only small fish will find this alluring.",
		OCEANFISHINGLURE_HERMIT_RAIN = "Best try fishing when it rains.",
		OCEANFISHINGLURE_HERMIT_SNOW = "This should help me catch more fish when it snows.",
		OCEANFISHINGLURE_HERMIT_DROWSY = "Something about it makes those fish drowsy.",
		OCEANFISHINGLURE_HERMIT_HEAVY = "So heavy, how does it not sink?",

		OCEANFISH_SMALL_1 = "You're so small, I feel bad.",
		OCEANFISH_SMALL_2 = "It's just a tiny fish.",
		OCEANFISH_SMALL_3 = "Itty bitty fishy.",
		OCEANFISH_SMALL_4 = "So tiny, what am I to do with you?",	-- UPDATED
		OCEANFISH_SMALL_5 = "Is it covered in butter??",
		OCEANFISH_SMALL_6 = "You almost fooled me with that leafy look.",
		OCEANFISH_SMALL_7 = "Smells like roses and salt water.",
		OCEANFISH_SMALL_8 = "I've never seen or heard of a fish like this.",
        OCEANFISH_SMALL_9 = "Stop spitting on me!",

		OCEANFISH_MEDIUM_1 = "It must like swimming in murky waters.",
		OCEANFISH_MEDIUM_2 = "I prefer the electric. Hahaha!",
		OCEANFISH_MEDIUM_3 = "It's kinda cute.",
		OCEANFISH_MEDIUM_4 = "I got a big one!",
		OCEANFISH_MEDIUM_5 = "Smells corny to me.",
		OCEANFISH_MEDIUM_6 = "Woah, I caught a good one!",
		OCEANFISH_MEDIUM_7 = "Woah, I caught a good one!",
		OCEANFISH_MEDIUM_8 = "My hands are freezing from holding it!",

		PONDFISH = "Smells fishy to me. Hahaha!",
		PONDEEL = "Eel cook it first. Haha!",

        FISHMEAT = "Better eat it fast before it spoils.",
        FISHMEAT_COOKED = "Seafood's my favorite!",
        FISHMEAT_SMALL = "It's just a small widdle bit of fish.",
        FISHMEAT_SMALL_COOKED = "I should've removed the bones.",
		SPOILED_FISH = "Yech!",

		FISH_BOX = "It's like a little pool for all my fish.",
        POCKET_SCALE = "Hope I caught a big one today.",

		TACKLECONTAINER = "At least now I don't have to keep them in my pockets.",
		SUPERTACKLECONTAINER = "At least now I don't have to keep them in my pockets.",

		TROPHYSCALE_FISH =
		{
			GENERIC = "Let's see what's the catch of the day.",
			HAS_ITEM = "Weight: {weight}\nCaught by: {owner}",
			HAS_ITEM_HEAVY = "Weight: {weight}\nCaught by: {owner}\nThat's a big one!",
			BURNING = "Not the fish!!",
			BURNT = "Shoot...",
			OWNER = "Would you look at that.\nWeight: {weight}\nCaught by: {owner}",
			OWNER_HEAVY = "Weight: {weight}\nCaught by: {owner}\nThat was a hard catch.",
		},

		OCEANFISHABLEFLOTSAM = "There might be something good among all that mud.",

		CALIFORNIAROLL = "Seafood is best food.",
		SEAFOODGUMBO = "Smells divine.",
		SURFNTURF = "A little bit of both.",

        WOBSTER_SHELLER = "You're so cute, I don't want to eat you.", 
        WOBSTER_DEN = "It's packed with lobsters.",
        WOBSTER_SHELLER_DEAD = "The poor thing!",
        WOBSTER_SHELLER_DEAD_COOKED = "No use letting it go to waste.",

        LOBSTERBISQUE = "Poor Wobster...",
        LOBSTERDINNER = "The fact that they have to boil alive has put a damper on my appetite...",

        WOBSTER_MOONGLASS = "What happened to you?",
        MOONGLASS_WOBSTER_DEN = "Is that... glass?",	-- UPDATED

		TRIDENT = "Somewhere out there, there are three Gnarwails without horns.",	-- UPDATED
		
		WINCH =
		{
			GENERIC = "Who knows what kinds of treasure lie underwater.",
			RETRIEVING_ITEM = "Here it comes!",
			HOLDING_ITEM = "What do we have here?",
		},

        HERMITHOUSE = {
            GENERIC = "It could use a bit of work.",
            BUILTUP = "There we go, it's looking a lot better.",
        }, 
        
        SHELL_CLUSTER = "She has a lot of shells to spare, I guess I can keep these.",	-- UPDATED
        --
		SINGINGSHELL_OCTAVE3 =
		{
			GENERIC = "Ding!",
		},
		SINGINGSHELL_OCTAVE4 =
		{
			GENERIC = "Tink!",
		},
		SINGINGSHELL_OCTAVE5 =
		{
			GENERIC = "Plonk!",
        },

        CHUM = "A meal fit for a fish.",

        SUNKENCHEST =
        {
            GENERIC = "Now we're living the life of a pirate!",
            LOCKED = "It needs a key? Aaaw.",
        },
        
        HERMIT_BUNDLE = "Aaw, there's no need to thank me.",
        HERMIT_BUNDLE_SHELLS = "Thanks for the shells.",

        RESKIN_TOOL = "I can never find time to clean up.",
        MOON_FISSURE_PLUGGED = "Why'd she plug it with a bunch of shells?",


		----------------------- ROT STRINGS GO ABOVE HERE ------------------

		-- Walter
        WOBYBIG = 
        {
            "Good to know Walter is feeding her regularly.",
            "Good to know Walter is feeding her regularly.",
        },
        WOBYSMALL = 
        {
            "She's a bundle of joy.",
            "She's a bundle of joy.",
        },
		WALTERHAT = "I'm more of an indoors person.",
		SLINGSHOT = "The primary weapon of a delinquent.",
		SLINGSHOTAMMO_ROCK = "Pebbles for a slingshot.",		
		SLINGSHOTAMMO_MARBLE = "Pebbles for a slingshot.",		
		SLINGSHOTAMMO_THULECITE = "Pebbles for a slingshot.",	
        SLINGSHOTAMMO_GOLD = "Pebbles for a slingshot.",	
        SLINGSHOTAMMO_SLOW = "Pebbles for a slingshot.",	
        SLINGSHOTAMMO_FREEZE = "Pebbles for a slingshot.",	
		SLINGSHOTAMMO_POOP = "Rounded poop pellets for a slingshot.",	
        PORTABLETENT = "It comes with its own pillow and blanket!",
        PORTABLETENT_ITEM = "Portable, very convenient if you ask me.",	-- UPDATED

        -- Wigfrid
        BATTLESONG_DURABILITY = "I can barely sing karaoke.",
        BATTLESONG_HEALTHGAIN = "I can barely sing karaoke.",
        BATTLESONG_SANITYGAIN = "I can barely sing karaoke.",
        BATTLESONG_SANITYAURA = "I can barely sing karaoke.",
        BATTLESONG_FIRERESISTANCE = "You DON'T want to hear my sing, trust me.",
        BATTLESONG_INSTANT_TAUNT = "You DON'T want to hear my sing, trust me.",
        BATTLESONG_INSTANT_PANIC = "You DON'T want to hear my sing, trust me.",
        
		-- Wendy
		GHOSTLYELIXIR_SLOWREGEN = "I best not mess with Wendy's things.",
		GHOSTLYELIXIR_FASTREGEN = "I best not mess with Wendy's things.",
		GHOSTLYELIXIR_SHIELD = "I best not mess with Wendy's things.",
		GHOSTLYELIXIR_ATTACK = "I best not mess with Wendy's things.",
		GHOSTLYELIXIR_SPEED = "I best not mess with Wendy's things.",
		GHOSTLYELIXIR_RETALIATION = "I best not mess with Wendy's things.",
		SISTURN =
		{
			GENERIC = "I should pay my respect with a few flowers.",
			SOME_FLOWERS = "It looks nice.",
			LOTS_OF_FLOWERS = "It looks very nice, Wendy.",
		},

        --Wortox
        WORTOX_SOUL = "only_used_by_wortox", --only wortox can inspect souls

        PORTABLECOOKPOT_ITEM =
        {
            GENERIC = "I'm a good cook, but not as good as Warly.",
            DONE = "Smells great, Warly!",

			COOKING_LONG = "Might as well doodle while I wait.",
			COOKING_SHORT = "Should be just about done.",
			EMPTY = "I'm a good cook, but not as good as Warly.",
        },
        
        PORTABLEBLENDER_ITEM = "Grinds our food into dust.",
        PORTABLESPICER_ITEM =
        {
            GENERIC = "I am not sure how it works.",
            DONE = "Thanks for that, Warly.",
        },
        SPICEPACK = "Warly's magic hat.",
        SPICE_GARLIC = "Phew! The smell of garlic is strong.",
        SPICE_SUGAR = "Tiny crystals of honey.",
        SPICE_CHILI = "Ssssspicy!",
        SPICE_SALT = "I'll have some on my food.",
        MONSTERTARTARE = "I think I'll eat something else, thanks.",
        FRESHFRUITCREPES = "Oho! Now this is breakfast!",	-- UPDATED
        FROGFISHBOWL = "Looks a bit undercooked.",
        POTATOTORNADO = "Jabbed potato lunch.",
        DRAGONCHILISALAD = "And here I thought curry was hot!",
        GLOWBERRYMOUSSE = "It glows in the dark.",
        VOLTGOATJELLY = "How did he use horns as food??",
        NIGHTMAREPIE = "It's... whispering to me.",
        BONESOUP = "I would never even think about using bones for a soup, this is great!",
        MASHEDPOTATOES = "I would've preferred french fries.",
        POTATOSOUFFLE = "It puffed up pretty nicely.",	-- UPDATED
        MOQUECA = "My favorite of Warly's cooking!",
        GAZPACHO = "Gulp!",
        ASPARAGUSSOUP = "Asparagus with a hint of more asparagus.",	-- UPDATED
        VEGSTINGER = "Mmmm, spicy.",
        BANANAPOP = "I'll pop it in my mouth.",
        CEVICHE = "Mmmm! That's good!",
        SALSA = "Hot! Hot! Hot!",
        PEPPERPOPPER = "The flavors just pop in your mouth!",

        TURNIP = "I remember drawing turnips in school to pass the time. A weird thing to draw, isn't it?",
        TURNIP_COOKED = "Cooked it up real good, I did.",
        TURNIP_SEEDS = "Seeds of... some kind.",
        
        GARLIC = "Keeps the vampires at bay.",
        GARLIC_COOKED = "I love the smell of cooked garlic.",
        GARLIC_SEEDS = "Seeds of... some kind.",
        
        ONION = "Ogres have layers, you know?",
        ONION_COOKED = "Chopped it up real good.",
        ONION_SEEDS = "Seeds of... some kind.",
        
        POTATO = "That's a nice spud.",
        POTATO_COOKED = "I could've made french fries, but okay.",
        POTATO_SEEDS = "Seeds of... some kind.",
        
        TOMATO = "I'm good at making tomato sauce.",	-- UPDATED
        TOMATO_COOKED = "I'm bleeding!- Oh wait, that's just the tomato. Phew!",
        TOMATO_SEEDS = "Seeds of... some kind.",

        ASPARAGUS = "Just a plain asparagus.", 
        ASPARAGUS_COOKED = "Could make a soup with it.",
        ASPARAGUS_SEEDS = "Seeds of... some kind.",

        PEPPER = "I dared <default> to eat it raw.",
        PEPPER_COOKED = "Now it's even spicier.",
        PEPPER_SEEDS = "Seeds of... some kind.",

        WEREITEM_BEAVER = "I should leave Woodie's stuff alone.",
        WEREITEM_GOOSE = "Not a bad wooden sculpture, Woodie.",
        WEREITEM_MOOSE = "Woodie carved it himself, he did a pretty good job.",

        MERMHAT = "Nobody will recognise me now.",
        MERMTHRONE =
        {
            GENERIC = "It's a nice carpet, could use a patch or two though.",
            BURNT = "It's beyond repair.",
        },        
        MERMTHRONE_CONSTRUCTION =
        {
            GENERIC = "What's going on here?",
            BURNT = "She'll have to start from scratch.",
        },        
        MERMHOUSE_CRAFTED = 
        {
            GENERIC = "She build all that by herself?",
            BURNT = "It's beyond repair.",
        },

        MERMWATCHTOWER_REGULAR = "They've got a job protecting the king.",
        MERMWATCHTOWER_NOKING = "They're out of a job.",
        MERMKING = "He certainly looks and smells like a King.",
        MERMGUARD = "Better not mess with these guys, they look serious.",
        MERM_PRINCE = "I guess he's next in line.",

        SQUID = "Hey, leave some fish for me!",

		GHOSTFLOWER = "Spooky ghost flowers.",
        SMALLGHOST = "You look a bit like Casper.",

        CRABKING = 
        {
            GENERIC = "This is how you treat someone after bringing you all those gems?!",
            INERT = "A castle like this could use a few gems.",
        },
		CRABKING_CLAW = "That thing is liable to snap my boat in half!",
		
		MESSAGEBOTTLE = "Who keeps throwing bottles in the water??",
		MESSAGEBOTTLEEMPTY = "This'd make a nice jar for jam.",

        MEATRACK_HERMIT =
        {
            DONE = "It's all dried up.",
            DRYING = "It still needs a bit of time.",
            DRYINGINRAIN = "This rain isn't helping things.",
            GENERIC = "Maybe I should give her a bit of meat I have laying around.",
            BURNT = "Darn it...",
            DONE_NOTMEAT = "It's all dried up.",
            DRYING_NOTMEAT = "It still needs a bit of time.",
            DRYINGINRAIN_NOTMEAT = "This rain isn't helping things.",
        },
        BEEBOX_HERMIT =
        {
			READY = "It's packed with honey.",
			FULLHONEY = "It's packed with honey.",
			GENERIC = "She did her best to build that.",
			NOHONEY = "I'll have to wait if I want more honey.",
			SOMEHONEY = "That's not a lot.",
			BURNT = "No! Not the honey!",
        },

        HERMITCRAB = "I take commissions if you want an artist.",

        HERMIT_PEARL = "I'll find him for you, Pearly.",
        HERMIT_CRACKED_PEARL = "Yikes, I'd hate to be the one who has to tell Pearly.",

        -- DSEAS
        WATERPLANT = "Your petals are beautiful!",
        WATERPLANT_BOMB = "They're attacking, quickly sail away!",
        WATERPLANT_BABY = "It hasn't fully grown to be terrifying just yet.",
        WATERPLANT_PLANTER = "I could plant more of those beautiful sea flowers.",

        SHARK = "Uh-oh, we're in deep trouble now.",

        MASTUPGRADE_LAMP_ITEM = "More room on the boat.",
        MASTUPGRADE_LIGHTNINGROD_ITEM = "Now the lightning won't sink my boat.",

        WATERPUMP = "I hope we won't have to use it.",

        BARNACLE = "They make a great snack if I cook them.",
        BARNACLE_COOKED = "Smells really good!",

        BARNACLEPITA = "This is good stuff!",
        BARNACLESUSHI = "Sushi, finally!",
        BARNACLINGUINE = "These barnacles are so tasty!",
        BARNACLESTUFFEDFISHHEAD = "The heads aren't that bad.",

        LEAFLOAF = "It's covered in jello.",
        LEAFYMEATBURGER = "Meat or vegetable, I'm eating it.",
        LEAFYMEATSOUFFLE = "Almost tastes like pudding.",
        MEATYSALAD = "That salad tastes an awful lot like meat.",

        -- GROTTO

		MOLEBAT = "Nosy, aren't you?",
        MOLEBATHILL = "Is that what they call a home?",

        BATNOSE = "Am I really thinking about eating this?",	-- UPDATED
        BATNOSE_COOKED = "I guess I really am eating this...",
        BATNOSEHAT = "Couldn't I use juice instead of milk?",

        MUSHGNOME = "He's just minding his own business.",

        SPORE_MOON = "They sporadically combust.",

        MOON_CAP = "I hope eating it doesn't mutate me...",
        MOON_CAP_COOKED = "It smells a bit like tea?",

        MUSHTREE_MOON = "All that strange water coming from the ceiling must've mutated it.",

        LIGHTFLIER = "Thanks for the free light, little guys.",	-- UPDATED

        GROTTO_POOL_BIG = "Only an insane person would think of swimming in that.",	-- UPDATED ("The pool's filled with sharp glass.")
        GROTTO_POOL_SMALL = "Only an insane person would think of swimming in that.",	-- UPDATED ("The pool's filled with sharp glass.")

        DUSTMOTH = "He's working hard at keeping this place tidy.",	--"I could really use one of these guys back home.",

        DUSTMOTHDEN = "It's sparkling clean.",

        ARCHIVE_LOCKBOX = "I hate puzzle boxes.",
        ARCHIVE_CENTIPEDE = "They really don't like people coming here!",
        ARCHIVE_CENTIPEDE_HUSK = "I feel better knowing it's not moving.",

        ARCHIVE_COOKPOT =
        {
			COOKING_LONG = "Might as well doodle while I wait.",
			COOKING_SHORT = "It should be just about done.",
			DONE = "Dinner time!",
			EMPTY = "This is the only thing covered in dust.",
			BURNT = "There was an accident in the kitchen.",
        },

        ARCHIVE_MOON_STATUE = "The two colors compliment each other quite beautifully.",	-- UPDATED
        ARCHIVE_RUNE_STATUE = 
        {
            LINE_1 = "This is probably important, but I'll never know.",
            LINE_2 = "I can't make heads or tails of it.",
            LINE_3 = "This is probably important, but I'll never know.",
            LINE_4 = "I can't make heads or tails of it.",
            LINE_5 = "This is probably important, but I'll never know.",
        },        

        ARCHIVE_RESONATOR = {
            GENERIC = "I should follow that bright arrow.",
            IDLE = "It seems I found everything.",	-- UPDATED
        },
        
        ARCHIVE_RESONATOR_ITEM = "Seems simple to use, just drop it on the floor.",

        ARCHIVE_LOCKBOX_DISPENCER = {
          POWEROFF = "How do I get this working?",
          GENERIC =  "Looks a bit like a water cooler.",
        },

        ARCHIVE_SECURITY_DESK = {
            POWEROFF = "What does this thing do?",
            GENERIC = "I'm not sure if that light is a good thing.",
        },

        ARCHIVE_SECURITY_PULSE = "I'm not sure if that light is a good thing.",

        ARCHIVE_SWITCH = {
            VALID = "That gem seemed to fit.",
            GEMS = "I need another one of those opal gems.",
        },

        ARCHIVE_PORTAL = {
            POWEROFF = "I need to find the switch to this thing.",
            GENERIC = "Huh, it's still not working for some reason.",	-- UPDATED
        },

        WALL_STONE_2 = "Aaw, these walls looks way better than the ones I made.",	-- UPDATED
        WALL_RUINS_2 = "Those little creatures are keeping these walls clean.",

        REFINED_DUST = "Now I have a pocketful of dust.",
        DUSTMERINGUE = "I know one creature who'd eat this.",

        SHROOMCAKE = "It's not much of a cake.",

        NIGHTMAREGROWTH = "I have a very bad feeling about this.",	-- UPDATED

        TURFCRAFTINGSTATION = "It's groundbreaking. Hahah!",

        MOON_ALTAR_LINK = "This seems incredibly important.",	--TODO (when a use for it comes out)

        -- FARMING
        COMPOSTINGBIN =
        {
            -- WIP, might not end up with these states so don't fill in for now
            GENERIC = "Smells like poop and rot.",
            WET = "It's too wet.",
            DRY = "Far too dry.",
            BALANCED = "That'd make for good fertilizer.",
            BURNT = "Ugh, the smell is worse now.",
        },
        COMPOST = "I hope the plants like it.",
        SOIL_AMENDER = 
		{ 
			GENERIC = "I should let it work its magic a bit before giving it to the plants.",
			STALE = "That smell is pungent.",
			SPOILED = "It's really starting to stink up the place.",
		},

		SOIL_AMENDER_FERMENTED = "It can't get smellier than this.",	-- UPDATED

        WATERINGCAN = 
        {
            GENERIC = "It's a can. For watering. The name says it all, you know?",
            EMPTY = "Empty, I should find a pond and fill it up.",
        },
        PREMIUMWATERINGCAN =
        {
            GENERIC = "It smells just a little bit fishy.",	-- UPDATED
            EMPTY = "Empty, I should find a pond and fill it up.",
        },

		FARM_PLOW = "I'll have a nice little garden to plant crops soon.",
		FARM_PLOW_ITEM = "Time to make a garden!",
		FARM_HOE = "Gonna need it if I want to plant some crops.",
		GOLDEN_FARM_HOE = "I hope the crops appreciate the extra effort I put into the tilling.",
		NUTRIENTSGOGGLESHAT = "Might as well learn a thing or two about my crops while I'm at it.",
		PLANTREGISTRYHAT = "I'll learn all there is to know about plants soon enough.",

        FARM_SOIL_DEBRIS = "All this stuff is messing up my beautiful garden!",	-- UPDATED

		FIRENETTLES = "Darn nettles!",
		FORGETMELOTS = "They have a pleasant, relaxing smell to them.",
		SWEETTEA = "Aaah, all my problems just float away.",
		TILLWEED = "Get outta my garden, nasty weeds!",
		TILLWEEDSALVE = "It's pretty effective at healing my wounds.",	-- UPDATED

		TROPHYSCALE_OVERSIZEDVEGGIES =
		{
			GENERIC = "I can show off my wonderful harvests on that.",	-- UPDATED
			HAS_ITEM = "Weight: {weight}\nHarvested on day: {day}\nI'm getting quite good at gardening.",	-- UPDATED
            HAS_ITEM_HEAVY = "Weight: {weight}\nHarvested on day: {day}\nMy poor, sprained back...",	-- UPDATED
            HAS_ITEM_LIGHT = "It's not really something to brag about.",
			BURNING = "Nooo, not the vegetables!",
			BURNT = "Shoot...",
        },
        
        CARROT_OVERSIZED = "The colors and the different sizes, they're picture perfect.",
        CORN_OVERSIZED = "I hope just being near it won't cause me to have an allergic reaction...",
        PUMPKIN_OVERSIZED = "Imagine the size of the pie I could make with that.",
        EGGPLANT_OVERSIZED = "That's a big aubergine.",
        DURIAN_OVERSIZED = "Bigger the size, worse the smell.",
        POMEGRANATE_OVERSIZED = "Cooking that up will be a pain.",
        DRAGONFRUIT_OVERSIZED = "How am I gonna carry that giant thing??",
        WATERMELON_OVERSIZED = "I can just roll it wherever I want it.",
        TOMATO_OVERSIZED = "It would make a lot of sauce.",
        POTATO_OVERSIZED = "Just think of all the french fries I could make with that.",
        ASPARAGUS_OVERSIZED = "I'll be eating asparagus for days...",
        ONION_OVERSIZED = "Those are a lot of layers.",
        GARLIC_OVERSIZED = "I'd like to see those vampires get me now!",
        PEPPER_OVERSIZED = "I didn't know peppers could grow this big.",
        
        VEGGIE_OVERSIZED_ROTTEN = "What a waste of good food.",

		FARM_PLANT =
		{
			GENERIC = "It's a little plant.",
			SEED = "This will take time.",	-- UPDATED
			GROWING = "Still growing.",
			FULL = "It's finally ready!",
			ROTTEN = "I should've harvested that when I had the chance.",
			FULL_OVERSIZED = "Woah! Look at the size of that crop!",
			ROTTEN_OVERSIZED = "What a waste of good food.",
			FULL_WEED = "Darn weeds have taken over my garden!",

			BURNING = "Noooo! Not the plants!",
        },
        
        FRUITFLY = "Oh no, you don't!",
        LORDFRUITFLY = "Stop messing with my crops!",
        FRIENDLYFRUITFLY = "Aaaw, it's taking good care of my crops.",
        FRUITFLYFRUIT = "That's what you get for messing with my plants.",

        SEEDPOUCH = "I was getting tired of carrying seeds on my pockets.",
		
		-- Crow Carnival
		CARNIVAL_HOST = "Such a classy guy.",
		CARNIVAL_CROWKID = "Hello there, birdie!",
		CARNIVAL_GAMETOKEN = "We're rich!",
		CARNIVAL_PRIZETICKET =
		{
			GENERIC = "What can this get me?",
			GENERIC_SMALLSTACK = "What can these get me?",
			GENERIC_LARGESTACK = "What can all of these get me?",
		},

		CARNIVALGAME_FEEDCHICKS_NEST = "There's a bird behind that door.",
		CARNIVALGAME_FEEDCHICKS_STATION =
		{
			GENERIC = "Looks like I need to bring some coins to play.",
			PLAYING = "Looks quite fun to me!",
		},
		CARNIVALGAME_FEEDCHICKS_KIT = "It's a bird in a box! I should place this somewhere first.",
		CARNIVALGAME_FEEDCHICKS_FOOD = "A handful of foodies for small bird mouths.",

		CARNIVALGAME_MEMORY_KIT = "I should place this somewhere first.",
		CARNIVALGAME_MEMORY_STATION =
		{
			GENERIC = "Looks like I need to bring some coins to play.",
			PLAYING = "I'll win this one for sure!",
		},
		CARNIVALGAME_MEMORY_CARD =
		{
			GENERIC = "It's a trap door.",
			PLAYING = "Think fast!",
		},

		CARNIVALGAME_HERDING_KIT = "An egg, huh? I should place this somewhere first.",
		CARNIVALGAME_HERDING_STATION =
		{
			GENERIC = "Looks like I need to bring some coins to play.",
			PLAYING = "These eggs are quite lively!",
		},
		CARNIVALGAME_HERDING_CHICK = "Don't be scared, I already had my breakfast!",

		CARNIVAL_PRIZEBOOTH_KIT = "I want to be rewarded for my efforts! I should place this somewhere.",
		CARNIVAL_PRIZEBOOTH =
		{
			GENERIC = "Hmm, what should I pick?",
		},

		CARNIVALCANNON_KIT = "A confetti cannon is something I can dig.",
		CARNIVALCANNON =
		{
			GENERIC = "Show me your true colors!",
			COOLDOWN = "Explosions?!",
		},

		CARNIVAL_PLAZA_KIT = "Let the festivities begin! I should place this somewhere first.",
		CARNIVAL_PLAZA =
		{
			GENERIC = "We need to make this place more festive. It leaves a bit to be desired.",
			LEVEL_2 = "We're going strong. This is going to be the best carnival ever, you'll see!",
			LEVEL_3 = "There we go! That there is a full-blown carnival!",
		},

		CARNIVALDECOR_EGGRIDE_KIT = "It's a carnival decoration. I should place it near the plaza.",
		CARNIVALDECOR_EGGRIDE = "Looks pretty nice, if you ask me.",

		CARNIVALDECOR_LAMP_KIT = "It's a carnival decoration. I should place it near the plaza.",
		CARNIVALDECOR_LAMP = "It looks like something out of a fairy tale.",
		CARNIVALDECOR_PLANT_KIT = "It's a carnival decoration. I should place it near the plaza.",
		CARNIVALDECOR_PLANT = "It's a cute bonsai tree!",

		CARNIVALDECOR_FIGURE =
		{
			RARE = "Oh, this one looks unusual! I wonder if it's worth something.",
			UNCOMMON = "It's an uncommon pattern, for sure.",
			GENERIC = "It's nice, I guess...",
		},
		CARNIVALDECOR_FIGURE_KIT = "It's a carnival decoration. I should place it near the plaza.",

        CARNIVAL_BALL = "Boing-boing.",
		CARNIVAL_SEEDPACKET = "Oh, a packet of corn seeds. Thanks.",
		CARNIVALFOOD_CORNTEA = "I don't think drinking this is a good idea...",

        CARNIVAL_VEST_A = "It's adventure time!",
        CARNIVAL_VEST_B = "Brings me waaay back. Like, way back to caveman times.",
        CARNIVAL_VEST_C = "Yabba-dabba-doo.",

        -- YOTB
        YOTB_SEWINGMACHINE = "Sewing is not exactly my forte, but I can give it a try...",
        YOTB_SEWINGMACHINE_ITEM = "Not quite ready for sewing yet. I should place this somewhere.",
        YOTB_STAGE = "Who even is that elder guy?",
        YOTB_POST =  "Now I'll need a Beefalo. And I don't think a drawn one will do here...",
        YOTB_STAGE_ITEM = "That's not very useful yet. I should place this somewhere.",
        YOTB_POST_ITEM =  "Hmm... I should place this somewhere.",


        YOTB_PATTERN_FRAGMENT_1 = "I could sew a couple of these together to make a custome for a Beefalo.",
        YOTB_PATTERN_FRAGMENT_2 = "I could sew a couple of these together to make a custome for a Beefalo.",
        YOTB_PATTERN_FRAGMENT_3 = "I could sew a couple of these together to make a custome for a Beefalo.",

        YOTB_BEEFALO_DOLL_WAR = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_DOLL = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_FESTIVE = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_NATURE = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_ROBOT = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_ICE = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_FORMAL = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_VICTORIAN = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },
        YOTB_BEEFALO_DOLL_BEAST = {
            GENERIC = "This fluffball is very fashionable.",
            YOTB = "I think the Judge would enjoy seeing this fluffball.",
        },

        WAR_BLUEPRINT = "This would make a Beefalo look beefy.",
        DOLL_BLUEPRINT = "It's such a cute costume!",
        FESTIVE_BLUEPRINT = "Is it christmas already?",
        ROBOT_BLUEPRINT = "It's a robot! Beep-boop.",
        NATURE_BLUEPRINT = "Smells like a freshly picked bouquet.",
        FORMAL_BLUEPRINT = "That's one classy costume.",
        VICTORIAN_BLUEPRINT = "Back to ye olde times we go.",
        ICE_BLUEPRINT = "That's pretty cool, I'm not gonna lie.",
        BEAST_BLUEPRINT = "This will make a Beefalo look like a beast!",

        BEEF_BELL = "It's time to make friends with a Beefalo.",

        -- Moon Storm
        ALTERGUARDIAN_PHASE1 = {
            GENERIC = "You're not very artistically pleasing, you know that?",
            DEAD = "It was ugly anyways.",
        },
        ALTERGUARDIAN_PHASE2 = {
            GENERIC = "It's gotten even more fierce now.",
            DEAD = "I got it this time, I think.",
        },
        ALTERGUARDIAN_PHASE2SPIKE = "These spikes HURT.",
        ALTERGUARDIAN_PHASE3 = "What are you...",
        ALTERGUARDIAN_PHASE3TRAP = "After rigorous testing, I can confirm that they make me want to take a nap.",
        ALTERGUARDIAN_PHASE3DEADORB = "Is it dead? That strange energy still seems to be lingering around it.",
        ALTERGUARDIAN_PHASE3DEAD = "Maybe someone should go poke it... just to be sure.",

        ALTERGUARDIANHAT = "It shows me infinite possibilities...",
        ALTERGUARDIANHATSHARD = "Even a single piece is pretty illuminating!",

        MOONSTORM_GLASS = {
            GENERIC = "It's glassy.",
            INFUSED = "It's glowing with unearthly energy."
        },

        MOONSTORM_STATIC = "I think I could catch this like a bug, in a net.",
        MOONSTORM_STATIC_ITEM = "That's a very... particular item I have in here.",
        MOONSTORM_SPARK = "That's a very... particular item I have in here.",

        BIRD_MUTANT = "Soo creepy! What happened to you, poor birb?",
        BIRD_MUTANT_SPITTER = "It gives me the creeps...",

        WAGSTAFF_NPC = "Who is that guy?",
        ALTERGUARDIAN_CONTAINED = "It's draining the energy right out of that monster!",

        WAGSTAFF_TOOL_1 = "This must be one of the items belonging to that old gray-haired guy.",
        WAGSTAFF_TOOL_2 = "This must be one of the items belonging to that old gray-haired guy.",
        WAGSTAFF_TOOL_3 = "This must be one of the items belonging to that old gray-haired guy.",
        WAGSTAFF_TOOL_4 = "This must be one of the items belonging to that old gray-haired guy.",
        WAGSTAFF_TOOL_5 = "This must be one of the items belonging to that old gray-haired guy.",

        MOONSTORM_GOGGLESHAT = "It's a potato-brain hat.",

        MOON_DEVICE = {
            GENERIC = "It's containing the energy... Or is it?",
            CONSTRUCTION1 = "It's still a work-in-progress!",
            CONSTRUCTION2 = "Still a bit more to go until it's finished.",
        },
		
		-- Waterlog
        WATERTREE_PILLAR = "This tree definitely stands out from the rest.",
        OCEANTREE = "It's adorably cute.",
        OCEANTREENUT = "Full of leafy energy.",
        WATERTREE_ROOT = "This tree's roots must reach to the bottom of the ocean.",

        OCEANTREE_PILLAR = "That's a big tree, if I ever saw one.",
        
        OCEANVINE = "They almost reach the water's surface.",
        FIG = "Seems like a juicy fruit.",
        FIG_COOKED = "Ready to be eaten.",

        SPIDER_WATER = "Haha, spider goes brr!",
        MUTATOR_WATER = "That's... yes, that's something, alright.",
        OCEANVINE_COCOON = "I don't think touching that is a good idea.",
        OCEANVINE_COCOON_BURNT = "No more spiders here.",

        GRASSGATOR = "It looks more like a unicorn than an alligator.",

        TREEGROWTHSOLUTION = "It's tree food!",

        FIGATONI = "Pasta goes well with anything.",
        FIGKABAB = "I'm gonna stick it right in my mouth!",
        KOALEFIG_TRUNK = "It's nose-ating to look at.",
        FROGNEWTON = "That's just froggin' weird.",
		
		-- Sketch Items
		SKETCHBOOK_WAROLINE = "I always keep it close to me, you never know when creativity will hit.",
		SKETCHBOOK_WAROLINE_SURVIVOR = "I always keep it close to me, you never know when creativity will hit.",
		SKETCHBOOK_WAROLINE_WINTER = "I always keep it close to me, you never know when creativity will hit.",
		
		AXE_DRAWING = "A sharp tool drawn by a sharp mind.",	--"This should do for now.",
		PICKAXE_DRAWING = "Paper beats rock.",	--"It might not last long, but it works!",
		CAMPFIRE_DRAWING = "It'll keep the place bright for a short period of time.",
		RABBIT_DRAWING = {
			GENERIC = "I'm rather happy about the way it turned out.",
			HAS_CARROT = "What did you find, my fluffy friend?",
		},
		SPIDER_DRAWING = "See? Spiders aren't that scary.",
		SMALLBIRD_DRAWING = "Ohh, it's such a cute floof!",
		PIGMAN_DRAWING = "First time drawing a humanoid pig. Not bad, not bad at all.",
		BEEFALO_DRAWING = "You took quite a bit out of me to draw you. Phew!",
		KOALEFANT_DRAWING = "Getting close without scaring it was a bit of a challenge.",
		MONKEY_DRAWING = "This little guy will help me with foraging.",
    },

    DESCRIBE_GENERIC = "It's... some thing?",
    DESCRIBE_TOODARK = "It's pitch-black!",	-- UPDATED
    DESCRIBE_SMOLDERING = "That's about to burst into flames!",

    DESCRIBE_PLANTHAPPY = "I'm happy you're happy.",
    DESCRIBE_PLANTVERYSTRESSED = "What's got you so down, little guy?",
    DESCRIBE_PLANTSTRESSED = "It's a bit sad, maybe I can help it somehow?",
    DESCRIBE_PLANTSTRESSORKILLJOYS = "I should really get rid of all these weeds.",
    DESCRIBE_PLANTSTRESSORFAMILY = "Poor little guy is lonely.",
    DESCRIBE_PLANTSTRESSOROVERCROWDING = "The garden is getting a bit overcrowded.",	-- UPDATED
    DESCRIBE_PLANTSTRESSORSEASON = "It'll have a hard time growing in this season.",	-- UPDATED
    DESCRIBE_PLANTSTRESSORMOISTURE = "It could use a few drops of water.",	-- UPDATED
    DESCRIBE_PLANTSTRESSORNUTRIENTS = "It could use a some plant food.",	-- UPDATED
    DESCRIBE_PLANTSTRESSORHAPPINESS = "Want to have a little chat, plant?",

    EAT_FOOD =
    {
        TALLBIRDEGG_CRACKED = "W-was that a... bird?...",
		WINTERSFEASTFUEL = "Feels like I'm back in my art studio.",	--"Reminds me of home...",
    },
}
