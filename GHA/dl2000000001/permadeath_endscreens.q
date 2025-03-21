fcd_all_songs_last_song = 0
force_credits = 0

PD_Bonus_NumSongToProgress = {
	easy = 11
	medium = 11
	hard = 11
	expert = 11
}


permadeath_fgfc_fs = {
	Create = create_beat_permadeath_menu
	destroy = destroy_beat_game_menu
	actions = [
		{
			action = continue
			flow_state = career_newspaper_fs
			transition_right
		}
	]
}

script create_beat_permadeath_menu 
	calculate_max_streak_song
	calculate_max_streak_total
	pd_streak = ($permadeath_max_streak)
	FormatText textname = pd_streak_text "%i" i = <pd_streak> usecommas
	create_menu_backdrop \{texture = Beat_Game_BG}
	menu_font = fontgrid_title_gh3
	get_current_band_info
	GetGlobalTags <band_info> param = name
	band_name = <name>
	FormatText textname = band_name_text "%s" s = <band_name>
	difficulty_text = ($def_expert_text)
	next_difficulty_text = "'Take It Easy'"
	<difficulty> = ($current_difficulty)
	switch (<difficulty>)
		case easy
		<difficulty_text> = ($def_easy_text)
		next_difficulty = medium
		<next_difficulty_text> = ($def_medium_text)
		case medium
		<difficulty_text> = ($def_medium_text)
		next_difficulty = hard
		<next_difficulty_text> = ($def_hard_text)
		case hard
		<difficulty_text> = ($def_hard_text)
		next_difficulty = expert
		<next_difficulty_text> = ($def_expert_text)
	endswitch
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = beat_game_container
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_band_name
		just = [center top]
		font = <menu_font>
		text = <band_name_text>
		Scale = 1.38
		rgba = (($G_menu_colors).pink)
		Pos = (640.0, 366.0)
	}
	GetScreenElementDims \{id = bgs_band_name}
	if (<width> > 300)
		fit_text_in_rectangle \{id = bgs_band_name
			dims = (1060.0, 130.0)
			Pos = (640.0, 366.0)}
	endif
	FormatText textname = title_text $beat_permadeath_title d = <difficulty_text>
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_under_title
		just = [left top]
		font = <menu_font>
		text = <title_text>
		Scale = 1.0
		rgba = (($G_menu_colors).lt_violet_grey)
	}
	fit_text_in_rectangle \{id = bgs_under_title
		dims = (700.0, 65.0)
		Pos = (300.0, 428.0)}
	if (<difficulty> = expert)
		FormatText TextName = motivation_text ($beat_permadeath_message_expert) i = <pd_streak_text>
	else
		FormatText textname = motivation_text ($beat_game_message) n = <next_difficulty_text>
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = beat_game_container
		font = text_a4
		text = <motivation_text>
		dims = (1100.0, 700.0)
		Pos = (640.0, 468.0)
		rgba = (($G_menu_colors).dk_violet_grey)
		just = [center top]
		internal_just = [center top]
		Scale = 0.7
		z_priority = 3
	}
	final_message = ($permadeath_disabled_text)
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_cheat_text
		just = [center top]
		font = <menu_font>
		text = <final_message>
		Scale = 0.5
		Pos = (640.0, 622.0)
		rgba = [250 245 145 255]
	}
	button_font = buttonsxenon
	displaySprite \{id = bgs_black_banner
		parent = beat_game_container
		tex = white
		Pos = (0.0, -2.0)
		dims = (1240.0, 100.0)
		rgba = [
			0
			0
			0
			255
		]
		z = -2}
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = continue_text
		Scale = 1.0
		Pos = (40.0, 20.0)
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action params = {action = continue}}
		]
	}
	SpawnScriptNow scroll_ticker_text Params = {ticker_text = <band_name_text>}
	LaunchEvent \{type = focus
		target = continue_text}
	change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = $text_button_continue
		button = green
		z = 100}
endscript

script Permadeath_CheckBonusSongComplete 
	printf \{"Progression_CheckSongComplete"}
	get_progression_globals game_mode = ($game_mode) bonus
	songlist = <tier_global>
	progression_getdifficulty
	songs_required = (<numsongstoprogress>.<difficulty>)
	setlist_prefix = (<songlist>.prefix)
	FormatText checksumname = tiername '%ptier%i' p = 'bonus' i = <tier>
	FormatText checksumname = tier_checksum 'tier%s' s = <tier>
	GetArraySize (<songlist>.<tier_checksum>.songs)
	array_count = 0
	begin
	FormatText checksumname = song_checksum '%p_song%i_tier%s' p = 'bonus' i = (<array_count> + 1) s = <tier> addtostringlookup = TRUE
	GetGlobalTags <song_checksum> param = stars
	if (<stars> > 2)
		songs_required = (<songs_required> - 1)
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	SetGlobalTags <tiername> params = {num_songs_to_progress = <songs_required>}
	if (<songs_required> > 0)
		return \{FALSE}
	else
		return \{TRUE}
	endif
endscript

script Permadeath_BonusComplete
	change \{fcd_all_songs_last_song = 1}
	difficulty = ($current_difficulty)
	if (<difficulty> = easy)
		change \{permadeath_disabled_easy = 1}
	elseif (<difficulty> = medium)
		change \{permadeath_disabled_medium = 1}
	elseif (<difficulty> = hard)
		change \{permadeath_disabled_hard = 1}
	elseif (<difficulty> = expert)
		change \{permadeath_disabled_expert = 1}
		change \{force_credits = 1}
		change \{end_credits = 1}
		FormatText \{checksumname = bonus_song_checksum
			'%p_song%i_tier%s'
			p = 'bonus'
			i = 12
			s = 1}
		SetGlobalTags <bonus_song_checksum> params = {unlocked = 1}
		SetGlobalTags ($GH3_Bonus_Songs.tier1.songs [11]) params = {unlocked = 1}
	endif
endscript

script Progression_EndCreditsPermadeath
	printf \{"CREDITS2 BEGIN"}
	change \{current_level = load_z_credits}
	ui_flow_manager_respond_to_action \{action = select_retry}
	change \{current_song = sosadcover}
	create_loading_screen
	Load_Venue
	restart_gem_scroller song_name = ($current_song) difficulty = ($current_difficulty) difficulty2 = ($current_difficulty2) starttime = 0 end_credits_restart = 1
	destroy_loading_screen
	start_flow_manager \{flow_state = career_play_song_fs}
	spawnscriptnow \{scrolling_list_begin}
endscript

