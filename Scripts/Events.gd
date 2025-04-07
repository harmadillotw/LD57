extends Node

var numEvents = 2

const Descriptions = ["You stand at the entrance to a vast cave system. The sun shines brightly outside while the darkness beckons below.",
"Unremarkable, featureless rocks loom around you.",
"Unremarkable, featureless rocks loom around you. This feels familiar. Have you been this way before.",
"Crystal walls sparkle around you in the half light of your torch.",
"Great crystal stalictites and stalagmites abound. It is like you have passed a portal into a different world.",
"Huge stalactites descend from the ceiling. Water drips down forming small pools.",
"The cavern constricts forcing you to crouch and sometimes crawl to make progress.",
"The ceiling rises like a vaulted cathedral. You find yourself holding your breath as you stair upwards.",
"The floor is littered with small stalagmites. You carefully manoeuvre  around them to avoid tripping.",
"The air is damp and cloying. Water runs down the walls disappearing underground before it can pool.",
"Impressive flowstones dominate the chamber. Perhaps larger than any you have seen in previous travels.",
"An unusually dense collection of soda straws in one corner of the cavern.",
"You feel a slight breeze on your face. You find the source is a small fissure that must lead back to the surface. But far too small for you to enter.",
"A small river of water flows through the cave. Both its entrance  and exit too small for you to explore.",
"A lake of freezing water stretches across the cavern. You are forced to hug the wall to continue.",
]

const EventDesc = ["",
 "You find some rubbish left by a previous explorer. You are able to fashion a crude torch.",
"You find some rubbish left by a previous explorer. You are able to fashion 2 crude torches.",
"You find some rubbish left by a previous explorer. You are able to fashion 3 crude torches.",
"Sunlight streams into the cavern from a large fissure  in the ceiling. Light +1.",
"Slime mould has spread across the floor making movement treacherous and slowing your progress. Light -1",
"A large crevasse blocks your progress. You are forced to spend time searching for a way around. Light -2",
"You find insects of a type you don't recognise glowing with an internal bioluminescence. They light the cavern in a faint flow. Light +1",
"Bioluminescence moss covers the walls lighting your progress. Light +2",
"Strange vines or possibly roots cover the walls. They can be used as a makeshift but sturdy rope. Rope +1",
"You find some rubbish left by a previous explorer. You find some usable rope. Rope +1.",
"A rock shifts under your foot and you fall grazing your arm. Health -1",

"A crevasse blocks your progress. Perhaps it is small enough to jump across.",
"The cavern contains a nest for large eyeless scorpions. Clear the nest with your torch or sneak around",
"You see a cave bear prowling the cavern. It has not spotted you yet. Hide amongst  the rocks or take more aggressive action.",
"Crude depictions  of hunters and animals adorn the wall. Perhaps this was an ancient place of worship or shelter.",
"Old bones and flint remains tell the tale of ancient visitors."
]

const EventH1 = [0,0,0,0,0,0,0,0,0,0
				,0,-1,-2,0,0,0,0]
const EventH2 = [0,0,0,0,0,0,0,0,0,0
				,0,0,0,-1,-4,0,0]
const EventL1 = [0,0,0,0,1,-1,-2,1,2,0,
				0,0,0,0,0,0,0]
const EventL2 = [0,0,0,0,0,0,0,0,0,0
				,0,0,-1,0,0,0,0]
const EventT1 = [0,1,2,3,0,0,0,0,0,0
				,0,0,0,-1,-1,0,0]
const EventT2 = [0,0,0,0,0,0,0,0,0,0
				,0,0,0,0,0,0,0]
const EventR1 = [0,0,0,0,0,0,0,0,0,0
				,1,0,0,0,0,0,0]
const EventR2 = [0,0,0,0,0,0,0,0,0,0
				,0,0,0,0,0,0,0]
const EventOptions = [1,1,1,1,1,1,1,1,1,1
				,1,1,2,2,2,0,0]
const EventOpt1 = ["Continue","Continue","Continue","Continue","Continue","Continue","Continue","Continue","Continue","Continue",
					"Continue","Continue", "Jump", "Clear the nest. -1 torch", "Quicky Hide from the bear. -1 torch","Continue","Continue"]
const EventOpt2 = ["","","","","","","","","","",
					"","","Go Around. -1 light", "Sneak around", "Attack the bear","",""]
const Percent1 = [0,0,0,0,0,0,0,0,0,0,
					0,0,1,0,0,0,0]
const Percent2 = [0,0,0,0,0,0,0,0,0,0
,0,0,0,1,1,0,0]
const SResult1 = ["","","","","","","","","","",
				"","","You clear the crevasse without trouble","","","",""]
const SResult2 = ["","","","","","","","","","",
				"","","","You sucessfully sneak around the scorpion nest","You wave your torch in the bear's face. It growls angrily  but retreats","",""]
const FResult1 = ["","","","","","","","","","",
				"","","You misjudge the jump and just catch the lip. You drag yourself up but are left bruised","","","",""]
const FResult2 = ["","","","","","","","","","",
				"","","","Your were too noisy and are bitten by the scorpions. -1 health","The bear roars and attacks. It's claws swipe you viciously before you can make your escape","",""]
#explore events
#waterfall
#lake
#crystal cave
# stalactites
# stalagmites
# light
# bioluminescence
# wall art.
# ancient tools/ remains
#animals
	# cave spider
	# mole
	# dragon
	# bats
	# snake

#search events
# stuff for torches
# rest/recovery
# damage
	# fall
	# cut
	
