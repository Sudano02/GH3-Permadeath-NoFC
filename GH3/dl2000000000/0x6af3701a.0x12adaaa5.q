enable_saving = 0
gh3_button_font = buttonsxenon
bunny_flame_index = 1
g_anim_flame = 1

permadeath_text = "Permadeath Mode"
permadeath_lives = 3
permadeath_lives_total = 3
permadeath_fails = 0
permadeath_toggle = 1
permadeath_max_streak = 0
permadeath_max_song_count = 0

script create_fail_song_menu 
	change permadeath_lives = ($permadeath_lives - 1)
	if ($permadeath_lives > 0)
		fail_song_menu_select_new_song
	else
		change permadeath_lives = 3
		change permadeath_fails = ($permadeath_fails + 1)
		handle_signin_changed
	endif
endscript

script create_signin_changed_menu 
	permadeath_popup_text = "Welcome to GH3 Permadeath!  Miss a note and reset to the very start of the game.  Saving is disabled.  Good Luck!"
	permadeath_continue = "SUFFER"
	permadeath_title = "PERMADEATH"
	if ($permadeath_fails > 0)
		FormatText textname = text "Uh oh!  You have run out of lives!  Unfortunately that means your progress has been reset.  Here's to attempt #%i" i = ($permadeath_fails + 1)
		permadeath_popup_text = <text>
		permadeath_continue = Random (@ "RESET EVERYTHING :(" @ "KILL YOUR SAVE :O" @ "LOSE IT ALL :'(" )
		permadeath_title = Random (@ "YA DUN GOOFED!" @ "WOMP WOMP" @ "OH NO!" @ "BIFFED IT")
	endif
	destroy_popup_warning_menu
	create_popup_warning_menu {
		title = <permadeath_title>
		title_props = {
			scale = 1.0
		}
		textblock = {
			text = <permadeath_popup_text>
			pos = (640.0, 390.0)
		}
		menu_pos = (640.0, 510.0)
		options = [
			{
				func = signing_change_confirm_reboot
				text = <permadeath_continue>
				scale = (1.0, 1.0)
			}
		]}
endscript

script setlist_show_helperbar \{text_option1 = "BONUS"
		text_option2 = "DOWNLOADS"
		button_option1 = "\\b7"
		button_option2 = "\\b8"
		spacing = 16}
	if NOT English
		change \{pill_helper_max_width = 65}
	endif
	text_options = [
		"UP/DOWN"
		"SELECT"
		"BACK"
	]
	button_options = [
		"\\bb"
		"\\m0"
		"\\m1"
	]
	i = 0
	begin
	if (<i> > 2)
		if (<i> = 3)
			<text1> = <button_option1>
		else
			<text1> = <button_option2>
		endif
	else
		<text1> = (<button_options> [<i>])
	endif
	if (<i> > 2)
		if (<i> = 3)
			<text2> = <text_option1>
		else
			<text2> = <text_option2>
		endif
	else
		<text2> = (<text_options> [<i>])
	endif
	switch <text1>
		case "\\bb"
		<button> = strumbar
		case "\\m0"
		<button> = green
		case "\\m1"
		<button> = red
		case "\\b6"
		<button> = yellow
		case "\\b7"
		<button> = blue
		case "\\b8"
		<button> = orange
	endswitch
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
	if ($is_network_game = 1)
		if ishost
			if ($host_songs_to_pick > 0)
				if NOT (($g_tie_breaker_song = 1) && (<i> = 2))
					add_user_control_helper text = <text2> button = <button> z = 100
				endif
			endif
		else
			if ($client_songs_to_pick > 0)
				if NOT (($g_tie_breaker_song = 1) && (<i> = 2))
					add_user_control_helper text = <text2> button = <button> z = 100
				endif
			endif
		endif
	else
		add_user_control_helper text = <text2> button = <button> z = 100
	endif
	<i> = (<i> + 1)
	repeat 5
	tabs_text = ["setlist" "bonus" "downloads"]
	setlist_text_positions = [(300.0, 70.0) (624.0, 102.0) (870.0, 120.0)]
	download_text_positions = [(300.0, 70.0) (624.0, 102.0) (870.0, 160.0)]
	buttons_text = ["\\b7" "\\b6" "\\b8"]
	setlist_button_positions = [(580.0, 90.0) (260.0, 65.0) (830.0, 110.0)]
	download_button_positions = [(580.0, 90.0) (260.0, 65.0) (830.0, 150.0)]
	i = 0
	begin
	button_text_pos = (<setlist_button_positions> [<i>])
	if ($current_tab = tab_downloads)
		<button_text_pos> = (<download_button_positions> [<i>])
	endif
	displayText parent = setlist_menu Scale = 1 text = (<buttons_text> [<i>]) rgba = [128 128 128 255] Pos = <button_text_pos> z = 50 font = buttonsxenon
	tab_text_pos = (<setlist_text_positions> [<i>])
	if ($current_tab = tab_downloads)
		<tab_text_pos> = (<download_text_positions> [<i>])
	endif
	displayText parent = setlist_menu Scale = 1 text = (<tabs_text> [<i>]) rgba = [0 0 0 255] Pos = <tab_text_pos> z = 50 noshadow
	<i> = (<i> + 1)
	repeat 3
	if ($permadeath_toggle = 1)
		lives_ratio = (($permadeath_lives * 1.0) / ($permadeath_lives_total * 1.0))
		green_text = [0 190 0 255]
		orange_text = [190 85 0 255]
		red_text = [190 0 0 255]
		colour_array = [0 0 0 255]
		if (<lives_ratio> > 0.5)
			t = ((<lives_ratio> - 0.5) * 2)
			val1 = (((<green_text> [0]) * <t>) + ((<orange_text> [0]) * (1 - <t>)))
			val2 = (((<green_text> [1]) * <t>) + ((<orange_text> [1]) * (1 - <t>)))
			val3 = (((<green_text> [2]) * <t>) + ((<orange_text> [2]) * (1 - <t>)))
			CastToInteger \{val1}
			CastToInteger \{val2}
			CastToInteger \{val3}
			SetArrayElement arrayName = colour_array index = 0 newValue = (<val1>)
			SetArrayElement arrayName = colour_array index = 1 newValue = (<val2>)
			SetArrayElement arrayName = colour_array index = 2 newValue = (<val3>)
		else
			t = (<lives_ratio> * 2)
			val1 = (((<orange_text> [0]) * <t>) + ((<red_text> [0]) * (1 - <t>)))
			val2 = (((<orange_text> [1]) * <t>) + ((<red_text> [1]) * (1 - <t>)))
			val3 = (((<orange_text> [2]) * <t>) + ((<red_text> [2]) * (1 - <t>)))
			CastToInteger \{val1}
			CastToInteger \{val2}
			CastToInteger \{val3}
			SetArrayElement arrayName = colour_array index = 0 newValue = (<val1>)
			SetArrayElement arrayName = colour_array index = 1 newValue = (<val2>)
			SetArrayElement arrayName = colour_array index = 2 newValue = (<val3>)
		endif
		if ($permadeath_lives = 1)
			<colour_array> = <red_text>
		endif
		FormatText textname = text "Permadeath Lives: %i" i = $permadeath_lives
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = <colour_array> Pos = (870.0, 240.0) z = 50
		FormatText textname = text "Attempt #: %i" i = ($permadeath_fails + 1)
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (870.0, 280.0) z = 50
		FormatText textname = text "Max Note Streak: %i" i = $permadeath_max_streak
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (870.0, 320.0) z = 50
		FormatText textname = text "Max FC Count: %i" i = $permadeath_max_song_count
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (870.0, 360.0) z = 50
	endif
endscript

script testing_scripts_do_not_use
	FormatText textname = text "Colour Array: %i %j %k" i = <val1> j = <val2> k = <val3>
	displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (870.0, 200.0) z = 50
endscript

script intro_song_info 
	begin
	getsongtimems
	if ($current_intro.song_title_start_time + $current_starttime < <time>)
		break
	endif
	wait \{1
		gameframe}
	repeat
	if ($current_intro.song_title_on_time = 0)
		return
	endif
	get_song_title song = ($current_song)
	GetUpperCaseString <song_title>
	intro_song_info_text :setprops text = <uppercasestring>
	intro_song_info_text :DoMorph Pos = ($current_intro.song_title_pos)
	get_song_artist song = ($current_song)
	GetUpperCaseString <song_artist>
	intro_artist_info_text :setprops text = <uppercasestring>
	intro_artist_info_text :DoMorph Pos = ($current_intro.song_artist_pos)
	get_song_artist_text song = ($current_song)
	GetUpperCaseString <song_artist_text>
	intro_performed_by_text :setprops text = <uppercasestring>
	intro_performed_by_text :DoMorph Pos = ($current_intro.performed_by_pos)
	get_song_covered_by song = ($current_song)
	if GotParam \{covered_by}
		GetUpperCaseString <covered_by>
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = intro_covered_by_text
			font = text_a10
			just = [
				left
				top
			]
			Scale = (1.0, 0.5)
			rgba = [
				230
				205
				160
				255
			]
			text = "COVERED BY"
			z_priority = 5.0
			alpha = 0
			shadow
			shadow_offs = (1.0, 1.0)}
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = intro_covered_by
			font = text_a10
			just = [
				left
				top
			]
			Scale = 1.0
			rgba = [
				255
				190
				70
				255
			]
			text = "Coverer"
			z_priority = 5.0
			alpha = 0
			shadow
			shadow_offs = (1.0, 1.0)}
		intro_covered_by_text :DoMorph Pos = ((255.0, 200.0))
		intro_covered_by :setprops text = <uppercasestring>
		intro_covered_by :DoMorph Pos = ((255.0, 215.0))
	endif
	intro_song_info_text :setprops \{z_priority = 5.0}
	intro_artist_info_text :setprops \{z_priority = 5.0}
	intro_performed_by_text :setprops \{z_priority = 5.0}
	DoScreenElementMorph id = intro_song_info_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	DoScreenElementMorph id = intro_performed_by_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	DoScreenElementMorph id = intro_artist_info_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	if GotParam \{covered_by}
		DoScreenElementMorph id = intro_covered_by_text alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
		DoScreenElementMorph id = intro_covered_by alpha = 1 time = ($current_intro.song_title_fade_time / 1000.0)
	endif
	wait ($current_intro.song_title_on_time / 1000.0) seconds
	DoScreenElementMorph id = intro_song_info_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	DoScreenElementMorph id = intro_artist_info_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	DoScreenElementMorph id = intro_performed_by_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
	if GotParam \{covered_by}
		DoScreenElementMorph id = intro_covered_by_text alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
		DoScreenElementMorph id = intro_covered_by alpha = 0 time = ($current_intro.song_title_fade_time / 1000.0)
		wait ($current_intro.song_title_fade_time / 1000.0) seconds
		DestroyScreenElement \{id = intro_covered_by_text}
		DestroyScreenElement \{id = intro_covered_by}
	endif
endscript

script destroy_intro 
	KillSpawnedScript \{id = intro_scripts}
	KillSpawnedScript \{name = Song_Intro_Kick_SFX_Waiting}
	KillSpawnedScript \{name = Song_Intro_Highway_Up_SFX_Waiting}
	KillSpawnedScript \{name = move_highway_2d}
	KillSpawnedScript \{name = intro_buttonup_ripple}
	KillSpawnedScript \{name = intro_hud_move}
	DoScreenElementMorph \{id = intro_song_info_text
		alpha = 0}
	DoScreenElementMorph \{id = intro_artist_info_text
		alpha = 0}
	DoScreenElementMorph \{id = intro_performed_by_text
		alpha = 0}
	if ScreenElementExists \{id = intro_covered_by}
		DestroyScreenElement \{id = intro_covered_by}
	endif
	if ScreenElementExists \{id = intro_covered_by_text}
		DestroyScreenElement \{id = intro_covered_by_text}
	endif
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> addtostringlookup
	EnableInput controller = ($<player_status>.controller)
	player = (<player> + 1)
	repeat $current_num_players
endscript

song_covers_wavegroup = {
	slowride
	blacksunshine
	cliffsofdover
	holidayincambodia
	storyofmylife
	shebangsadrum
}

song_covers_steve = {
	barracuda
	citiesonflame
	hitmewithyourbestshot
	mississippiqueen
	rockulikeahurricane
	schoolsout
	talkdirtytome
}

song_covers_line6 = {
	blackmagicwoman
	lagrange
	paranoid
	pridenjoy
	rocknrollallnite
	theseeker
	sunshineofyourlove
}

script get_song_covered_by \{song = invalid}
	if StructureContains structure = $gh3_songlist_props <song>
		if StructureContains structure = ($gh3_songlist_props.<song>) covered_by
			return covered_by = ($gh3_songlist_props.<song>.covered_by) TRUE
		elseif StructureContains structure = $song_covers_wavegroup <song>
			return covered_by = "WaveGroup" TRUE
		elseif StructureContains structure = $song_covers_steve <song>
			return covered_by = "Steve Ouimette" TRUE
		elseif StructureContains structure = $song_covers_line6 <song>
			return covered_by = "Line 6" TRUE
		else
			return \{FALSE}
		endif
	endif
	printstruct <...>
	scriptassert \{"Song not found"}
endscript

script setup_user_option_tags 
	SetGlobalTags \{user_options
		params = {
			guitar_volume = 11
			band_volume = 11
			sfx_volume = 11
			lefty_flip_p1 = 0
			lefty_flip_p2 = 0
			lag_calibration = 0.0
			autosave = 0
			resting_whammy_position_device_0 = -0.76
			resting_whammy_position_device_1 = -0.76
			resting_whammy_position_device_2 = -0.76
			resting_whammy_position_device_3 = -0.76
			resting_whammy_position_device_4 = -0.76
			resting_whammy_position_device_5 = -0.76
			resting_whammy_position_device_6 = -0.76
			star_power_position_device_0 = -1.0
			star_power_position_device_1 = -1.0
			star_power_position_device_2 = -1.0
			star_power_position_device_3 = -1.0
			star_power_position_device_4 = -1.0
			star_power_position_device_5 = -1.0
			star_power_position_device_6 = -1.0
			gamma_brightness = 5
			online_game_mode = 0
			online_difficulty = 0
			online_num_songs = 0
			online_tie_breaker = 0
			online_highway = 0
			unlock_Cheat_AirGuitar = 1
			unlock_Cheat_PerformanceMode = 1
			unlock_Cheat_Hyperspeed = 1
			unlock_Cheat_NoFail = 0
			unlock_Cheat_EasyExpert = 0
			unlock_Cheat_PrecisionMode = 1
			unlock_Cheat_BretMichaels = 1
		}}
endscript

default_event_handlers = [
	{
		pad_up
		generic_menu_up_or_down_sound
		params = {
			up
		}
	}
	{
		pad_down
		generic_menu_up_or_down_sound
		params = {
			down
		}
	}
	{
		pad_back
		generic_menu_pad_back
		params = {
			callback = menu_flow_go_back
		}
	}
]
menu_text_color = [
	215
	160
	110
	255
]

script create_using_guitar_controller_menu 
	handle_signin_changed
endscript

script memcard_save_file \{overwriteconfirmed = 0}
	memcard_sequence_quit
endscript

script destroy_download_scan_menu 
	destroy_popup_warning_menu
endscript

script menu_flow_go_back \{player = 1
		create_params = {
		}
		destroy_params = {
		}}
	ui_flow_manager_respond_to_action action = go_back player = <player> create_params = <create_params> destroy_params = <destroy_params>
endscript

script new_menu \{menu_pos = $menu_pos
		event_handlers = $default_event_handlers
		use_backdrop = 0
		z = 1
		dims = (400.0, 480.0)
		font = text_a1
		font_size = 0.75
		default_colors = 1
		just = [
			left
			top
		]
		no_focus = 0
		internal_just = [
			center
			top
		]}
	if screenelementexists id = <scrollid>
		printf "script new_menu - %s Already exists." s = <scrollid>
		return
	endif
	if screenelementexists id = <vmenuid>
		printf "script new_menu - %s Already exists." s = <vmenuid>
		return
	endif
	createscreenelement {
		type = vscrollingmenu
		parent = root_window
		id = <scrollid>
		just = <just>
		dims = <dims>
		pos = <menu_pos>
		z_priority = <z>
	}
	if (<use_backdrop>)
		create_generic_backdrop
	endif
	if gotparam \{name}
		createscreenelement {
			type = textelement
			parent = <scrollid>
			font = <font>
			pos = (0.0, -45.0)
			scale = <font_size>
			rgba = [210 210 210 250]
			text = <name>
			just = <just>
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [0 0 0 255]
		}
	endif
	createscreenelement {
		type = vmenu
		parent = <scrollid>
		id = <vmenuid>
		pos = (0.0, 0.0)
		just = <just>
		internal_just = <internal_just>
		event_handlers = <event_handlers>
	}
	if gotparam \{rot_angle}
		SetScreenElementProps id = <vmenuid> rot_angle = <rot_angle>
	endif
	if gotparam \{no_wrap}
		SetScreenElementProps id = <vmenuid> dont_allow_wrap
	endif
	if gotparam \{spacing}
		SetScreenElementProps id = <vmenuid> spacing_between = <spacing>
	endif
	if gotparam \{text_left}
		SetScreenElementProps id = <vmenuid> internal_just = [left top]
	endif
	if gotparam \{text_right}
		SetScreenElementProps id = <vmenuid> internal_just = [right top]
	endif
	if NOT gotparam \{exclusive_device}
		exclusive_device = ($primary_controller)
	endif
	if NOT (<exclusive_device> = none)
		SetScreenElementProps {
			id = <scrollid>
			exclusive_device = <exclusive_device>
		}
		SetScreenElementProps {
			id = <vmenuid>
			exclusive_device = <exclusive_device>
		}
	endif
	if gotparam \{tierlist}
		tier = 0
		begin
		<tier> = (<tier> + 1)
		setlist_prefix = ($<tierlist>.prefix)
		formattext checksumname = tiername '%ptier%i' p = <setlist_prefix> i = (<tier>)
		formattext checksumname = tier_checksum 'tier%s' s = (<tier>)
		<unlocked> = 1
		GetGlobalTags <tiername> param = unlocked
		if ((<unlocked> = 1) || ($is_network_game))
			getarraysize ($<tierlist>.<tier_checksum>.songs)
			song_count = 0
			if (<array_size> > 0)
				begin
				formattext checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1) s = (<tier>) addtostringlookup = true
				for_bonus = 0
				if ($current_tab = tab_bonus)
					<for_bonus> = 1
				endif
				if issongavailable song_checksum = <song_checksum> song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>]) for_bonus = <for_bonus>
					get_song_title song = ($<tierlist>.<tier_checksum>.songs [<song_count>])
					createscreenelement {
						type = textelement
						parent = <vmenuid>
						font = <font>
						scale = <font_size>
						rgba = [210 210 210 250]
						text = <song_title>
						just = [left top]
						event_handlers = [
							{focus menu_focus}
							{unfocus menu_unfocus}
							{pad_choose <on_choose> params = {tier = <tier> song_count = <song_count>}}
							{pad_left <on_left> params = {tier = <tier> song_count = <song_count>}}
							{pad_right <on_right> params = {tier = <tier> song_count = <song_count>}}
							{pad_l3 <on_l3> params = {tier = <tier> song_count = <song_count>}}
						]
					}
				endif
				song_count = (<song_count> + 1)
				repeat <array_size>
			endif
		endif
		repeat ($<tierlist>.num_tiers)
	endif
	if (<default_colors>)
		set_focus_color rgba = ($default_menu_focus_color)
		set_unfocus_color rgba = ($default_menu_unfocus_color)
	endif
	if (<no_focus> = 0)
		launchevent type = focus target = <vmenuid>
	endif
endscript

script destroy_menu 
	if gotparam \{menu_id}
		if screenelementexists id = <menu_id>
			destroyscreenelement id = <menu_id>
		endif
		destroy_generic_backdrop
	endif
endscript

