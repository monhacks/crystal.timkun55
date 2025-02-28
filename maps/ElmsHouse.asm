	object_const_def
	const ELMSHOUSE_ELMS_WIFE
	const ELMSHOUSE_ELMS_SON

ElmsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ElmsWife:
	jumptextfaceplayer ElmsWifeText

ElmsSon:
	jumptextfaceplayer ElmsSonText

ElmsHousePC:
	jumptext ElmsHousePCText

ElmsHouseBookshelf:
	jumpstd DifficultBookshelfScript

ElmsWifeText:
	text "Hi, <PLAY_G>! My"
	line "husband's always"

	para "so busy--I hope"
	line "he's OK."

	para "When he's caught"
	line "up in his #mon"

	para "research, he even"
	line "forgets to eat."
	done

ElmsSonText:
	text "When I grow up,"
	line "I'm going to help"
	cont "my dad!"

	para "I'm going to be a"
	line "great #mon"
	cont "professor!"
	done

ElmsHousePCText:
	text "#mon. Where do"
	line "they come from? "

	para "Where are they"
	line "going?"

	para "Why has no one"
	line "ever witnessed a"
	cont "#mon's birth?"

	para "I want to know! I"
	line "will dedicate my"

	para "life to the study"
	line "of #mon!"

	para "…"

	para "It's a part of"
	line "Prof.Elm's re-"
	cont "search papers."
	done
	
ElmsHouseFridgeText:
	text "There's some food"
	line "here. This must be"
	cont "for #mon."
	done

ElmsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  4, NEW_BARK_TOWN, 4
	warp_event  7,  5, NEW_BARK_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, ElmsHousePC
	bg_event  0,  1, BGEVENT_READ, ElmsHouseFridgeText
	bg_event  7,  1, BGEVENT_READ, ElmsHouseBookshelf

	def_object_events
	object_event  1,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ElmsWife, -1
	object_event  4,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsSon, -1
