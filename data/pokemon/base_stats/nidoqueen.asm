	db NIDOQUEEN ; 031

	db  90,  92,  87,  76,  75,  85
	evs  3,   0,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 194 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F100 ; gender ratio
	db 2 ; step cycles to hatch
	INCBIN "gfx/pokemon/nidoqueen/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm DYNAMICPUNCH, HEADBUTT, CURSE, ROAR, TOXIC, ROCK_SMASH, HIDDEN_POWER, HEX, SNORE, BLIZZARD, HYPER_BEAM, ICY_WIND, PROTECT, ENDURE, ROCK_TOMB, IRON_TAIL, THUNDER, EARTHQUAKE, RETURN, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, ICE_PUNCH, SWAGGER, SLEEP_TALK, SLUDGE_BOMB, AERIAL_ACE, FIRE_BLAST, DEFENSE_CURL, THUNDERPUNCH, REST, ATTRACT, THIEF, FIRE_PUNCH, FURY_CUTTER, BODY_SLAM, SLUDGE, BULLDOZE, SURF, STRENGTH, FLAMETHROWER, THUNDERBOLT, ICE_BEAM, POISON_JAB, STONE_EDGE, ROCK_BLAST, GUNK_SHOT, FOCUS_BLAST, GROWTH_PUNCH, SAND_TOMB, WATER_PULSE, ROCK_TOMB, GIGA_IMPACT, AQUA_TAIL, SUNNY_DAY, RAIN_DANCE, SANDSTORM
	; end