script create_main_menu_backdrop 
	create_menu_backdrop \{texture = GH3_Main_Menu_BG}
	base_menu_pos = (730.0, 90.0)
	createscreenelement {
		type = containerelement
		id = main_menu_text_container
		parent = root_window
		pos = (<base_menu_pos>)
		just = [left top]
		z_priority = 3
		scale = 0.8
	}
	createscreenelement \{type = containerelement
		id = main_menu_bg_container
		parent = root_window
		pos = (0.0, 0.0)
		z_priority = 3}
	createscreenelement \{type = spriteelement
		id = main_menu_bg2
		parent = main_menu_bg_container
		texture = main_menu_bg2
		pos = (335.0, 0.0)
		dims = (720.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 1}
	RunScriptOnScreenElement id = main_menu_bg2 glow_menu_element params = {time = 1 id = <id>}
	createscreenelement \{type = spriteelement
		parent = main_menu_bg_container
		texture = main_menu_illustrations
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		z_priority = 2}
	createscreenelement \{type = spriteelement
		id = eyes_BL
		parent = main_menu_bg_container
		texture = main_menu_eyesBL
		pos = (93.0, 676.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_BL glow_menu_element params = {time = 1.0 id = <id>}
	createscreenelement \{type = spriteelement
		id = eyes_BR
		parent = main_menu_bg_container
		texture = main_menu_eyesBR
		pos = (1176.0, 659.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_BR glow_menu_element params = {time = 1.0 id = <id>}
	createscreenelement \{type = spriteelement
		id = eyes_C
		parent = main_menu_bg_container
		texture = main_menu_eyesC
		pos = (406.0, 398.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_C glow_menu_element params = {time = 1.5 id = <id>}
	createscreenelement \{type = spriteelement
		id = eyes_TL
		parent = main_menu_bg_container
		texture = main_menu_eyesTL
		pos = (271.0, 215.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_TL glow_menu_element params = {time = 1.7 id = <id>}
	createscreenelement \{type = spriteelement
		id = eyes_TR
		parent = main_menu_bg_container
		texture = main_menu_eyesTR
		pos = (995.0, 71.0)
		dims = (128.0, 64.0)
		just = [
			center
			center
		]
		z_priority = 3}
	RunScriptOnScreenElement id = eyes_TR glow_menu_element params = {time = 1.0 id = <id>}
endscript
main_menu_movie_first_time = 1

script create_main_menu 
	GetGlobalTags \{user_options}
	menu_audio_settings_update_guitar_volume vol = <guitar_volume>
	menu_audio_settings_update_band_volume vol = <band_volume>
	menu_audio_settings_update_sfx_volume vol = <sfx_volume>
	setsoundbussparams {crowd = {vol = ($default_BussSet.crowd.vol)}}
	if ($main_menu_movie_first_time = 0)
		fadetoblack \{on
			time = 0
			alpha = 1.0
			z_priority = 900}
	endif
	create_main_menu_backdrop
	if ($main_menu_movie_first_time = 0 && $invite_controller = -1)
		PlayMovieAndWait \{movie = 'GH3_Intro'
			noblack
			noletterbox}
		change \{main_menu_movie_first_time = 1}
		fadetoblack \{off
			time = 0}
	endif
	SetMenuAutoRepeatTimes \{(0.3, 0.05)}
	kill_start_key_binding
	unpausegame
	change \{current_num_players = 1}
	change structurename = player1_status controller = ($primary_controller)
	change \{player_controls_valid = 0}
	disable_pause
	spawnscriptnow \{menu_music_on}
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
	else
		demo_mode_disable = {rgba = [80 80 80 255] not_focusable}
	endif
	DeRegisterAtoms
	RegisterAtoms \{name = achievement
		$Achievement_Atoms}
	change \{setlist_previous_tier = 1}
	change \{setlist_previous_song = 0}
	change \{setlist_previous_tab = tab_setlist}
	change \{current_song = welcometothejungle}
	change \{end_credits = 0}
	change \{battle_sudden_death = 0}
	change \{structurename = player1_status
		character_id = axel}
	change \{structurename = player2_status
		character_id = axel}
	change \{default_menu_focus_color = [
			125
			0
			0
			255
		]}
	change \{default_menu_unfocus_color = $menu_text_color}
	safe_create_gh3_pause_menu
	base_menu_pos = (730.0, 90.0)
	main_menu_font = fontgrid_title_gh3
	new_menu scrollid = main_menu_scrolling_menu vmenuid = vmenu_main_menu use_backdrop = (0) menu_pos = (<base_menu_pos>)
	change \{rich_presence_context = presence_main_menu}
	career_text_off = (-30.0, 0.0)
	career_text_scale = (1.55, 1.4499999)
	coop_career_text_off = (<career_text_off> + (30.0, 63.0))
	coop_career_text_scale = (0.8, 0.9)
	quickplay_text_off = (<coop_career_text_off> + (-35.0, 40.0))
	quickplay_text_scale = (1.65, 1.55)
	multiplayer_text_off = (<quickplay_text_off> + (-40.0, 65.0))
	multiplayer_text_scale = (1.2, 1.1)
	training_text_off = (<multiplayer_text_off> + (60.0, 47.0))
	training_text_scale = (1.5, 1.5)
	options_text_off = (<training_text_off> + (-20.0, 63.0))
	options_text_scale = (1.2, 1.1)
	leaderboards_text_off = (<options_text_off> + (20.0, 48.0))
	leaderboards_text_scale = (1.1, 1.0)
	debug_menu_text_off = (<leaderboards_text_off> + (-30.0, 160.0))
	debug_menu_text_scale = 0.8
	createscreenelement {
		type = textelement
		id = main_menu_career_text
		parent = main_menu_text_container
		text = "CAREER"
		font = <main_menu_font>
		pos = {(<career_text_off>) relative}
		scale = (<career_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		font_spacing = 0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getScreenElementDims id = <id>
	if (<width> > 420)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_coop_career_text
		parent = main_menu_text_container
		text = "CO-OP CAREER"
		font = <main_menu_font>
		pos = {(<coop_career_text_off>) relative}
		scale = (<coop_career_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		font_spacing = 0
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getScreenElementDims id = <id>
	if (<width> > 400)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_quickplay_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = "QUICKPLAY"
		font_spacing = 0
		pos = {(<quickplay_text_off>) relative}
		scale = (<quickplay_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
		<demo_mode_disable>
	}
	getScreenElementDims id = <id>
	if (<width> > 400)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		id = main_menu_multiplayer_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = "MULTIPLAYER"
		font_spacing = 1
		pos = {(<multiplayer_text_off>) relative}
		scale = (<multiplayer_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
		<demo_mode_disable>
	}
	getScreenElementDims id = <id>
	if (<width> > 460)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((460.0, 0.0) + <height> * (0.0, 1.0))
	endif
	createscreenelement {
		type = textelement
		text = "PERMADEATH"
		pos = (-361.5, 260.5)
		parent = main_menu_text_container
		rgba = [200 0 0 255]
		font = text_a6
		just = [center top]
		scale = (1.0, 1.0)
	}
	createscreenelement {
		type = textelement
		id = main_menu_training_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = "TRAINING"
		font_spacing = 0
		pos = {(<training_text_off>) relative}
		scale = (<training_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getScreenElementDims id = <id>
	if (<width> > 345)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((345.0, 0.0) + <height> * (0.0, 1.0))
	endif
	getScreenElementDims \{id = main_menu_training_text}
	old_height = <height>
	fit_text_in_rectangle id = main_menu_training_text dims = (350.0, 100.0) pos = {(<training_text_off>) relative} start_x_scale = (<training_text_scale>.(1.0, 0.0)) start_y_scale = (<training_text_scale>.(0.0, 1.0)) only_if_larger_x = 1 keep_ar = 1
	getScreenElementDims \{id = main_menu_training_text}
	offset = ((<old_height> * ((<old_height> -24.0) / <old_height>)) - (<height> * ((<height> - (24.0 * ((1.0 * <height>) / <old_height>))) / <height>)))
	leaderboards_text_off = (<leaderboards_text_off> - <offset> * (0.0, 1.0))
	options_text_off = (<options_text_off> - <offset> * (0.0, 1.0))
	if isXenon
		createscreenelement {
			type = textelement
			id = main_menu_leaderboards_text
			parent = main_menu_text_container
			font = <main_menu_font>
			text = "XBOX LIVE"
			font_spacing = 0
			pos = {(<leaderboards_text_off>) relative}
			scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [left top]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
			<demo_mode_disable>
		}
		getScreenElementDims id = <id>
		if (<width> > 360)
			SetScreenElementProps id = <id> scale = 1
			fit_text_in_rectangle id = <id> dims = ((360.0, 0.0) + <height> * (0.0, 1.0))
		endif
	else
		createscreenelement {
			type = textelement
			id = main_menu_leaderboards_text
			parent = main_menu_text_container
			font = <main_menu_font>
			text = "ONLINE"
			font_spacing = 0
			pos = {(<leaderboards_text_off>) relative}
			scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [left top]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
			<demo_mode_disable>
		}
		getScreenElementDims id = <id>
		if (<width> > 360)
			SetScreenElementProps id = <id> scale = 1
			fit_text_in_rectangle id = <id> dims = ((360.0, 0.0) + <height> * (0.0, 1.0))
		endif
	endif
	createscreenelement {
		type = textelement
		id = main_menu_options_text
		parent = main_menu_text_container
		font = <main_menu_font>
		text = "OPTIONS"
		font_spacing = 0
		pos = {(<options_text_off>) relative}
		scale = (<options_text_scale>)
		rgba = ($menu_text_color)
		just = [left top]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	getScreenElementDims id = <id>
	if (<width> > 420)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> dims = ((420.0, 0.0) + <height> * (0.0, 1.0))
	endif
	if ($enable_button_cheats = 1)
		createscreenelement {
			type = textelement
			id = main_menu_debug_menu_text
			parent = main_menu_text_container
			font = <main_menu_font>
			text = "DEBUG MENU"
			pos = {(<debug_menu_text_off>) relative}
			scale = (<debug_menu_text_scale>)
			rgba = ($menu_text_color)
			just = [left top]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
		}
	endif
	offwhite = [255 255 205 255]
	hilite_off = (5.0, 0.0)
	gm_hlInfoList = [
		{
			posL = (<career_text_off> + <hilite_off> + (-40.0, 9.0))
			posR = (<career_text_off> + <hilite_off> + (218.0, 9.0))
			beDims = (40.0, 40.0)
			posH = (<career_text_off> + <hilite_off> + (-14.0, -2.0))
			hdims = (240.0, 57.0)
		} ,
		{
			posL = (<coop_career_text_off> + <hilite_off> + (-33.0, 3.0))
			posR = (<coop_career_text_off> + <hilite_off> + (281.0, 3.0))
			beDims = (32.0, 32.0)
			posH = (<coop_career_text_off> + <hilite_off> + (-14.0, -1.0))
			hdims = (300.0, 37.0)
		} ,
		{
			posL = (<quickplay_text_off> + <hilite_off> + (-34.0, 4.0))
			posR = (<quickplay_text_off> + <hilite_off> + (251.0, 4.0))
			beDims = (40.0, 40.0)
			posH = (<quickplay_text_off> + <hilite_off> + (-14.0, -2.0))
			hdims = (267.0, 47.0)
		} ,
		{
			posL = (<multiplayer_text_off> + <hilite_off> + (-37.0, 4.0))
			posR = (<multiplayer_text_off> + <hilite_off> + (301.0, 4.0))
			beDims = (38.0, 38.0)
			posH = (<multiplayer_text_off> + <hilite_off> + (-14.0, -1.0))
			hdims = (320.0, 43.0)
		} ,
		{
			posL = (<training_text_off> + <hilite_off> + (-31.0, 9.0))
			posR = (<training_text_off> + <hilite_off> + (282.0, 9.0))
			beDims = (42.0, 42.0)
			posH = (<training_text_off> + <hilite_off> + (-13.0, -2.0))
			hdims = (295.0, 61.0)
		} ,
		{
			posL = (<leaderboards_text_off> + <hilite_off> + (-33.0, 3.0))
			posR = (<leaderboards_text_off> + <hilite_off> + (213.0, 3.0))
			beDims = (34.0, 34.0)
			posH = (<leaderboards_text_off> + <hilite_off> + (-13.0, -2.0))
			hdims = (232.0, 40.0)
		} ,
		{
			posL = (<options_text_off> + <hilite_off> + (-36.0, 5.0))
			posR = (<options_text_off> + <hilite_off> + (183.0, 5.0))
			beDims = (36.0, 36.0)
			posH = (<options_text_off> + <hilite_off> + (-14.0, 0.0))
			hdims = (205.0, 43.0)
		}
	]
	<gm_hlIndex> = 0
	displaySprite {
		parent = main_menu_text_container
		tex = character_hub_hilite_bookend
		pos = ((<gm_hlInfoList> [<gm_hlIndex>]).posL)
		dims = ((<gm_hlInfoList> [<gm_hlIndex>]).beDims)
		rgba = <offwhite>
		z = 2
	}
	<bookEnd1ID> = <id>
	displaySprite {
		parent = main_menu_text_container
		tex = character_hub_hilite_bookend
		pos = ((<gm_hlInfoList> [<gm_hlIndex>]).posR)
		dims = ((<gm_hlInfoList> [<gm_hlIndex>]).beDims)
		rgba = <offwhite>
		z = 2
	}
	<bookEnd2ID> = <id>
	displaySprite {
		parent = main_menu_text_container
		tex = white
		rgba = <offwhite>
		pos = ((<gm_hlInfoList> [<gm_hlIndex>]).posH)
		dims = ((<gm_hlInfoList> [<gm_hlIndex>]).hdims)
		z = 2
	}
	<whiteTexHighlightID> = <id>
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_career_text}}
			{focus SetScreenElementProps params = {id = main_menu_career_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 0
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_career_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_career_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_career_text}}
			{pad_choose main_menu_select_career}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_coop_career_text}}
			{focus SetScreenElementProps params = {id = main_menu_coop_career_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 1
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_coop_career_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_coop_career_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_coop_career_text}}
			{pad_choose main_menu_select_coop_career}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_quickplay_text}}
			{focus SetScreenElementProps params = {id = main_menu_quickplay_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 2
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_quickplay_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_quickplay_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_quickplay_text}}
			{pad_choose main_menu_select_quickplay}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_multiplayer_text}}
			{focus SetScreenElementProps params = {id = main_menu_multiplayer_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 3
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_multiplayer_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_multiplayer_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_multiplayer_text}}
			{pad_choose main_menu_select_multiplayer}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_training_text}}
			{focus SetScreenElementProps params = {id = main_menu_training_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 4
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_training_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_training_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_training_text}}
			{pad_choose main_menu_select_training}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_options_text}}
			{focus SetScreenElementProps params = {id = main_menu_options_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 6
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_options_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_options_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_options_text}}
			{pad_choose main_menu_select_options}
		]
		z_priority = -1
	}
	createscreenelement {
		type = textelement
		parent = vmenu_main_menu
		font = <main_menu_font>
		text = ""
		event_handlers = [
			{focus retail_menu_focus params = {id = main_menu_leaderboards_text}}
			{focus SetScreenElementProps params = {id = main_menu_leaderboards_text no_shadow}}
			{focus guitar_menu_highlighter params = {
					hlIndex = 5
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_leaderboards_text
				}
			}
			{unfocus SetScreenElementProps params = {id = main_menu_leaderboards_text shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus params = {id = main_menu_leaderboards_text}}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	if ($enable_button_cheats = 1)
		createscreenelement {
			type = textelement
			parent = vmenu_main_menu
			font = <main_menu_font>
			text = ""
			event_handlers = [
				{focus retail_menu_focus params = {id = main_menu_debug_menu_text}}
				{focus guitar_menu_highlighter params = {
						zPri = -2
						hlIndex = 0
						hlInfoList = <gm_hlInfoList>
						be1ID = <bookEnd1ID>
						be2ID = <bookEnd2ID>
						wthlID = <whiteTexHighlightID>
					}
				}
				{unfocus retail_menu_unfocus params = {id = main_menu_debug_menu_text}}
				{pad_choose ui_flow_manager_respond_to_action params = {action = select_debug_menu}}
			]
			z_priority = -1
		}
	endif
	if ($new_message_of_the_day = 1)
		spawnscriptnow \{pop_in_new_downloads_notifier}
	endif
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
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
	if NOT ($invite_controller = -1)
		change \{invite_controller = -1}
		ui_flow_manager_respond_to_action \{action = select_xbox_live}
		fadetoblack \{off
			time = 0}
	else
		launchevent \{type = focus
			target = vmenu_main_menu}
	endif
endscript

script guitar_menu_highlighter \{zPri = 50}
	if gotparam \{text_id}
		getScreenElementDims id = <text_id>
		hilite_dims = (<width> * (1.0, 0.0) + <height> * (0.0, 0.7) + (20.0, -1.0))
		bookend_dims = (<height> * (0.5, 0.5))
		hilite_pos = ((<hlInfoList> [<hlIndex>]).posH - (5.0, 0.0))
		SetScreenElementProps {
			id = <wthlID>
			pos = <hilite_pos>
			dims = <hilite_dims>
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <be1ID>
			pos = (<hilite_pos> - <bookend_dims>.(1.0, 0.0) * (0.6, 0.0) + <height> * (0.0, 0.1))
			dims = <bookend_dims>
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <be2ID>
			pos = (<hilite_pos> + (<hilite_dims>.(1.0, 0.0) * (1.0, 0.0)) + <height> * (0.0, 0.1) - (<bookend_dims>.(1.0, 0.0) * (0.1, 0.0)))
			dims = <bookend_dims>
			z_priority = <zPri>
			flip_h
		}
	else
		SetScreenElementProps {
			id = <be1ID>
			pos = ((<hlInfoList> [<hlIndex>]).posL)
			dims = ((<hlInfoList> [<hlIndex>]).beDims)
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <be2ID>
			pos = ((<hlInfoList> [<hlIndex>]).posR)
			dims = ((<hlInfoList> [<hlIndex>]).beDims)
			z_priority = <zPri>
		}
		SetScreenElementProps {
			id = <wthlID>
			pos = ((<hlInfoList> [<hlIndex>]).posH)
			dims = ((<hlInfoList> [<hlIndex>]).hdims)
			z_priority = <zPri>
		}
	endif
endscript

script glow_new_downloads_text 
	begin
	if screenelementexists \{id = new_downloads_text_glow}
		new_downloads_text_glow :DoMorph alpha = 0 time = <time>
	endif
	if screenelementexists \{id = new_downloads_text_glow}
		new_downloads_text_glow :DoMorph alpha = 1 time = <time>
	endif
	repeat
endscript

script pop_in_new_downloads_notifier \{time = 0.5}
	wait \{0.5
		second}
	if NOT screenelementexists \{id = main_menu_text_container}
		return
	endif
	pos = (100.0, 390.0)
	text = "NEW  DOWNLOADABLE  CONTENT!"
	createscreenelement {
		type = textelement
		parent = main_menu_text_container
		text = <text>
		scale = 0.5
		rgba = [255 255 205 255]
		just = [center center]
		font_spacing = 5
		font = text_a3
		pos = <pos>
		z_priority = 5
		alpha = 0
	}
	getScreenElementDims id = <id>
	if (<width> >= 500)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> only_if_larger_x = 1 dims = ((500.0, 0.0) + <height> * (0.0, 1.0)) keep_ar = 1
	endif
	DoScreenElementMorph id = <id> alpha = 1 time = <time>
	createscreenelement {
		type = textelement
		parent = main_menu_text_container
		id = new_downloads_text_glow
		text = <text>
		scale = 0.5
		rgba = [255 255 255 255]
		font = text_a3
		just = [center center]
		font_spacing = 5
		pos = <pos>
		z_priority = 6
		alpha = 0
	}
	getScreenElementDims id = <id>
	if (<width> >= 500)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> only_if_larger_x = 1 dims = ((500.0, 0.0) + <height> * (0.0, 1.0)) keep_ar = 1
	endif
	DoScreenElementMorph id = <id> alpha = 1 time = <time>
	displaySprite {
		parent = main_menu_text_container
		tex = white
		pos = (<pos>)
		just = [center center]
		rgba = [170 90 35 255]
		z = 4
		dims = ((<width> + 20) * (1.0, 0.0) + (0.0, 1.0) * (<height> + 10))
		alpha = 0
	}
	DoScreenElementMorph id = <id> alpha = 1 time = <time>
	displaySprite {
		parent = main_menu_text_container
		tex = character_hub_hilite_bookend
		just = [right center]
		rgba = [170 90 35 255]
		z = 4
		pos = ((<pos>) - <width> * (0.5, 0.0) - (6.0, 1.0))
		dims = (<height> * (1.0, 1.0))
		flip_v
		alpha = 0
	}
	DoScreenElementMorph id = <id> alpha = 1 time = <time>
	displaySprite {
		parent = main_menu_text_container
		tex = character_hub_hilite_bookend
		just = [left center]
		rgba = [170 90 35 255]
		z = 4
		pos = ((<pos>) + <width> * (0.5, 0.0) + (6.0, 1.0))
		dims = (<height> * (1.0, 1.0))
		alpha = 0
	}
	DoScreenElementMorph id = <id> alpha = 1 time = <time>
	spawnscriptnow \{glow_new_downloads_text
		params = {
			time = 0.75
		}}
endscript

script glow_menu_element \{time = 1}
	if NOT screenelementexists id = <id>
		return
	endif
	wait RandomRange (0.0, 2.0) seconds
	begin
	<id> :DoMorph alpha = 1 time = <time> motion = smooth
	<id> :DoMorph alpha = 0 time = <time> motion = smooth
	repeat
endscript

script destroy_main_menu 
	killspawnedscript \{name = pop_in_new_downloads_notifier}
	killspawnedscript \{name = glow_new_downloads_text}
	clean_up_user_control_helpers
	change \{default_menu_focus_color = [
			210
			210
			210
			250
		]}
	change \{default_menu_unfocus_color = [
			210
			130
			0
			250
		]}
	printstruct x = ($ui_flow_manager_state)
	destroy_menu \{menu_id = main_menu_scrolling_menu}
	destroy_menu \{menu_id = main_menu_text_container}
	destroy_menu_backdrop
	destroyscreenelement \{id = main_menu_bg_container}
endscript

script main_menu_select_career 
	change \{game_mode = p1_career}
	change \{current_num_players = 1}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	ui_flow_manager_respond_to_action \{action = select_career}
endscript

script main_menu_select_coop_career 
	change \{game_mode = p2_career}
	change \{current_num_players = 2}
	ui_flow_manager_respond_to_action \{action = select_coop_career}
endscript

script main_menu_select_quickplay 
	change \{game_mode = p1_quickplay}
	change \{current_num_players = 1}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	ui_flow_manager_respond_to_action \{action = select_quickplay}
endscript

script main_menu_select_multiplayer 
	change \{game_mode = p2_faceoff}
	change \{current_num_players = 2}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	ui_flow_manager_respond_to_action \{action = select_multiplayer}
endscript

script main_menu_select_training 
	change \{game_mode = training}
	change \{current_num_players = 1}
	change \{came_to_practice_from = main_menu}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	ui_flow_manager_respond_to_action \{action = select_training}
endscript

script main_menu_select_xbox_live 
	ui_flow_manager_respond_to_action \{action = select_xbox_live}
endscript

script main_menu_select_options 
	ui_flow_manager_respond_to_action \{action = select_options}
endscript

script create_play_song_menu 
endscript

script destroy_play_song_menu 
endscript

script isSinglePlayerGame 
	if ($game_mode = p1_career || $game_mode = p1_quickplay || $game_mode = training)
		return \{true}
	else
		return \{false}
	endif
endscript

script create_pause_menu \{player = 1
		for_options = 0
		for_practice = 0}
	player_device = ($last_start_pressed_device)
	if ($player1_device = <player_device>)
		<player> = 1
	else
		<player> = 2
	endif
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
	if (<for_options> = 0)
		if ($view_mode)
			return
		endif
		enable_pause
		safe_create_gh3_pause_menu
	else
		kill_start_key_binding
		flame_handlers = [
			{pad_back ui_flow_manager_respond_to_action params = {action = go_back}}
		]
	endif
	change \{bunny_flame_index = 1}
	pause_z = 10000
	spacing = -65
	if (<for_options> = 0)
		menu_pos = (730.0, 220.0)
		if (<for_practice> = 1)
			<menu_pos> = (640.0, 190.0)
			<spacing> = -65
		endif
	else
		<spacing> = -65
		if isguitarcontroller controller = <player_device>
			menu_pos = (640.0, 265.0)
		else
			menu_pos = (640.0, 300.0)
		endif
	endif
	new_menu {
		scrollid = scrolling_pause
		vmenuid = vmenu_pause
		menu_pos = <menu_pos>
		rot_angle = 2
		event_handlers = <flame_handlers>
		spacing = <spacing>
		use_backdrop = (0)
		exclusive_device = <player_device>
	}
	create_pause_menu_frame z = (<pause_z> - 10)
	if ($is_network_game = 0)
		createscreenelement {
			type = spriteelement
			parent = pause_menu_frame_container
			texture = menu_pause_frame_banner
			pos = (640.0, 540.0)
			just = [center center]
			z_priority = (<pause_z> + 100)
		}
		if gotparam \{banner_text}
			pause_player_text = <banner_text>
			if gotparam \{banner_scale}
				pause_player_scale = <banner_scale>
			else
				pause_player_scale = (1.0, 1.0)
			endif
		else
			if (<for_options> = 0)
				if (<for_practice> = 1)
					<pause_player_text> = "PAUSED"
				else
					if NOT isSinglePlayerGame
						formattext textname = pause_player_text "P%d PAUSED" d = <player>
					else
						<pause_player_text> = "PAUSED"
					endif
				endif
				pause_player_scale = (0.6, 0.75)
			else
				pause_player_text = "OPTIONS"
				pause_player_scale = (0.75, 0.75)
			endif
		endif
	endif
	createscreenelement {
		type = textelement
		parent = <id>
		text = <pause_player_text>
		font = text_a6
		pos = (125.0, 53.0)
		scale = <pause_player_scale>
		rgba = [170 90 30 255]
		scale = 0.8
	}
	text_scale = (0.9, 0.9)
	if (<for_options> = 0 && <for_practice> = 0)
		createscreenelement {
			type = containerelement
			parent = pause_menu_frame_container
			id = bunny_container
			pos = (380.0, 170.0)
			just = [left top]
			z_priority = <pause_z>
		}
		i = 1
		begin
		formattext checksumname = bunny_id 'pause_bunny_flame_%d' d = <i>
		formattext checksumname = bunny_tex 'GH3_Pause_Bunny_Flame%d' d = <i>
		createscreenelement {
			type = spriteelement
			id = <bunny_id>
			parent = bunny_container
			pos = (160.0, 170.0)
			texture = <bunny_tex>
			rgba = [255 255 255 255]
			dims = (300.0, 300.0)
			just = [right bottom]
			z_priority = (<pause_z> + 3)
			rot_angle = 5
		}
		if (<i> > 1)
			DoScreenElementMorph id = <bunny_id> alpha = 0
		endif
		<i> = (<i> + 1)
		repeat 7
		createscreenelement {
			type = spriteelement
			id = pause_bunny_shadow
			parent = bunny_container
			texture = GH3_Pause_bunny
			rgba = [0 0 0 128]
			pos = (20.0, -110.0)
			dims = (550.0, 550.0)
			just = [center top]
			z_priority = (<pause_z> + 4)
		}
		createscreenelement {
			type = spriteelement
			id = pause_bunny
			parent = bunny_container
			texture = GH3_Pause_bunny
			rgba = [255 255 255 255]
			pos = (0.0, -130.0)
			dims = (550.0, 550.0)
			just = [center top]
			z_priority = (<pause_z> + 5)
		}
		RunScriptOnScreenElement \{id = bunny_container
			bunny_hover
			params = {
				hover_origin = (380.0, 170.0)
			}}
	endif
	container_params = {type = containerelement parent = vmenu_pause dims = (0.0, 100.0)}
	if (<for_options> = 0)
		if (<for_practice> = 1)
			if English
			else
				text_scale = (0.71999997, 0.71999997)
			endif
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_resume}}
					{unfocus retail_menu_unfocus params = {id = pause_resume}}
					{pad_choose gh3_start_pressed}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				id = pause_resume
				text = "RESUME"
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_restart}}
					{unfocus retail_menu_unfocus params = {id = pause_restart}}
					{pad_choose ui_flow_manager_respond_to_action params = {action = select_restart}}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "RESTART"
				id = pause_restart
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_options}}
					{unfocus retail_menu_unfocus params = {id = pause_options}}
					{pad_choose ui_flow_manager_respond_to_action params = {action = select_options create_params = {player_device = <player_device>}}}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "OPTIONS"
				id = pause_options
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_change_speed}}
					{unfocus retail_menu_unfocus params = {id = pause_change_speed}}
					{pad_choose ui_flow_manager_respond_to_action params = {action = select_change_speed}}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "CHANGE SPEED"
				id = pause_change_speed
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_change_section}}
					{unfocus retail_menu_unfocus params = {id = pause_change_section}}
					{pad_choose ui_flow_manager_respond_to_action params = {action = select_change_section}}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "CHANGE SECTION"
				id = pause_change_section
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($came_to_practice_from = main_menu)
				createscreenelement {
					<container_params>
					event_handlers = [
						{focus retail_menu_focus params = {id = pause_new_song}}
						{unfocus retail_menu_unfocus params = {id = pause_new_song}}
						{pad_choose ui_flow_manager_respond_to_action params = {action = select_new_song}}
					]
				}
				createscreenelement {
					type = textelement
					parent = <id>
					font = fontgrid_title_gh3
					scale = <text_scale>
					rgba = [210 130 0 250]
					text = "NEW SONG"
					id = pause_new_song
					just = [center top]
					shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [0 0 0 255]
					z_priority = <pause_z>
					exclusive_device = <player_device>
				}
				getScreenElementDims id = <id>
				fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			endif
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_quit}}
					{unfocus retail_menu_unfocus params = {id = pause_quit}}
					{pad_choose ui_flow_manager_respond_to_action params = {action = select_quit}}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "QUIT"
				id = pause_quit
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((300.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			add_user_control_helper \{text = "SELECT"
				button = green
				z = 100000}
			add_user_control_helper \{text = "UP/DOWN"
				button = strumbar
				z = 100000}
		else
			if English
			else
				container_params = {type = containerelement parent = vmenu_pause dims = (0.0, 105.0)}
				text_scale = (0.8, 0.8)
			endif
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_resume}}
					{unfocus retail_menu_unfocus params = {id = pause_resume}}
					{pad_choose gh3_start_pressed}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "RESUME"
				id = pause_resume
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((250.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($is_network_game = 0)
				if NOT ($end_credits = 1)
					createscreenelement {
						<container_params>
						event_handlers = [
							{focus retail_menu_focus params = {id = pause_restart}}
							{unfocus retail_menu_unfocus params = {id = pause_restart}}
							{pad_choose ui_flow_manager_respond_to_action params = {action = select_restart}}
						]
					}
					createscreenelement {
						type = textelement
						parent = <id>
						font = fontgrid_title_gh3
						scale = <text_scale>
						rgba = [210 130 0 250]
						text = "RESTART"
						id = pause_restart
						just = [center top]
						shadow
						shadow_offs = (3.0, 3.0)
						shadow_rgba [0 0 0 255]
						z_priority = <pause_z>
						exclusive_device = <player_device>
					}
					getScreenElementDims id = <id>
					fit_text_in_rectangle id = <id> dims = ((250.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
					if ($is_demo_mode = 1)
						demo_mode_disable = {rgba = [80 80 80 255] not_focusable}
					else
						demo_mode_disable = {rgba = [80 80 80 255] not_focusable}
					endif
					if (($game_mode = p1_career && $boss_battle = 0) || ($game_mode = p1_quickplay))
						createscreenelement {
							<container_params>
							event_handlers = [
								{focus retail_menu_focus params = {id = pause_practice}}
								{unfocus retail_menu_unfocus params = {id = pause_practice}}
								{pad_choose ui_flow_manager_respond_to_action params = {action = select_practice}}
							]
						}
						createscreenelement {
							type = textelement
							parent = <id>
							font = fontgrid_title_gh3
							scale = <text_scale>
							rgba = [210 130 0 250]
							text = "PRACTICE"
							id = pause_practice
							just = [center top]
							shadow
							shadow_offs = (3.0, 3.0)
							shadow_rgba [0 0 0 255]
							z_priority = <pause_z>
							exclusive_device = <player_device>
						}
						getScreenElementDims id = <id>
						fit_text_in_rectangle id = <id> dims = ((260.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
					endif
					createscreenelement {
						<container_params>
						event_handlers = [
							{focus retail_menu_focus params = {id = pause_options}}
							{unfocus retail_menu_unfocus params = {id = pause_options}}
							{pad_choose ui_flow_manager_respond_to_action params = {action = select_options create_params = {player_device = <player_device>}}}
						]
					}
					createscreenelement {
						type = textelement
						parent = <id>
						font = fontgrid_title_gh3
						scale = <text_scale>
						rgba = [210 130 0 250]
						text = "OPTIONS"
						id = pause_options
						just = [center top]
						shadow
						shadow_offs = (3.0, 3.0)
						shadow_rgba [0 0 0 255]
						z_priority = <pause_z>
						exclusive_device = <player_device>
					}
					getScreenElementDims id = <id>
					fit_text_in_rectangle id = <id> dims = ((260.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
				endif
			endif
			quit_script = ui_flow_manager_respond_to_action
			quit_script_params = {action = select_quit create_params = {player = <player>}}
			if ($is_network_game)
				quit_script = create_leaving_lobby_dialog
				quit_script_params = {
					create_pause_menu
					pad_back_script = return_to_pause_menu_from_net_warning
					pad_choose_script = pause_menu_really_quit_net_game
					z = 300
				}
			endif
			createscreenelement {
				<container_params>
				event_handlers = [
					{focus retail_menu_focus params = {id = pause_quit}}
					{unfocus retail_menu_unfocus params = {id = pause_quit}}
					{pad_choose <quit_script> params = <quit_script_params>}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "QUIT"
				id = pause_quit
				just = [center top]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = ((270.0, 0.0) + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($enable_button_cheats = 1)
				createscreenelement {
					<container_params>
					event_handlers = [
						{focus retail_menu_focus params = {id = pause_debug_menu}}
						{unfocus retail_menu_unfocus params = {id = pause_debug_menu}}
						{pad_choose ui_flow_manager_respond_to_action params = {action = select_debug_menu}}
					]
				}
				createscreenelement {
					type = textelement
					parent = <id>
					font = fontgrid_title_gh3
					scale = <text_scale>
					rgba = [210 130 0 250]
					text = "DEBUG MENU"
					id = pause_debug_menu
					just = [center top]
					shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [0 0 0 255]
					z_priority = <pause_z>
					exclusive_device = <player_device>
				}
			endif
			add_user_control_helper \{text = "SELECT"
				button = green
				z = 100000}
			add_user_control_helper \{text = "UP/DOWN"
				button = strumbar
				z = 100000}
		endif
	else
		<fit_dims> = (400.0, 0.0)
		createscreenelement {
			type = containerelement
			parent = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{focus retail_menu_focus params = {id = options_audio}}
				{focus generic_menu_up_or_down_sound}
				{unfocus retail_menu_unfocus params = {id = options_audio}}
				{pad_choose ui_flow_manager_respond_to_action params = {action = select_audio_settings create_params = {player = <player>}}}
			]
		}
		createscreenelement {
			type = textelement
			parent = <id>
			font = fontgrid_title_gh3
			scale = <text_scale>
			rgba = [210 130 0 250]
			text = "SET AUDIO"
			id = options_audio
			just = [center center]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [0 0 0 255]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		getScreenElementDims id = <id>
		fit_text_in_rectangle id = <id> dims = (<fit_dims> + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		createscreenelement {
			type = containerelement
			parent = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{focus retail_menu_focus params = {id = options_calibrate_lag}}
				{focus generic_menu_up_or_down_sound}
				{unfocus retail_menu_unfocus params = {id = options_calibrate_lag}}
				{pad_choose ui_flow_manager_respond_to_action params = {action = select_calibrate_lag create_params = {player = <player>}}}
			]
		}
		createscreenelement {
			type = textelement
			parent = <id>
			font = fontgrid_title_gh3
			scale = <text_scale>
			rgba = [210 130 0 250]
			text = "CALIBRATE LAG"
			id = options_calibrate_lag
			just = [center center]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [0 0 0 255]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		getScreenElementDims id = <id>
		fit_text_in_rectangle id = <id> dims = (<fit_dims> + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		if isguitarcontroller controller = <player_device>
			createscreenelement {
				type = containerelement
				parent = vmenu_pause
				dims = (0.0, 100.0)
				event_handlers = [
					{focus retail_menu_focus params = {id = options_calibrate_whammy}}
					{focus generic_menu_up_or_down_sound}
					{unfocus retail_menu_unfocus params = {id = options_calibrate_whammy}}
					{pad_choose ui_flow_manager_respond_to_action params = {action = select_calibrate_whammy_bar create_params = {player = <player> popup = 1}}}
				]
			}
			createscreenelement {
				type = textelement
				parent = <id>
				font = fontgrid_title_gh3
				scale = <text_scale>
				rgba = [210 130 0 250]
				text = "CALIBRATE WHAMMY"
				id = options_calibrate_whammy
				just = [center center]
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <player_device>
			}
			getScreenElementDims id = <id>
			fit_text_in_rectangle id = <id> dims = (<fit_dims> + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		endif
		if isSinglePlayerGame
			lefty_flip_text = "LEFTY FLIP:"
		else
			if (<player> = 1)
				lefty_flip_text = "P1 LEFTY FLIP:"
			else
				lefty_flip_text = "P2 LEFTY FLIP:"
			endif
		endif
		createscreenelement {
			type = containerelement
			parent = vmenu_pause
			dims = (0.0, 100.0)
			event_handlers = [
				{focus retail_menu_focus params = {id = pause_options_lefty}}
				{focus generic_menu_up_or_down_sound}
				{unfocus retail_menu_unfocus params = {id = pause_options_lefty}}
				{pad_choose ui_flow_manager_respond_to_action params = {action = select_lefty_flip create_params = {player = <player>}}}
			]
		}
		<lefty_container> = <id>
		createscreenelement {
			type = textelement
			parent = <lefty_container>
			id = pause_options_lefty
			font = fontgrid_title_gh3
			scale = <text_scale>
			rgba = [210 130 0 250]
			text = <lefty_flip_text>
			just = [center center]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba [0 0 0 255]
			z_priority = <pause_z>
			exclusive_device = <player_device>
		}
		getScreenElementDims id = <id>
		fit_text_in_rectangle id = <id> dims = (<fit_dims> + <height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		GetGlobalTags \{user_options}
		if (<player> = 1)
			if (<lefty_flip_p1> = 1)
				lefty_tex = options_controller_check
			else
				lefty_tex = options_controller_X
			endif
		else
			if (<lefty_flip_p2> = 1)
				lefty_tex = options_controller_check
			else
				lefty_tex = options_controller_X
			endif
		endif
		displaySprite {
			parent = <lefty_container>
			tex = <lefty_tex>
			just = [center center]
			z = (<pause_z> + 10)
		}
		getScreenElementDims \{id = pause_options_lefty}
		<id> :setprops pos = (<width> * (0.5, 0.0) + (22.0, 0.0))
		add_user_control_helper \{text = "SELECT"
			button = green
			z = 100000}
		add_user_control_helper \{text = "BACK"
			button = red
			z = 100000}
		add_user_control_helper \{text = "UP/DOWN"
			button = strumbar
			z = 100000}
	endif
	if ($is_network_game = 0)
		if NOT isSinglePlayerGame
			if (<for_practice> = 0)
				formattext textname = player_paused_text "PLAYER %d PAUSED. ONLY PLAYER %d OPTIONS ARE AVAILABLE." d = <player>
				displaySprite {
					parent = pause_menu_frame_container
					id = pause_helper_text_bg
					tex = control_pill_body
					pos = (640.0, 600.0)
					just = [center center]
					rgba = [96 0 0 255]
					z = (<pause_z> + 10)
				}
				displayText {
					parent = pause_menu_frame_container
					pos = (640.0, 604.0)
					just = [center center]
					text = <player_paused_text>
					rgba = [186 105 0 255]
					scale = (0.45000002, 0.6)
					z = (<pause_z> + 11)
					font = text_a6
				}
				getScreenElementDims id = <id>
				bg_dims = (<width> * (1.0, 0.0) + (0.0, 32.0))
				pause_helper_text_bg :setprops dims = <bg_dims>
				displaySprite {
					parent = pause_menu_frame_container
					tex = control_pill_end
					pos = ((640.0, 600.0) - <width> * (0.5, 0.0))
					rgba = [96 0 0 255]
					just = [right center]
					flip_v
					z = (<pause_z> + 10)
				}
				displaySprite {
					parent = pause_menu_frame_container
					tex = control_pill_end
					pos = ((640.0, 601.0) + <width> * (0.5, 0.0))
					rgba = [96 0 0 255]
					just = [left center]
					z = (<pause_z> + 10)
				}
			endif
		endif
	endif
	change \{menu_choose_practice_destroy_previous_menu = 1}
	if (<for_options> = 0 && <for_practice> = 0)
		spawnscriptnow \{animate_bunny_flame}
	endif
endscript

script animate_bunny_flame 
	begin
	swap_bunny_flame
	wait \{0.1
		second}
	repeat
endscript

script bunny_hover 
	if NOT screenelementexists \{id = bunny_container}
		return
	endif
	i = 1
	begin
	formattext checksumname = bunnyid 'pause_bunny_flame_%d' d = <i>
	if NOT screenelementexists id = <bunnyid>
		return
	else
		SetScreenElementProps id = <bunnyid> pos = <flame_origin>
	endif
	<i> = (<i> + 1)
	repeat 7
	begin
	bunny_container :DoMorph \{pos = (360.0, 130.0)
		time = 1
		rot_angle = -25
		scale = 1.05
		motion = ease_out}
	bunny_container :DoMorph \{pos = (390.0, 170.0)
		time = 1
		rot_angle = -20
		scale = 0.95
		motion = ease_in}
	bunny_container :DoMorph \{pos = (360.0, 130.0)
		time = 1
		rot_angle = -15
		scale = 1.05
		motion = ease_out}
	bunny_container :DoMorph \{pos = (390.0, 170.0)
		time = 1
		rot_angle = -20
		scale = 0.95
		motion = ease_in}
	repeat
endscript

script destroy_pause_menu 
	restore_start_key_binding
	clean_up_user_control_helpers
	destroy_pause_menu_frame
	destroy_menu \{menu_id = scrolling_pause}
	destroy_menu \{menu_id = pause_menu_frame_container}
	killspawnedscript \{name = animate_bunny_flame}
	if screenelementexists \{id = warning_message_container}
		destroyscreenelement \{id = warning_message_container}
	endif
	if screenelementexists \{id = leaving_lobby_dialog_menu}
		destroyscreenelement \{id = leaving_lobby_dialog_menu}
	endif
	destroy_pause_menu_frame \{container_id = net_quit_warning}
endscript

script swap_bunny_flame 
	if gotparam \{up}
		generic_menu_up_or_down_sound \{up}
		change \{g_anim_flame = -1}
	elseif gotparam \{down}
		generic_menu_up_or_down_sound \{down}
		change \{g_anim_flame = 1}
	endif
	change bunny_flame_index = ($bunny_flame_index + $g_anim_flame)
	if ($bunny_flame_index > 7)
		change \{bunny_flame_index = 1}
	endif
	if ($bunny_flame_index < 1)
		change \{bunny_flame_index = 7}
	endif
	reset_bunny_alpha
	formattext \{checksumname = bunnyid
		'pause_bunny_flame_%d'
		d = $bunny_flame_index}
	if screenelementexists id = <bunnyid>
		DoScreenElementMorph id = <bunnyid> alpha = 1
	endif
endscript

script reset_bunny_alpha 
	i = 1
	begin
	formattext checksumname = bunnyid 'pause_bunny_flame_%d' d = <i>
	if screenelementexists id = <bunnyid>
		DoScreenElementMorph id = <bunnyid> alpha = 0
	endif
	<i> = (<i> + 1)
	repeat 7
endscript

script create_menu_backdrop \{texture = Venue_BG
		rgba = [
			255
			255
			255
			255
		]}
	if screenelementexists \{id = menu_backdrop_container}
		destroyscreenelement \{id = menu_backdrop_container}
	endif
	createscreenelement \{type = containerelement
		parent = root_window
		id = menu_backdrop_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	createscreenelement {
		type = spriteelement
		parent = menu_backdrop_container
		id = menu_backdrop
		texture = <texture>
		rgba = <rgba>
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [center center]
		z_priority = 0
	}
endscript

script destroy_menu_backdrop 
	if screenelementexists \{id = menu_backdrop_container}
		destroyscreenelement \{id = menu_backdrop_container}
	endif
endscript

script create_pause_menu_frame \{x_scale = 1
		y_scale = 1
		tile_sprite = 1
		container_id = pause_menu_frame_container
		z = 0
		gradient = 1
		parent = root_window}
	createscreenelement {
		type = containerelement
		parent = <parent>
		id = <container_id>
		pos = (0.0, 0.0)
		just = [left top]
		z_priority = <z>
	}
	<center_pos> = (640.0, 360.0)
	pos_scale_2 = ((0.0, -5.0) * <y_scale>)
	scale_1 = ((1.5, 0.0) * <x_scale> + (0.0, 1.4) * <y_scale>)
	scale_2 = ((1.4, 0.0) * <x_scale> + (0.0, 1.4) * <y_scale>)
	scale_3 = ((1.4, 0.0) * <x_scale> + (0.0, 1.3499999) * <y_scale>)
	scale_4 = ((1.575, 0.0) * <x_scale> + (0.0, 1.5) * <y_scale>)
	scale_5 = ((1.5, 0.0) * <x_scale> + (0.0, 1.4) * <y_scale>)
	if (<gradient> = 1)
		createscreenelement {
			type = spriteelement
			id = pause_gradient
			parent = <container_id>
			texture = gradient_128
			rgba = [0 0 0 180]
			pos = (0.0, 0.0)
			dims = (1280.0, 720.0)
			just = [left top]
			z_priority = (<z> + 1)
		}
	endif
	if (<tile_sprite> = 1)
		createscreenelement {
			type = windowelement
			parent = <container_id>
			id = pause_menu_scrolling_bg_01
			pos = (642.0, 360.0)
			dims = ((508.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			just = [center center]
			z_priority = (<z> - 1)
		}
		TileSprite \{parent = pause_menu_scrolling_bg_01
			tile_dims = (980.0, 910.0)
			pos = (0.0, 0.0)
			texture = GH3_Pause_bg_tile}
		RunScriptOnScreenElement TileSpriteLoop id = <id> params = {move_x = -2 move_y = -2}
	else
		createscreenelement {
			type = spriteelement
			id = frame_background
			parent = <container_id>
			rgba = [0 0 0 255]
			pos = (640.0, 360.0)
			just = [center center]
			dims = ((520.0, 0.0) * <x_scale> + (0.0, 340.0) * <y_scale>)
			z_priority = (<z> - 1)
		}
	endif
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top left]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top left]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom right]
		z_priority = (<z> + 2)
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top right]
		z_priority = (<z> + 2)
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top left]
		z_priority = (<z> + 2)
		flip_v
		flip_h
	}
	createscreenelement {
		type = spriteelement
		parent = <container_id>
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom left]
		z_priority = (<z> + 2)
		flip_h
	}
endscript

script destroy_pause_menu_frame \{container_id = pause_menu_frame_container}
	destroy_menu menu_id = <container_id>
endscript
default_menu_focus_color = [
	210
	210
	210
	250
]
default_menu_unfocus_color = [
	210
	130
	0
	250
]
menu_focus_color = [
	210
	210
	210
	250
]
menu_unfocus_color = [
	210
	130
	0
	250
]

script set_focus_color \{rgba = [
			210
			210
			210
			250
		]}
	change menu_focus_color = <rgba>
endscript

script set_unfocus_color \{rgba = [
			210
			130
			0
			250
		]}
	change menu_unfocus_color = <rgba>
endscript

script retail_menu_focus 
	if gotparam \{id}
		if screenelementexists id = <id>
			SetScreenElementProps id = <id> rgba = ($menu_focus_color)
		endif
	else
		gettags
		printstruct <...>
		SetScreenElementProps id = <id> rgba = ($menu_focus_color)
	endif
endscript

script retail_menu_unfocus 
	if gotparam \{id}
		if screenelementexists id = <id>
			SetScreenElementProps id = <id> rgba = ($menu_unfocus_color)
		endif
	else
		gettags
		SetScreenElementProps id = <id> rgba = ($menu_unfocus_color)
	endif
endscript

script fit_text_in_rectangle \{dims = (100.0, 100.0)
		just = center
		keep_ar = 0
		only_if_larger_x = 0
		only_if_larger_y = 0
		start_x_scale = 1.0
		start_y_scale = 1.0}
	if NOT gotparam \{id}
		scriptassert \{"No id passed to fit_text_in_rectangle!"}
	endif
	getScreenElementDims id = <id>
	x_dim = (<dims>.(1.0, 0.0))
	y_dim = (<dims>.(0.0, 1.0))
	x_scale = (<x_dim> / <width>)
	if (<keep_ar> = 1)
		y_scale = <x_scale>
	else
		y_scale = (<y_dim> / <height>)
	endif
	if gotparam \{debug_me}
		printstruct <...>
	endif
	if (<only_if_larger_x> = 1)
		if (<x_scale> > 1)
			return
		endif
	elseif (<only_if_larger_y> = 1)
		if (<y_scale> > 1)
			return
		endif
	endif
	if (<just> = center)
		if gotparam \{pos}
		endif
	endif
	scale_pair = ((1.0, 0.0) * <x_scale> * <start_x_scale> + (0.0, 1.0) * <y_scale> * <start_y_scale>)
	SetScreenElementProps {
		id = <id>
		scale = <scale_pair>
	}
	if gotparam \{pos}
		SetScreenElementProps id = <id> pos = <pos>
	endif
endscript
num_user_control_helpers = 0
user_control_text_font = fontgrid_title_gh3
user_control_pill_color = [
	20
	20
	20
	155
]
user_control_pill_text_color = [
	180
	180
	180
	255
]
user_control_auto_center = 1
user_control_super_pill = 0
user_control_pill_y_position = 650
user_control_pill_scale = 0.4
user_control_pill_end_width = 50
user_control_pill_gap = 150
user_control_super_pill_gap = 0.4
pill_helper_max_width = 100

script clean_up_user_control_helpers 
	if screenelementexists \{id = user_control_container}
		destroyscreenelement \{id = user_control_container}
	endif
	change \{user_control_pill_gap = 150}
	change \{pill_helper_max_width = 100}
	change \{num_user_control_helpers = 0}
	change \{user_control_pill_color = [
			20
			20
			20
			155
		]}
	change \{user_control_pill_text_color = [
			180
			180
			180
			255
		]}
	change \{user_control_auto_center = 1}
	change \{user_control_super_pill = 0}
	change \{user_control_pill_y_position = 650}
	change \{user_control_pill_scale = 0.4}
endscript

script add_user_control_helper \{z = 10
		pill = 1
		fit_to_rectangle = 1}
	scale = ($user_control_pill_scale)
	pos = ((0.0, 1.0) * ($user_control_pill_y_position))
	buttonoff = (0.0, 0.0)
	if NOT screenelementexists \{id = user_control_container}
		createscreenelement \{id = user_control_container
			type = containerelement
			parent = root_window
			pos = (0.0, 0.0)}
	endif
	if gotparam \{button}
		switch (<button>)
			case green
			buttonchar = "\\m0"
			case red
			buttonchar = "\\m1"
			case yellow
			buttonchar = "\\b6"
			case blue
			buttonchar = "\\b7"
			case orange
			buttonchar = "\\b8"
			case strumbar
			buttonchar = "\\bb"
			offset_for_strumbar = 1
			case start
			buttonchar = "\\ba"
			offset_for_strumbar = 1
		endswitch
	else
		buttonchar = ""
	endif
	if (<pill> = 0)
		createscreenelement {
			type = textelement
			parent = user_control_container
			text = <buttonchar>
			pos = (<pos> + (-10.0, 8.0) * <scale> + <buttonoff>)
			scale = (1 * <scale>)
			rgba = [255 255 255 255]
			font = ($gh3_button_font)
			just = [left top]
			z_priority = (<z> + 0.1)
		}
		createscreenelement {
			type = textelement
			parent = user_control_container
			text = <text>
			rgba = $user_control_pill_text_color
			scale = (1.1 * <scale>)
			pos = (<pos> + (50.0, 0.0) * <scale> + (0.0, 20.0) * <scale>)
			font = ($user_control_text_font)
			z_priority = (<z> + 0.1)
			just = [left top]
		}
		if (<fit_to_rectangle> = 1)
			SetScreenElementProps id = <id> scale = (1.1 * <scale>)
			getScreenElementDims id = <id>
			if (<width> > $pill_helper_max_width)
				fit_text_in_rectangle id = <id> dims = ($pill_helper_max_width * (0.5, 0.0) + <height> * (0.0, 1.0) * $user_control_pill_scale)
			endif
		endif
	else
		if (($user_control_super_pill = 0) && ($user_control_auto_center = 0))
			createscreenelement {
				type = textelement
				parent = user_control_container
				text = <text>
				id = <textid>
				rgba = $user_control_pill_text_color
				scale = (1.1 * <scale>)
				pos = (<pos> + (50.0, 0.0) * <scale> + (0.0, 20.0) * <scale>)
				font = ($user_control_text_font)
				z_priority = (<z> + 0.1)
				just = [left top]
			}
			textid = <id>
			if (<fit_to_rectangle> = 1)
				SetScreenElementProps id = <id> scale = (1.1 * <scale>)
				getScreenElementDims id = <id>
				if (<width> > $pill_helper_max_width)
					fit_text_in_rectangle id = <id> dims = ($pill_helper_max_width * (0.5, 0.0) + <height> * (0.0, 1.0) * $user_control_pill_scale)
				endif
			endif
			createscreenelement {
				type = textelement
				parent = user_control_container
				id = <buttonid>
				text = <buttonchar>
				pos = (<pos> + (-10.0, 8.0) * <scale> + <buttonoff>)
				scale = (1 * <scale>)
				rgba = [255 255 255 255]
				font = ($gh3_button_font)
				just = [left top]
				z_priority = (<z> + 0.1)
			}
			buttonid = <id>
			if gotparam \{offset_for_strumbar}
				<textid> :settags is_strumbar = 1
				fastscreenelementpos id = <textid> absolute
				SetScreenElementProps id = <textid> pos = (<screenelementpos> + (50.0, 0.0) * <scale>)
			else
			endif
			fastscreenelementpos id = <buttonid> absolute
			top_left = <screenelementpos>
			fastscreenelementpos id = <textid> absolute
			bottom_right = <screenelementpos>
			getScreenElementDims id = <textid>
			bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
			pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
			pill_height = ((0.0, 1.0).<bottom_right> - (0.0, 1.0).<top_left>)
			pill_y_offset = (<pill_height> * 0.2)
			pill_height = (<pill_height> + <pill_y_offset>)
			<pos> = (<pos> + (0.0, 1.0) * (<scale> * 3))
			createscreenelement {
				type = spriteelement
				parent = user_control_container
				texture = control_pill_body
				dims = ((1.0, 0.0) * <pill_width> + (0.0, 1.0) * <pill_height>)
				pos = (<pos> + (0.0, -0.5) * <pill_y_offset>)
				rgba = ($user_control_pill_color)
				just = [left top]
				z_priority = <z>
			}
			createscreenelement {
				type = spriteelement
				parent = user_control_container
				texture = control_pill_end
				dims = ((1.0, 0.0) * (<scale> * $user_control_pill_end_width) + (0.0, 1.0) * <pill_height>)
				pos = (<pos> + (0.0, -0.5) * <pill_y_offset>)
				rgba = ($user_control_pill_color)
				just = [right top]
				z_priority = <z>
				flip_v
			}
			createscreenelement {
				type = spriteelement
				parent = user_control_container
				texture = control_pill_end
				dims = ((1.0, 0.0) * (<scale> * $user_control_pill_end_width) + (0.0, 1.0) * <pill_height>)
				pos = (<pos> + (0.0, -0.5) * <pill_y_offset> + (1.0, 0.0) * <pill_width>)
				rgba = ($user_control_pill_color)
				just = [left top]
				z_priority = <z>
			}
		else
			formattext checksumname = textid 'uc_text_%d' d = ($num_user_control_helpers)
			createscreenelement {
				type = textelement
				parent = user_control_container
				text = <text>
				id = <textid>
				rgba = $user_control_pill_text_color
				scale = (1.1 * <scale>)
				pos = (<pos> + (50.0, 0.0) * <scale> + (0.0, 20.0) * <scale>)
				font = ($user_control_text_font)
				z_priority = (<z> + 0.1)
				just = [left top]
			}
			if (<fit_to_rectangle> = 1)
				SetScreenElementProps id = <id> scale = (1.1 * <scale>)
				getScreenElementDims id = <id>
				if (<width> > $pill_helper_max_width)
					fit_text_in_rectangle id = <id> dims = ($pill_helper_max_width * (0.5, 0.0) + <height> * (0.0, 1.0) * $user_control_pill_scale)
				endif
			endif
			formattext checksumname = buttonid 'uc_button_%d' d = ($num_user_control_helpers)
			createscreenelement {
				type = textelement
				parent = user_control_container
				id = <buttonid>
				text = <buttonchar>
				pos = (<pos> + (-10.0, 8.0) * <scale> + <buttonoff>)
				scale = (1.2 * <scale>)
				rgba = [255 255 255 255]
				font = ($gh3_button_font)
				just = [left top]
				z_priority = (<z> + 0.1)
			}
			if gotparam \{offset_for_strumbar}
				<textid> :settags is_strumbar = 1
				fastscreenelementpos id = <textid> absolute
				SetScreenElementProps id = <textid> pos = (<screenelementpos> + (50.0, 0.0) * <scale>)
			endif
			change num_user_control_helpers = ($num_user_control_helpers + 1)
		endif
	endif
	if ($user_control_super_pill = 1)
		user_control_build_super_pill z = <z>
	elseif ($user_control_auto_center = 1)
		user_control_build_pills z = <z>
	endif
endscript

script user_control_cleanup_pills 
	destroy_menu \{menu_id = user_control_super_pill_object_main}
	destroy_menu \{menu_id = user_control_super_pill_object_l}
	destroy_menu \{menu_id = user_control_super_pill_object_r}
	index = 0
	if NOT ($num_user_control_helpers = 0)
		begin
		formattext checksumname = pill_id 'uc_pill_%d' d = <index>
		if screenelementexists id = <pill_id>
			destroyscreenelement id = <pill_id>
		endif
		formattext checksumname = pill_l_id 'uc_pill_l_%d' d = <index>
		if screenelementexists id = <pill_l_id>
			destroyscreenelement id = <pill_l_id>
		endif
		formattext checksumname = pill_r_id 'uc_pill_r_%d' d = <index>
		if screenelementexists id = <pill_r_id>
			destroyscreenelement id = <pill_r_id>
		endif
		<index> = (<index> + 1)
		repeat ($num_user_control_helpers)
	endif
endscript
action_safe_width_for_helpers = 925

script user_control_build_pills 
	user_control_cleanup_pills
	scale = ($user_control_pill_scale)
	index = 0
	max_pill_width = 0
	if NOT ($num_user_control_helpers = 0)
		begin
		formattext checksumname = textid 'uc_text_%d' d = <index>
		formattext checksumname = buttonid 'uc_button_%d' d = <index>
		fastscreenelementpos id = <buttonid> absolute
		top_left = <screenelementpos>
		fastscreenelementpos id = <textid> absolute
		bottom_right = <screenelementpos>
		getScreenElementDims id = <textid>
		bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
		pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
		if (<pill_width> > <max_pill_width>)
			<max_pill_width> = (<pill_width>)
		endif
		<index> = (<index> + 1)
		repeat ($num_user_control_helpers)
	endif
	<total_width> = (((<max_pill_width> + (<scale> * $user_control_pill_end_width * 2)) * ($num_user_control_helpers)) + (($user_control_pill_gap * <scale>) * ($num_user_control_helpers - 1)))
	if (<total_width> > $action_safe_width_for_helpers)
		<max_pill_width> = ((($action_safe_width_for_helpers - (($user_control_pill_gap * <scale>) * ($num_user_control_helpers - 1))) / ($num_user_control_helpers)) - (<scale> * $user_control_pill_end_width * 2))
	endif
	index = 0
	initial_pill_x = (640 + -1 * (($num_user_control_helpers / 2.0) * <max_pill_width>) - ((0.5 * $user_control_pill_gap * <scale>) * ($num_user_control_helpers -1)))
	pos = ((1.0, 0.0) * <initial_pill_x> + (0.0, 1.0) * ($user_control_pill_y_position) + (0.0, 0.8) * (<scale>))
	if NOT ($num_user_control_helpers = 0)
		begin
		formattext checksumname = pill_id 'uc_pill_%d' d = <index>
		formattext checksumname = pill_l_id 'uc_pill_l_%d' d = <index>
		formattext checksumname = pill_r_id 'uc_pill_r_%d' d = <index>
		formattext checksumname = textid 'uc_text_%d' d = <index>
		formattext checksumname = buttonid 'uc_button_%d' d = <index>
		fastscreenelementpos id = <buttonid> absolute
		top_left = <screenelementpos>
		fastscreenelementpos id = <textid> absolute
		bottom_right = <screenelementpos>
		getScreenElementDims id = <textid>
		bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
		pill_width = (<max_pill_width>)
		pill_height = ((0.0, 1.0).<bottom_right> - (0.0, 1.0).<top_left>)
		pill_y_offset = (<pill_height> * 0.2)
		pill_height = (<pill_height> + <pill_y_offset>)
		createscreenelement {
			type = spriteelement
			parent = user_control_container
			id = <pill_id>
			texture = control_pill_body
			dims = ((1.0, 0.0) * <pill_width> + (0.0, 1.0) * <pill_height>)
			pos = (<pos> + (0.0, -0.5) * <pill_y_offset>)
			rgba = ($user_control_pill_color)
			just = [left top]
			z_priority = <z>
		}
		createscreenelement {
			type = spriteelement
			parent = user_control_container
			id = <pill_l_id>
			texture = control_pill_end
			dims = ((1.0, 0.0) * (<scale> * $user_control_pill_end_width) + (0.0, 1.0) * <pill_height>)
			pos = (<pos> + (0.0, -0.5) * <pill_y_offset>)
			rgba = ($user_control_pill_color)
			just = [right top]
			z_priority = <z>
			flip_v
		}
		createscreenelement {
			type = spriteelement
			parent = user_control_container
			id = <pill_r_id>
			texture = control_pill_end
			dims = ((1.0, 0.0) * (<scale> * $user_control_pill_end_width) + (0.0, 1.0) * <pill_height>)
			pos = (<pos> + (0.0, -0.5) * <pill_y_offset> + (1.0, 0.0) * <max_pill_width>)
			rgba = ($user_control_pill_color)
			just = [left top]
			z_priority = <z>
		}
		<index> = (<index> + 1)
		pos = (<pos> + (1.0, 0.0) * ($user_control_pill_gap * <scale> + <max_pill_width>))
		repeat ($num_user_control_helpers)
	endif
	index = 0
	if NOT ($num_user_control_helpers = 0)
		begin
		align_user_control_with_pill pill_index = <index>
		<index> = (<index> + 1)
		repeat ($num_user_control_helpers)
	endif
endscript

script align_user_control_with_pill 
	formattext checksumname = pill_id 'uc_pill_%d' d = <pill_index>
	fastscreenelementpos id = <pill_id> absolute
	getScreenElementDims id = <pill_id>
	pill_midpoint_x = (<screenelementpos>.(1.0, 0.0) + 0.5 * <width>)
	align_user_control_with_x x = <pill_midpoint_x> pill_index = <pill_index>
endscript

script align_user_control_with_x 
	formattext checksumname = textid 'uc_text_%d' d = <pill_index>
	formattext checksumname = buttonid 'uc_button_%d' d = <pill_index>
	fastscreenelementpos id = <buttonid> absolute
	top_left = <screenelementpos>
	button_pos = <screenelementpos>
	fastscreenelementpos id = <textid> absolute
	bottom_right = <screenelementpos>
	text_pos = <screenelementpos>
	getScreenElementDims id = <textid>
	bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
	pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
	text_button_midpoint = (<top_left>.(1.0, 0.0) + 0.5 * <pill_width>)
	midpoint_diff = (<text_button_midpoint> - <x>)
	new_button_pos = (<button_pos> - (1.0, 0.0) * <midpoint_diff>)
	new_text_pos = (<text_pos> - (1.0, 0.0) * <midpoint_diff>)
	SetScreenElementProps id = <textid> pos = <new_text_pos>
	SetScreenElementProps id = <buttonid> pos = <new_button_pos>
endscript

script user_control_build_super_pill 
	user_control_cleanup_pills
	scale = ($user_control_pill_scale)
	index = 0
	pos = ((0.0, 1.0) * $user_control_pill_y_position)
	leftmost = 9999.0
	rightmost = -9999.0
	if NOT ($num_user_control_helpers = 0)
		begin
		formattext checksumname = textid 'uc_text_%d' d = <index>
		formattext checksumname = buttonid 'uc_button_%d' d = <index>
		fastscreenelementpos id = <buttonid> absolute
		top_left = <screenelementpos>
		fastscreenelementpos id = <textid> absolute
		bottom_right = <screenelementpos>
		getScreenElementDims id = <textid>
		bottom_right = (<bottom_right> + (1.0, 0.0) * <width> + (0.0, 1.0) * <height>)
		button_text_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
		left_x = ((1.0, 0.0).<pos>)
		right_x = ((1.0, 0.0).<pos> + <button_text_width>)
		if (<left_x> < <leftmost>)
			<leftmost> = (<left_x>)
		endif
		if (<right_x> > <rightmost>)
			<rightmost> = (<right_x>)
		endif
		pill_width = ((1.0, 0.0).<bottom_right> - (1.0, 0.0).<top_left>)
		<buttonid> :settags calc_width = <pill_width>
		<buttonid> :settags calc_pos = <pos>
		pos = (<pos> + (1.0, 0.0) * ($user_control_pill_gap * <scale> * $user_control_super_pill_gap + <pill_width>))
		<index> = (<index> + 1)
		repeat ($num_user_control_helpers)
	endif
	whole_pill_width = (<rightmost> - <leftmost>)
	holy_midpoint_batman = (<leftmost> + 0.5 * <whole_pill_width>)
	midpoint_diff = (<holy_midpoint_batman> - 640)
	index = 0
	if NOT ($num_user_control_helpers = 0)
		begin
		formattext checksumname = textid 'uc_text_%d' d = <index>
		formattext checksumname = buttonid 'uc_button_%d' d = <index>
		<buttonid> :gettags
		<calc_pos> = (<calc_pos> - (1.0, 0.0) * <midpoint_diff>)
		SetScreenElementProps id = <buttonid> pos = (<calc_pos>)
		istextstrumbar id = <textid>
		if (<is_strumbar> = 0)
			SetScreenElementProps id = <textid> pos = (<calc_pos> + (50.0, 7.0) * <scale>)
		else
			SetScreenElementProps id = <textid> pos = (<calc_pos> + (100.0, 7.0) * <scale>)
		endif
		<index> = (<index> + 1)
		repeat ($num_user_control_helpers)
	endif
	pill_height = ((0.0, 1.0).<bottom_right> - (0.0, 1.0).<top_left>)
	pill_y_offset = (<pill_height> * 0.2)
	pill_height = (<pill_height> + <pill_y_offset>)
	pos = ((1.0, 0.0) * (<leftmost> - <midpoint_diff>) + (0.0, 1.0) * $user_control_pill_y_position)
	createscreenelement {
		type = spriteelement
		parent = user_control_container
		id = user_control_super_pill_object_main
		texture = control_pill_body
		dims = ((1.0, 0.0) * <whole_pill_width> + (0.0, 1.0) * <pill_height>)
		pos = (<pos> + (0.0, -0.5) * <pill_y_offset>)
		rgba = ($user_control_pill_color)
		just = [left top]
		z_priority = <z>
	}
	createscreenelement {
		type = spriteelement
		parent = user_control_container
		id = user_control_super_pill_object_l
		texture = control_pill_end
		dims = ((1.0, 0.0) * (<scale> * $user_control_pill_end_width) + (0.0, 1.0) * <pill_height>)
		pos = (<pos> + (0.0, -0.5) * <pill_y_offset>)
		rgba = ($user_control_pill_color)
		just = [right top]
		z_priority = <z>
		flip_v
	}
	createscreenelement {
		type = spriteelement
		parent = user_control_container
		id = user_control_super_pill_object_r
		texture = control_pill_end
		dims = ((1.0, 0.0) * (<scale> * $user_control_pill_end_width) + (0.0, 1.0) * <pill_height>)
		pos = (<pos> + (0.0, -0.5) * <pill_y_offset> + (1.0, 0.0) * <whole_pill_width>)
		rgba = ($user_control_pill_color)
		just = [left top]
		z_priority = <z>
	}
endscript

script fastscreenelementpos 
	GetScreenElementProps id = <id>
	return screenelementpos = <pos>
endscript

script istextstrumbar 
	<id> :gettags
	if gotparam \{is_strumbar}
		return \{is_strumbar = 1}
	else
		return \{is_strumbar = 0}
	endif
endscript

script get_diff_completion_text \{for_p2_career = 0}
	pop_progression = 0
	if ($progression_pop_count = 1)
		progression_push_current
		pop_progression = 1
	endif
	diff_completion_text = ["" "" "" ""]
	get_progression_globals game_mode = ($game_mode)
	change g_gh3_setlist = <tier_global>
	difficulty_array = [easy medium hard expert]
	stored_difficulty = ($current_difficulty)
	if ($game_mode = p2_career)
		stored_difficulty2 = ($current_difficulty2)
		change \{current_difficulty2 = expert}
	endif
	num_tiers = ($g_gh3_setlist.num_tiers)
	diff_index = 0
	begin
	diff_num_songs = 0
	diff_songs_completed = 0
	change current_difficulty = (<difficulty_array> [<diff_index>])
	progression_pop_current \{UpdateAtoms = 0}
	tier_index = 1
	begin
	setlist_prefix = ($g_gh3_setlist.prefix)
	formattext checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier_index>
	formattext checksumname = tier_checksum 'tier%s' s = <tier_index>
	getarraysize ($g_gh3_setlist.<tier_checksum>.songs)
	num_songs = <array_size>
	diff_num_songs = (<diff_num_songs> + <num_songs>)
	song_count = 0
	begin
	formattext checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1) s = <tier_index> addtostringlookup = true
	GetGlobalTags <song_checksum> params = {stars score}
	if NOT (<stars> = 0)
		<diff_songs_completed> = (<diff_songs_completed> + 1)
	endif
	song_count = (<song_count> + 1)
	repeat <num_songs>
	<tier_index> = (<tier_index> + 1)
	repeat <num_tiers>
	if NOT (<for_p2_career>)
		formattext textname = diff_completion_string "%a OF %b SONGS" a = <diff_songs_completed> b = <diff_num_songs>
		SetArrayElement arrayname = diff_completion_text index = (<diff_index>) newvalue = (<diff_completion_string>)
	else
		formattext textname = diff_completion_string "%a of %b songs completed" a = <diff_songs_completed> b = <diff_num_songs>
		SetArrayElement arrayname = diff_completion_text index = (<diff_index>) newvalue = (<diff_completion_string>)
	endif
	progression_push_current
	<diff_index> = (<diff_index> + 1)
	repeat 4
	change current_difficulty = <stored_difficulty>
	if ($game_mode = p2_career)
		change current_difficulty2 = <stored_difficulty2>
	endif
	if (<pop_progression> = 1)
		progression_pop_current \{UpdateAtoms = 0}
	endif
	return diff_completion_text = <diff_completion_text>
endscript

script get_diff_completion_percentage \{for_p2_career = 0}
	pop_progression = 0
	if ($progression_pop_count = 1)
		progression_push_current
		pop_progression = 1
	endif
	diff_completion_percentage = [0 0 0 0]
	diff_completion_score = [0 0 0 0]
	get_progression_globals game_mode = ($game_mode)
	change g_gh3_setlist = <tier_global>
	difficulty_array = [easy medium hard expert]
	stored_difficulty = ($current_difficulty)
	if ($game_mode = p2_career)
		stored_difficulty2 = ($current_difficulty2)
		change \{current_difficulty2 = expert}
	endif
	num_tiers = ($g_gh3_setlist.num_tiers)
	percentage_complete = 0
	diff_index = 0
	begin
	diff_num_songs = 0
	diff_songs_completed = 0
	diff_songs_score = 0
	change current_difficulty = (<difficulty_array> [<diff_index>])
	progression_pop_current \{UpdateAtoms = 0}
	tier_index = 1
	begin
	setlist_prefix = ($g_gh3_setlist.prefix)
	formattext checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier_index>
	formattext checksumname = tier_checksum 'tier%s' s = <tier_index>
	getarraysize ($g_gh3_setlist.<tier_checksum>.songs)
	num_songs = <array_size>
	diff_num_songs = (<diff_num_songs> + <num_songs>)
	song_count = 0
	begin
	formattext checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1) s = <tier_index> addtostringlookup = true
	GetGlobalTags <song_checksum> params = {stars score}
	if NOT (<stars> = 0)
		<diff_songs_completed> = (<diff_songs_completed> + 1)
		<diff_songs_score> = (<diff_songs_score> + <score>)
	endif
	song_count = (<song_count> + 1)
	repeat <num_songs>
	<tier_index> = (<tier_index> + 1)
	repeat <num_tiers>
	percentage_complete = (<percentage_complete> + (100 * <diff_songs_completed>) / <diff_num_songs>)
	SetArrayElement arrayname = diff_completion_percentage index = (<diff_index>) newvalue = ((100 * <diff_songs_completed>) / <diff_num_songs>)
	SetArrayElement arrayname = diff_completion_score index = (<diff_index>) newvalue = <diff_songs_score>
	progression_push_current
	<diff_index> = (<diff_index> + 1)
	repeat 4
	change current_difficulty = <stored_difficulty>
	if ($game_mode = p2_career)
		change current_difficulty2 = <stored_difficulty2>
	endif
	if (<pop_progression> = 1)
		progression_pop_current \{UpdateAtoms = 0}
	endif
	return diff_completion_percentage = <diff_completion_percentage> total_percentage_complete = (<percentage_complete> / 4) diff_completion_score = <diff_completion_score>
endscript

script destroy_signin_changed_menu 
	destroy_popup_warning_menu
endscript

script recreate_signin_changed_menu 
	destroy_signin_changed_menu
	create_signin_changed_menu
endscript
transition_playing = false
current_playing_transition = none
Transition_Types = {
	intro = {
		textnl = 'intro'
	}
	fastintro = {
		textnl = 'fastintro'
	}
	practice = {
		textnl = 'practice'
	}
	preencore = {
		textnl = 'preencore'
	}
	encore = {
		textnl = 'encore'
	}
	restartencore = {
		textnl = 'restartencore'
	}
	preboss = {
		textnl = 'preboss'
	}
	boss = {
		textnl = 'boss'
	}
	restartboss = {
		textnl = 'restartboss'
	}
	songwon = {
		textnl = 'songwon'
	}
	songlost = {
		textnl = 'songlost'
	}
}
Default_Immediate_Transition = {
	time = 0
	ScriptTable = [
	]
}
Common_Immediate_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras'
				changenow
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
	]
}
Default_FastIntro_Transition = {
	time = 3000
	ScriptTable = [
	]
}
Common_FastIntro_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
		{
			time = 100
			scr = enable_tutorial_pause
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_RestartEncore_Transition = {
	time = 3000
	ScriptTable = [
	]
}
Common_RestartEncore_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_RestartBoss_Transition = {
	time = 3000
	ScriptTable = [
	]
}
Common_RestartBoss_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				fast
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_Practice_Transition = {
	time = 5000
	ScriptTable = [
	]
}
Common_Practice_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_fastintro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
				practice
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_Intro_Transition = {
	time = 8000
	ScriptTable = [
	]
}
Common_Intro_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_intro'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 1
			scr = play_intro_anims
			params = {
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
		{
			time = 100
			scr = GH_SFX_Intro_WarmUp
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_PreEncore_Transition = {
	time = 8000
	ScriptTable = [
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = good
			}
		}
	]
}
Common_PreEncore_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = play_win_anims
			params = {
			}
		}
		{
			time = 0
			scr = play_outro
			params = {
			}
		}
		{
			time = 0
			scr = Crowd_AllPlayAnim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_preencore'
				changenow
			}
		}
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = good
			}
		}
	]
	EndWithDefaultCamera
}
Default_Encore_Transition = {
	time = 5000
	ScriptTable = [
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
	]
}
Common_Encore_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_encore'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 1
			scr = play_intro_anims
			params = {
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_PreBoss_Transition = {
	time = 8000
	ScriptTable = [
	]
}
Common_PreBoss_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = play_win_anims
			params = {
			}
		}
		{
			time = 0
			scr = play_outro
			params = {
			}
		}
		{
			time = 0
			scr = Crowd_AllPlayAnim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_preboss'
				changenow
			}
		}
	]
	EndWithDefaultCamera
}
Default_Boss_Transition = {
	time = 8000
	ScriptTable = [
	]
}
Common_Boss_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = Transition_StopRendering
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_boss'
				changenow
			}
		}
		{
			time = 0
			scr = play_intro
			params = {
			}
		}
		{
			time = 1
			scr = play_intro_anims
			params = {
			}
		}
		{
			time = 100
			scr = Transition_StartRendering
		}
	]
	EndWithDefaultCamera
	SyncWithNoteCameras
}
Default_SongWon_Transition = {
	time = 8000
	ScriptTable = [
	]
}
Common_SongWon_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = play_win_anims
			params = {
			}
		}
		{
			time = 0
			scr = play_outro
			params = {
				kill_cameracuts_iterator
			}
		}
		{
			time = 0
			scr = Crowd_AllPlayAnim
			params = {
				anim = idle
			}
		}
		{
			time = 0
			scr = Transition_CameraCut
			params = {
				prefix = 'cameras_win'
				changenow
			}
		}
	]
	EndWithDefaultCamera
}
Default_SongLost_Transition = {
	time = 500
	ScriptTable = [
	]
}
Common_SongLost_Transition = {
	ScriptTable = [
		{
			time = 0
			scr = play_lose_anims
			params = {
			}
		}
		{
			time = 0
			scr = change_crowd_looping_sfx
			params = {
				crowd_looping_state = bad
			}
		}
		{
			time = 0
			scr = play_outro
			params = {
				kill_cameracuts_iterator
				song_failed_pitch_streams = 1
			}
		}
		{
			time = 0
			scr = Crowd_AllPlayAnim
			params = {
				anim = idle
			}
		}
	]
	EndWithDefaultCamera
}

