	object_const_def
	const LAVRADIOTOWER1F_RECEPTIONIST
	const LAVRADIOTOWER1F_OFFICER
	const LAVRADIOTOWER1F_SUPER_NERD1
	const LAVRADIOTOWER1F_GENTLEMAN
	const LAVRADIOTOWER1F_SUPER_NERD2

LavRadioTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

LavRadioTower1FReceptionistScript:
	jumptextfaceplayer LavRadioTower1FReceptionistText

LavRadioTower1FOfficerScript:
	jumptextfaceplayer LavRadioTower1FOfficerText

LavRadioTower1FSuperNerd1Script:
	jumptextfaceplayer LavRadioTower1FSuperNerd1Text

LavRadioTower1FGentlemanScript:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext LavRadioTower1FGentlemanText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext LavRadioTower1FGentlemanText_ReturnedMachinePart
	promptbutton
	getstring STRING_BUFFER_4, .expncardname
	scall .receiveitem
	setflag ENGINE_EXPN_CARD
.GotExpnCard:
	writetext LavRadioTower1FGentlemanText_GotExpnCard
	waitbutton
	closetext
	end

.receiveitem:
	jumpstd ReceiveItemScript
	end

.expncardname
	db "Expn Card@"

LavRadioTower1FSuperNerd2Script:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	writetext LavRadioTower1FSuperNerd2Text
	waitbutton
	closetext
	end

.GotExpnCard:
	writetext LavRadioTower1FSuperNerd2Text_GotExpnCard
	waitbutton
	closetext
	end

LavRadioTower1FDirectory:
	jumptext LavRadioTower1FDirectoryText

LavRadioTower1FPokeFluteSign:
	jumptext LavRadioTower1FPokeFluteSignText

LavRadioTower1FReceptionistText:
	text "Welcome!"
	line "Feel free to look"

	para "around anywhere on"
	line "this floor."
	done

LavRadioTower1FOfficerText:
	text "Sorry, but you can"
	line "only tour the"
	cont "ground floor."

	para "Ever since Johto's"
	line "Radio Tower was"

	para "taken over by a"
	line "criminal gang, we"

	para "have had to step"
	line "up our security."
	done

LavRadioTower1FSuperNerd1Text:
	text "Many people are"
	line "hard at work here"

	para "in the Radio"
	line "Tower."

	para "They must be doing"
	line "their best to put"
	cont "on good shows."
	done

LavRadioTower1FGentlemanText:
	text "Oh, no, no, no!"

	para "We've been off the"
	line "air ever since the"

	para "Power Plant shut"
	line "down."

	para "All my efforts to"
	line "start this station"

	para "would be wasted if"
	line "I can't broadcast."

	para "I'll be ruined!"
	done

LavRadioTower1FGentlemanText_ReturnedMachinePart:
	text "Ah! So you're the"
	line "<PLAY_G> who solved"

	para "the Power Plant's"
	line "problem?"

	para "Thanks to you, I"
	line "never lost my job."

	para "I tell you, you're"
	line "a real lifesaver!"

	para "Please take this"
	line "as my thanks."
	done

LavRadioTower1FGentlemanText_GotExpnCard:
	text "With that thing,"
	line "you can tune into"

	para "the radio programs"
	line "here in Kanto."

	para "Gahahahaha!"
	done

LavRadioTower1FSuperNerd2Text:
	text "Hey there!"

	para "I am the super"
	line "Music Director!"

	para "Huh? Your #gear"
	line "can't tune into my"

	para "music programs."
	line "How unfortunate!"

	para "If you get an Expn"
	line "Card upgrade, you"

	para "can tune in. You'd"
	line "better get one!"
	done

LavRadioTower1FSuperNerd2Text_GotExpnCard:
	text "Hey there!"

	para "I am the super"
	line "Music Director!"

	para "I'm responsible"
	line "for the gorgeous"

	para "melodies that go"
	line "out over the air."

	para "Don't be square."
	line "Grab your music"
	cont "off the air!"
	done

LavRadioTower1FDirectoryText:
	text "1F Reception"
	line "2F Sales"

	para "3F Personnel"
	line "4F Production"

	para "5F Director's"
	line "   Office"
	done

LavRadioTower1FPokeFluteSignText:
	text "Perk Up #mon"
	line "with Mellow Sounds"

	para "of the # Flute"
	line "on Channel 20"
	done

LavRadioTower1FReferenceLibraryText:
	text "Wow! A full rack"
	line "of #mon CDs and"
	cont "videos."

	para "This must be the"
	line "reference library."
	done

LavRadioTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 7
	warp_event  3,  7, LAVENDER_TOWN, 7

	def_coord_events

	def_bg_events
	bg_event 11,  0, BGEVENT_READ, LavRadioTower1FDirectory
	bg_event  5,  0, BGEVENT_READ, LavRadioTower1FPokeFluteSign

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FReceptionistScript, -1
	object_event 15,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FOfficerScript, -1
	object_event  1,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd1Script, -1
	object_event  9,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FGentlemanScript, -1
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd2Script, -1
