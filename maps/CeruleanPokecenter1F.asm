	object_const_def
	const CERULEANPOKECENTER1F_NURSE
	const CERULEANPOKECENTER1F_CHANSEY
	const CERULEANPOKECENTER1F_SUPER_NERD
	const CERULEANPOKECENTER1F_GYM_GUIDE

CeruleanPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

CeruleanPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

CeruleanPokecenter1FChansey:
	jumpstd PokecenterChanseyScript

CeruleanPokecenter1FSuperNerdScript:
	jumptextfaceplayer CeruleanPokecenter1FSuperNerdText

CeruleanPokecenter1FGymGuideScript:
	jumptextfaceplayer CeruleanPokecenter1FGymGuideText

CeruleanPokecenter1FSuperNerdText:
	text "For battles, I'd"
	line "much rather use"

	para "#mon I've been"
	line "raising, even if"

	para "they're weaker"
	line "than some newly"
	cont "caught #mon."
	done

CeruleanPokecenter1FGymGuideText:
	text "The Magnet Train"
	line "travels at over"

	para "550km/h. It goes"
	line "between Kanto and"

	para "Johto in almost no"
	line "time at all."

	para "It really makes"
	line "Johto accessible."
	done

CeruleanPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  7, CERULEAN_CITY, 4
	warp_event  6,  7, CERULEAN_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanPokecenter1FNurseScript, -1
	object_event  6,  1, SPRITE_CHANSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanPokecenter1FChansey, -1
	object_event  9,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeruleanPokecenter1FSuperNerdScript, -1
	object_event  1,  5, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeruleanPokecenter1FGymGuideScript, -1