script Transition_SelectTransition \{practice_intro = 0}
	if (<practice_intro> = 1)
		return
	endif
	if ($current_transition = debugintro)
		change \{current_transition = intro}
		return
	endif
	if ($game_mode = p1_career ||
			$game_mode = p2_career)
		get_progression_globals game_mode = ($game_mode) use_current_tab = 1
		Career_Songs = <tier_global>
		tier = ($setlist_selection_tier)
		formattext checksumname = tier_checksum 'tier%s' s = <tier>
		if NOT structurecontains structure = ($<Career_Songs>) <tier_checksum>
			change \{current_transition = intro}
			return
		endif
		if Progression_IsBossSong tier_global = <tier_global> tier = <tier> song = ($current_song)
			if should_play_boss_intro
				if NOT ($current_song = bossdevil)
					change \{current_transition = boss}
				else
					change \{current_transition = fastintro}
				endif
			else
				change \{current_transition = fastintro}
			endif
			return
		endif
		if Progression_IsEncoreSong tier_global = <tier_global> tier = <tier> song = ($current_song)
			change \{current_transition = encore}
			return
		endif
	endif
	if ($game_mode = p1_quickplay)
		get_progression_globals game_mode = ($game_mode) use_current_tab = 1
		SetList_Songs = <tier_global>
		tier = ($setlist_selection_tier)
		formattext checksumname = tier_checksum 'tier%s' s = <tier>
		if NOT structurecontains structure = ($<SetList_Songs>) <tier_checksum>
			change \{current_transition = intro}
			return
		endif
	endif
	change \{current_transition = intro}
