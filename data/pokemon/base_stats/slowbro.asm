	db SLOWBRO ; 080

	db  95,  75, 110,  30, 100,  80
	evs  0,   0,   2,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db WATER, PSYCHIC_TYPE ; type
	db 75 ; catch rate
	db 164 ; base exp
	db NO_ITEM, KINGS_ROCK ; items
	db GENDER_F50 ; gender ratio
	db 2 ; step cycles to hatch
	INCBIN "gfx/pokemon/slowbro/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm DYNAMICPUNCH, HEADBUTT, CURSE, TOXIC, ZAP_CANNON, ROCK_SMASH, CALM_MIND, HIDDEN_POWER, SNORE, BLIZZARD, HYPER_BEAM, ICY_WIND, PROTECT, SCALD, ENDURE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, PSYCHIC_M, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, ICE_PUNCH, SWAGGER, SLEEP_TALK, AERIAL_ACE, FIRE_BLAST, SWIFT, DREAM_EATER, REST, ATTRACT, FURY_CUTTER, NIGHTMARE, BODY_SLAM, BULLDOZE, HAIL, SURF, STRENGTH, FLASH, WHIRLPOOL, WATERFALL, FLAMETHROWER, ICE_BEAM, DRAIN_PUNCH, SIGNAL_BEAM, FOCUS_BLAST, WATER_PULSE, ZEN_HEADBUTT, GIGA_IMPACT, IRON_DEFENSE, AQUA_TAIL, SUNNY_DAY, RAIN_DANCE
	; end
