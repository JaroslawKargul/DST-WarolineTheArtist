name = "Waroline, the Artist"
description = "She's here, at last!\nAn artist, who has been brought to the Constant by <default>.\n\nVersion: 1.29\nLast updated: 24.10.2021"
author = "<default>"
version = "1.29"

forumthread = "https://steamcommunity.com/sharedfiles/filedetails/?id=2345989057"

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character", "waroline", "drawing", "sketch", "artist"
}

configuration_options = {
	-- HEALTH
	{
		name = "warolinehp",
		label = "Waroline's HP",
		hover = "Maximum base amount of health for Waroline.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150(Default)", data = 150},
			{description = "155", data = 155},
			{description = "160", data = 160},
			{description = "165", data = 165},
			{description = "170", data = 170},
			{description = "175", data = 175},
			{description = "180", data = 180},
			{description = "185", data = 185},
			{description = "190", data = 190},
			{description = "195", data = 195},
			{description = "200", data = 200},
			{description = "205", data = 205},
			{description = "210", data = 210},
			{description = "215", data = 215},
			{description = "220", data = 220},
			{description = "225", data = 225},
			{description = "230", data = 230},
			{description = "235", data = 235},
			{description = "240", data = 240},
			{description = "245", data = 245},
			{description = "250", data = 250},
			{description = "255", data = 255},
			{description = "260", data = 260},
			{description = "265", data = 265},
			{description = "270", data = 270},
			{description = "275", data = 275},
			{description = "280", data = 280},
			{description = "285", data = 285},
			{description = "290", data = 290},
			{description = "295", data = 295},
			{description = "300", data = 300},
		},
		default = 150,
	},
	-- HUNGER
	{
		name = "warolinehunger",
		label = "Waroline's Hunger",
		hover = "Maximum base amount of hunger for Waroline.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150(Default)", data = 150},
			{description = "155", data = 155},
			{description = "160", data = 160},
			{description = "165", data = 165},
			{description = "170", data = 170},
			{description = "175", data = 175},
			{description = "180", data = 180},
			{description = "185", data = 185},
			{description = "190", data = 190},
			{description = "195", data = 195},
			{description = "200", data = 200},
			{description = "205", data = 205},
			{description = "210", data = 210},
			{description = "215", data = 215},
			{description = "220", data = 220},
			{description = "225", data = 225},
			{description = "230", data = 230},
			{description = "235", data = 235},
			{description = "240", data = 240},
			{description = "245", data = 245},
			{description = "250", data = 250},
			{description = "255", data = 255},
			{description = "260", data = 260},
			{description = "265", data = 265},
			{description = "270", data = 270},
			{description = "275", data = 275},
			{description = "280", data = 280},
			{description = "285", data = 285},
			{description = "290", data = 290},
			{description = "295", data = 295},
			{description = "300", data = 300},
		},
		default = 150,
	},
	-- SANITY
	{
		name = "warolinesanity",
		label = "Waroline's Sanity",
		hover = "Maximum base amount of sanity for Waroline.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
			{description = "155", data = 155},
			{description = "160", data = 160},
			{description = "165", data = 165},
			{description = "170", data = 170},
			{description = "175", data = 175},
			{description = "180", data = 180},
			{description = "185", data = 185},
			{description = "190", data = 190},
			{description = "195", data = 195},
			{description = "200(Default)", data = 200},
			{description = "205", data = 205},
			{description = "210", data = 210},
			{description = "215", data = 215},
			{description = "220", data = 220},
			{description = "225", data = 225},
			{description = "230", data = 230},
			{description = "235", data = 235},
			{description = "240", data = 240},
			{description = "245", data = 245},
			{description = "250", data = 250},
			{description = "255", data = 255},
			{description = "260", data = 260},
			{description = "265", data = 265},
			{description = "270", data = 270},
			{description = "275", data = 275},
			{description = "280", data = 280},
			{description = "285", data = 285},
			{description = "290", data = 290},
			{description = "295", data = 295},
			{description = "300", data = 300},
		},
		default = 200,
	},
	-- SKETCHES
	{
		name = "warolinesketchlimit",
		label = "Max Sketches At Once",
		hover = "Maximum amount of sketches Waroline can have out at once.",
		options =
		{
			{description = "1(Default)", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
		},
		default = 1,
	},
	{
		name = "drawingaxecost",
		label = "Sketch Axe Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Axe.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15(Default)", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 15,
	},
	{
		name = "drawingpickaxecost",
		label = "Sketch Pickaxe Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Pickaxe.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15(Default)", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 15,
	},
	{
		name = "drawingcampfirecost",
		label = "Sketch Campfire Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Campfire.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25(Default)", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 25,
	},
	{
		name = "drawingrabbitcost",
		label = "Sketch Rabbit Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Rabbit.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30(Default)", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 30,
	},
	{
		name = "drawingspidercost",
		label = "Sketch Spider Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Spider.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30(Default)", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 30,
	},
	{
		name = "drawingsmallbirdcost",
		label = "Sketch Smallbird Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Smallbird.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40(Default)", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 40,
	},
	{
		name = "drawingpigmancost",
		label = "Sketch Pigman Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Pigman.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50(Default)", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 50,
	},
	{
		name = "drawingbeefalocost",
		label = "Sketch Beefalo Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Beefalo.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80(Default)", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 80,
	},
	{
		name = "drawingkoalefantcost",
		label = "Sketch Koalefant Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Koalefant.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70", data = 70},
			{description = "75", data = 75},
			{description = "80(Default)", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 80,
	},
	{
		name = "drawingmonkeycost",
		label = "Sketch Splumonkey Cost",
		hover = "Cost of hunger points which has to be paid upon drawing a Sketch Splumonkey.",
		options =
		{
			{description = "5", data = 5},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "25", data = 25},
			{description = "30", data = 30},
			{description = "35", data = 35},
			{description = "40", data = 40},
			{description = "45", data = 45},
			{description = "50", data = 50},
			{description = "55", data = 55},
			{description = "60", data = 60},
			{description = "65", data = 65},
			{description = "70(Default)", data = 70},
			{description = "75", data = 75},
			{description = "80", data = 80},
			{description = "85", data = 85},
			{description = "90", data = 90},
			{description = "95", data = 95},
			{description = "100", data = 100},
			{description = "105", data = 105},
			{description = "110", data = 110},
			{description = "115", data = 115},
			{description = "120", data = 120},
			{description = "125", data = 125},
			{description = "130", data = 130},
			{description = "135", data = 135},
			{description = "140", data = 140},
			{description = "145", data = 145},
			{description = "150", data = 150},
		},
		default = 70,
	},
}