endscript

script Transition_KillAll 
	killspawnedscript \{id = transitions}
	change \{transition_playing = false}
	change \{current_playing_transition = none}
endscript

script Transition_GetTime \{type = intro}
	if structurecontains structure = $Transition_Types <type>
		printstruct <...>
		type_textnl = ($Transition_Types.<type>.textnl)
	else
		printstruct <...>
		scriptassert \{"Unknown transition type"}
	endif
	GetPakManCurrentName \{map = zones}
	formattext checksumname = Transition_Props '%s_%p_Transition' p = <type_textnl> s = <pakname>
	if NOT globalexists name = <Transition_Props>
		formattext checksumname = Transition_Props 'default_%p_Transition' p = <type_textnl> s = <pakname>
	endif
	return transition_time = ($<Transition_Props>.time)
endscript

script Transition_Play \{type = intro}
	Transition_KillAll
	change current_playing_transition = <type>
	if structurecontains structure = $Transition_Types <type>
		type_textnl = ($Transition_Types.<type>.textnl)
	else
		printstruct <...>
		scriptassert \{"Unknown transition type"}
	endif
	GetPakManCurrentName \{map = zones}
	formattext checksumname = event 'Common_%p_TransitionSetup' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		<event>
	endif
	formattext checksumname = event '%s_%p_TransitionSetup' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		<event>
	endif
	spawnscriptnow Transition_Play_Spawned id = transitions params = {<...>}
	formattext checksumname = event 'GuitarEvent_Transition%s' s = <type_textnl>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
