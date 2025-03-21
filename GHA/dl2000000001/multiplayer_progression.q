GH3_General_Coop_Progression = [
	{
		Name = set_initial_states
		Type = Scr
		atom_script = Progression_Coop_Init
		atom_params = {
		}
	}
]

GH3_Coop_Progression = {
	tier_global = GH3_General_Songs_Coop
	progression_global = GH3_General_Coop_Progression
}

Bonus_coop_progression = {
	tier_global = GH3_Bonus_Songs_Coop
	progression_global = NONE
}

GH3_Bonus_Songs_Coop = {
	prefix = 'bonus'
	num_tiers = 1
	tier1 = {
		Title = "Bonus Songs"
		songs = [
			WalkThisWay
			ratsinthecellar
			kingsandqueens
			combination
			letthemusicdothetalking
			shakinmycage
			pink
			talktalking
			mercy
			pandorasbox
			joeperryguitarbattle
		]
		Level = load_z_Nipmuc
		defaultunlocked = 11
	}
}

script Progression_Coop_Init 
	Printf \{"Progression_Coop_Init"}
	GlobalTags_UnlockAll \{SongList = GH3_Bonus_Songs_Coop
			songs_only = 1}
endscript

script get_progression_globals game_mode = <game_mode> use_current_tab = 0
	if (<use_current_tab> = 1)
		if ($current_tab = tab_bonus)
			Bonus = 1
		elseif ($current_tab = tab_downloads)
			Download = 1
		endif
	endif
	if ($is_demo_mode = 1)
		if GotParam \{Bonus}
			AddParams ($Bonus_progression)
		elseif GotParam \{Download}
			AddParams ($Download_progression)
		elseif (<game_mode> = p1_career)
			AddParams ($Demo_progression_Career)
		elseif (<game_mode> = p1_quickplay)
			AddParams ($Demo_progression_Quickplay)
		elseif (<game_mode> = p2_quickplay)
			AddParams ($Demo_progression_Coop)
		else
			AddParams ($Demo_progression_Multiplayer)
		endif
		return tier_global = <tier_global> progression_global = <progression_global>
	endif
	if GotParam \{Bonus}
		if (<game_mode> = p2_quickplay)
			AddParams ($Bonus_coop_progression)
		else
			AddParams ($Bonus_progression)
		endif
	elseif GotParam \{Download}
		AddParams ($Download_progression)
	elseif (<game_mode> = p1_career)
		AddParams ($P1_career_progression)
	elseif (<game_mode> = p1_quickplay)
		AddParams ($General_progression)
	elseif (<game_mode> = p2_quickplay)
		AddParams ($GH3_Coop_Progression)
	elseif (<game_mode> = p2_coop)
		AddParams ($GH3_Coop_Progression)
	else
		AddParams ($General_progression)
	endif
	return tier_global = <tier_global> progression_global = <progression_global>
endscript

GH3_General_Songs_Coop = {
	prefix = 'general'
	num_tiers = 8
	tier1 = {
		Title = "1. Getting the band together"
		songs = [
			dreampolice
			alltheyoungdudes
			makeit
			unclesalty
			DrawTheLine
		]
		Level = load_z_Nipmuc
		defaultunlocked = 5
		completion_movie = 'AO_short_2'
		setlist_icon = setlist_icon_01
	}
	tier2 = {
		Title = "2. First taste of success"
		songs = [
			ihatemyselfforlovingyou
			alldayandallofthenight
			nosurprize
			movinout
			sweetemotion
		]
		Level = load_z_MaxsKC
		defaultunlocked = 5
		completion_movie = 'AO_short_3'
		setlist_icon = setlist_icon_02
	}
	tier3 = {
		Title = "3. The triumphant return"
		songs = [
			completecontrol
			personalitycrisis
			livinontheedge
			Ragdoll
			loveinanelevator
		]
		Level = load_z_Fenway
		defaultunlocked = 5
		completion_movie = 'AO_short_4'
		setlist_icon = setlist_icon_03
	}
	tier4 = {
		Title = "4. International Superstars"
		songs = [
			shesellssanctuary
			kingofrock
			nobodysfault
			brightlightfright
			walkthiswayrundmc
		]
		Level = load_z_nine_lives
		defaultunlocked = 5
		completion_movie = 'AO_short_5'
		setlist_icon = setlist_icon_04
	}
	tier5 = {
		Title = "5. The Great American Band"
		songs = [
			hardtohandle
			alwaysontherun
			BackInTheSaddle
			beyondbeautiful
			dreamon
		]
		Level = load_z_JPPlay
		defaultunlocked = 5
		completion_movie = 'AO_short_6'
		setlist_icon = setlist_icon_05
	}
	tier6 = {
		Title = "6. Rock 'N Roll Legends"
		songs = [
			catscratchfever
			sextypething
			mamakin
			ToysInTheAttic
			trainkeptarollin
		]
		Level = load_z_hof
		defaultunlocked = 5
		completion_movie = 'singleplayer_end'
		setlist_icon = setlist_icon_06
	}
	tier7 = {
		Title = "Bonus Songs"
		songs = [
			WalkThisWay
			ratsinthecellar
			kingsandqueens
			combination
			letthemusicdothetalking
			shakinmycage
			pink
			talktalking
			mercy
			pandorasbox
			joeperryguitarbattle
		]
		Level = load_z_Nipmuc
		defaultunlocked = 11
	}
	tier8 = {
		Title = "Secret Song"
		songs = [
			sosadcover
		]
		Level = load_z_Nipmuc
		defaultunlocked = 1
	}
}
