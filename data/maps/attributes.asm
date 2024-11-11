MACRO map_attributes
;\1: map name
;\2: map id
;\3: border block
;\4: connections: combo of NORTH, SOUTH, WEST, and/or EAST, or 0 for none
	DEF CURRENT_MAP_WIDTH = \2_WIDTH
	DEF CURRENT_MAP_HEIGHT = \2_HEIGHT
\1_MapAttributes::
	db \3
	db CURRENT_MAP_HEIGHT, CURRENT_MAP_WIDTH
	db BANK(\1_Blocks)
	dw \1_Blocks
	db BANK(\1_MapScripts) ; aka BANK(\1_MapEvents)
	dw \1_MapScripts
	dw \1_MapEvents
	db \4
ENDM

; Connections go in order: north, south, west, east
MACRO connection
;\1: direction
;\2: map name
;\3: map id
;\4: offset of the target map relative to the current map
;    (x offset for east/west, y offset for north/south)

	; LEGACY: Support for old connection macro
	if _NARG == 6
		connection \1, \2, \3, (\4) - (\5)
	else

		; Calculate tile offsets for source (current) and target maps
		DEF _src = 0
		DEF _tgt = (\4) + MAP_CONNECTION_PADDING_WIDTH
		if _tgt < 0
			DEF _src = -_tgt
			DEF _tgt = 0
		endc

		if !STRCMP("\1", "north")
			DEF _blk = \3_WIDTH * (\3_HEIGHT - MAP_CONNECTION_PADDING_WIDTH) + _src
			DEF _map = _tgt
			DEF _win = (\3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * \3_HEIGHT + 1
			DEF _y = \3_HEIGHT * 2 - 1
			DEF _x = (\4) * -2
			DEF _len = CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_WIDTH
				DEF _len = \3_WIDTH
			endc

		elif !STRCMP("\1", "south")
			DEF _blk = _src
			DEF _map = (CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * (CURRENT_MAP_HEIGHT + MAP_CONNECTION_PADDING_WIDTH) + _tgt
			DEF _win = \3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2 + 1
			DEF _y = 0
			DEF _x = (\4) * -2
			DEF _len = CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_WIDTH
				DEF _len = \3_WIDTH
			endc

		elif !STRCMP("\1", "west")
			DEF _blk = (\3_WIDTH * _src) + \3_WIDTH - MAP_CONNECTION_PADDING_WIDTH
			DEF _map = (CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * _tgt
			DEF _win = (\3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * 2 - MAP_CONNECTION_PADDING_WIDTH * 2
			DEF _y = (\4) * -2
			DEF _x = \3_WIDTH * 2 - 1
			DEF _len = CURRENT_MAP_HEIGHT + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_HEIGHT
				DEF _len = \3_HEIGHT
			endc

		elif !STRCMP("\1", "east")
			DEF _blk = (\3_WIDTH * _src)
			DEF _map = (CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2) * _tgt + CURRENT_MAP_WIDTH + MAP_CONNECTION_PADDING_WIDTH
			DEF _win = \3_WIDTH + MAP_CONNECTION_PADDING_WIDTH * 2 + 1
			DEF _y = (\4) * -2
			DEF _x = 0
			DEF _len = CURRENT_MAP_HEIGHT + MAP_CONNECTION_PADDING_WIDTH - (\4)
			if _len > \3_HEIGHT
				DEF _len = \3_HEIGHT
			endc

		else
			fail "Invalid direction for 'connection'."
		endc

	map_id \3
	dw \2_Blocks + _blk
	dw wOverworldMapBlocks + _map
	db _len - _src
	db \3_WIDTH
	db _y, _x
	dw wOverworldMapBlocks + _win

	endc
ENDM


	map_attributes NewBarkTown, NEW_BARK_TOWN, $05, WEST | EAST
	connection west, Route29, ROUTE_29, 0
	connection east, Route27, ROUTE_27, 0

	map_attributes CherrygroveCity, CHERRYGROVE_CITY, $05, NORTH | EAST
	connection north, Route30, ROUTE_30, 5
	connection east, Route29, ROUTE_29, 0

	map_attributes VioletCity, VIOLET_CITY, $05, SOUTH | WEST | EAST
	connection south, Route32, ROUTE_32, 0
	connection west, Route36, ROUTE_36, 0
	connection east, Route31, ROUTE_31, 9

	map_attributes AzaleaTown, AZALEA_TOWN, $05, WEST | EAST
	connection west, Route34, ROUTE_34, -18
	connection east, Route33, ROUTE_33, 0

	map_attributes CianwoodCity, CIANWOOD_CITY, $25, EAST
	connection east, Route41, ROUTE_41, 0

	map_attributes GoldenrodCity, GOLDENROD_CITY, $35, NORTH | SOUTH
	connection north, Route35, ROUTE_35, 6
	connection south, Route34, ROUTE_34, 6

	map_attributes OlivineCity, OLIVINE_CITY, $25, NORTH | WEST
	connection north, Route39, ROUTE_39, 5
	connection west, Route40, ROUTE_40, 9

	map_attributes EcruteakCity, ECRUTEAK_CITY, $05, SOUTH | WEST | EAST
	connection south, Route37, ROUTE_37, 5
	connection west, Route38, ROUTE_38, 11
	connection east, Route42, ROUTE_42, 15

	map_attributes MahoganyTown, MAHOGANY_TOWN, $45, NORTH | WEST | EAST
	connection north, Route43, ROUTE_43, 0
	connection west, Route42, ROUTE_42, 0
	connection east, Route44, ROUTE_44, 0

	map_attributes LakeOfRage, LAKE_OF_RAGE, $05, SOUTH
	connection south, Route43, ROUTE_43, 5

	map_attributes BlackthornCity, BLACKTHORN_CITY, $45, SOUTH | WEST
	connection south, Route45, ROUTE_45, 0
	connection west, Route44, ROUTE_44, 9

	map_attributes MtSilverOutside, MT_SILVER_OUTSIDE, $45, EAST
	connection east, Route28, ROUTE_28, 6

	map_attributes Route26, ROUTE_26, $05, WEST
	connection west, Route27, ROUTE_27, 45

	map_attributes Route27, ROUTE_27, $35, WEST | EAST
	connection west, NewBarkTown, NEW_BARK_TOWN, 0
	connection east, Route26, ROUTE_26, -45

	map_attributes Route28, ROUTE_28, $45, WEST
	connection west, MtSilverOutside, MT_SILVER_OUTSIDE, -6

	map_attributes Route29, ROUTE_29, $05, NORTH | WEST | EAST
	connection north, Route46, ROUTE_46, 10
	connection west, CherrygroveCity, CHERRYGROVE_CITY, 0
	connection east, NewBarkTown, NEW_BARK_TOWN, 0

	map_attributes Route30, ROUTE_30, $05, NORTH | SOUTH
	connection north, Route31, ROUTE_31, -10
	connection south, CherrygroveCity, CHERRYGROVE_CITY, -5

	map_attributes Route31, ROUTE_31, $05, SOUTH | WEST
	connection south, Route30, ROUTE_30, 10
	connection west, VioletCity, VIOLET_CITY, -9

	map_attributes Route32, ROUTE_32, $05, NORTH | SOUTH
	connection north, VioletCity, VIOLET_CITY, 0
	connection south, Route33, ROUTE_33, 0

	map_attributes Route33, ROUTE_33, $05, NORTH | WEST
	connection north, Route32, ROUTE_32, 0
	connection west, AzaleaTown, AZALEA_TOWN, 0

	map_attributes Route34, ROUTE_34, $05, NORTH | EAST
	connection north, GoldenrodCity, GOLDENROD_CITY, -6
	connection east, AzaleaTown, AZALEA_TOWN, 18

	map_attributes Route35, ROUTE_35, $05, NORTH | SOUTH
	connection north, Route36, ROUTE_36, 0
	connection south, GoldenrodCity, GOLDENROD_CITY, -6

	map_attributes Route36, ROUTE_36, $05, NORTH | SOUTH | EAST
	connection north, Route37, ROUTE_37, 10
	connection south, Route35, ROUTE_35, 0
	connection east, VioletCity, VIOLET_CITY, 0

	map_attributes Route37, ROUTE_37, $05, NORTH | SOUTH
	connection north, EcruteakCity, ECRUTEAK_CITY, -5
	connection south, Route36, ROUTE_36, -10

	map_attributes Route38, ROUTE_38, $05, WEST | EAST
	connection west, Route39, ROUTE_39, 0
	connection east, EcruteakCity, ECRUTEAK_CITY, -11

	map_attributes Route39, ROUTE_39, $05, SOUTH | EAST
	connection south, OlivineCity, OLIVINE_CITY, -5
	connection east, Route38, ROUTE_38, 0

	map_attributes Route40, ROUTE_40, $25, SOUTH | EAST
	connection south, Route41, ROUTE_41, -15
	connection east, OlivineCity, OLIVINE_CITY, -9

	map_attributes Route41, ROUTE_41, $25, NORTH | WEST
	connection north, Route40, ROUTE_40, 15
	connection west, CianwoodCity, CIANWOOD_CITY, 0

	map_attributes Route42, ROUTE_42, $05, WEST | EAST
	connection west, EcruteakCity, ECRUTEAK_CITY, -15
	connection east, MahoganyTown, MAHOGANY_TOWN, 0

	map_attributes Route43, ROUTE_43, $05, NORTH | SOUTH
	connection north, LakeOfRage, LAKE_OF_RAGE, -5
	connection south, MahoganyTown, MAHOGANY_TOWN, 0

	map_attributes Route44, ROUTE_44, $45, WEST | EAST
	connection west, MahoganyTown, MAHOGANY_TOWN, 0
	connection east, BlackthornCity, BLACKTHORN_CITY, -9

	map_attributes Route45, ROUTE_45, $45, NORTH | WEST
	connection north, BlackthornCity, BLACKTHORN_CITY, 0
	connection west, Route46, ROUTE_46, 36

	map_attributes Route46, ROUTE_46, $05, SOUTH | EAST
	connection south, Route29, ROUTE_29, -10
	connection east, Route45, ROUTE_45, -36

	map_attributes PewterCity, PEWTER_CITY, $45, SOUTH | EAST
	connection south, Route2, ROUTE_2, 5
	connection east, Route3, ROUTE_3, 5

	map_attributes Route2, ROUTE_2, $2f, NORTH | SOUTH
	connection north, PewterCity, PEWTER_CITY, -5
	connection south, ViridianCity, VIRIDIAN_CITY, -5

	map_attributes ViridianCity, VIRIDIAN_CITY, $2f, NORTH | SOUTH | WEST
	connection north, Route2, ROUTE_2, 5
	connection south, Route1, ROUTE_1, 5
	connection west, Route22, ROUTE_22, 4

	map_attributes Route22, ROUTE_22, $45, EAST
	connection east, ViridianCity, VIRIDIAN_CITY, -4

	map_attributes Route1, ROUTE_1, $2f, NORTH | SOUTH
	connection north, ViridianCity, VIRIDIAN_CITY, -5
	connection south, PalletTown, PALLET_TOWN, 0

	map_attributes PalletTown, PALLET_TOWN, $2f, NORTH | SOUTH
	connection north, Route1, ROUTE_1, 0
	connection south, Route21, ROUTE_21, 0

	map_attributes Route21, ROUTE_21, $25, NORTH | SOUTH
	connection north, PalletTown, PALLET_TOWN, 0
	connection south, CinnabarIsland, CINNABAR_ISLAND, -4

	map_attributes CinnabarIsland, CINNABAR_ISLAND, $25, NORTH | EAST
	connection north, Route21, ROUTE_21, 4
	connection east, Route20, ROUTE_20, 3

	map_attributes Route20, ROUTE_20, $25, WEST | EAST
	connection west, CinnabarIsland, CINNABAR_ISLAND, -3
	connection east, Route19, ROUTE_19, -9

	map_attributes Route19, ROUTE_19, $25, NORTH | WEST
	connection north, FuchsiaCity, FUCHSIA_CITY, 0
	connection west, Route20, ROUTE_20, 9

	map_attributes FuchsiaCity, FUCHSIA_CITY, $2f, SOUTH | WEST | EAST
	connection south, Route19, ROUTE_19, 0
	connection west, Route18, ROUTE_18, 7
	connection east, Route15, ROUTE_15, 9

	map_attributes Route18, ROUTE_18, $25, WEST | EAST
	connection west, Route17, ROUTE_17, -38
	connection east, FuchsiaCity, FUCHSIA_CITY, -7

	map_attributes Route17, ROUTE_17, $25, NORTH | EAST
	connection north, Route16, ROUTE_16, 0
	connection east, Route18, ROUTE_18, 38

	map_attributes Route16, ROUTE_16, $2f, SOUTH | EAST
	connection south, Route17, ROUTE_17, 0
	connection east, CeladonCity, CELADON_CITY, -9

	map_attributes CeladonCity, CELADON_CITY, $2f, WEST | EAST
	connection west, Route16, ROUTE_16, 9
	connection east, Route7, ROUTE_7, 5

	map_attributes Route7, ROUTE_7, $2f, WEST | EAST
	connection west, CeladonCity, CELADON_CITY, -5
	connection east, SaffronCity, SAFFRON_CITY, -9

	map_attributes Route15, ROUTE_15, $2f, WEST | EAST
	connection west, FuchsiaCity, FUCHSIA_CITY, -9
	connection east, Route14, ROUTE_14, -9

	map_attributes Route14, ROUTE_14, $25, NORTH | WEST
	connection north, Route13, ROUTE_13, 0
	connection west, Route15, ROUTE_15, 9
	
	map_attributes Route13, ROUTE_13, $25, NORTH | SOUTH
	connection north, Route12, ROUTE_12, 20
	connection south, Route14, ROUTE_14, 0

	map_attributes Route12, ROUTE_12, $25, NORTH | SOUTH | WEST
	connection north, LavenderTown, LAVENDER_TOWN, 0
	connection south, Route13, ROUTE_13, -20
	connection west, Route11, ROUTE_11, 9

	map_attributes Route11, ROUTE_11, $2f, WEST | EAST
	connection west, VermilionCity, VERMILION_CITY, 0
	connection east, Route12, ROUTE_12, -9

	map_attributes LavenderTown, LAVENDER_TOWN, $45, NORTH | SOUTH | WEST
	connection north, Route10South, ROUTE_10_SOUTH, 0
	connection south, Route12, ROUTE_12, 0
	connection west, Route8, ROUTE_8, 0

	map_attributes VermilionCity, VERMILION_CITY, $25, NORTH | EAST
	connection north, Route6, ROUTE_6, 5
	connection east, Route11, ROUTE_11, 0

	map_attributes Route6, ROUTE_6, $2f, NORTH | SOUTH
	connection north, SaffronCity, SAFFRON_CITY, -5
	connection south, VermilionCity, VERMILION_CITY, -5

	map_attributes SaffronCity, SAFFRON_CITY, $2f, NORTH | SOUTH | WEST | EAST
	connection north, Route5, ROUTE_5, 4
	connection south, Route6, ROUTE_6, 5
	connection west, Route7, ROUTE_7, 9
	connection east, Route8, ROUTE_8, 11

	map_attributes Route5, ROUTE_5, $2f, NORTH | SOUTH
	connection north, CeruleanCity, CERULEAN_CITY, -5
	connection south, SaffronCity, SAFFRON_CITY, -4

	map_attributes CeruleanCity, CERULEAN_CITY, $2f, NORTH | SOUTH | WEST | EAST
	connection north, Route24, ROUTE_24, 5
	connection south, Route5, ROUTE_5, 5
	connection west, Route4, ROUTE_4, 5
	connection east, Route9, ROUTE_9, 9

	map_attributes Route9, ROUTE_9, $45, SOUTH | WEST
	connection south, Route10North, ROUTE_10_NORTH, 20
	connection west, CeruleanCity, CERULEAN_CITY, -9

	map_attributes Route24, ROUTE_24, $45, NORTH | SOUTH
	connection north, Route25, ROUTE_25, 0
	connection south, CeruleanCity, CERULEAN_CITY, -5

	map_attributes Route25, ROUTE_25, $45, SOUTH
	connection south, Route24, ROUTE_24, 0

	map_attributes Route3, ROUTE_3, $45, WEST | EAST
	connection west, PewterCity, PEWTER_CITY, -5
	connection east, Route4, ROUTE_4, 0

	map_attributes Route4, ROUTE_4, $45, SOUTH | WEST | EAST 
	connection south, Route4ZapdosNest, ROUTE_4_ZAPDOS_NEST, 4
	connection west, Route3, ROUTE_3, 0
	connection east, CeruleanCity, CERULEAN_CITY, -5
	
	map_attributes Route4ZapdosNest, ROUTE_4_ZAPDOS_NEST, $45, NORTH
	connection north, Route4, ROUTE_4, -4

	map_attributes Route8, ROUTE_8, $45, WEST | EAST
	connection west, SaffronCity, SAFFRON_CITY, -11
	connection east, LavenderTown, LAVENDER_TOWN, 0

	map_attributes Route10North, ROUTE_10_NORTH, $45, NORTH | SOUTH
	connection north, Route9, ROUTE_9, -20
	connection south, Route10South, ROUTE_10_SOUTH, 0

	map_attributes Route10South, ROUTE_10_SOUTH, $45, NORTH | SOUTH
	connection north, Route10North, ROUTE_10_NORTH, 0
	connection south, LavenderTown, LAVENDER_TOWN, 0
	
	map_attributes Route23, ROUTE_23, $87, NORTH
	connection north, IndigoPlateau, INDIGO_PLATEAU, 0
	
	map_attributes IndigoPlateau, INDIGO_PLATEAU, $87, SOUTH
	connection south, Route23, ROUTE_23, 0	

	map_attributes SproutTower1F, SPROUT_TOWER_1F, $00, 0
	map_attributes SproutTower2F, SPROUT_TOWER_2F, $00, 0
	map_attributes SproutTower3F, SPROUT_TOWER_3F, $00, 0
	map_attributes TinTower1F, TIN_TOWER_1F, $00, 0
	map_attributes TinTower2F, TIN_TOWER_2F, $00, 0
	map_attributes TinTower3F, TIN_TOWER_3F, $00, 0
	map_attributes TinTower4F, TIN_TOWER_4F, $00, 0
	map_attributes TinTower5F, TIN_TOWER_5F, $00, 0
	map_attributes TinTower6F, TIN_TOWER_6F, $00, 0
	map_attributes TinTower7F, TIN_TOWER_7F, $00, 0
	map_attributes TinTower8F, TIN_TOWER_8F, $00, 0
	map_attributes TinTower9F, TIN_TOWER_9F, $00, 0
	map_attributes BurnedTower1F, BURNED_TOWER_1F, $00, 0
	map_attributes BurnedTowerB1F, BURNED_TOWER_B1F, $bd, 0
	map_attributes NationalPark, NATIONAL_PARK, $45, 0
	map_attributes NationalParkBugContest, NATIONAL_PARK_BUG_CONTEST, $45, 0
	map_attributes RadioTower1F, RADIO_TOWER_1F, $00, 0
	map_attributes RadioTower2F, RADIO_TOWER_2F, $00, 0
	map_attributes RadioTower3F, RADIO_TOWER_3F, $00, 0
	map_attributes RadioTower4F, RADIO_TOWER_4F, $00, 0
	map_attributes RadioTower5F, RADIO_TOWER_5F, $00, 0
	map_attributes RuinsOfAlphOutside, RUINS_OF_ALPH_OUTSIDE, $05, 0
	map_attributes RuinsOfAlphHoOhChamber, RUINS_OF_ALPH_HO_OH_CHAMBER, $00, 0
	map_attributes RuinsOfAlphKabutoChamber, RUINS_OF_ALPH_KABUTO_CHAMBER, $00, 0
	map_attributes RuinsOfAlphOmanyteChamber, RUINS_OF_ALPH_OMANYTE_CHAMBER, $00, 0
	map_attributes RuinsOfAlphAerodactylChamber, RUINS_OF_ALPH_AERODACTYL_CHAMBER, $00, 0
	map_attributes RuinsOfAlphInnerChamber, RUINS_OF_ALPH_INNER_CHAMBER, $00, 0
	map_attributes RuinsOfAlphResearchCenter, RUINS_OF_ALPH_RESEARCH_CENTER, $00, 0
	map_attributes RuinsOfAlphHoOhItemRoom, RUINS_OF_ALPH_HO_OH_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphKabutoItemRoom, RUINS_OF_ALPH_KABUTO_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphOmanyteItemRoom, RUINS_OF_ALPH_OMANYTE_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphAerodactylItemRoom, RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM, $00, 0
	map_attributes RuinsOfAlphHoOhWordRoom, RUINS_OF_ALPH_HO_OH_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphKabutoWordRoom, RUINS_OF_ALPH_KABUTO_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphOmanyteWordRoom, RUINS_OF_ALPH_OMANYTE_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphAerodactylWordRoom, RUINS_OF_ALPH_AERODACTYL_WORD_ROOM, $00, 0
	map_attributes RuinsOfAlphGSBallChamber, RUINS_OF_ALPH_GS_BALL_CHAMBER, $00, 0
	map_attributes RuinsOfAlphCaveEntrance, RUINS_OF_ALPH_CAVE_ENTRANCE, $00, 0
	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE, $A1, 0
	map_attributes UnionCave1F, UNION_CAVE_1F, $bd, 0
	map_attributes UnionCaveB1F, UNION_CAVE_B1F, $bd, 0
	map_attributes UnionCaveB2F, UNION_CAVE_B2F, $bd, 0
	map_attributes SlowpokeWellB1F, SLOWPOKE_WELL_B1F, $bd, 0
	map_attributes SlowpokeWellB2F, SLOWPOKE_WELL_B2F, $bd, 0
	map_attributes OlivineLighthouse1F, OLIVINE_LIGHTHOUSE_1F, $00, 0
	map_attributes OlivineLighthouse2F, OLIVINE_LIGHTHOUSE_2F, $00, 0
	map_attributes OlivineLighthouse3F, OLIVINE_LIGHTHOUSE_3F, $00, 0
	map_attributes OlivineLighthouse4F, OLIVINE_LIGHTHOUSE_4F, $00, 0
	map_attributes OlivineLighthouse5F, OLIVINE_LIGHTHOUSE_5F, $00, 0
	map_attributes OlivineLighthouse6F, OLIVINE_LIGHTHOUSE_6F, $00, 0
	map_attributes MahoganyMart1F, MAHOGANY_MART_1F, $00, 0
	map_attributes MahoganyMoveTutorHouse, MAHOGANY_MOVE_TUTOR_HOUSE, $00, 0
	map_attributes TeamRocketBaseB1F, TEAM_ROCKET_BASE_B1F, $00, 0
	map_attributes TeamRocketBaseB2F, TEAM_ROCKET_BASE_B2F, $00, 0
	map_attributes TeamRocketBaseB3F, TEAM_ROCKET_BASE_B3F, $00, 0
	map_attributes IlexForest, ILEX_FOREST, $29, 0
	map_attributes GoldenrodUnderground, GOLDENROD_UNDERGROUND, $00, 0
	map_attributes GoldenrodUndergroundSwitchRoomEntrances, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, $00, 0
	map_attributes GoldenrodDeptStoreB1F, GOLDENROD_DEPT_STORE_B1F, $00, 0
	map_attributes GoldenrodUndergroundWarehouse, GOLDENROD_UNDERGROUND_WAREHOUSE, $00, 0
	map_attributes MountMortar1FOutside, MOUNT_MORTAR_1F_OUTSIDE, $01, 0
	map_attributes MountMortar1FInside, MOUNT_MORTAR_1F_INSIDE, $01, 0
	map_attributes MountMortar2FInside, MOUNT_MORTAR_2F_INSIDE, $01, 0
	map_attributes MountMortarB1F, MOUNT_MORTAR_B1F, $01, 0
	map_attributes IcePath1F, ICE_PATH_1F, $01, 0
	map_attributes IcePathB1F, ICE_PATH_B1F, $01, 0
	map_attributes IcePathB2FMahoganySide, ICE_PATH_B2F_MAHOGANY_SIDE, $01, 0
	map_attributes IcePathB2FBlackthornSide, ICE_PATH_B2F_BLACKTHORN_SIDE, $01, 0
	map_attributes IcePathB3F, ICE_PATH_B3F, $01, 0
	map_attributes WhirlIslandNW, WHIRL_ISLAND_NW, $01, 0
	map_attributes WhirlIslandNE, WHIRL_ISLAND_NE, $01, 0
	map_attributes WhirlIslandSW, WHIRL_ISLAND_SW, $01, 0
	map_attributes WhirlIslandCave, WHIRL_ISLAND_CAVE, $01, 0
	map_attributes WhirlIslandSE, WHIRL_ISLAND_SE, $01, 0
	map_attributes WhirlIslandB1F, WHIRL_ISLAND_B1F, $01, 0
	map_attributes WhirlIslandB2F, WHIRL_ISLAND_B2F, $01, 0
	map_attributes WhirlIslandLugiaChamber, WHIRL_ISLAND_LUGIA_CHAMBER, $0f, 0
	map_attributes MtSilverRoom1, MT_SILVER_ROOM_1, $01, 0
	map_attributes MtSilverRoom2, MT_SILVER_ROOM_2, $bd, 0
	map_attributes MtSilverPeak, MT_SILVER_PEAK, $8d, 0
	map_attributes MtSilverItemRooms, MT_SILVER_ITEM_ROOMS, $bd, 0
	map_attributes DarkCaveVioletEntrance, DARK_CAVE_VIOLET_ENTRANCE, $01, 0
	map_attributes DarkCaveBlackthornEntrance, DARK_CAVE_BLACKTHORN_ENTRANCE, $01, 0
	map_attributes DragonsDen1F, DRAGONS_DEN_1F, $bd, 0
	map_attributes DragonsDenB1F, DRAGONS_DEN_B1F, $45, 0
	map_attributes DragonShrine, DRAGON_SHRINE, $00, 0
	map_attributes TohjoFalls, TOHJO_FALLS, $bd, 0
	map_attributes OlivinePokecenter1F, OLIVINE_POKECENTER_1F, $00, 0
	map_attributes OlivineGym, OLIVINE_GYM, $00, 0
	map_attributes OlivineTimsHouse, OLIVINE_TIMS_HOUSE, $00, 0
	map_attributes OlivinePunishmentSpeechHouse, OLIVINE_PUNISHMENT_SPEECH_HOUSE, $00, 0
	map_attributes OlivineGoodRodHouse, OLIVINE_GOOD_ROD_HOUSE, $00, 0
	map_attributes OlivineCafe, OLIVINE_CAFE, $00, 0
	map_attributes OlivineMart, OLIVINE_MART, $00, 0
	map_attributes Route38EcruteakGate, ROUTE_38_ECRUTEAK_GATE, $00, 0
	map_attributes Route39Barn, ROUTE_39_BARN, $00, 0
	map_attributes Route39Farmhouse, ROUTE_39_FARMHOUSE, $00, 0
	map_attributes MahoganyRedGyaradosSpeechHouse, MAHOGANY_RED_GYARADOS_SPEECH_HOUSE, $00, 0
	map_attributes MahoganyGym, MAHOGANY_GYM, $00, 0
	map_attributes MahoganyPokecenter1F, MAHOGANY_POKECENTER_1F, $00, 0
	map_attributes Route42EcruteakGate, ROUTE_42_ECRUTEAK_GATE, $00, 0
	map_attributes DiglettsCave, DIGLETTS_CAVE, $bd, 0
	map_attributes MountMoon1F, MOUNT_MOON_1F, $bd, 0
	map_attributes MountMoonB1F, MOUNT_MOON_B1F, $bd, 0
	map_attributes MountMoonB2F, MOUNT_MOON_B2F, $bd, 0
	map_attributes UndergroundPath, UNDERGROUND_PATH, $00, 0
	map_attributes UndergroundRoom, UNDERGROUND_ROOM, $bd, 0
	map_attributes RockTunnel1F, ROCK_TUNNEL_1F, $01, 0
	map_attributes RockTunnelB1F, ROCK_TUNNEL_B1F, $01, 0
	map_attributes SafariZoneFuchsiaGate, SAFARI_ZONE_FUCHSIA_GATE, $00, 0
	map_attributes SafariZoneHub, SAFARI_ZONE_HUB, $54, 0
	map_attributes SafariZoneEast, SAFARI_ZONE_EAST, $54, 0
	map_attributes SafariZoneNorth, SAFARI_ZONE_NORTH, $54, 0
	map_attributes SafariZoneWest, SAFARI_ZONE_WEST, $54, 0
	map_attributes SafariZoneHubRestHouse, SAFARI_ZONE_HUB_REST_HOUSE, $0, 0
	map_attributes SafariZoneEastRestHouse, SAFARI_ZONE_EAST_REST_HOUSE, $0, 0
	map_attributes SafariZoneNorthRestHouse, SAFARI_ZONE_NORTH_REST_HOUSE, $0, 0
	map_attributes SafariZoneWestRestHouse1, SAFARI_ZONE_WEST_REST_HOUSE_1, $0, 0
	map_attributes SafariZoneWestRestHouse2, SAFARI_ZONE_WEST_REST_HOUSE_2, $0, 0
	map_attributes VictoryRoad1F, VICTORY_ROAD_1F, $bd, 0
	map_attributes VictoryRoad2F, VICTORY_ROAD_2F, $bd, 0
	map_attributes VictoryRoad3F, VICTORY_ROAD_3F, $bd, 0
	map_attributes CeruleanCave1F, CERULEAN_CAVE_1F, $bd, 0
	map_attributes CeruleanCave2F, CERULEAN_CAVE_2F, $bd, 0
	map_attributes CeruleanCaveB1F, CERULEAN_CAVE_B1F, $bd, 0
	map_attributes EcruteakTinTowerEntrance, ECRUTEAK_TIN_TOWER_ENTRANCE, $00, 0
	map_attributes WiseTriosRoom, WISE_TRIOS_ROOM, $00, 0
	map_attributes EcruteakPokecenter1F, ECRUTEAK_POKECENTER_1F, $00, 0
	map_attributes EcruteakLugiaSpeechHouse, ECRUTEAK_LUGIA_SPEECH_HOUSE, $00, 0
	map_attributes EcruteakFairyFamilyHouse, ECRUTEAK_FAIRY_FAMILY_HOUSE, $00, 0
	map_attributes EcruteakSwarmHouse, ECRUTEAK_SWARM_HOUSE, $00, 0
	map_attributes DanceTheater, DANCE_THEATER, $00, 0
	map_attributes EcruteakMart, ECRUTEAK_MART, $00, 0
	map_attributes EcruteakGym, ECRUTEAK_GYM, $00, 0
	map_attributes EcruteakItemfinderHouse, ECRUTEAK_ITEMFINDER_HOUSE, $00, 0
	map_attributes BlackthornGym1F, BLACKTHORN_GYM_1F, $00, 0
	map_attributes BlackthornGym2F, BLACKTHORN_GYM_2F, $00, 0
	map_attributes BlackthornDragonSpeechHouse, BLACKTHORN_DRAGON_SPEECH_HOUSE, $00, 0
	map_attributes BlackthornEmysHouse, BLACKTHORN_EMYS_HOUSE, $00, 0
	map_attributes BlackthornMart, BLACKTHORN_MART, $00, 0
	map_attributes BlackthornPokecenter1F, BLACKTHORN_POKECENTER_1F, $00, 0
	map_attributes BlackthornMoveTutorHouse, BLACKTHORN_MOVE_TUTOR_HOUSE, $00, 0
	map_attributes MadamItemsHouse, MADAM_ITEMS_HOUSE, $00, 0
	map_attributes CinnabarPokecenter1F, CINNABAR_POKECENTER_1F, $00, 0
	map_attributes CinnabarVolcano1F, CINNABAR_VOLCANO_1F, $bd, 0
	map_attributes CinnabarVolcano2F, CINNABAR_VOLCANO_2F, $bd, 0
	map_attributes CinnabarMoltresNest, CINNABAR_MOLTRES_NEST, $00, 0
	map_attributes CinnabarIslandRecoveryLab, CINNABAR_ISLAND_RECOVERY_LAB, $00, 0
	map_attributes SeafoamGym, SEAFOAM_GYM, $bd, 0
	map_attributes SeafoamIslands1F, SEAFOAM_ISLANDS_1F, $bd, 0
	map_attributes SeafoamIslandsB1F, SEAFOAM_ISLANDS_B1F, $01, 0
	map_attributes SeafoamIslandsB2F, SEAFOAM_ISLANDS_B2F, $01, 0
	map_attributes SeafoamIslandsB3F, SEAFOAM_ISLANDS_B3F, $01, 0
	map_attributes SeafoamIslandsB4F, SEAFOAM_ISLANDS_B4F, $01, 0
	map_attributes Route19FuchsiaGate, ROUTE_19_FUCHSIA_GATE, $00, 0
	map_attributes CeruleanGymBadgeSpeechHouse, CERULEAN_GYM_BADGE_SPEECH_HOUSE, $00, 0
	map_attributes CeruleanPoliceStation, CERULEAN_POLICE_STATION, $00, 0
	map_attributes CeruleanTradeSpeechHouse, CERULEAN_TRADE_SPEECH_HOUSE, $00, 0
	map_attributes CeruleanPokecenter1F, CERULEAN_POKECENTER_1F, $00, 0
	map_attributes CeruleanGym, CERULEAN_GYM, $00, 0
	map_attributes CeruleanMart, CERULEAN_MART, $00, 0
	map_attributes CeruleanEmptyHouse, CERULEAN_EMPTY_HOUSE, $00, 0
	map_attributes CeruleanEmptyHouseUnderground, CERULEAN_EMPTY_HOUSE_UNDERGROUND, $00, 0
	map_attributes Route10Pokecenter1F, ROUTE_10_POKECENTER_1F, $00, 0
	map_attributes PowerPlant, POWER_PLANT, $00, 0
	map_attributes BillsHouse, BILLS_HOUSE, $00, 0
	map_attributes AzaleaPokecenter1F, AZALEA_POKECENTER_1F, $00, 0
	map_attributes CharcoalKiln, CHARCOAL_KILN, $00, 0
	map_attributes AzaleaMart, AZALEA_MART, $00, 0
	map_attributes KurtsHouse, KURTS_HOUSE, $00, 0
	map_attributes AzaleaGym, AZALEA_GYM, $00, 0
	map_attributes LakeOfRageHiddenPowerHouse, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, $00, 0
	map_attributes LakeOfRageMagikarpHouse, LAKE_OF_RAGE_MAGIKARP_HOUSE, $00, 0
	map_attributes Route43MahoganyGate, ROUTE_43_MAHOGANY_GATE, $00, 0
	map_attributes Route43Gate, ROUTE_43_GATE, $00, 0
	map_attributes VioletMart, VIOLET_MART, $00, 0
	map_attributes VioletGym, VIOLET_GYM, $00, 0
	map_attributes EarlsPokemonAcademy, EARLS_POKEMON_ACADEMY, $00, 0
	map_attributes EarlsPokemonAcademyB1F, EARLS_POKEMON_ACADEMY_B1F, $01, 0
	map_attributes VioletNicknameSpeechHouse, VIOLET_NICKNAME_SPEECH_HOUSE, $00, 0
	map_attributes VioletPokecenter1F, VIOLET_POKECENTER_1F, $00, 0
	map_attributes VioletKylesHouse, VIOLET_KYLES_HOUSE, $00, 0
	map_attributes VioletPrimosHouse, VIOLET_PRIMOS_HOUSE, $00, 0
	map_attributes Route32RuinsOfAlphGate, ROUTE_32_RUINS_OF_ALPH_GATE, $00, 0
	map_attributes Route32Pokecenter1F, ROUTE_32_POKECENTER_1F, $00, 0
	map_attributes Route35GoldenrodGate, ROUTE_35_GOLDENROD_GATE, $00, 0
	map_attributes Route35NationalParkGate, ROUTE_35_NATIONAL_PARK_GATE, $00, 0
	map_attributes Route36RuinsOfAlphGate, ROUTE_36_RUINS_OF_ALPH_GATE, $00, 0
	map_attributes Route36NationalParkGate, ROUTE_36_NATIONAL_PARK_GATE, $00, 0
	map_attributes Route36VioletGate, ROUTE_36_VIOLET_GATE, $00, 0
	map_attributes GoldenrodGym, GOLDENROD_GYM, $00, 0
	map_attributes GoldenrodBikeShop, GOLDENROD_BIKE_SHOP, $00, 0
	map_attributes GoldenrodHappinessRater, GOLDENROD_HAPPINESS_RATER, $00, 0
	map_attributes BillsFamilysHouse, BILLS_FAMILYS_HOUSE, $00, 0
	map_attributes GoldenrodMagnetTrainStation, GOLDENROD_MAGNET_TRAIN_STATION, $00, 0
	map_attributes GoldenrodFlowerShop, GOLDENROD_FLOWER_SHOP, $00, 0
	map_attributes GoldenrodFlowerShopGarden, GOLDENROD_FLOWER_SHOP_GARDEN, $45, 0
	map_attributes GoldenrodPPSpeechHouse, GOLDENROD_PP_SPEECH_HOUSE, $00, 0
	map_attributes GoldenrodNameRater, GOLDENROD_NAME_RATER, $00, 0
	map_attributes GoldenrodDeptStore1F, GOLDENROD_DEPT_STORE_1F, $00, 0
	map_attributes GoldenrodDeptStore2F, GOLDENROD_DEPT_STORE_2F, $00, 0
	map_attributes GoldenrodDeptStore3F, GOLDENROD_DEPT_STORE_3F, $00, 0
	map_attributes GoldenrodDeptStore4F, GOLDENROD_DEPT_STORE_4F, $00, 0
	map_attributes GoldenrodDeptStore5F, GOLDENROD_DEPT_STORE_5F, $00, 0
	map_attributes GoldenrodDeptStore6F, GOLDENROD_DEPT_STORE_6F, $00, 0
	map_attributes GoldenrodDeptStoreElevator, GOLDENROD_DEPT_STORE_ELEVATOR, $00, 0
	map_attributes GoldenrodDeptStoreRoof, GOLDENROD_DEPT_STORE_ROOF, $24, 0
	map_attributes GoldenrodGameCorner, GOLDENROD_GAME_CORNER, $00, 0
	map_attributes GoldenrodPokecenter1F, GOLDENROD_POKECENTER_1F, $00, 0
	map_attributes IlexForestAzaleaGate, ILEX_FOREST_AZALEA_GATE, $00, 0
	map_attributes Route34IlexForestGate, ROUTE_34_ILEX_FOREST_GATE, $00, 0
	map_attributes DayCare, DAY_CARE, $00, 0
	map_attributes GoldenrodHomeDecorStore1F, GOLDENROD_HOME_DECOR_STORE_1F, $00, 0
	map_attributes GoldenrodHomeDecorStore2F, GOLDENROD_HOME_DECOR_STORE_2F, $00, 0
	map_attributes GoldenrodHomeDecorStore3F, GOLDENROD_HOME_DECOR_STORE_3F, $00, 0
	map_attributes GoldenrodHomeDecorStore4F, GOLDENROD_HOME_DECOR_STORE_4F, $00, 0
	map_attributes VermilionFishingSpeechHouse, VERMILION_FISHING_SPEECH_HOUSE, $00, 0
	map_attributes VermilionPokecenter1F, VERMILION_POKECENTER_1F, $00, 0
	map_attributes PokemonFanClub, POKEMON_FAN_CLUB, $00, 0
	map_attributes VermilionMagnetTrainSpeechHouse, VERMILION_MAGNET_TRAIN_SPEECH_HOUSE, $00, 0
	map_attributes VermilionMart, VERMILION_MART, $00, 0
	map_attributes VermilionBerryMart, VERMILION_BERRY_MART, $00, 0
	map_attributes VermilionSailorsHouse, VERMILION_SAILORS_HOUSE, $00, 0
	map_attributes VermilionDiglettsCaveSpeechHouse, VERMILION_DIGLETTS_CAVE_SPEECH_HOUSE, $00, 0
	map_attributes VermilionGym, VERMILION_GYM, $00, 0
	map_attributes Route6SaffronGate, ROUTE_6_SAFFRON_GATE, $00, 0
	map_attributes Route6UndergroundPathEntrance, ROUTE_6_UNDERGROUND_PATH_ENTRANCE, $00, 0
	map_attributes Route11Route12Gate, ROUTE_11_ROUTE_12_GATE, $00, 0
	map_attributes RedsHouse1F, REDS_HOUSE_1F, $00, 0
	map_attributes RedsHouse2F, REDS_HOUSE_2F, $00, 0
	map_attributes BluesHouse, BLUES_HOUSE, $00, 0
	map_attributes OaksLab, OAKS_LAB, $00, 0
	map_attributes Route1ViridianGate, ROUTE_1_VIRIDIAN_GATE, $00, 0
	map_attributes PewterNidoranSpeechHouse, PEWTER_NIDORAN_SPEECH_HOUSE, $00, 0
	map_attributes PewterGym, PEWTER_GYM, $00, 0
	map_attributes PewterMart, PEWTER_MART, $00, 0
	map_attributes PewterPokecenter1F, PEWTER_POKECENTER_1F, $00, 0
	map_attributes PewterSnoozeSpeechHouse, PEWTER_SNOOZE_SPEECH_HOUSE, $00, 0
	map_attributes Route3Pokecenter1F, ROUTE_3_POKECENTER_1F, $00, 0
	map_attributes OlivinePort, OLIVINE_PORT, $0a, 0
	map_attributes VermilionPort, VERMILION_PORT, $0a, 0
	map_attributes FastShip1F, FAST_SHIP_1F, $00, 0
	map_attributes FastShipCabins_NNW_NNE_NE, FAST_SHIP_CABINS_NNW_NNE_NE, $00, 0
	map_attributes FastShipCabins_SW_SSW_NW, FAST_SHIP_CABINS_SW_SSW_NW, $00, 0
	map_attributes FastShipCabins_SE_SSE_CaptainsCabin, FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN, $00, 0
	map_attributes FastShipB1F, FAST_SHIP_B1F, $00, 0
	map_attributes OlivinePortPassage, OLIVINE_PORT_PASSAGE, $00, 0
	map_attributes VermilionPortPassage, VERMILION_PORT_PASSAGE, $00, 0
	map_attributes MountMoonSquare, MOUNT_MOON_SQUARE, $2d, 0
	map_attributes MountMoonGiftShop, MOUNT_MOON_GIFT_SHOP, $00, 0
	map_attributes TinTowerRoof, TIN_TOWER_ROOF, $00, 0
	map_attributes FarawayIslandOutside, FARAWAY_ISLAND_OUTSIDE, $40, 0
	map_attributes FarawayIslandInside, FARAWAY_ISLAND_INSIDE, $6f, 0	
	map_attributes IndigoPlateauPokecenter1F, INDIGO_PLATEAU_POKECENTER_1F, $00, 0
	map_attributes WillsRoom, WILLS_ROOM, $00, 0
	map_attributes KogasRoom, KOGAS_ROOM, $00, 0
	map_attributes BrunosRoom, BRUNOS_ROOM, $00, 0
	map_attributes KarensRoom, KARENS_ROOM, $00, 0
	map_attributes LancesRoom, LANCES_ROOM, $00, 0
	map_attributes HallOfFame, HALL_OF_FAME, $00, 0
	map_attributes FuchsiaMart, FUCHSIA_MART, $00, 0
	map_attributes FuchsiaGym, FUCHSIA_GYM, $00, 0
	map_attributes BillsOlderSistersHouse, BILLS_OLDER_SISTERS_HOUSE, $00, 0
	map_attributes FuchsiaPokecenter1F, FUCHSIA_POKECENTER_1F, $00, 0
	map_attributes SafariZoneWardensHome, SAFARI_ZONE_WARDENS_HOME, $00, 0
	map_attributes Route15FuchsiaGate, ROUTE_15_FUCHSIA_GATE, $00, 0
	map_attributes FuchsiaCinnabarHouse1, FUCHSIA_CINNABAR_HOUSE_1, $00, 0
	map_attributes LavenderPokecenter1F, LAVENDER_POKECENTER_1F, $00, 0
	map_attributes MrFujisHouse, MR_FUJIS_HOUSE, $00, 0
	map_attributes LavenderSpeechHouse, LAVENDER_SPEECH_HOUSE, $00, 0
	map_attributes LavenderNameRater, LAVENDER_NAME_RATER, $00, 0
	map_attributes LavenderMart, LAVENDER_MART, $00, 0
	map_attributes SoulHouse, SOUL_HOUSE, $00, 0
	map_attributes LavRadioTower1F, LAV_RADIO_TOWER_1F, $00, 0
	map_attributes Route8SaffronGate, ROUTE_8_SAFFRON_GATE, $00, 0
	map_attributes Route12SuperRodHouse, ROUTE_12_SUPER_ROD_HOUSE, $00, 0
	map_attributes Route12LavenderGate, ROUTE_12_LAVENDER_GATE, $00, 0
	map_attributes MtSilverPokecenter1F, MT_SILVER_POKECENTER_1F, $00, 0
	map_attributes Route28SteelWingHouse, ROUTE_28_STEEL_WING_HOUSE, $00, 0
	map_attributes Pokecenter2F, POKECENTER_2F, $00, 0
	map_attributes TradeCenter, TRADE_CENTER, $00, 0
	map_attributes Colosseum, COLOSSEUM, $00, 0
;	map_attributes TimeCapsule, TIME_CAPSULE, $00, 0
	map_attributes CeladonDeptStore1F, CELADON_DEPT_STORE_1F, $00, 0
	map_attributes CeladonDeptStore2F, CELADON_DEPT_STORE_2F, $00, 0
	map_attributes CeladonDeptStore3F, CELADON_DEPT_STORE_3F, $00, 0
	map_attributes CeladonDeptStore4F, CELADON_DEPT_STORE_4F, $00, 0
	map_attributes CeladonDeptStore5F, CELADON_DEPT_STORE_5F, $00, 0
	map_attributes CeladonDeptStore6F, CELADON_DEPT_STORE_6F, $00, 0
	map_attributes CeladonDeptStoreElevator, CELADON_DEPT_STORE_ELEVATOR, $00, 0
	map_attributes CeladonMansion1F, CELADON_MANSION_1F, $00, 0
	map_attributes CeladonMansion2F, CELADON_MANSION_2F, $00, 0
	map_attributes CeladonMansion3F, CELADON_MANSION_3F, $00, 0
	map_attributes CeladonMansionRoof, CELADON_MANSION_ROOF, $01, 0
	map_attributes CeladonMansionRoofHouse, CELADON_MANSION_ROOF_HOUSE, $00, 0
	map_attributes CeladonPokecenter1F, CELADON_POKECENTER_1F, $00, 0
	map_attributes CeladonGameCorner, CELADON_GAME_CORNER, $00, 0
	map_attributes CeladonGameCornerPrizeRoom, CELADON_GAME_CORNER_PRIZE_ROOM, $00, 0
	map_attributes CeladonGym, CELADON_GYM, $00, 0
	map_attributes CeladonCafe, CELADON_CAFE, $00, 0
	map_attributes CeladonHomeDecorStore1F, CELADON_HOME_DECOR_STORE_1F, $00, 0
	map_attributes CeladonHomeDecorStore2F, CELADON_HOME_DECOR_STORE_2F, $00, 0
	map_attributes CeladonHomeDecorStore3F, CELADON_HOME_DECOR_STORE_3F, $00, 0
	map_attributes CeladonHomeDecorStore4F, CELADON_HOME_DECOR_STORE_4F, $00, 0
	map_attributes CeladonCurseHouse, CELADON_CURSE_HOUSE, $00, 0
	map_attributes Route16FuchsiaSpeechHouse, ROUTE_16_FUCHSIA_SPEECH_HOUSE, $00, 0
	map_attributes Route16Gate, ROUTE_16_GATE, $00, 0
	map_attributes Route7SaffronGate, ROUTE_7_SAFFRON_GATE, $00, 0
	map_attributes Route17Route18Gate, ROUTE_17_ROUTE_18_GATE, $00, 0
	map_attributes ManiasHouse, MANIAS_HOUSE, $00, 0
	map_attributes CianwoodGym, CIANWOOD_GYM, $df, 0
	map_attributes CianwoodPokecenter1F, CIANWOOD_POKECENTER_1F, $00, 0
	map_attributes CianwoodPharmacy, CIANWOOD_PHARMACY, $00, 0
	map_attributes CianwoodLugiaSpeechHouse, CIANWOOD_LUGIA_SPEECH_HOUSE, $00, 0
	map_attributes CianwoodBeastsHouse, CIANWOOD_BEASTS_HOUSE, $00, 0
	map_attributes CianwoodMoveTutorHouse, CIANWOOD_MOVE_TUTOR_HOUSE, $00, 0
	map_attributes BattleTower1F, BATTLE_TOWER_1F, $00, 0
	map_attributes BattleTowerBattleRoom, BATTLE_TOWER_BATTLE_ROOM, $00, 0
	map_attributes BattleTowerElevator, BATTLE_TOWER_ELEVATOR, $00, 0
	map_attributes BattleTowerHallway, BATTLE_TOWER_HALLWAY, $00, 0
	map_attributes Route40BattleTowerGate, ROUTE_40_BATTLE_TOWER_GATE, $00, 0
	map_attributes BattleTowerOutside, BATTLE_TOWER_OUTSIDE, $05, 0
	map_attributes ViridianGym, VIRIDIAN_GYM, $00, 0
	map_attributes ViridianNicknameSpeechHouse, VIRIDIAN_NICKNAME_SPEECH_HOUSE, $00, 0
	map_attributes TrainerHouse1F, TRAINER_HOUSE_1F, $00, 0
	map_attributes TrainerHouseB1F, TRAINER_HOUSE_B1F, $00, 0
	map_attributes ViridianMart, VIRIDIAN_MART, $00, 0
	map_attributes ViridianPokecenter1F, VIRIDIAN_POKECENTER_1F, $00, 0
	map_attributes Route2NuggetHouse, ROUTE_2_NUGGET_HOUSE, $00, 0
	map_attributes Route2ViridianForestGate, ROUTE_2_VIRIDIAN_FOREST_GATE, $00, 0
	map_attributes ViridianForest, VIRIDIAN_FOREST, $4d, 0
	map_attributes ViridianForestHouse, VIRIDIAN_FOREST_HOUSE, $00, 0
	map_attributes ViridianForestHouseBF1, VIRIDIAN_FOREST_HOUSE_BF1, $00, 0
	map_attributes ViridianForestRoute2Gate, VIRIDIAN_FOREST_ROUTE_2_GATE, $00, 0	
	map_attributes Route2Gate, ROUTE_2_GATE, $00, 0
	map_attributes VictoryRoadGate, VICTORY_ROAD_GATE, $00, 0
	map_attributes ElmsLab, ELMS_LAB, $00, 0
	map_attributes PlayersHouse1F, PLAYERS_HOUSE_1F, $00, 0
	map_attributes PlayersHouse2F, PLAYERS_HOUSE_2F, $00, 0
	map_attributes PlayersNeighborsHouse, PLAYERS_NEIGHBORS_HOUSE, $00, 0
	map_attributes ElmsHouse, ELMS_HOUSE, $00, 0
	map_attributes LyrasHouse1F, LYRAS_HOUSE_1F, $00, 0
	map_attributes LyrasHouse2F, LYRAS_HOUSE_2F, $00, 0
	map_attributes Route26HealHouse, ROUTE_26_HEAL_HOUSE, $00, 0
	map_attributes DayOfWeekSiblingsHouse, DAY_OF_WEEK_SIBLINGS_HOUSE, $00, 0
	map_attributes Route27AerialAceHouse, ROUTE_27_AERIAL_ACE_HOUSE, $00, 0
	map_attributes Route29Route46Gate, ROUTE_29_ROUTE_46_GATE, $00, 0
	map_attributes FightingDojo, FIGHTING_DOJO, $00, 0
	map_attributes SaffronGym, SAFFRON_GYM, $00, 0
	map_attributes SaffronMart, SAFFRON_MART, $00, 0
	map_attributes SaffronPokecenter1F, SAFFRON_POKECENTER_1F, $00, 0
	map_attributes MrPsychicsHouse, MR_PSYCHICS_HOUSE, $00, 0
	map_attributes SaffronMagnetTrainStation, SAFFRON_MAGNET_TRAIN_STATION, $00, 0
	map_attributes SaffronAviculturalSociety1F, SAFFRON_AVICULTURAL_SOCIETY_1F, $00, 0
	map_attributes SaffronAviculturalSociety2F, SAFFRON_AVICULTURAL_SOCIETY_2F, $00, 0
	map_attributes SaffronAviculturalSociety3F, SAFFRON_AVICULTURAL_SOCIETY_3F, $00, 0
	map_attributes SaffronOddishDollHouse, SAFFRON_ODDISH_DOLL_HOUSE, $00, 0
	map_attributes SilphCo1F, SILPH_CO_1F, $00, 0
	map_attributes CopycatsHouse1F, COPYCATS_HOUSE_1F, $00, 0
	map_attributes CopycatsHouse2F, COPYCATS_HOUSE_2F, $00, 0
	map_attributes Route5UndergroundPathEntrance, ROUTE_5_UNDERGROUND_PATH_ENTRANCE, $00, 0
	map_attributes Route5SaffronGate, ROUTE_5_SAFFRON_GATE, $00, 0
	map_attributes Route5CleanseTagHouse, ROUTE_5_CLEANSE_TAG_HOUSE, $00, 0
	map_attributes CherrygroveMart, CHERRYGROVE_MART, $00, 0
	map_attributes CherrygrovePokecenter1F, CHERRYGROVE_POKECENTER_1F, $00, 0
	map_attributes CherrygroveGymSpeechHouse, CHERRYGROVE_GYM_SPEECH_HOUSE, $00, 0
	map_attributes GuideGentsHouse, GUIDE_GENTS_HOUSE, $00, 0
	map_attributes CherrygroveEvolutionSpeechHouse, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, $00, 0
	map_attributes Route30BerryHouse, ROUTE_30_BERRY_HOUSE, $00, 0
	map_attributes MrPokemonsHouse, MR_POKEMONS_HOUSE, $00, 0
	map_attributes Route31VioletGate, ROUTE_31_VIOLET_GATE, $00, 0