endscript

script Transition_Play_Spawned 
	change \{transition_playing = true}
	GetPakManCurrentName \{map = zones}
	formattext checksumname = Transition_Props '%s_%p_Transition' p = <type_textnl> s = <pakname>
	if NOT globalexists name = <Transition_Props>
		formattext checksumname = Transition_Props 'default_%p_Transition' p = <type_textnl>
		if NOT globalexists name = <Transition_Props>
			printstruct <...>
			scriptassert \{"Default Transition Struct not found"}
		endif
	endif
	transition_time = ($<Transition_Props>.time)
	spawnscriptnow Transition_Play_Iterator id = transitions params = {<...>}
	formattext checksumname = Transition_Props 'Common_%p_Transition' p = <type_textnl>
	spawnscriptnow Transition_Play_Iterator id = transitions params = {<...>}
	getsongtimems
	time_offset = (0 - <time>)
	begin
	getsongtimems time_offset = <time_offset>
	if (<transition_time> <= <time>)
		change \{transition_playing = false}
		break
	endif
	wait \{1
		gameframe}
	repeat
	if structurecontains structure = ($<Transition_Props>) EndWithDefaultCamera
		if structurecontains structure = ($<Transition_Props>) SyncWithNoteCameras
			CameraCuts_GetNextNoteCameraTime
			getsongtimems
			if (<camera_time> >= 0 &&
					<camera_time> - <time> < 2000)
				CameraCuts_EnableChangeCam \{enable = false}
			else
				if NOT ($game_mode = training)
					CameraCuts_SetArrayPrefix \{prefix = 'cameras'
						changenow}
				else
					CameraCuts_EnableChangeCam \{enable = false}
				endif
			endif
		else
			if NOT ($game_mode = training)
				CameraCuts_SetArrayPrefix \{prefix = 'cameras'
					changenow}
			else
				CameraCuts_EnableChangeCam \{enable = false}
			endif
		endif
	endif
	formattext checksumname = event 'Common_%p_TransitionEnd' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
	formattext checksumname = event '%s_%p_TransitionEnd' p = <type_textnl> s = <pakname>
	if scriptexists <event>
		spawnscriptnow <event>
	endif
	change \{current_playing_transition = none}
endscript

script Transition_Play_Iterator 
	getsongtimems
	time_offset = (0 - <time>)
	getarraysize ($<Transition_Props>.ScriptTable)
	if (<array_size> = 0)
		return
	endif
	getsongtimems time_offset = <time_offset>
	array_count = 0
	begin
	begin
	getsongtimems time_offset = <time_offset>
	if ($<Transition_Props>.ScriptTable [<array_count>].time <= <time>)
		break
	endif
	wait \{1
		gameframe}
	repeat
	if scriptexists ($<Transition_Props>.ScriptTable [<array_count>].scr)
		spawnscriptnow ($<Transition_Props>.ScriptTable [<array_count>].scr) id = transitions params = {transition_time = <transition_time> ($<Transition_Props>.ScriptTable [<array_count>].params)}
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script Transition_Wait 
	begin
	if ($transition_playing = false)
		return
	endif
	wait \{1
		gameframe}
	repeat
endscript

script Transition_PlayAnim \{cycle = 0}
	<obj> :obj_switchscript Transition_PlayAnim_Spawned params = {anim = <anim> cycle = <cycle> blendduration = <blendduration>}
endscript

script Transition_PlayAnim_Spawned 
	begin
	GameObj_PlayAnim anim = <anim> blendduration = <blendduration>
	GameObj_WaitAnimFinished
	if (<cycle> = 0)
		break
	endif
	repeat
endscript

script Transition_CameraCut 
	CameraCuts_SetArrayPrefix <...> length = <transition_time>
endscript

script Transition_StopRendering 
	printf \{"Transition_StopRendering"}
	stoprendering
endscript

script Transition_StartRendering 
	printf \{"Transition_StartRendering"}
	startrendering
	enable_pause
	change \{is_changing_levels = 0}
	if ($blade_active = 1)
		gh3_start_pressed
	endif
endscript

script Transition_Printf 
	printf <...>
endscript

script Transitions_ResetZone 
	printf \{"Transitions_ResetZone"}
	GetPakManCurrentName \{map = zones}
	formattext checksumname = reset_func '%s_ResetTransition' s = <pakname>
	if scriptexists <reset_func>
		<reset_func>
	endif
	formattext checksumname = nodearray_checksum '%s_NodeArray' s = <pakname>
	if NOT globalexists name = <nodearray_checksum> type = array
		return
	endif
	getarraysize $<nodearray_checksum>
	array_count = 0
	begin
	resetvalid = true
	if structurecontains structure = ($<nodearray_checksum> [<array_count>]) createdfromvariable
		resetvalid = false
	endif
	if structurecontains structure = ($<nodearray_checksum> [<array_count>]) createdonprogress
		resetvalid = false
	endif
	if structurecontains structure = ($<nodearray_checksum> [<array_count>]) class
		if NOT ($<nodearray_checksum> [<array_count>].class = gameobject ||
				$<nodearray_checksum> [<array_count>].class = levelgeometry)
			resetvalid = false
		endif
	else
		resetvalid = false
	endif
	if (<resetvalid> = true)
		printf "Resetting %s" s = ($<nodearray_checksum> [<array_count>].name)
		kill name = ($<nodearray_checksum> [<array_count>].name)
		if structurecontains structure = ($<nodearray_checksum> [<array_count>]) createdatstart
			create name = ($<nodearray_checksum> [<array_count>].name)
		endif
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
endscript

script Common_PreEncore_TransitionSetup 
	PreEncore_Crowd_Build_SFX
	change_crowd_looping_sfx \{crowd_looping_state = good}
endscript

script Common_PreEncore_TransitionEnd 
endscript

script Common_Encore_TransitionSetup 
	GH_SFX_Play_Encore_Audio_From_Zone_Memory
endscript

script Common_Boss_TransitionSetup 
	GH_SFX_Play_Boss_Audio_From_Zone_Memory
endscript

script Common_Encore_TransitionEnd 
endscript

script Preload_Encore_Bink_Audio \{movie_name = 'z_artdeco_encore_audio'}
endscript
destroy_time = 1.0
gHighwayTiling1 = 1.5
highway_playline1 = 655
highway_height1 = 350
highway_top_width1 = 160.0
widthOffsetFactor1 = 2.2
highway_fade1 = 30.0
gem_start_scale1 = 0.25
gem_end_scale1 = 0.8
gem_star_scale1 = 1.3
gem_y_just1 = 0.83
star_y_just1 = 0.5
fretbar_start_scale1 = 0.15
whammy_top_width1 = 10.0
whammy_width_offset1 = 1.8
sidebar_x_offset1 = 4.0
sidebar_x_scale1 = 0.3
sidebar_y_scale1 = 1.0
starpower_fx_scale1 = 1.0
nowbar_scale_x1 = 0.8
nowbar_scale_y1 = 0.8
string_scale_x1 = 0.65000004
string_scale_y1 = 0.8
gHighwayTiling2 = 1.4
highway_playline2 = 655
highway_height2 = 270
highway_top_width2 = 170.0
widthOffsetFactor2 = 1.3299999
highway_fade2 = 25.0
gem_start_scale2 = 0.27
gem_end_scale2 = 0.8
gem_star_scale2 = 1.3
gem_y_just2 = 0.83
star_y_just2 = 0.5
fretbar_start_scale2 = 0.16
whammy_top_width2 = 9.2
whammy_width_offset2 = 1.5
sidebar_x_offset2 = 4.5
sidebar_x_scale2 = 0.3
sidebar_y_scale2 = 0.75
starpower_fx_scale2 = 0.75
nowbar_scale_x2 = 0.66
nowbar_scale_y2 = 0.8
string_scale_x2 = 0.65000004
string_scale_y2 = 0.5
x_offset_p2 = 225
sidebar_normal0 = [
	255
	255
	255
	255
]
sidebar_normal1 = [
	192
	255
	255
	255
]
sidebar_starready0 = [
	255
	255
	255
	255
]
sidebar_starready1 = [
	128
	192
	255
	255
]
sidebar_dying0 = [
	255
	255
	255
	255
]
sidebar_dying1 = [
	255
	80
	80
	255
]
sidebar_starpower0 = [
	255
	255
	255
	255
]
sidebar_starpower1 = [
	192
	255
	255
	255
]
highway_normal = [
	255
	255
	255
	255
]
highway_starpower = [
	64
	255
	255
	255
]
highway_pulse = [
	0
	0
	0
	255
]
highway_pulse_time = 0.2
neck_sprite_size = 16
neck_lip_add = 16
neck_lip_base = 5
button_up_pixels = 20.0
button_sink_time = 0.1
check_time_early = 0.116
check_time_late = 0.1
hammer_time_early = 0.083
hammer_time_late = 0.083
split_late_percent = 0.5
default_hammer_on_measure_scale = 2.95
strum_before_forming = 0.033999998
form_before_strumming = 0.025
ignore_strums_after_hammers = 0.05
xenon_gem_offset = -66
xenon_input_offset = -66
xenon_drums_offset = 77
ps3_gem_offset = -117
ps3_input_offset = -117
ps3_drums_offset = 117
ps2_gem_offset = -41
ps2_input_offset = -41
ps2_drums_offset = 41
xenon_practice_mode_geminput_offset = 53
ps3_practice_mode_geminput_offset = 44
ps2_practice_mode_geminput_offset = 0
xenon_practice_mode_pitchshift_offset_song = -64
ps3_practice_mode_pitchshift_offset_song = -32
ps2_practice_mode_pitchshift_offset_song = 0
xenon_practice_mode_pitchshift_offset_slow = 0
ps3_practice_mode_pitchshift_offset_slow = 0
ps2_practice_mode_pitchshift_offset_slow = 0
xenon_practice_mode_pitchshift_offset_slower = 0
ps3_practice_mode_pitchshift_offset_slower = 0
ps2_practice_mode_pitchshift_offset_slower = 0
xenon_practice_mode_pitchshift_offset_slowest = 0
ps3_practice_mode_pitchshift_offset_slowest = 0
ps2_practice_mode_pitchshift_offset_slowest = 0
fret_offset_tweak = -14.0
whammy_offset_tweak = -33.0
disallow_tolerance_strums = 1
clear_history_on_hit = 1
dragonforce_hack = 0
prefretbar_time = 0.25
star_spin_rate = -2.5
whammy_shorten = 0.25
whammy_cutoff = 1100.0
whammy_min_hold_pct = 10.0
whammy_min_hold_mute_ms = 750.0
whammy_min_hold_pct_short = 35.0
whammy_wibble_speed = 2
player_two_x_offset = 200
health_change_bad_easy = -3
health_change_good_easy = 0
health_change_star_easy = 0
health_change_bad_battle_easy = -0.053
health_change_good_battle_easy = 0.029
health_change_bad_boss_easy = -0.04
health_change_good_boss_easy = 0.029
health_change_bad_medium = -3
health_change_good_medium = 0
health_change_star_medium = 0
health_change_bad_battle_medium = -0.0267
health_change_good_battle_medium = 0.0145
health_change_bad_boss_medium = -0.02
health_change_good_boss_medium = 0.02
health_change_bad_hard = -3
health_change_good_hard = 0
health_change_star_hard = 0
health_change_bad_battle_hard = -0.0374
health_change_good_battle_hard = 0.013499999
health_change_bad_boss_hard = -0.0267
health_change_good_boss_hard = 0.017499998
health_change_bad_expert = -3
health_change_good_expert = 0
health_change_star_expert = 0
health_change_bad_battle_expert = -0.048
health_change_good_battle_expert = 0.012
health_change_bad_boss_expert = -0.0374
health_change_good_boss_expert = 0.015
health_poor_medium = 0.6666
health_medium_good = 1.3333
health_change_red_multi = 1.3499999
health_change_green_multi = 0.85
health_invincible_time_percentage_easy = 20.0
health_invincible_time_percentage_medium = 10.0
health_invincible_minimum = 25.0
crowd_poor_medium = 0.6666
crowd_medium_good = 1.3333
highway_flash_dying = 0.5
star_power_hit_note_score = 0
star_power_whammy_add = 3.3332999
star_power_whammy_add_coop = 2.5
star_power_sequence_bonus = 25.0
star_power_sequence_min = 0
star_power_drain_rate = 12.5
star_power_drain_rate_coop = 16.666601
star_power_bolt_scale = (1.0, 1.5)
star_power_bolt_time = 0.3
star_power_coop_trigger_ms = 1000
star_tilt_threshold = 16.0
star_lean_scale = 1.75
Song_Win_Delay = 2
star_power_trigger_frames = 3
drum_kick_anim_delay = 0.2
calibrate_lag_tick_ms_offset = 66
is_boss_song = 0
is_guitar_controller = 0

script fail_song_menu_select_tutorial 
	player_device = ($primary_controller)
	if isguitarcontroller controller = <player_device>
		ui_flow_manager_respond_to_action \{action = select_tutorial}
	endif
endscript

