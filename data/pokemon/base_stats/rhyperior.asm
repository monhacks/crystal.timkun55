	db RHYPERIOR ; 173

	db 115, 140, 130,  40,  55,  55
	evs  0,   3,   0,   0,   0,   0
	;   hp  atk  def  spd  sat  sdf

	db GROUND, ROCK ; type
	db 30 ; catch rate
	db 241 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 2 ; step cycles to hatch
	INCBIN "gfx/pokemon/rhyperior/front.dimensions"
	dw NULL, NULL ; unused (beta front/back pics)
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm DYNAMICPUNCH, HEADBUTT, CURSE, ROLLOUT, ROAR, TOXIC, ZAP_CANNON, ROCK_SMASH, HIDDEN_POWER, SNORE, BLIZZARD, HYPER_BEAM, ICY_WIND, PROTECT, ENDURE, ROCK_TOMB, IRON_TAIL, THUNDER, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, FIRE_BLAST, THUNDERPUNCH, REST, ATTRACT, FIRE_PUNCH, FURY_CUTTER, BODY_SLAM, BULLDOZE, SURF, STRENGTH, FLAMETHROWER, THUNDERBOLT, ICE_BEAM, POISON_JAB, STONE_EDGE, ROCK_BLAST, FOCUS_BLAST, GROWTH_PUNCH, SAND_TOMB, ROCK_TOMB, GIGA_IMPACT, IRON_DEFENSE, AQUA_TAIL, SUNNY_DAY, SANDSTORM
	; end