script destroy_fail_song_menu 
	restore_start_key_binding
	destroy_menu \{menu_id = fail_song_scrolling_menu}
	destroy_pause_menu_frame
	destroy_menu \{menu_id = fail_song_static_text_container}
endscript

script fail_song_menu_select_practice 
	GH3_SFX_fail_song_stop_sounds
	ui_flow_manager_respond_to_action \{action = select_practice}
endscript

script fail_song_menu_select_retry_song 
	GH3_SFX_fail_song_stop_sounds
	unpausegame
	ui_flow_manager_respond_to_action \{action = select_retry}
	restart_song
endscript

script fail_song_menu_select_new_song 
	GH3_SFX_fail_song_stop_sounds
	ui_flow_manager_respond_to_action \{action = select_new_song}
endscript

script fail_song_menu_select_quit 
	ui_flow_manager_respond_to_action \{action = select_quit}
endscript

script retry_highlight_focus 
	retail_menu_focus id = <id>
	if screenelementexists \{id = hi_left}
		if screenelementexists \{id = hi_right}
			getScreenElementDims id = <id>
			SetScreenElementProps id = hi_left pos = ((635.0, 475.0) - <width> * (0.5, 0.0)) flip_v
			SetScreenElementProps id = hi_right pos = ((645.0, 475.0) + <width> * (0.5, 0.0))
			if ($game_mode = p1_career)
				if ($is_boss_song = 1)
					if ($is_guitar_controller = 1)
						SetScreenElementProps id = hi_left pos = ((635.0, 471.0) - <width> * (0.5, 0.0)) flip_v
						SetScreenElementProps id = hi_right pos = ((645.0, 471.0) + <width> * (0.5, 0.0))
					endif
				else
					SetScreenElementProps id = hi_left pos = ((635.0, 455.0) - <width> * (0.5, 0.0)) flip_v
					SetScreenElementProps id = hi_right pos = ((645.0, 455.0) + <width> * (0.5, 0.0))
				endif
			endif
		endif
	endif
endscript

script practice_highlight_focus 
	retail_menu_focus id = <id>
	if screenelementexists \{id = hi_left}
		if screenelementexists \{id = hi_right}
			getScreenElementDims id = <id>
			SetScreenElementProps id = hi_left pos = ((635.0, 495.0) - <width> * (0.5, 0.0)) flip_v
			SetScreenElementProps id = hi_right pos = ((645.0, 495.0) + <width> * (0.5, 0.0))
			if ($game_mode = p1_career)
				if ($is_boss_song = 1)
					if ($is_guitar_controller = 1)
						SetScreenElementProps id = hi_left pos = ((635.0, 515.0) - <width> * (0.5, 0.0)) flip_v
						SetScreenElementProps id = hi_right pos = ((645.0, 515.0) + <width> * (0.5, 0.0))
					endif
				else
					SetScreenElementProps id = hi_left pos = ((635.0, 495.0) - <width> * (0.5, 0.0)) flip_v
					SetScreenElementProps id = hi_right pos = ((645.0, 495.0) + <width> * (0.5, 0.0))
				endif
			endif
		endif
	endif
endscript

script newsong_highlight_focus 
	retail_menu_focus id = <id>
	if screenelementexists \{id = hi_left}
		if screenelementexists \{id = hi_right}
			getScreenElementDims id = <id>
			SetScreenElementProps id = hi_left pos = ((635.0, 515.0) - <width> * (0.5, 0.0)) flip_v
			SetScreenElementProps id = hi_right pos = ((645.0, 515.0) + <width> * (0.5, 0.0))
			if ($game_mode = p1_career)
				if ($is_boss_song = 1)
					if ($is_guitar_controller = 1)
						SetScreenElementProps id = hi_left pos = ((635.0, 555.0) - <width> * (0.5, 0.0)) flip_v
						SetScreenElementProps id = hi_right pos = ((645.0, 555.0) + <width> * (0.5, 0.0))
					endif
				else
					SetScreenElementProps id = hi_left pos = ((635.0, 535.0) - <width> * (0.5, 0.0)) flip_v
					SetScreenElementProps id = hi_right pos = ((645.0, 535.0) + <width> * (0.5, 0.0))
				endif
			endif
		endif
	endif
endscript

script quit_highlight_focus 
	retail_menu_focus id = <id>
	if screenelementexists \{id = hi_left}
		if screenelementexists \{id = hi_right}
			getScreenElementDims id = <id>
			SetScreenElementProps id = hi_left pos = ((635.0, 555.0) - <width> * (0.5, 0.0)) flip_v
			SetScreenElementProps id = hi_right pos = ((645.0, 555.0) + <width> * (0.5, 0.0))
			if ($game_mode = p1_career)
				if ($is_boss_song = 1)
					if ($is_guitar_controller = 1)
						SetScreenElementProps id = hi_left pos = ((635.0, 596.0) - <width> * (0.5, 0.0)) flip_v
						SetScreenElementProps id = hi_right pos = ((645.0, 596.0) + <width> * (0.5, 0.0))
					endif
				else
					SetScreenElementProps id = hi_left pos = ((635.0, 575.0) - <width> * (0.5, 0.0)) flip_v
					SetScreenElementProps id = hi_right pos = ((645.0, 575.0) + <width> * (0.5, 0.0))
				endif
			endif
		endif
	endif
endscript

script fill_song_title_and_completion_details 
	requireparams \{[
			parent
			uppercasestring
		]
		all}
	createscreenelement {
		type = textelement
		parent = <parent>
		id = fail_song_song_name
		font = <menu_font>
		just = [center center]
		text = <uppercasestring>
		pos = <song_name_pos>
		rgba = [223 223 223 255]
		scale = <song_title_scale>
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = (<z> + 0.1)
	}
	fit_text_in_rectangle {
		id = fail_song_song_name
		dims = (430.0, 65.0)
		keep_ar = 1
		only_if_larger_x = 1
		start_x_scale = <song_title_scale>
		start_y_scale = <song_title_scale>
	}
	<completion_text_scale> = 0.5
	createscreenelement {
		type = hmenu
		parent = <parent>
		id = fail_completion_stacker
		just = [center center]
		pos = <completion_text_pos>
		internal_just = [center center]
		scale = <completion_text_scale>
	}
	<completion_text_params> = {
		type = textelement
		font = <menu_font>
		parent = fail_completion_stacker
		just = [center center]
		rgba = [210 130 0 255]
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = (<z> + 0.1)
	}
	createscreenelement <completion_text_params> scale = 1 text = "COMPLETED"
	createscreenelement <completion_text_params> scale = 1 text = " "
	createscreenelement <completion_text_params> scale = 2 text = <completion_text>
	createscreenelement <completion_text_params> scale = 1 text = "% "
	createscreenelement <completion_text_params> scale = 1 text = "ON"
	createscreenelement <completion_text_params> scale = 1 text = " "
	createscreenelement <completion_text_params> scale = 2 text = <difficulty_text>
	SetScreenElementLock \{id = fail_completion_stacker
		on}
	fit_text_in_rectangle {
		id = fail_completion_stacker
		dims = (405.0, 400.0)
		keep_ar = 1
		only_if_larger_x = 1
		start_x_scale = <completion_text_scale>
		start_y_scale = <completion_text_scale>
	}
endscript
respond_to_signin_changed = 0
bootup_sequence_fs = {
	create = start_bootup_sequence
	destroy = end_bootup_sequence
	actions = [
		{
			action = skip_bootup_sequence
			flow_state = bootup_press_any_button_fs
		}
	]
}
bootup_press_any_button_fs = {
	create = create_press_any_button_menu
	destroy = destroy_press_any_button_menu
	actions = [
		{
			action = enter_attract_mode
			flow_state = bootup_attract_mode_fs
		}
		{
			action = continue
			flow_state_func = 0x84f7dd08
		}
	]
}
bootup_attract_mode_fs = {
	create = create_attract_mode
	destroy = destroy_attract_mode
	actions = [
		{
			action = exit_attract_mode
			flow_state = 0x84f7dd08
		}
	]
}
legal_timer = 0

script start_legal_timer 
	change \{legal_timer = 0}
	wait \{6
		seconds}
	change \{legal_timer = 1}
endscript

script wait_for_legal_timer 
	if notcd
		if ($show_movies = 0)
			return
		endif
	endif
	begin
	if ($legal_timer = 1)
		break
	endif
	wait \{1
		gameframe}
	repeat
endscript

script bootup_sequence 
	wait_for_legal_timer
	startrendering
	PlayMovieAndWait \{movie = 'atvi'}
	PlayMovieAndWait \{movie = 'ro_logo'}
	PlayMovieAndWait \{movie = 'ns_logo'}
	PlayMovieAndWait \{movie = 'intro'}
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = skip_bootup_sequence
			play_sound = 0
		}}
endscript

script start_bootup_sequence 
	if notcd
		if ($show_movies = 0)
			startrendering
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = skip_bootup_sequence
					play_sound = 0
				}}
			return
		endif
	endif
	spawnscriptnow \{bootup_sequence}
endscript

script end_bootup_sequence 
endscript

script check_signin_change_monitor_flag 
	if ($respond_to_signin_changed = 0)
		scriptassert \{"check_signin_change_monitor_flag failed"}
	endif
endscript

script start_checking_for_signin_change 
	printf \{"start_checking_for_signin_change"}
	printscriptinfo \{"start_checking_for_signin_change"}
	printf \{"start_checking_for_signin_change - killing sysnotifys"}
	killspawnedscript \{name = sysnotify_handle_signin_change}
	printf \{"start_checking_for_signin_change - begin"}
	change \{respond_to_signin_changed = 1}
	change \{menu_select_difficulty_first_time = 1}
endscript

script bootup_check_for_sign_in 
	change \{enable_saving = 0}
	if gotparam \{device_num}
		change primary_controller = <device_num>
		change structurename = player1_status controller = ($primary_controller)
	endif
	StartGameProfileSettingsRead
	begin
	if GameProfileSettingsFinished
		break
	endif
	repeat
	change \{menu_select_difficulty_first_time = 1}
	return \{flow_state = bootup_download_scan_fs}
endscript

script process_signin_complete 
	RefreshSigninStatus
	if isXenon
		StartGameProfileSettingsRead
		begin
		if GameProfileSettingsFinished
			break
		endif
		repeat
	endif
	start_checking_for_signin_change
	return \{flow_state = bootup_do_memcard_sequence_fs}
endscript
ps3_signin_complete = 0

script wait_for_blade_complete 
	if isXenon
		wait_for_sysnotify_unpause
	else
		begin
		if (1 = $ps3_signin_complete)
			break
		endif
		wait \{1
			frame}
		repeat
	endif
endscript

script signin_complete_callback 
	change \{ps3_signin_complete = 1}
endscript
bootup_signin_warning_fs = {
	create = create_signin_warning_menu
	destroy = destroy_signin_warning_menu
	actions = [
		{
			action = select_continue_without_saving
			flow_state = bootup_using_guitar_controller_fs
		}
		{
			action = select_choose_storage_device
			flow_state_func = bootup_check_for_sign_in
		}
		{
			action = select_continue_without_signing_in
			flow_state = bootup_signin_complete_message
		}
	]
}
bootup_do_memcard_sequence_fs = {
	create = memcard_sequence_begin_bootup
	create_params = {
		StorageSelectorForce = 1
	}
	destroy = memcard_sequence_cleanup_generic
	actions = [
		{
			action = memcard_sequence_save_success
			flow_state = bootup_using_guitar_controller_fs
		}
		{
			action = memcard_sequence_save_failed
			flow_state = bootup_using_guitar_controller_fs
		}
		{
			action = memcard_sequence_load_success
			flow_state = bootup_download_scan_fs
		}
		{
			action = memcard_sequence_load_failed
			flow_state = bootup_using_guitar_controller_fs
		}
	]
}
bootup_using_guitar_controller_fs = {
	create = create_using_guitar_controller_menu
	destroy = destroy_using_guitar_controller_menu
	actions = [
		{
			action = continue
			flow_state = main_menu_fs
		}
	]
}
bootup_download_scan_fs = {
	create = create_download_scan_menu
	destroy = destroy_download_scan_menu
	actions = [
		{
			action = continue
			flow_state = bootup_using_guitar_controller_fs
		}
	]
}
0x84f7dd08 = {
	create = create_download_scan_menu
	destroy = destroy_download_scan_menu
	actions = [
		{
			action = continue
			flow_state = main_menu_fs
		}
	]
}
bootup_signin_complete_message = {
	create = create_signin_complete_menu
	destroy = destroy_signin_complete_menu
	actions = [
		{
			action = continue
			flow_state_func = process_signin_complete
		}
	]
}
is_shutdown_safe = 1

script mark_unsafe_for_shutdown 
	change \{is_shutdown_safe = 0}
endscript

script mark_safe_for_shutdown 
	change \{is_shutdown_safe = 1}
	unpausespawnedscript \{wait_for_safe_shutdown}
endscript

script wait_for_safe_shutdown 
	begin
	if ($is_shutdown_safe = 1)
		break
	endif
	wait \{1
		gameframe}
	repeat
endscript

script handle_signin_changed 
	printf \{"handle_signin_changed"}
	change \{respond_to_signin_changed = 0}
	wait_for_safe_shutdown
	printf \{"handle_signin_changed started"}
	disable_pause
	stoprendering
	shutdown_game_for_signin_change \{signin_change = 1}
	launchevent \{type = unfocus
		target = root_window}
	create_signin_changed_menu
	startrendering
	printf \{"handle_signin_changed end"}
endscript

script signing_change_confirm_reboot 
	printf \{"signing_change_confirm_reboot"}
	destroy_signin_changed_menu
	enable_pause
	wait \{5
		gameframes}
	start_flow_manager \{flow_state = main_menu_fs}
	printf \{"signing_change_confirm_reboot end"}
endscript
shutdown_game_for_signin_change_flag = 0

script shutdown_game_for_signin_change \{unloadcontent = 1
		signin_change = 0}
	printf \{"shutdown_game_for_signin_change"}
	change \{shutdown_game_for_signin_change_flag = 1}
	StopAllSounds
	killspawnedscript \{name = online_menu_init}
	killspawnedscript \{name = do_calibration_update}
	killspawnedscript \{name = cl_do_ping}
	killspawnedscript \{name = kill_off_and_finish_calibration}
	killspawnedscript \{name = menu_calibrate_lag_create_circles}
	set_demonware_failed
	killspawnedscript \{name = create_leaderboard_menu2}
	killspawnedscript \{name = create_leaderboard_menu3}
	killspawnedscript \{name = add_leaderboard_rows_to_menu}
	shutdown_options_video_monitor
	destroy_alert_popup \{force = 1}
	end_practice_song_slomo
	destroy_loading_screen
	memcard_sequence_cleanup_generic
	destroy_leaving_lobby_dialog
	menu_store_go_back
	destroy_menu \{menu_id = select_style_container}
	destroy_menu \{menu_id = select_style_container_p2}
	shut_down_character_hub
	quit_network_game_early \{signin_change}
	tutorial_shutdown
	shut_down_flow_manager \{player = 1
		resetstate}
	shut_down_flow_manager \{player = 2
		resetstate}
	store_monitor_goal_guitar_finish
	DeRegisterAtoms
	kill_gem_scroller \{no_render = 1}
	progression_push_current \{force = 1}
	clean_up_user_control_helpers
	Menu_Music_Off
	unload_songqpak
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	destroy_band \{unload_paks}
	if (<signin_change> = 1)
		clear_cheats
	endif
	if (<unloadcontent> = 1)
		ClearGlobalTags
		setup_globaltags
	endif
	if screenelementexists \{id = ready_container_p2}
		destroyscreenelement \{id = ready_container_p2}
	endif
	set_default_misc_globals
	cleanup_songwon_event
	destroy_menu_transition
	unpausegame
	change \{shutdown_game_for_signin_change_flag = 0}
	printf \{"shutdown_game_for_signin_change end"}
endscript

script cleanup_songwon_event 
	destroy_menu \{menu_id = yourock_text}
	destroy_menu \{menu_id = yourock_text_2}
	destroy_menu \{menu_id = yourock_text_legend}
	killspawnedscript \{name = jiggle_text_array_elements}
	killspawnedscript \{name = You_Rock_Waiting_Crowd_SFX}
	killspawnedscript \{name = GuitarEvent_SongWon_Spawned}
endscript

script set_default_misc_globals 
	change \{show_boss_helper_screen = 0}
	change \{use_last_player_scores = 0}
	change \{old_song = none}
	change \{devil_finish = 0}
	change \{battle_sudden_death = 0}
	change \{menu_flow_locked = 0}
endscript

script setlist_songpreview_monitor 
	begin
	if NOT ($current_setlist_songpreview = $target_setlist_songpreview)
		change \{setlist_songpreview_changing = 1}
		song = ($target_setlist_songpreview)
		SongUnLoadFSB
		wait \{0.5
			second}
		if ($target_setlist_songpreview != <song> || $target_setlist_songpreview = none)
			change \{current_setlist_songpreview = none}
			change \{setlist_songpreview_changing = 0}
		else
			get_song_prefix song = <song>
			get_song_struct song = <song>
			if structurecontains structure = <song_struct> streamname
				song_prefix = (<song_struct>.streamname)
			endif
			if NOT SongLoadFSB song_prefix = <song_prefix>
				change \{setlist_songpreview_changing = 0}
				downloadcontentlost
				return
			endif
			formattext checksumname = song_preview '%s_preview' s = <song_prefix>
			get_song_struct song = <song>
			soundbussunlock \{music_setlist}
			if structurecontains structure = <song_struct> name = band_playback_volume
				setlistvol = ((<song_struct>.band_playback_volume))
				setsoundbussparams {music_setlist = {vol = <setlistvol>}}
			else
				setsoundbussparams \{music_setlist = {
						vol = 0.0
					}}
			endif
			SoundBussLock \{music_setlist}
			playsound <song_preview> buss = music_setlist
			change current_setlist_songpreview = <song>
			change \{setlist_songpreview_changing = 0}
		endif
	elseif NOT ($current_setlist_songpreview = none)
		song = ($current_setlist_songpreview)
		get_song_prefix song = <song>
		formattext checksumname = song_preview '%s_preview' s = <song_prefix>
		if NOT issoundplaying <song_preview>
			change \{setlist_songpreview_changing = 1}
			if NOT SongLoadFSB song_prefix = <song_prefix>
				change \{setlist_songpreview_changing = 0}
				downloadcontentlost
				return
			endif
			playsound <song_preview> buss = music_setlist
			change \{setlist_songpreview_changing = 0}
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript

script downloadcontentlost 
	change \{is_changing_levels = 0}
	change \{practice_songpreview_changing = 0}
	printscriptinfo \{"DownloadContentLost"}
	spawnscriptnow \{noqbid
		DownloadContentLost_Spawned}
	killspawnedscript \{name = setlist_choose_song}
	killspawnedscript \{name = downloadcontentlost}
endscript

script SongUnLoadFSBIfDownloaded 
	GetContentFolderIndexFromFile ($song_fsb_name)
	if NOT ($song_fsb_id = -1)
		if (<device> = content)
			UnLoadFSB \{fsb_index = $song_fsb_id}
			spawnscriptnow Downloads_CloseContentFolder params = {content_index = <content_index>}
			change \{song_fsb_id = -1}
			change \{song_fsb_name = 'none'}
		endif
	endif
endscript

script Downloads_CloseContentFolder \{force = 0}
	mark_unsafe_for_shutdown
	if (<force> = 1)
		if ($downloadcontentfolder_index = -1)
			mark_safe_for_shutdown
			return
		endif
	endif
	if (<force> = 1)
		change \{downloadcontentfolder_count = 0}
	else
		change downloadcontentfolder_count = ($downloadcontentfolder_count - 1)
		if ($downloadcontentfolder_count > 0)
			mark_safe_for_shutdown
			return \{true}
		endif
	endif
	if (<force> = 1)
		content_index = ($downloadcontentfolder_index)
	else
		change \{downloadcontentfolder_index = -1}
	endif
	if NOT CloseContentFolder content_index = <content_index>
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	GetContentFolderState
	if (<contentfolderstate> = free)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 0}
	mark_safe_for_shutdown
	return \{true}
endscript

script Downloads_OpenContentFolder 
	unpausespawnedscript \{Downloads_CloseContentFolder}
	mark_unsafe_for_shutdown
	begin
	if ($downloadcontentfolder_lock = 0)
		break
	endif
	if ($downloadcontentfolder_index = <content_index>)
		change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
		mark_safe_for_shutdown
		return \{true}
	endif
	wait \{1
		gameframe}
	repeat
	change \{downloadcontentfolder_lock = 1}
	if NOT OpenContentFolder content_index = <content_index>
		mark_safe_for_shutdown
		return \{false}
	endif
	begin
	GetContentFolderState
	if (<contentfolderstate> = failed)
		change \{downloadcontentfolder_lock = 0}
		mark_safe_for_shutdown
		return \{false}
	endif
	if (<contentfolderstate> = opened)
		break
	endif
	wait \{1
		gameframe}
	repeat
	change downloadcontentfolder_count = ($downloadcontentfolder_count + 1)
	change downloadcontentfolder_index = <content_index>
	mark_safe_for_shutdown
	return \{true}
endscript

script crowd_monitor_performance 
	lighters_on = false
	begin
	get_skill_level
	if ($current_song = dlc19)
		skill = good
	endif
	if (<skill> != bad)
		if (<lighters_on> = false)
			Crowd_AllSetHand \{hand = right
				type = lighter}
			Crowd_AllPlayAnim \{anim = special}
			lighters_on = true
			Crowd_ToggleLighters \{on}
		endif
	else
		if (<lighters_on> = true)
			Crowd_AllSetHand \{hand = right
				type = clap}
			Crowd_AllPlayAnim \{anim = idle}
			lighters_on = false
			Crowd_ToggleLighters \{off}
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript

script Transition_StartRendering 
	printf \{"Transition_StartRendering"}
	startrendering
	enable_pause
	change \{is_changing_levels = 0}
	if ($blade_active = 1)
		gh3_start_pressed
	endif
	if ($current_song = dlc19)
		crowd_create_lighters
		Crowd_StartLighters
	endif
endscript

script first_gem_fx 
	extendcrc <gem_id> '_particle' out = fx_id
	if gotparam \{is_star}
		if ($game_mode = p2_battle || $boss_battle = 1)
			<pos> = (125.0, 170.0)
		else
			if ($player1_status.star_power_used = 1)
				<pos> = (95.0, 20.0)
			else
				<pos> = (255.0, 170.0)
			endif
		endif
	else
		<pos> = (66.0, 20.0)
	endif
	destroy2dparticlesystem id = <fx_id>
	create2dparticlesystem {
		id = <fx_id>
		pos = <pos>
		z_priority = 8.0
		material = sys_Particle_lnzflare02_sys_Particle_lnzflare02
		parent = <gem_id>
		start_color = [255 255 255 255]
		end_color = [255 255 255 0]
		start_scale = (1.0, 1.0)
		end_scale = (2.0, 2.0)
		start_angle_spread = 360.0
		min_rotation = -500.0
		max_rotation = 500.0
		emit_start_radius = 0.0
		emit_radius = 0.0
		emit_rate = 0.3
		emit_dir = 0.0
		emit_spread = 160.0
		velocity = 0.01
		friction = (0.0, 0.0)
		time = 1.25
	}
	spawnscriptnow destroy_first_gem_fx params = {gem_id = <gem_id> fx_id = <fx_id>}
	wait \{0.8
		seconds}
	destroy2dparticlesystem id = <fx_id> kill_when_empty
endscript

script create_cheats_menu 
	disable_pause
	if ($entering_cheat = 0)
		createscreenelement \{type = containerelement
			id = cheats_container
			parent = root_window
			pos = (0.0, 0.0)}
		create_menu_backdrop \{texture = Venue_BG}
		displaySprite \{parent = cheats_container
			tex = options_video_poster
			rot_angle = 1
			pos = (640.0, 215.0)
			dims = (820.0, 440.0)
			just = [
				center
				center
			]
			z = 1
			font = $video_settings_menu_font}
		displayText \{parent = cheats_container
			pos = (910.0, 402.0)
			just = [
				right
				center
			]
			text = "CHEATS"
			scale = 1.5
			rgba = [
				240
				235
				240
				255
			]
			font = text_a5
			noshadow}
		displaySprite \{parent = cheats_container
			tex = tape_H_03
			pos = (270.0, 185.0)
			rot_angle = -50
			scale = 0.5
			z = 20}
		displaySprite {
			parent = <id>
			tex = tape_H_03
			pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			z = 19
		}
		displaySprite \{parent = cheats_container
			tex = tape_H_04
			pos = (930.0, 380.0)
			rot_angle = -120
			scale = 0.5
			z = 20}
		displaySprite {
			parent = <id>
			tex = tape_H_04
			pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			z = 19
		}
		createscreenelement \{type = containerelement
			id = cheats_warning_container
			parent = root_window
			alpha = 0
			scale = 0.5
			pos = (640.0, 540.0)}
		displaySprite \{parent = cheats_warning_container
			id = cheats_warning
			tex = control_pill_body
			pos = (0.0, 0.0)
			just = [
				center
				center
			]
			rgba = [
				96
				0
				0
				255
			]
			z = 100}
		getplatform
		switch <platform>
			case xenon
			warning = "WARNING: Some active cheats do not work in career modes and online."
			warning_cont = "Also, achievement unlocking and leaderboard posts are turned off."
			case ps3
			warning = "WARNING: Some active cheats do not work in career modes and online."
			warning_cont = "Also, leaderboard posts are turned off."
			case ps2
			warning = "WARNING: Some active cheats do not work in career modes."
			warning_cont = ""
			default
			warning = "WARNING: Some active cheats do not work in career modes and online."
			warning_cont = "Also, leaderboard posts are turned off."
		endswitch
		formattext textname = warning_text "%a %b" a = <warning> b = <warning_cont>
		createscreenelement {
			type = textblockelement
			id = first_warning
			parent = cheats_warning_container
			font = text_a6
			scale = 1
			text = <warning_text>
			rgba = [186 105 0 255]
			just = [center center]
			z_priority = 101.0
			pos = (0.0, 0.0)
			dims = (1400.0, 100.0)
			allow_expansion
		}
		getScreenElementDims \{id = first_warning}
		bg_dims = (<width> * (1.0, 0.0) + (<height> * (0.0, 1.0) + (0.0, 40.0)))
		cheats_warning :setprops dims = <bg_dims>
		displaySprite {
			parent = cheats_warning_container
			tex = control_pill_end
			pos = (-1 * <width> * (0.5, 0.0))
			rgba = [96 0 0 255]
			dims = ((64.0, 0.0) + (<height> * (0.0, 1.0) + (0.0, 40.0)))
			just = [right center]
			flip_v
			z = 100
		}
		displaySprite {
			parent = cheats_warning_container
			tex = control_pill_end
			pos = (<width> * (0.5, 0.0))
			rgba = [96 0 0 255]
			dims = ((64.0, 0.0) + (<height> * (0.0, 1.0) + (0.0, 40.0)))
			just = [left center]
			z = 100
		}
		cheats_create_guitar
	endif
	show_cheat_warning
	displaySprite \{parent = cheats_container
		id = cheats_hilite
		tex = white
		rgba = [
			40
			60
			110
			255
		]
		rot_angle = 1
		pos = (349.0, 382.0)
		dims = (230.0, 30.0)
		z = 2}
	new_menu \{scrollid = cheats_scroll
		vmenuid = cheats_vmenu
		menu_pos = (360.0, 191.0)
		text_left
		spacing = -12
		rot_angle = 1}
	text_params = {parent = cheats_vmenu type = textelement font = text_a3 rgba = [255 245 225 255] z_priority = 50 rot_angle = 0 scale = 1}
	text_params2 = {parent = cheats_vmenu type = textelement font = text_a5 rgba = [255 245 225 255] z_priority = 50 rot_angle = 0 scale = 0.63}
	GetGlobalTags \{user_options}
	<text> = "locked"
	if (<unlock_Cheat_NoFail> > 0)
		if ($cheat_nofail = 1)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [3].name_text)
		else
			if ($cheat_nofail < 0)
				change \{cheat_nofail = 2}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [3].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_NoFail_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 206.0) id = Cheat_NoFail_Text}}
			{pad_choose toggle_cheat params = {cheat = cheat_nofail id = Cheat_NoFail_Text index = 3}}
		]
	}
	<text> = "locked"
	if (<unlock_Cheat_AirGuitar> > 0)
		if ($Cheat_AirGuitar = 1)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [0].name_text)
		else
			if ($Cheat_AirGuitar < 0)
				change \{Cheat_AirGuitar = 2}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [0].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_AirGuitar_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 229.0) id = Cheat_AirGuitar_Text}}
			{pad_choose toggle_cheat params = {cheat = Cheat_AirGuitar id = Cheat_AirGuitar_Text index = 0}}
		]
	}
	<text> = "locked"
	if (<unlock_Cheat_Hyperspeed> > 0)
		if ($Cheat_Hyperspeed > 0)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [2].name_text)
			formattext textname = text "%c, %d" c = <text> d = ($Cheat_Hyperspeed)
		else
			if ($Cheat_Hyperspeed < 0)
				change \{Cheat_Hyperspeed = 0}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [2].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_Hyperspeed_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 252.0) id = Cheat_Hyperspeed_Text}}
			{pad_choose toggle_hyperspeed params = {cheat = Cheat_Hyperspeed id = Cheat_Hyperspeed_Text index = 2}}
		]
	}
	<text> = "locked"
	if (<unlock_Cheat_PerformanceMode> > 0)
		if ($cheat_performancemode = 1)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [1].name_text)
		else
			if ($cheat_performancemode < 0)
				change \{cheat_performancemode = 2}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [1].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_PerformanceMode_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 275.0) id = Cheat_PerformanceMode_Text}}
			{pad_choose toggle_cheat params = {cheat = cheat_performancemode id = Cheat_PerformanceMode_Text index = 1}}
		]
	}
	<text> = "locked"
	if (<unlock_Cheat_EasyExpert> > 0)
		if ($cheat_easyexpert = 1)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [4].name_text)
		else
			if ($cheat_easyexpert < 0)
				change \{cheat_easyexpert = 2}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [4].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_EasyExpert_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 298.0) id = Cheat_EasyExpert_Text}}
			{pad_choose toggle_cheat params = {cheat = cheat_easyexpert id = Cheat_EasyExpert_Text index = 4}}
		]
	}
	<text> = "locked"
	if (<unlock_Cheat_PrecisionMode> > 0)
		if ($Cheat_PrecisionMode = 1)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [5].name_text)
		else
			if ($Cheat_PrecisionMode < 0)
				change \{Cheat_PrecisionMode = 2}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [5].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_PrecisionMode_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 321.0) id = Cheat_PrecisionMode_Text}}
			{pad_choose toggle_cheat params = {cheat = Cheat_PrecisionMode id = Cheat_PrecisionMode_Text index = 5}}
		]
	}
	<text> = "locked"
	if (<unlock_Cheat_BretMichaels> > 0)
		if ($Cheat_BretMichaels = 1)
			formattext textname = text "%c : ON" c = ($guitar_hero_cheats [6].name_text)
		else
			if ($Cheat_BretMichaels < 0)
				change \{Cheat_BretMichaels = 2}
			endif
			formattext textname = text "%c : OFF" c = ($guitar_hero_cheats [6].name_text)
		endif
	endif
	createscreenelement {
		<text_params2>
		text = <text>
		id = Cheat_BretMichaels_Text
		event_handlers = [
			{focus cheats_morph_hilite params = {pos = (349.0, 344.0) id = Cheat_BretMichaels_Text}}
			{pad_choose toggle_cheat params = {cheat = Cheat_BretMichaels id = Cheat_BretMichaels_Text index = 6}}
		]
	}
	clean_up_user_control_helpers
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
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
	change \{entering_cheat = 0}
	change \{guitar_hero_cheats_completed = [
			0
			0
			0
			0
			0
			0
			0
			0
			0
		]}
endscript
beat_game_message_expert = "Wow. You've mastered Permadeath on expert -- Go start a band already! Take it to the next level with the \\c1%n\\c0!"

new_band_flashing_char = "1"
new_band_flashing_index = 0
new_band_flashing_index_prev = 0
new_band_index = 0
max_band_characters = 2
ebn_transitioning_back = 0
default_band_characters = [
	"1"
	"2"
	"3"
	"4"
	"5"
	"6"
	"7"
	"8"
	"9"
	"10"
	"11"
	"12"
	"13"
	"14"
	"15"
	"16"
	"17"
	"18"
	"19"
	"20"
	"21"
	"22"
	"23"
	"24"
	"25"
	"26"
	"27"
	"28"
	"29"
	"30"
	"31"
	"32"
	"33"
	"34"
	"35"
	"36"
	"37"
	"38"
	"39"
	"40"
	"41"
	"42"
	"43"
	"44"
	"45"
	"46"
	"47"
	"48"
	"49"
	"50"
	"51"
	"52"
	"53"
	"54"
	"55"
	"56"
	"57"
	"58"
	"59"
	"60"
	"61"
	"62"
	"63"
	"64"
	"65"
	"66"
	"67"
	"68"
	"69"
	"70"
	"71"
	"72"
	"73"
	"74"
	"75"
	"76"
	"77"
	"78"
	"79"
	"80"
	"81"
	"82"
	"83"
	"84"
	"85"
	"86"
	"87"
	"88"
	"89"
	"90"
	"91"
	"92"
	"93"
	"94"
	"95"
	"96"
	"97"
	"98"
	"99"
	"100"
]

script create_enter_band_name_menu 
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				null_script
			}
		]
		replace_handlers}
	NetSessionFunc \{func = stats_init}
	enter_band_name_reset_variables
	rotation_angle = -2
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = ebn_container
		Pos = (0.0, 0.0)}
	CreateScreenElement \{type = SpriteElement
		parent = ebn_container
		id = menu_backdrop
		texture = TopRockers_BG
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 0}
	CreateScreenElement \{type = SpriteElement
		parent = ebn_container
		id = light_overlay
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 99}
	CreateScreenElement \{type = SpriteElement
		parent = ebn_container
		id = ticket_image
		texture = band_name_ticket
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 1}
	CreateScreenElement {
		type = SpriteElement
		parent = ebn_container
		id = random_image
		texture = band_name_graphic03
		rgba = [255 255 255 255]
		Pos = (($enter_band_name_big_vals).right_side_img_pos)
		dims = (($enter_band_name_big_vals).right_side_img_dims)
		z_priority = 2
	}
	rand = 0
	getrandomvalue \{name = rand
		integer
		a = 0
		b = 2}
	if (<rand> = 0)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic03}
	endif
	black = [70 10 10 255]
	blue = [30 110 150 255]
	nameColor = [180 70 35 255]
	activeColor = [230 130 65 255]
	CreateScreenElement {
		type = TextElement
		parent = ebn_container
		font = text_a10_Large
		text = "NUMBER OF LIVES"
		id = ebn_header_text
		Pos = (($enter_band_name_big_vals).header_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		Scale = (($enter_band_name_big_vals).header_scale)
	}
	CreateScreenElement {
		type = TextElement
		parent = ebn_container
		font = text_a3
		text = "THE LEGENDS"
		id = ebn_tour_text
		Pos = (($enter_band_name_big_vals).tour_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		Scale = (($enter_band_name_big_vals).tour_scale)
	}
	CreateScreenElement {
		type = TextElement
		parent = ebn_container
		font = text_a3
		text = "OF ROCK TOUR"
		id = ebn_address_text
		Pos = (($enter_band_name_big_vals).address_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		Scale = (($enter_band_name_big_vals).address_scale)
	}
	GetLocalSystemTime
	if English
		GetUpperCaseString (($us_month_names) [(<localsystemtime>.month)])
		FormatText textname = date_text "%m %d, %y" m = (<uppercasestring>) d = (<localsystemtime>.dayofmonth) y = (<localsystemtime>.year)
	else
		GetUpperCaseString (($us_month_names) [(<localsystemtime>.month)])
		FormatText textname = date_text "%d %m %y" d = (<localsystemtime>.dayofmonth) m = (<uppercasestring>) y = (<localsystemtime>.year)
	endif
	CreateScreenElement {
		type = TextElement
		parent = ebn_container
		font = text_a3
		text = <date_text>
		id = ebn_date_text
		Pos = (($enter_band_name_big_vals).date_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		Scale = (($enter_band_name_big_vals).date_scale)
	}
	CreateScreenElement {
		type = TextElement
		parent = ebn_container
		font = text_a3
		text = "SPONSORED BY:"
		id = ebn_sponsor_text
		Pos = (($enter_band_name_big_vals).sponsor_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		Scale = (($enter_band_name_big_vals).sponsor_scale)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = ebn_container
		id = logo_vault_image
		texture = setlist_icon_generic
		Pos = (($enter_band_name_big_vals).sponsor_pos + ($enter_band_name_big_vals).sponsor_offset)
		dims = (($enter_band_name_big_vals).sponsor_dims)
		rot_angle = <rotation_angle>
		just = [center top]
		Blend = subtract
	}
	CreateScreenElement {
		type = ContainerElement
		parent = ebn_container
		id = band_name_text_container
		rot_angle = <rotation_angle>
	}
	CreateScreenElement {
		type = TextElement
		parent = band_name_text_container
		font = text_a3
		Scale = (($enter_band_name_big_vals).text_scale)
		rgba = <nameColor>
		id = band_name_text
		Pos = (($enter_band_name_big_vals).text_pos)
		just = [center center]
	}
	CreateScreenElement {
		type = TextElement
		parent = band_name_text_container
		font = text_a3
		Scale = (($enter_band_name_big_vals).text_scale)
		rgba = <activeColor>
		text = "1"
		id = band_name_entry_char
		just = [center center]
	}
	CreateScreenElement {
		type = SpriteElement
		parent = band_name_text_container
		id = ebn_marker
		texture = band_name_underline
		just = [center center]
		event_handlers = [
			{pad_up enter_band_name_change_character params = {up}}
			{pad_down enter_band_name_change_character params = {down}}
			{pad_choose band_advance_pointer}
			{pad_back band_retreat_pointer}
			{pad_start confirm_band_name}
		]
		rgba = <activeColor>
		exclusive_device = ($primary_controller)
	}
	RunScriptOnScreenElement \{id = ebn_marker
		blinker
		params = {
			id = ebn_marker
			time = 0.5
		}}
	RunScriptOnScreenElement \{id = band_name_entry_char
		blinker
		params = {
			id = band_name_entry_char
			time = 0.5
		}}
	LaunchEvent \{type = focus
		target = ebn_marker}
	change \{ebn_transitioning_back = 0}
	menu_ebn_update_marker
	enter_band_name_reset_user_control_helpers
endscript

script band_advance_pointer 
	if (($new_band_index + 1) < $max_band_characters)
		SoundEvent \{event = ui_sfx_select}
		SetArrayElement \{arrayName = new_band_name
			globalarray
			index = $new_band_index
			newValue = $new_band_flashing_char}
		change \{new_band_flashing_index_prev = $new_band_flashing_index}
		change \{new_band_flashing_index = 0}
		change \{new_band_flashing_char = "1"}
		change new_band_index = ($new_band_index + 1)
		menu_ebn_refresh_band_name
		if (($new_band_index + 1) = $max_band_characters)
			ebn_take_away_blinker
		endif
	endif
endscript

script enter_band_name_reset_variables 
	change \{new_band_name = [
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
			""
		]}
	change \{new_band_index = 0}
	change \{default_band_indexes = [
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
		]}
	change \{new_band_flashing_char = "1"}
	change \{new_band_flashing_index = 0}
endscript

script band_advance_pointer 
	if (($new_band_index + 1) < $max_band_characters)
		SoundEvent \{event = ui_sfx_select}
		SetArrayElement \{arrayName = new_band_name
			globalarray
			index = $new_band_index
			newValue = $new_band_flashing_char}
		change \{new_band_flashing_index_prev = $new_band_flashing_index}
		change \{new_band_flashing_index = 0}
		change \{new_band_flashing_char = "1"}
		change new_band_index = ($new_band_index + 1)
		menu_ebn_refresh_band_name
		if (($new_band_index + 1) = $max_band_characters)
			ebn_take_away_blinker
		endif
	endif
endscript

script menu_ebn_get_band_name_text 
	FormatText textname = band_name_text_string "%a%b%c%d%e%f%g%h%i%j%k%l%m%n%o%p%q%r%s%t" a = ($new_band_name [0]) b = ($new_band_name [1]) c = ($new_band_name [2]) d = ($new_band_name [3]) e = ($new_band_name [4]) f = ($new_band_name [5]) g = ($new_band_name [6]) h = ($new_band_name [7]) i = ($new_band_name [8]) j = ($new_band_name [9]) k = ($new_band_name [10]) l = ($new_band_name [11]) m = ($new_band_name [12]) n = ($new_band_name [13]) o = ($new_band_name [14]) p = ($new_band_name [15]) q = ($new_band_name [16]) r = ($new_band_name [17]) s = ($new_band_name [18]) t = ($new_band_name [19])
	return band_name_text_string = <band_name_text_string>
endscript

script confirm_band_name 
	if ($ebn_transitioning_back)
		return
	endif
	num_spaces = 0
	array_entry = 0
	<valid> = 0
	<need_unique> = 0
	begin
	if NOT ($new_band_name [<array_entry>] = "")
		if NOT ($new_band_name [<array_entry>] = " ")
			<valid> = 1
			break
		endif
	endif
	<array_entry> = (<array_entry> + 1)
	repeat ($max_band_characters)
	if (<valid> = 1)
		<prev_band_index> = ($current_band - 1)
		if (<prev_band_index> > 0)
			begin
			menu_ebn_get_band_name_text
			StringRemoveTrailingWhitespace string = <band_name_text_string>
			get_band_game_mode_name
			FormatText checksumname = bandname_id 'band%i_info_%g' i = <prev_band_index> g = <game_mode_name>
			GetGlobalTags <bandname_id> param = name
			if (<name> = <new_string>)
				<valid> = 0
				<need_unique> = 1
			endif
			<prev_band_index> = (<prev_band_index> - 1)
			repeat ($current_band - 1)
		endif
		<next_band_index> = ($current_band + 1)
		if (<next_band_index> < 6)
			begin
			menu_ebn_get_band_name_text
			StringRemoveTrailingWhitespace string = <band_name_text_string>
			get_band_game_mode_name
			FormatText checksumname = bandname_id 'band%i_info_%g' i = <next_band_index> g = <game_mode_name>
			GetGlobalTags <bandname_id> param = name
			if (<name> = <new_string>)
				<valid> = 0
				<need_unique> = 1
			endif
			<next_band_index> = (<next_band_index> + 1)
			repeat (5 - $current_band)
		endif
	endif
	if (<valid> = 0)
		SoundEvent \{event = Menu_Warning_SFX}
		enter_band_name_reset_variables
		menu_ebn_refresh_band_name
		menu_ebn_update_marker
		if ScreenElementExists \{id = ebn_marker}
			if (<need_unique> = 1)
				create_alert_popup \{prev_menu_id = ebn_marker
					alert = "The Band Name you entered already exists.  Please enter a different Band Name."}
			else
				create_alert_popup \{prev_menu_id = ebn_marker
					alert = "You must enter a Band Name to proceed!"}
			endif
		endif
	else
		menu_ebn_get_band_name_text
		StringRemoveTrailingWhitespace string = <band_name_text_string>
		get_band_game_mode_name
		FormatText checksumname = bandname_id 'band%i_info_%g' i = ($current_band) g = <game_mode_name>
		GetTrueStartTime
		FormatText checksumname = band_unique_id 'band%i_info_%g_%d' i = ($current_band) g = <game_mode_name> d = <starttime>
		SetGlobalTags <bandname_id> params = {name = <new_string> band_unique_id = <band_unique_id>}
		agora_update band_id = <band_unique_id> name = <new_string> new_band
		StringToInteger \{new_string}
		change permadeath_lives = <new_string>
		change permadeath_lives_total = <new_string>
		if ($options_for_manage_band = 1)
			ui_flow_manager_respond_to_action \{action = enter_band_name_for_manage_band}
		else
			ui_flow_manager_respond_to_action \{action = enter_band_name}
		endif
	endif
endscript

script create_choose_band_menu 
	menu_pos = (400.0, 270.0)
	new_menu {
		scrollid = scrolling_choose_band
		vmenuid = vmenu_choose_band
		use_backdrop = 0
		menu_pos = <menu_pos>
		spacing = -9
	}
	set_focus_color \{rgba = [
			255
			220
			140
			255
		]}
	set_unfocus_color \{rgba = [
			90
			25
			5
			255
		]}
	create_menu_backdrop \{texture = TopRockers_BG}
	rotation_angle = -2
	SetScreenElementProps \{id = scrolling_choose_band}
	SetScreenElementProps \{id = vmenu_choose_band
		internal_just = [
			center
			top
		]
		dims = (650.0, 365.0)}
	CreateScreenElement \{type = ContainerElement
		id = cb_helper_container
		parent = root_window
		Pos = (0.0, 0.0)}
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		Pos = ($menu_pos)
		id = choose_band_header_container
	}
	CreateScreenElement {
		type = SpriteElement
		parent = choose_band_header_container
		id = big_blue_box
		just = [left bottom]
		rgba = [30 110 160 0]
		Pos = (-283.0, 165.0)
		dims = (655.0, 80.0)
		rot_angle = <rotation_angle>
	}
	CreateScreenElement \{type = SpriteElement
		parent = cb_helper_container
		id = light_overlay
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 99}
	CreateScreenElement \{type = SpriteElement
		parent = cb_helper_container
		id = ticket_image
		texture = band_name_ticket
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 1}
	CreateScreenElement {
		type = SpriteElement
		parent = cb_helper_container
		id = random_image
		texture = band_name_graphic03
		rgba = [255 255 255 255]
		Pos = (($enter_band_name_big_vals).right_side_img_pos)
		dims = (($enter_band_name_big_vals).right_side_img_dims)
		z_priority = 2
	}
	<rand> = 0
	getrandomvalue \{name = rand
		integer
		a = 0
		b = 2}
	if (<rand> = 0)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic03}
	endif
	CreateScreenElement \{type = SpriteElement
		parent = cb_helper_container
		id = ticket_overlay
		texture = band_name_ticket_bar_overlay
		rgba = [
			255
			255
			255
			255
		]
		Pos = (734.0, 360.0)
		dims = (684.0, 680.0)
		just = [
			center
			center
		]
		z_priority = 2}
	choose_band_text = "CHOOSE BAND"
	CreateScreenElement {
		type = TextElement
		parent = big_blue_box
		just = [RIGHT bottom]
		font = text_a10_Large
		rgba = [105 50 35 255]
		text = <choose_band_text>
		Scale = 1.75
	}
	fit_text_in_rectangle id = <id> dims = (850.0, 200.0) Pos = (510.0, 75.0)
	CreateScreenElement \{type = SpriteElement
		parent = big_blue_box
		just = [
			RIGHT
			bottom
		]
		id = logo_vault_image
		texture = setlist_icon_generic
		Pos = (660.0, 96.0)
		dims = (128.0, 128.0)
		Blend = subtract}
	<cb_hlBar_pos> = [(6.0, 96.0) (6.0, 145.0) (6.0, 204.0) (8.0, 255.0) (9.0, 312.0)]
	<cb_hlBar_dims> = [(656.0, 48.0) (656.0, 58.0) (656.0, 48.0) (654.0, 58.0) (653.0, 54.0)]
	displaySprite {
		parent = big_blue_box
		tex = white
		rgba = [205 105 110 255]
		Pos = ((<cb_hlBar_pos>) [0])
		dims = ((<cb_hlBar_dims>) [0])
		z = 3
	}
	<cb_hlBarID> = <id>
	<loop_count> = 1
	band_index = 1
	begin
	band_name = "- NEW BAND -"
	get_band_game_mode_name
	FormatText checksumname = bandname_id 'band%i_info_%g' i = <band_index> g = <game_mode_name>
	GetGlobalTags <bandname_id> param = name
	if NOT (<name> = "")
		<band_name> = <name>
	endif
	CreateScreenElement {
		type = TextElement
		parent = vmenu_choose_band
		font = ($choose_band_menu_font)
		Scale = (1.1, 1.3)
		rgba = ($menu_unfocus_color)
		text = "PERMADEATH"
		just = [center top]
		rot_angle = <rotation_angle>
		event_handlers = [
			{focus retail_menu_focus}
			{focus SetScreenElementProps params = {
					id = <cb_hlBarID>
					Pos = ((<cb_hlBar_pos>) [(<band_index> - 1)])
					dims = ((<cb_hlBar_dims>) [(<band_index> - 1)])
				}
			}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_choose_band_make_selection params = {band_index = <band_index>}}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 500)
		SetScreenElementProps id = <id> Scale = (1.0, 1.3)
	elseif (<width> > 300)
		SetScreenElementProps id = <id> Scale = (1.2, 1.3)
	else
		SetScreenElementProps id = <id> Scale = (1.5, 1.3)
	endif
	<band_index> = (<band_index> + 1)
	repeat <loop_count>
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
endscript

script create_manage_band_menu 
	get_band_game_mode_name
	FormatText checksumname = bandname_id 'band%i_info_%g' i = ($current_band) g = <game_mode_name>
	GetGlobalTags <bandname_id>
	FormatText textname = the_bands_name "''%n''" n = <name>
	new_menu \{scrollid = mb_scroll
		vmenuid = mb_vmenu
		use_backdrop = 0
		menu_pos = (732.0, 314.0)
		rot_angle = -2
		spacing = 1}
	create_menu_backdrop \{texture = TopRockers_BG}
	CreateScreenElement \{type = ContainerElement
		id = mb_helper_container
		parent = root_window
		Pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		id = mb_menu_container
		parent = mb_vmenu
		Pos = (0.0, 0.0)
		not_focusable}
	CreateScreenElement \{type = SpriteElement
		parent = mb_helper_container
		id = light_overlay
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 99}
	CreateScreenElement \{type = SpriteElement
		parent = mb_helper_container
		id = ticket_image
		texture = band_name_ticket
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 1}
	CreateScreenElement {
		type = SpriteElement
		parent = mb_helper_container
		id = mb_random_image
		texture = band_name_graphic03
		rgba = [255 255 255 255]
		Pos = (($enter_band_name_big_vals).right_side_img_pos)
		dims = (($enter_band_name_big_vals).right_side_img_dims)
		z_priority = 2
	}
	<rand> = 0
	getrandomvalue \{name = rand
		integer
		a = 0
		b = 2}
	if (<rand> = 0)
		SetScreenElementProps \{id = mb_random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{id = mb_random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{id = mb_random_image
			texture = band_name_graphic03}
	endif
	<manage_band_pos> = (725.0, 190.0)
	CreateScreenElement {
		type = TextElement
		parent = mb_helper_container
		Pos = <manage_band_pos>
		font = text_a10_Large
		rgba = [90 25 5 255]
		text = "MANAGE BAND"
		Scale = 1.75
		z_priority = 3
		rot_angle = -2
	}
	fit_text_in_rectangle id = <id> dims = (850.0, 200.0) Pos = <manage_band_pos>
	CreateScreenElement {
		type = TextElement
		parent = mb_helper_container
		Pos = (<manage_band_pos> + (0.0, 110.0))
		font = ($choose_band_menu_font)
		rgba = [230 230 200 255]
		text = <the_bands_name>
		Scale = (1.75, 1.25)
		z_priority = 3
		rot_angle = -2
	}
	GetScreenElementDims id = <id>
	if (<width> > 600)
		fit_text_in_rectangle id = <id> dims = (1000.0, 70.0) Pos = (<manage_band_pos> + (0.0, 110.0))
	endif
	displaySprite {
		parent = mb_helper_container
		tex = white
		rgba = [90 25 5 255]
		Pos = (<manage_band_pos> + (-325.0, 92.0))
		dims = (656.0, 48.0)
		z = 3
		rot_angle = -2
	}
	<mb_hlBar_pos_1> = (408.0, 385.0)
	<mb_hlBar_pos_2> = (408.0, 441.0)
	<mb_hlBar_dims> = (654.0, 58.0)
	displaySprite {
		id = mb_hlBarID
		parent = mb_helper_container
		tex = white
		rgba = [205 105 110 255]
		Pos = <mb_hlBar_pos_1>
		dims = <mb_hlBar_dims>
		z = 3
		rot_angle = -2
	}
	CreateScreenElement {
		id = mb_rename_band_id
		parent = mb_menu_container
		type = TextElement
		font = ($choose_band_menu_font)
		rgba = ($menu_unfocus_color)
		text = "GO BACK"
		just = [center top]
	}
	CreateScreenElement {
		parent = mb_vmenu
		type = TextElement
		font = ($choose_band_menu_font)
		text = ""
		Scale = 1.3
		just = [center top]
		event_handlers = [
			{focus SetScreenElementProps params = {
					id = mb_hlBarID
					Pos = <mb_hlBar_pos_1>
				}
			}
			{focus manage_band_highlighter params = {id = mb_rename_band_id select}}
			{unfocus manage_band_highlighter params = {id = mb_rename_band_id unselect}}
			{pad_choose menu_manage_band_rename_band}
		]
	}
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
endscript

script menu_manage_band_rename_band 
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

GH3_Bonus_Songs = {
	prefix = 'bonus'
	num_tiers = 1
	tier1 = {
		Title = "Bonus songs"
		songs = [
			avalancha
			bellyofashark
			cantbesaved
			citiesonflame
			closer
			dontholdback
			downndirty
			fcpremix
			generationrock
			gothatfar
			helicopter
			hierkommtalex
			imintheband
			impulse
			inlove
			mauvaisgarcon
			metalheavylady
			minuscelsius
			monsters
			mycurse
			nothingformehere
			prayeroftherefugee
			radiosong
			reptilia
			ruby
			sabotage
			shebangsadrum
			suckmykiss
			takethislife
			thewayitends
			thrufireandflames
		]
		level = load_z_artdeco
		defaultunlocked = 0
	}
}

store_song_data = {
	avalancha = {
		price = 0
	}
	bellyofashark = {
		price = 0
	}
	cantbesaved = {
		price = 0
	}
	citiesonflame = {
		price = 0
	}
	closer = {
		price = 0
	}
	dontholdback = {
		price = 0
	}
	downndirty = {
		price = 0
	}
	fcpremix = {
		price = 0
	}
	generationrock = {
		price = 0
	}
	gothatfar = {
		price = 0
	}
	helicopter = {
		price = 0
	}
	hierkommtalex = {
		price = 0
	}
	imintheband = {
		price = 0
	}
	impulse = {
		price = 0
	}
	inlove = {
		price = 0
	}
	mauvaisgarcon = {
		price = 0
	}
	metalheavylady = {
		price = 0
	}
	minuscelsius = {
		price = 0
	}
	monsters = {
		price = 0
	}
	mycurse = {
		price = 0
	}
	nothingformehere = {
		price = 0
	}
	prayeroftherefugee = {
		price = 0
	}
	radiosong = {
		price = 0
	}
	reptilia = {
		price = 0
	}
	ruby = {
		price = 0
	}
	sabotage = {
		price = 0
	}
	shebangsadrum = {
		price = 0
	}
	suckmykiss = {
		price = 0
	}
	takethislife = {
		price = 0
	}
	thewayitends = {
		price = 0
	}
	thrufireandflames = {
		price = 12000
	}
}
Bonus_Songs_Info = [
	{
		item = avalancha
		text = "Heroes del Silencio is a rock band from Zaragoza Spain.  After 10 years and numerous albums, the band broke up in 1997.  In 2007, as part of a 20-year anniversary celebration and 10 years after their break-up they are participating in a 10 concert world tour."
		album_cover = HeroesDelSilencioAvalancha
	}
	{
		item = bellyofashark
		text = "The Gallows are a punk band from Watford, England that formed in 2005.  This killer track is taken off their debut album 'Orchestra of Wolves'"
		album_cover = store_song_default
	}
	{
		item = cantbesaved
		text = "Taken from Senses Fail's second full length album Still Searching.  The album's story is from the point of view of a character's stress and anxiety, including his battles with faith, alcohol, and depression."
		album_cover = SensesFailStillSearching
	}
	{
		item = citiesonflame
		text = ""
		album_cover = store_song_default
	}
	{
		item = closer
		text = "Lacuna Coil was formed in Milan Italy, and were originally called Sleep of Right.  They changed their name to Ethereal and signed to Century Media records in 1997.  They changed their name to Lacuna Coil when they discovered Ethereal was already taken."
		album_cover = LacunaCoilKarmaCode
	}
	{
		item = dontholdback
		text = "This song is from The Sleeping's second studio album Questions and Answers on Victory Records.  The Sleeping formed in 2003 from the remains of Skycamefalling."
		album_cover = TheSleepingQuestionsAndAnswers
	}
	{
		item = downndirty
		text = "Rising up out of the downtown shadows of a crumbling city of angels, The 'L.A. Slum Lords' set Guitar Hero 3 ablaze with a punishing molotov cocktail of rock revolution!"
		album_cover = store_song_default
	}
	{
		item = fcpremix
		text = "This song is a remake of the song F.C.P.S.I.T.S.G. E.P.G.E.P.G.E.P. which originally appeared on their self-titled album."
		album_cover = FallofTroyDoppelganger
	}
	{
		item = generationrock
		text = "Revolverheld is a rock band from Hamburg, Germany.  This song was their first single and released in June 2005, 3 months before the bands self-titled album."
		album_cover = RevolverheldRevolverheld
	}
	{
		item = gothatfar
		text = "Bret Michaels, the former lead singer of the notorious glam metal band Poison is back with his own band.  Bret also did the animation performances of the lead vocalist in the game."
		album_cover = BretMichealsBandGoThatFar
	}
	{
		item = helicopter
		text = ""
		album_cover = store_song_default
	}
	{
		item = hierkommtalex
		text = "Die Toten Hosen (which literally translates to 'The Dead Trousers') have been around for over 20 years.  The songs on their first album were mostly about having fun, but have since shifted their focus to more political and social issues."
		album_cover = store_song_default
	}
	{
		item = imintheband
		text = "Taken from the sixth album from the Swedish rockers.  Lead vocalist/guitarist Nicke Andersson used to play drums for the death metal pioneers Entombed."
		album_cover = store_song_default
	}
	{
		item = impulse
		text = "Big ups to film scoring major Zach Kamins and undisputed best THPS player, Andy 'THPS' Gentile, for collaborating on this song written specifically for Guitar Hero gameplay."
		album_cover = endlesssporadic
	}
	{
		item = inlove
		text = "Scouts of St. Sebastian guitarist/vocalist Judita Wignall (formerly of The Halo Friendlies) performed motion capture performance for many of the female characters in the game and was the inspiration for Judy Nails."
		album_cover = store_song_ScoutsStSebastian
	}
	{
		item = mauvaisgarcon
		text = "Naast was formed in Joinville-le-Point in 2004.  The band originally was comprised of just two members, Gustave (guitar and vocals) and Nicholas (drums).  Members Clod (bass guitar, keyboard) and Laka (guitar) joined the band in 2005."
		album_cover = NaastAntichambre
	}
	{
		item = metalheavylady
		text = "Lions are an Austin, TX based band that formed in August 2005.  Their music is influenced by 60's and 70's era hard rock with 90's era fever.  Lions create a blend of retro riffage, artful noise, melodic interludes and revolutionary attitude with a live show that has been described as 'furious' with a 'full-frontal assault' that will leave you half-deaf and disoriented."
		album_cover = LionsLions
	}
	{
		item = minuscelsius
		text = "Backyard Babies are largely attributed with bringing sleaze rock to Sweden.  Hailing from Nassjo, Sweden, the band was formed in 1987, have released 5 studio albums, and have even won a Swedish Grammy."
		album_cover = BackyardBabiesStockholmSyndrome
	}
	{
		item = monsters
		text = ""
		album_cover = store_song_default
	}
	{
		item = mycurse
		text = "The first single off the album 'As Daylight Dies', this song went to number 21 on the mainstream rock chart.  In 2004, Killswitch Engage was nominated for a Best Metal Performance Grammy."
		album_cover = KillswitchEngageAsDaylightDies
	}
	{
		item = nothingformehere
		text = "Dope was formed in 1997 by brothers Simon and Edsel Dope.  This song is from their much anticipated fifth studio album."
		album_cover = Dope_PosterCover_edsel
	}
	{
		item = prayeroftherefugee
		text = "The members of Rise Against are all vegetarians or vegans, and are active in bringing awareness to issues such as environmental degredation and animal cruelty."
		album_cover = RiseAgainstTheSuffererAndTheWitness
	}
	{
		item = radiosong
		text = "Superbus are a five-piece French pop-rock group.  They formed in 1999 after singer Jennifer Ayache returned to France from living in the U.S. to look for musicians.  In 2005 they won the Best French Act award at the MTV Europe Music Awards."
		album_cover = SuperbusPopnGum
	}
	{
		item = reptilia
		text = ""
		album_cover = store_song_default
	}
	{
		item = ruby
		text = "Kaiser Chiefs were the most successful act at the 2006 Brit awards - winning 'Best Group', 'Best British Rock Act', and 'Best Live Act'"
		album_cover = KaiserChiefsYoursTrulyAngry_Mob
	}
	{
		item = sabotage
		text = ""
		album_cover = store_song_default
	}
	{
		item = shebangsadrum
		text = "Taken from the 1989 self-titled debut by The Stone Roses.  The album is regarded by many as one of the greatest British albums ever released and was a huge influence on the Britpop movement that followed in the 1990's."
		album_cover = StoneRosesStoneRoses
	}
	{
		item = suckmykiss
		text = ""
		album_cover = store_song_default
	}
	{
		item = takethislife
		text = "Formed in Gothenburg, Sweden in 1990, In Flames is one of the pioneers of what is now known as melodic death metal.  This song is taken from the album 'Come Clarity' which debuted at No. 1 on the Swedish charts."
		album_cover = InFlamesComeClarity
	}
	{
		item = thewayitends
		text = "Prototype was formed in 1994 from the remains of the L.A. thrash band Psychosis.  They take progressive/thrash metal to the next level with this track off their third album 'Continuum'"
		album_cover = prototype_continuum_cover
	}
	{
		item = thrufireandflames
		text = "DragonForce are a British power metal band from London. The band was formed in 1999 by guitarists Herman Li and Sam Totman, and are known for their long and fast guitar solos, fantasy-themed lyrics and retro video game-influenced sound."
		album_cover = DragonforceInhumanRampage
	}
]

script create_store_menu 
	mark_unsafe_for_shutdown
	spawnscriptnow \{menu_music_on}
	change \{soundcheck_in_store = 1}
	change \{generic_select_monitor_p1_changed = 0}
	if ($store_view_cam_created = 0)
		change store_saved_guitar_id = ($player1_status.instrument_id)
		change \{structurename = player1_status
			style = 1}
		unload_band
		destroy_bg_viewport
		setup_bg_viewport
		PlayIGCCam \{name = store_view_cam
			viewport = bg_viewport
			ControlScript = store_camera_script
			Play_hold = 1}
		change \{store_view_cam_created = 1}
	endif
	change \{target_store_camera_prop = main_store_menu}
	setup_store_hub \{cash_pos = (-2000.0, -2000.0)}
	store_camera_wait
	SetScreenElementProps \{id = store_cash_text
		Pos = (900.0, 505.0)}
	hilite_pos = [
		(897.0, 155.0)
		(897.0, 197.0)
		(897.0, 241.0)
		(897.0, 284.0)
		(897.0, 326.0)
		(897.0, 370.0)
		(897.0, 413.0)
		(897.0, 456.0)
	]
	create_store_window_frame Pos = (900.0, 360.0) hilite_pos = (<hilite_pos> [0]) dims = (300.0, 512.0) hilite_dims = (270.0, 40.0)
	back_handlers = [
		{pad_up generic_menu_up_or_down_sound params = {up}}
		{pad_down generic_menu_up_or_down_sound params = {down}}
		{pad_back menu_store_go_back}
	]
	new_menu scrollid = ms_scroll vmenuid = ms_vmenu menu_pos = (775.0, 103.0) event_handlers = <back_handlers> z = 50 spacing = -20
	change \{menu_focus_color = [
			128
			0
			0
			255
		]}
	change \{menu_unfocus_color = [
			180
			100
			60
			255
		]}
	text_params = {
		parent = ms_vmenu
		type = TextElement
		font = ($store_menu_font)
		rgba = ($menu_unfocus_color)
		no_shadow
	}
	CreateScreenElement {
		<text_params>
		text = "GUITARS"
		event_handlers = [
			{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [0])}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_guitars}}
			{pad_l3 store_debug_givebandcash}
			{pad_left store_debug_givebandcash}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 270)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
	endif
	CreateScreenElement {
		<text_params>
		text = "FINISHES"
		event_handlers = [
			{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [1])}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_finishes}}
			{pad_l3 store_debug_givebandcash}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 270)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
	endif
	CreateScreenElement {
		<text_params>
		text = "SONGS"
		event_handlers = [
			{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [2])}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_songs}}
			{pad_l3 store_debug_givebandcash}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 270)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
	endif
	CreateScreenElement {
		<text_params>
		text = "CHARACTERS"
		event_handlers = [
			{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [3])}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_characters}}
			{pad_l3 store_debug_givebandcash}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 270)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
	endif
	CreateScreenElement {
		<text_params>
		text = "OUTFITS"
		event_handlers = [
			{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [4])}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_outfits}}
			{pad_l3 store_debug_givebandcash}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 270)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
	endif
	CreateScreenElement {
		<text_params>
		text = "STYLES"
		event_handlers = [
			{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [5])}}
			{unfocus retail_menu_unfocus}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_styles}}
			{pad_l3 store_debug_givebandcash}
		]
	}
	GetScreenElementDims id = <id>
	if (<width> > 270)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
	endif
	last_hilite_index = 7
	GetPlatform
	show_videos = 1
	if NOT English
		if (<platform> = ps2 || <platform> = ps3)
			<show_videos> = 0
		endif
	endif
	if (<show_videos> = 1)
		CreateScreenElement {
			<text_params>
			text = "VIDEOS"
			event_handlers = [
				{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [6])}}
				{unfocus retail_menu_unfocus}
				{pad_choose ui_flow_manager_respond_to_action params = {action = select_videos}}
				{pad_l3 store_debug_givebandcash}
			]
		}
		GetScreenElementDims id = <id>
		if (<width> > 270)
			SetScreenElementProps id = <id> Scale = 1
			fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
		endif
	else
		<last_hilite_index> = 6
	endif
	if (<platform> = xenon)
		param_flags = {}
		if NOT CheckForSignin \{local}
			<param_flags> = {not_focusable rgba = [100 100 100 255]}
		endif
		CreateScreenElement {
			<text_params>
			text = "DOWNLOADS"
			event_handlers = [
				{focus menu_store_focus params = {hilite_pos = (<hilite_pos> [<last_hilite_index>])}}
				{unfocus retail_menu_unfocus}
			]
			<param_flags>
		}
		GetScreenElementDims id = <id>
		if (<width> > 270)
			SetScreenElementProps id = <id> Scale = 1
			fit_text_in_rectangle id = <id> dims = (250.0, 60.0)
		endif
	endif
	clean_up_user_control_helpers
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
	mark_safe_for_shutdown
endscript

script Progression_TierComplete 
	printf \{"Progression_TierComplete"}
	get_progression_globals game_mode = ($game_mode)
	setlist_prefix = ($<tier_global>.prefix)
	FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier>
	SetGlobalTags <tiername> params = {complete = 1}
	if GotParam \{finished_game}
		if ($devil_finish = 0)
			printf \{"FINISHED GAME"}
			change \{end_credits = 0}
			
			change \{progression_beat_game_last_song = 1}
		endif
		get_difficulty_text_nl difficulty = ($current_difficulty)
		FormatText checksumname = gametype_checksum '%p_%s' p = <setlist_prefix> s = <difficulty_text_nl>
		SetGlobalTags <gametype_checksum> params = {complete = 1}
		if ($game_mode = p1_career)
			FormatText checksumname = bandname_id 'band%i_info_%g' i = ($current_band) g = 'p1_career'
			FormatText checksumname = hendrix_checksum 'hendrix_achievement_%s' s = <difficulty_text_nl>
			GetGlobalTags <bandname_id> param = <hendrix_checksum>
			if ((<...>.<hendrix_checksum>) = 0)
				SetGlobalTags \{achievement_info
					params = {
						hendrix_achievement_lefty_off = 1
					}}
			elseif ((<...>.<hendrix_checksum>) = 1)
				SetGlobalTags \{achievement_info
					params = {
						hendrix_achievement_lefty_on = 1
					}}
			endif
		endif
	else
		tier = (<tier> + 1)
		Progression_UnlockTier tier = <tier>
		FormatText checksumname = tiername 'tier%i' i = <tier>
		Progression_UnlockVenue level_checksum = ($<tier_global>.<tiername>.level)
	endif
endscript

