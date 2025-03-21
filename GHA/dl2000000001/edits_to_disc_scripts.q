enable_saving = 0
gh3_button_font = buttonsxenon
bunny_flame_index = 1
g_anim_flame = 1
main_menu_movie_first_time = 1

p2_scroll_time_factor = 0.9
p2_game_speed_factor = 0.9

health_change_bad_easy = -5.0
health_change_good_easy = 0.029
health_change_star_easy = 0
health_change_bad_battle_easy = -0.053
health_change_good_battle_easy = 0.029
health_change_bad_boss_easy = -0.04
health_change_good_boss_easy = 0.029
health_change_bad_medium = -5.0
health_change_good_medium = 0.0145
health_change_star_medium = 0
health_change_bad_battle_medium = -0.0267
health_change_good_battle_medium = 0.0145
health_change_bad_boss_medium = -0.02
health_change_good_boss_medium = 0.02
health_change_bad_hard = -5.0
health_change_good_hard = 0.013499999
health_change_star_hard = 0
health_change_bad_battle_hard = -0.0374
health_change_good_battle_hard = 0.013499999
health_change_bad_boss_hard = -0.0267
health_change_good_boss_hard = 0.017499998
health_change_bad_expert = -5.0
health_change_good_expert = 0.012
health_change_star_expert = 0
health_change_bad_battle_expert = -0.048
health_change_good_battle_expert = 0.012
health_change_bad_boss_expert = -0.0374
health_change_good_boss_expert = 0.015

GH3_Bonus_Songs = {
	prefix = 'bonus'
	num_tiers = 1
	tier1 = {
		Title = $sl_bonus_tier
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
			sosadcover
		]
		Level = load_z_Nipmuc
		defaultunlocked = 0
	}
}

battle_explanation_text = {
	bossjoe = {
		image = battle_help_boss_bg_JPerry
		Title = $joe_battle_title_text
        bullets = [
            {
                text = $permadeath_boss_splash_1
            }
            {
                text = $permadeath_boss_splash_2
            }
            {
                text = $permadeath_boss_splash_3
            }
            {
                text = $permadeath_boss_splash_4
            }
            {
                text = $permadeath_boss_splash_5
            }
        ]
		prompt = $ready_to_rock_text
	}
	generic = {
		Title = $battle_mode_title_text
        bullets = [
            {
                text = $permadeath_boss_splash_1
            }
            {
                text = $permadeath_boss_splash_2
            }
            {
                text = $permadeath_boss_splash_3
            }
            {
                text = $permadeath_boss_splash_4
            }
            {
                text = $permadeath_boss_splash_5
            }
        ]
		prompt = $ready_to_rock_text
	}
}

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

script create_fail_song_menu 
	difficulty = ($current_difficulty)
	change \{lose_a_life = TRUE}
	if (<difficulty> = easy && ($permadeath_disabled_easy = 1))
		change \{lose_a_life = FALSE}
	elseif (<difficulty> = medium && ($permadeath_disabled_medium = 1))
		change \{lose_a_life = FALSE}
	elseif (<difficulty> = hard && ($permadeath_disabled_hard = 1))
		change \{lose_a_life = FALSE}
	elseif (<difficulty> = expert && ($permadeath_disabled_expert = 1))
		change \{lose_a_life = FALSE}
	endif
	if ($lose_a_life = TRUE)
		change permadeath_lives = ($permadeath_lives - 1)
	endif
	calculate_max_streak_song
	if ($permadeath_lives > 0)
		fail_song_menu_select_new_song
	else
		save_hs_and_lag_settings
		change \{went_into_song = 0}
		change \{permadeath_lives = 3}
		change permadeath_fails = ($permadeath_fails + 1)
		handle_signin_changed
	endif
endscript

script set_song_icon 
	if NOT GotParam \{no_wait}
		wait \{0.5
			seconds}
	endif
	if NOT GotParam \{song}
		<song> = ($target_setlist_songpreview)
	endif
	if (<song> = None && $randomizer_toggle = 1)
		if ScreenElementExists \{id = sl_clipart}
			SetScreenElementProps \{id = sl_clipart alpha = 0}
		endif
		if ScreenElementExists \{id = sl_clipart_shadow}
			SetScreenElementProps \{id = sl_clipart_shadow alpha = 0}
		endif
		if ScreenElementExists \{id = sl_clip}
			SetScreenElementProps \{id = sl_clip alpha = 0}
		endif
		return
	endif
	if ($current_tab = tab_downloads)
		return
	endif
	if ($current_tab = tab_setlist)
		get_tier_from_song song = <song>
		get_progression_globals game_mode = ($game_mode)
		FormatText checksumname = tiername 'tier%d' d = <tier_number>
		if StructureContains structure = ($<tier_global>.<tiername>) setlist_icon
			song_icon = ($<tier_global>.<tiername>.setlist_icon)
		else
			song_icon = setlist_icon_generic
		endif
	elseif ($current_tab = tab_downloads)
		song_icon = setlist_icon_download
	else
		song_icon = setlist_icon_generic
	endif
	mini_rot = RandomRange (-5.0, 5.0)
	if ScreenElementExists \{id = sl_clipart}
		SetScreenElementProps id = sl_clipart texture = <song_icon>
		DoScreenElementMorph id = sl_clipart alpha = 1 time = 0.25 rot_angle = <mini_rot>
	endif
	if ScreenElementExists \{id = sl_clipart_shadow}
		SetScreenElementProps id = sl_clipart_shadow texture = <song_icon>
		DoScreenElementMorph id = sl_clipart_shadow alpha = 1 time = 0.25 rot_angle = <mini_rot>
	endif
	if ScreenElementExists \{id = sl_clip}
		GetScreenElementProps \{id = sl_clip}
		rot_clip_a = <rot_angle>
		rot_clip_b = (<rot_clip_a> + 10)
		SetScreenElementProps id = sl_clip rot_angle = <rot_clip_b>
		DoScreenElementMorph id = sl_clip alpha = 1 rot_angle = <rot_clip_a> time = 0.25
	endif
	if NOT (<song> = None)
		get_song_original_artist song = <song>
		if ($we_have_songs = TRUE && <original_artist> = 0)
			if ScreenElementExists \{id = sl_clipart}
				GetScreenElementProps \{id = sl_clipart}
			endif
		endif
	endif
endscript

script GuitarEvent_SongWon \{battle_win = 0}
	if notcd
		if ($output_gpu_log = 1)
			if IsPS3
				FormatText \{textname = filename
					"%s_gpu_ps3"
					s = $current_level
					DontAssertForChecksums}
			else
				FormatText \{textname = filename
					"%s_gpu"
					s = $current_level
					DontAssertForChecksums}
			endif
			TextOutputEnd output_text filename = <filename>
		endif
		if ($output_song_stats = 1)
			FormatText \{textname = filename
				"%s_stats"
				s = $current_song
				DontAssertForChecksums}
			TextOutputStart
			TextOutput \{text = "Player 1"}
			FormatText textname = text "Score: %s" s = ($player1_status.Score) DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Notes Hit: %n of %t" n = ($player1_status.notes_hit) t = ($player1_status.total_notes) DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Best Run: %r" r = ($player1_status.best_run) DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Max Notes: %m" m = ($player1_status.max_notes) DontAssertForChecksums
			TextOutput text = <text>
			FormatText textname = text "Base score: %b" b = ($player1_status.base_score) DontAssertForChecksums
			TextOutput text = <text>
			if (($player1_status.base_score) = 0)
				FormatText \{textname = text
					"Score Scale: n/a"}
			else
				FormatText textname = text "Score Scale: %s" s = (($player1_status.Score) / ($player1_status.base_score)) DontAssertForChecksums
			endif
			TextOutput text = <text>
			if (($player1_status.total_notes) = 0)
				FormatText \{textname = text
					"Notes Hit Percentage: n/a"}
			else
				FormatText textname = text "Notes Hit Percentage: %s" s = ((($player1_status.notes_hit) / ($player1_status.total_notes)) * 100.0) DontAssertForChecksums
			endif
			TextOutput text = <text>
			TextOutputEnd output_text filename = <filename>
		endif
	endif
	if ($current_num_players = 2)
		getsongtimems
		if ($last_time_in_lead_player = 0)
			change structurename = player1_status time_in_lead = ($player1_status.time_in_lead + <time> - $last_time_in_lead)
		elseif ($last_time_in_lead_player = 1)
			change structurename = player2_status time_in_lead = ($player2_status.time_in_lead + <time> - $last_time_in_lead)
		endif
		change \{last_time_in_lead_player = -1}
	endif
	if ($game_mode = p2_battle)
		if NOT (<battle_win> = 1)
			change \{save_current_powerups_p1 = $current_powerups_p1}
			change \{save_current_powerups_p2 = $current_powerups_p2}
			change \{current_powerups_p1 = [
					0
					0
					0
				]}
			change \{current_powerups_p2 = [
					0
					0
					0
				]}
			change structurename = player1_status save_num_powerups = ($player1_status.current_num_powerups)
			change structurename = player2_status save_num_powerups = ($player2_status.current_num_powerups)
			change \{structurename = player1_status
				current_num_powerups = 0}
			change \{structurename = player2_status
				current_num_powerups = 0}
			p1_health = ($player1_status.current_health)
			p2_health = ($player2_status.current_health)
			change structurename = player1_status save_health = <p1_health>
			change structurename = player2_status save_health = <p2_health>
			battlemode_killspawnedscripts
			if ScreenElementExists \{id = battlemode_container}
				DestroyScreenElement \{id = battlemode_container}
			endif
			change \{battle_sudden_death = 1}
		else
			battlemode_killspawnedscripts
			change \{battle_sudden_death = 0}
		endif
	endif
	calculate_max_streak_song
	add_song_to_fc
	KillSpawnedScript \{name = GuitarEvent_SongFailed_Spawned}
	spawnscriptnow \{GuitarEvent_SongWon_Spawned}
endscript


script create_signin_changed_menu 
	permadeath_popup_text = ($permadeath_startup_text)
	permadeath_continue = ($permadeath_start)
	permadeath_title = ($permadeath_title)
	if ($permadeath_fails > 0)
		FormatText textname = text ($permadeath_fail_text) i = ($permadeath_fails + 1)
		permadeath_popup_text = <text>
		permadeath_continue = Random (@ ($permadeath_fail_continue_1) @ ($permadeath_fail_continue_2) @ ($permadeath_fail_continue_3) )
		permadeath_title = Random (@ ($permadeath_fail_title_1) @ ($permadeath_fail_title_2) @ ($permadeath_fail_title_3) @ ($permadeath_fail_title_4) )
	elseif ($randomizer_toggle = 1)
		permadeath_title = ($permadeath_title_random)
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

script setlist_show_helperbar \{text_option1 = "THE VAULT"
		text_option2 = $permadeath_stat_full_big
		button_option1 = "\\b7"
		button_option2 = "\\b8"
		spacing = 16}
	if NOT English
		change \{pill_helper_max_width = 65}
	endif
	destroy_songs_practiced_scroll
	text_options = [
		"UP/DOWN"
		"SELECT"
		"BACK"
	]
	SetArrayElement arrayName = text_options index = 0 newValue = ($text_button_updown)
	SetArrayElement arrayName = text_options index = 1 newValue = ($text_button_select)
	SetArrayElement arrayName = text_options index = 2 newValue = ($text_button_back)
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
	tabs_text = ["setlist" "the Vault" "statistics"]
	SetArrayElement arrayName = tabs_text index = 0 newValue = ($sl_setlist_tab)
	SetArrayElement arrayName = tabs_text index = 2 newValue = ($permadeath_stat_full_small)
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
	calculate_max_streak_total
	CreateScreenElement {
		Type = TextElement
		PARENT = setlist_menu
		Scale = 1
		Text = (<buttons_text> [<I>])
		rgba = [128 128 128 255]
		Pos = <button_text_pos>
		z_priority = 50
		font = buttonsxenon
		just = [LEFT Top]
	}
	tab_text_pos = (<setlist_text_positions> [<i>])
	if ($current_tab = tab_downloads)
		<tab_text_pos> = (<download_text_positions> [<i>])
		FormatText textname = text ($permadeath_attempt_stat) i = ($permadeath_fails + 1)
		displayText parent = user_control_container Scale = ($text_scale_game) text = <text>  rgba = [255 255 255 255] Pos = (260.0, 360.0) z = 50
		FormatText textname = text ($permadeath_max_streak_stat) i = $permadeath_max_streak usecommas
		displayText parent = user_control_container Scale = ($text_scale_game) text = <text>  rgba = [255 255 255 255] Pos = (260.0, 400.0) z = 50
		FormatText textname = text ($permadeath_max_fc_count_stat) i = $permadeath_max_song_count
		displayText parent = user_control_container Scale = ($text_scale_game) text = <text>  rgba = [255 255 255 255] Pos = (260.0, 440.0) z = 50
		displayText parent = user_control_container Scale = 1 text = ($songs_practiced_title)  rgba = [255 255 255 255] Pos = ($songs_practiced_offset) z = 50
		create_songs_practiced_text
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = setlist_menu
		font = text_a5
		Scale = 1
		Text = (<tabs_text> [<I>])
		rgba = [0 0 0 255]
		Pos = <tab_text_pos>
		z_priority = 50
		just = [LEFT Top]
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle Id = <Id> Dims = ((185.0, 0.0) + (<Height> * (0.0, 1.0))) start_x_scale = 1 start_y_scale = 1 only_if_larger_x = 1
	<i> = (<i> + 1)
	repeat 3
	if ($permadeath_toggle = 1)
		lives_ratio = (($permadeath_lives * 1.0) / ($permadeath_lives_total * 1.0))
		green_text = [0 190 0 255]
		orange_text = [190 85 0 255]
		red_text = [190 0 0 255]
		colour_array = [0 0 0 255]
		if ($permadeath_lives = 1)
			<colour_array> = <red_text>
		else
			colour1 = <green_text>
			colour2 = <orange_text>
			if (<lives_ratio> > 0.5)
				t = ((<lives_ratio> - 0.5) * 2)
			else
				t = (<lives_ratio> * 2)
				<colour1> = <orange_text>
				<colour2> = <red_text>
			endif
			i = 0
			begin
			val = (((<colour1> [<i>]) * <t>) + ((<colour2> [<i>]) * (1 - <t>)))
			CastToInteger \{val}
			SetArrayElement arrayName = colour_array index = <i> newValue = (<val>)
			<i> = (<i> + 1)
			repeat 3
		endif
		FormatText textname = text ($permadeath_lives_stat) i = $permadeath_lives
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = <colour_array> Pos = (870.0, 80.0) z = 50
	endif
endscript

script destroy_setlist_menu 
	KillSpawnedScript \{Name = net_match_download_songs}
	KillSpawnedScript \{Name = scroll_ticker_text}
	destroy_songs_practiced_scroll
	if ($g_keep_song_preview = 0)
		destroy_setlist_songpreview_monitor
		Change \{target_setlist_songpreview = NONE}
	endif
	if ScreenElementExists \{Id = setlist_overlay}
		DestroyScreenElement \{Id = setlist_overlay}
	endif
	Change setlist_previous_tier = ($setlist_selection_tier)
	Change setlist_previous_song = ($setlist_selection_song)
	Change setlist_previous_tab = ($current_tab)
	destroy_menu \{menu_id = setlist_original_artist}
	destroy_menu \{menu_id = scrolling_setlist}
	destroy_menu \{menu_id = setlist_menu}
	destroy_menu \{menu_id = setlist_loops_menu}
	destroy_menu \{menu_id = setlist_bg_container}
	reset_vars \{del}
	clean_up_user_control_helpers
	destroy_setlist_popup
endscript

script practice_start_song \{device_num = 0}
	Change \{game_mode = training}
	Change \{current_transition = PRACTICE}
	Change \{current_level = load_z_soundcheck}
	Change g_char_id_before_practice = ($player1_status.character_id)
	Change g_char_outfit_before_practice = ($player1_status.outfit)
	Change g_char_style_before_practice = ($player1_status.style)
	Change \{StructureName = player1_status
		character_id = JoeP}
	Change \{StructureName = player1_status
		outfit = 1}
	Change \{StructureName = player1_status
		style = 1}
	if NOT ArrayContains array = ($songs_practiced) contains = ($current_song)
		songs_practiced_temp = ($songs_practiced)
		AddArrayElement array = (<songs_practiced_temp>) element = ($current_song)
		<songs_practiced_temp> = (<array>)
		change songs_practiced = <songs_practiced_temp>
	endif
	SafeKill \{NodeName = Z_SoundCheck_GFX_TRG_LH_HotSpot01}
	SafeKill \{NodeName = Z_SoundCheck_GFX_TRG_LH_HotSpot_P2}
	start_song StartTime = ($practice_start_time) device_num = <device_num> practice_intro = 1 endtime = ($practice_end_time)
	Change \{practice_audio_muted = 0}
	GetGlobalTags \{user_options}
	menu_audio_settings_update_band_volume vol = (<band_volume> * 7 / 11)
	SetSoundBussParams \{Crowd = {
			vol = -100.0
		}}
	SpawnScriptNow \{practice_update}
endscript

script create_sl_assets 
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = setlist_menu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	CreateScreenElement \{Type = WindowElement
		PARENT = setlist_menu
		Id = setlist_scroll_text_window
		Pos = (400.0, 465.0)
		Dims = (430.0, 3240.0)}
	if NOT ScreenElementExists \{id = setlist_bg_container}
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = setlist_bg_container
			Pos = (0.0, 0.0)
			just = [
				left
				top
			]}
	endif
	displaySprite \{id = sl_bg_head
		parent = setlist_menu
		tex = Setlist_BG_Head
		Pos = (0.0, 0.0)
		dims = (1280.0, 676.0)
		z = 3.1}
	displaySprite \{id = sl_bg_loop
		parent = setlist_menu
		tex = Setlist_BG_Loop
		Pos = $setlist_background_loop_pos
		dims = (1280.0, 1352.0)
		z = 3.1}
	begin
	displaySprite \{parent = setlist_menu
		tex = Setlist_Shoeprint
		Pos = (850.0, -70.0)
		dims = (640.0, 768.0)
		alpha = 0.15
		z = 3.2
		flip_v
		rot_angle = 10
		BlendMode = Subtract
		Z = 3.175}
	repeat 3
	displaySprite \{id = sl_page3_head
		parent = setlist_menu
		tex = Setlist_Page3_Head
		Pos = $setlist_page3_pos
		dims = (922.0, 614.0)
		z = $setlist_page3_z}
	displaySprite \{id = sl_page2_head
		parent = setlist_menu
		tex = Setlist_Page2_Head
		Pos = $setlist_page2_pos
		dims = (819.0, 553.0)
		z = $setlist_page2_z}
	displaySprite \{flip_h
		id = sl_page1_head
		parent = setlist_menu
		tex = Setlist_Page1_Head
		Pos = (160.0, 0.0)
		dims = (922.0, 768.0)
		z = $setlist_page1_z}
	displaySprite parent = setlist_menu tex = Setlist_Page1_Line_Red Pos = (320.0, 12.0) dims = (8.0, 6400.0) z = ($setlist_page1_z + 0.1)
	<title_pos> = (300.0, 383.0)
	displaySprite id = sl_page1_head_lines parent = setlist_menu tex = Setlist_Page1_Head_Lines Pos = (176.0, 64.0) dims = (896.0, 320.0) z = ($setlist_page1_z + 0.1)
	<begin_line> = (176.0, 420.0)
	<solid_line_pos> = (176.0, 340.0)
	<dotted_line_pos> = (176.0, 380.0)
	<dotted_line_add> = ($setlist_solid_line_add)
	begin
	<Line> = Random (@ ($setlist_solid_lines [0]) @ ($setlist_solid_lines [1]) @ ($setlist_solid_lines [2]) )
	<solid_line_pos> = (<solid_line_pos> + $setlist_solid_line_add)
	displaySprite parent = setlist_menu tex = <Line> Pos = <solid_line_pos> dims = (878.0, 16.0) z = ($setlist_page1_z + 0.1)
	repeat 8
	begin
	<Line> = Random (@ ($setlist_dotted_lines [0]) @ ($setlist_dotted_lines [1]) @ ($setlist_dotted_lines [2]) )
	<dotted_line_pos> = (<dotted_line_pos> + <dotted_line_add>)
	displaySprite parent = setlist_menu tex = <Line> Pos = <dotted_line_pos> dims = (878.0, 16.0) z = ($setlist_page1_z + 0.1)
	repeat 8
	<solid_line_pos> = (<solid_line_pos> + $setlist_solid_line_add)
	<dotted_line_pos> = (<dotted_line_pos> + <dotted_line_add>)
	change setlist_solid_line_pos = <solid_line_pos>
	change setlist_dotted_line_pos = <dotted_line_pos>
	change \{setlist_num_songs = 0}
	if English
		setlist_header_tex = Setlist_Page1_Title
	elseif French
		setlist_header_tex = Setlist_Page1_Title_fr
	elseif German
		setlist_header_tex = Setlist_Page1_Title_de
	elseif Spanish
		setlist_header_tex = Setlist_Page1_Title_sp
	elseif Italian
		setlist_header_tex = Setlist_Page1_Title_it
	endif
	if GotParam \{tab_setlist}
		CreateScreenElement {
			Type = SpriteElement
			Id = sl_page1_title
			PARENT = setlist_menu
			texture = <setlist_header_tex>
			Pos = (330.0, 220.0)
			Dims = (512.0, 128.0)
			just = [Top LEFT]
			rgba = [100 230 255 255]
			Alpha = 0.8
			z_priority = ($setlist_page1_z + 0.2)
			Rot_Angle = 0
			BLEND = Subtract
			Alpha = 0.7
		}
		GetUpperCaseString ($g_gh3_setlist.tier1.Title)
		displayText Id = sl_text_1 PARENT = setlist_menu Scale = (1.0, 1.0) Text = <UpperCaseString> rgba = (($G_menu_colors).pink) Pos = <title_pos> Z = $setlist_text_z noshadow
	endif
	if GotParam \{tab_downloads}
		displayText \{parent = setlist_menu
			id = sl_text_1
			text = $permadeath_sl_text
			font = text_a10
			Scale = 2
			Pos = (330.0, 220.0)
			rgba = [
				50
				30
				20
				255
			]
			z = $setlist_text_z
			noshadow}
		displaySprite parent = setlist_menu tex = Setlist_Page1_Line_Red Pos = (320.0, 216.0) dims = (8.0, 6400.0) z = ($setlist_page1_z - 0.2)
	endif
	if GotParam \{tab_bonus}
		CreateScreenElement \{Type = TextElement
			PARENT = setlist_menu
			Id = sl_text_1
			text = $sl_bonus_tier_big
			font = text_a10
			Scale = 2
			Pos = (330.0, 220.0)
			just = [
				LEFT
				Top
			]
			rgba = [
				50
				30
				20
				255
			]
			z_priority = $setlist_text_z}
		displaySprite parent = setlist_menu tex = Setlist_Page1_Line_Red Pos = (320.0, 216.0) dims = (8.0, 6400.0) z = ($setlist_page1_z - 0.2)
	endif
	<text_pos> = (<title_pos> + (40.0, 54.0))
	if ((GotParam tab_setlist) || (GotParam tab_bonus) )
		num_tiers = ($g_gh3_setlist.num_tiers)
		<tier> = 0
		change \{setlist_selection_index = 0}
		change \{setlist_selection_tier = 1}
		change \{setlist_selection_song = 0}
		change \{setlist_selection_found = 0}
		begin
		<tier> = (<tier> + 1)
		setlist_prefix = ($g_gh3_setlist.prefix)
		FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = <tier>
		FormatText checksumname = tier_checksum 'tier%s' s = <tier>
		GetGlobalTags <tiername> param = unlocked
		if (<unlocked> = 1 || $is_network_game = 1)
			if NOT (<tier> = 1)
				<text_pos> = (<text_pos> + (-40.0, 110.0))
				GetUpperCaseString ($g_gh3_setlist.<tier_checksum>.Title)
				displayText parent = setlist_menu Scale = (1.0, 1.0) text = <uppercasestring> rgba = (($G_menu_colors).pink) Pos = <text_pos> z = $setlist_text_z noshadow
				<text_pos> = (<text_pos> + (40.0, 50.0))
			endif
			change \{we_have_songs = FALSE}
			GetArraySize ($g_gh3_setlist.<tier_checksum>.songs)
			num_songs = <array_size>
			num_songs_unlocked = 0
			song_count = 0
			if (<array_size> > 0)
				begin
				setlist_prefix = ($g_gh3_setlist.prefix)
				FormatText checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = (<song_count> + 1) s = <tier> addtostringlookup = TRUE
				for_bonus = 0
				if ($current_tab = tab_bonus)
					<for_bonus> = 1
				endif
				if issongavailable song_checksum = <song_checksum> song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>]) for_bonus = <for_bonus>
					if ($setlist_selection_found = 0)
						change setlist_selection_tier = <tier>
						change setlist_selection_song = <song_count>
						change \{setlist_selection_found = 1}
					endif
					get_song_title song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
					get_song_prefix song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
					get_song_artist song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
					if get_song_covered_by Song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
						FormatText TextName = Song_Title ($sl_cover_song) S = <Song_Title>
					endif
					FormatText \{checksumname = textid
						'id_song%i'
						i = $setlist_num_songs
						addtostringlookup = TRUE}
					CreateScreenElement {
						type = TextElement
						id = <textid>
						parent = setlist_menu
						Scale = (0.85, 0.85)
						text = <song_title>
						Pos = <text_pos>
						rgba = (($G_menu_colors).dk_violet_grey)
						z_priority = $setlist_text_z
						font = text_a5
						just = [left top]
						font_spacing = 0.5
						no_shadow
						shadow_offs = (1.0, 1.0)
						shadow_rgba = [0 0 0 255]
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> Dims = ((475.0, 0.0) + (<Height> * (0.0, 1.0))) start_x_scale = 0.85 start_y_scale = 0.85 only_if_larger_x = 1
					if ($game_mode = p2_quickplay)
						get_difficulty_text_nl DIFFICULTY = ($current_difficulty_coop)
					else
						get_difficulty_text_nl DIFFICULTY = ($current_difficulty)
					endif
					get_song_prefix Song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
					get_formatted_songname song_prefix = (<song_prefix>) difficulty_text_nl = <difficulty_text_nl>
					if ($is_network_game = 0)
						GetGlobalTags <song_checksum>
						GetGlobalTags <songname>
						if ($game_mode = p1_quickplay || $game_mode = p2_quickplay)
							get_quickplay_song_stars Song = <song_prefix>
						endif
						if NOT ($game_mode = training || $game_mode = p2_faceoff || $game_mode = p2_pro_faceoff || $game_mode = p2_battle)
							if Progression_IsBossSong tier_global = $g_gh3_setlist Tier = <Tier> Song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
								STARS = 0
								hide_data = FALSE
							elseif (($g_gh3_setlist.<tier_checksum>.songs [<song_count>]) = sosadcover)
								hide_data = FALSE
							elseif ($randomizer_toggle = 1 && (GotParam tab_setlist))
								hide_data = TRUE
							elseif ($randomizer_all = 1)
								hide_data = TRUE
							endif
							if ($game_mode = p1_quickplay || $game_mode = p2_quickplay)
								GetGlobalTags <songname> Param = percent100
							else
								GetGlobalTags <song_checksum> Param = percent100
							endif
							if (<STARS> > 2)
								<star_space> = (25.0, 0.0)
								<star_pos> = (<text_pos> + (670.0, 10.0))
								begin
								if (<percent100> = 1)
									<Star> = Setlist_Goldstar
								else
									<Star> = Random (@ ($setlist_loop_stars [0]) @ ($setlist_loop_stars [1]) @ ($setlist_loop_stars [2]) )
								endif
								<star_pos> = (<star_pos> - <star_space>)
								CreateScreenElement {
									Type = SpriteElement
									PARENT = setlist_menu
									texture = <Star>
									just = [Center Center]
									rgba = [200 220 233 255]
									z_priority = $setlist_text_z
									Pos = <star_pos>
									Rot_Angle = (RandomRange (-20.0, 20.0))
									Scale = 0.9
								}
								repeat <STARS>
							elseif (<hide_data> = TRUE)
								<textid> :setprops text = ($randomizer_title)
								<song_artist> = ($randomizer_artist + $randomizer_year)
							endif
							GetGlobalTags <song_checksum> Param = Score
							if ($game_mode = p1_quickplay || $game_mode = p2_quickplay)
								get_quickplay_song_score Song = <song_prefix>
							endif
							if (<Score> > 0)
								if Progression_IsBossSong tier_global = $g_gh3_setlist Tier = <Tier> Song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
									if (<Score> = 1)
										FormatText \{TextName = score_text
											$sl_wussed_out}
									else
										FormatText \{TextName = score_text
											$sl_battle_won}
									endif
								else
									FormatText TextName = score_text "%d" D = <Score> UseCommas
								endif
								<score_pos> = (<text_pos> + (660.0, 40.0))
								CreateScreenElement {
									Type = TextElement
									PARENT = setlist_menu
									Scale = (0.75, 0.75)
									Text = <score_text>
									Pos = <score_pos>
									rgba = (($G_menu_colors).dk_violet_grey)
									z_priority = $setlist_text_z
									font = text_a5
									just = [RIGHT Top]
									noshadow
									Alpha = 0.8
								}
								GetScreenElementDims Id = <Id>
								fit_text_in_rectangle Id = <Id> only_if_larger_x = 1 Dims = ((130.0, 0.0) + <Height> * (0.0, 1.0)) start_x_scale = 0.75 start_y_scale = 0.75
							endif
						endif
					endif
					<text_pos> = (<text_pos> + (60.0, 40.0))
					FormatText \{ChecksumName = artistid
						'artist_id%d'
						D = $setlist_num_songs}
					GetUpperCaseString <song_artist>
					song_artist = <UpperCaseString>
					CreateScreenElement {
						Type = TextElement
						PARENT = setlist_menu
						Id = <artistid>
						font = text_a5
						Scale = (0.6, 0.6)
						just = [Top LEFT]
						Text = <song_artist>
						rgba = (($G_menu_colors).dk_violet_grey)
						Alpha = 0.5
						Pos = <text_pos>
						z_priority = $setlist_text_z
						font_spacing = 1
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> only_if_larger_x = 1 Dims = ((425.0, 0.0) + (<Height> * (0.0, 1.0))) start_x_scale = 0.6 start_y_scale = 0.6
					<text_pos> = (<text_pos> + (-60.0, 40.0))
					Change setlist_num_songs = ($setlist_num_songs + 1)
					num_songs_unlocked = (<num_songs_unlocked> + 1)
					Change \{we_have_songs = TRUE}
				endif
				song_count = (<song_count> + 1)
				repeat <num_songs>
				if (($current_tab = tab_bonus) && (<num_songs_unlocked> = 0))
					CreateScreenElement {
						Type = TextElement
						PARENT = setlist_menu
						Id = empty_bonus_song_title
						font = text_a5
						Scale = 1
						just = [Center Center]
						Text = ($sl_bonus_no_songs)
						rgba = (($G_menu_colors).dk_violet_grey)
						Pos = (650.0, 470.0)
						z_priority = 50
						font_spacing = 1
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> only_if_larger_x = 1 Dims = ((500.0, 0.0) + (<Height> * (0.0, 1.0)))
				endif
			endif
			if (($game_mode = p1_career) && (GotParam tab_setlist) && $is_demo_mode = 0)
				GetGlobalTags <tiername> Param = Complete
				if (<Complete> = 0)
					GetGlobalTags <tiername> Param = boss_unlocked
					GetGlobalTags <tiername> Param = encore_unlocked
					GetGlobalTags <tiername> Param = aerosmith_unlocked
					if (<encore_unlocked> = 1)
						FormatText \{TextName = completeText
							$sl_beat_encore}
					elseif (<aerosmith_unlocked> = 1)
						GetGlobalTags <tiername> Param = num_songs_to_progress
						if (<num_songs_to_progress> = 1)
							FormatText TextName = completeText ($sl_beat_aerosmith_1) P = <num_songs_to_progress>
						else
							FormatText TextName = completeText ($sl_beat_aerosmith_2) P = <num_songs_to_progress>
						endif
					elseif (<boss_unlocked> = 1)
						FormatText \{TextName = completeText
							$sl_beat_boss}
					else
						GetGlobalTags <tiername> Param = num_intro_songs_to_progress
						if (<num_intro_songs_to_progress> = 1)
							FormatText TextName = completeText ($sl_beat_opening_act_1) P = <num_intro_songs_to_progress>
						else
							FormatText TextName = completeText ($sl_beat_opening_act_2) P = <num_intro_songs_to_progress>
						endif
					endif
					CreateScreenElement {
						Type = TextElement
						PARENT = setlist_menu
						Scale = (0.6, 0.6)
						Text = <completeText>
						font = text_a5
						Pos = (<text_pos> + (300.0, 38.0))
						just = [Center Top]
						z_priority = $setlist_text_z
						rgba = (($G_menu_colors).pink)
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> Dims = (<Height> * (0.0, 1.0) + (450.0, 0.0)) only_if_larger_x = 1 start_y_scale = 1.1 start_x_scale = 1.1
				endif
			endif
		endif
		repeat <num_tiers>
		setlist_footnote \{Alpha = 0}
	endif
	if NOT (($current_tab = tab_bonus) && (<num_songs_unlocked> = 1))
		if (($game_mode = p1_career) && $is_demo_mode = 0)
			get_progression_globals game_mode = ($game_mode)
			summation_career_score tier_global = <tier_global>
			FormatText TextName = total_score_text ($sl_career_score) D = <career_score> UseCommas
			displayText {
				PARENT = setlist_menu
				Scale = 0.7
				Text = <total_score_text>
				Pos = ((640.0, 120.0) + (<text_pos>.(0.0, 1.0) * (0.0, 1.0)))
				just = [Center Top]
				Z = $setlist_text_z
				rgba = (($G_menu_colors).dk_violet_grey)
				noshadow
			}
		endif
	endif
	Change \{setlist_begin_text = $setlist_menu_pos}
	if ($setlist_num_songs > 0)
		setlist_menu_focus \{Id = id_song0}
		SetScreenElementProps \{id = id_song0
			shadow}
	endif
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = sl_fixed
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	clip_alpha = 1
	if ($current_tab = tab_downloads)
		<clip_alpha> = 0
	endif
	<clip_pos> = (160.0, 390.0)
	displaySprite id = sl_clipart parent = sl_fixed Pos = <clip_pos> dims = (160.0, 160.0) z = ($setlist_text_z + 0.1) rgba = [200 200 200 255] alpha = <clip_alpha>
	displaySprite id = sl_clipart_shadow parent = sl_fixed Pos = (<clip_pos> + (3.0, 3.0)) dims = (160.0, 160.0) z = ($setlist_text_z) rgba = [0 0 0 128] alpha = <clip_alpha>
	<clip_pos> = (<clip_pos> + (15.0, 50.0))
	displaySprite id = sl_clip parent = sl_fixed tex = Setlist_Clip just = [-0.5 -0.9] Pos = <clip_pos> dims = (141.0, 102.0) z = ($setlist_text_z + 0.2) alpha = <clip_alpha>
	if ($current_tab = tab_setlist)
		hilite_dims = (737.0, 80.0)

	elseif ($current_tab = tab_bonus)
		hilite_dims = (710.0, 80.0)
	endif
	if GotParam \{tab_bonus}
		CreateScreenElement {
			Type = SpriteElement
			Id = sl_highlight
			PARENT = sl_fixed
			texture = White
			just = [LEFT Top]
			Pos = (326.0, 428.0)
			Dims = <hilite_dims>
			z_priority = ($setlist_text_z - 0.1)
			rgba = [200 185 95 110]
		}
	else
		CreateScreenElement {
			Type = SpriteElement
			Id = sl_highlight
			PARENT = sl_fixed
			texture = White
			just = [LEFT Top]
			Pos = (326.0, 428.0)
			Dims = <hilite_dims>
			z_priority = ($setlist_text_z - 0.1)
			rgba = [255 250 250 200]
		}
	endif
	<bg_helper_pos> = (140.0, 585.0)
	<helper_rgba> = [105 65 7 160]
	change \{user_control_pill_gap = 100}
	if ($current_tab = tab_setlist)
		setlist_show_helperbar Pos = (<bg_helper_pos> + (64.0, 4.0))
	elseif ($current_tab = tab_bonus)
		setlist_show_helperbar {
			Pos = (<bg_helper_pos> + (64.0, 4.0))
			text_option1 = ($sl_setlist_big)
			text_option2 = ($permadeath_stat_full_big)
			button_option1 = "\\b6"
			button_option2 = "\\b8"
		}
	else
		setlist_show_helperbar {
			Pos = (<bg_helper_pos> + (64.0, 4.0))
			text_option1 = ($sl_setlist_big)
			text_option2 = "THE VAULT"
			button_option1 = "\\b6"
			button_option2 = "\\b7"
		}
	endif
	displaySprite \{id = sl_overshadow
		rgba = [
			105
			65
			7
			160
		]
		parent = root_window
		tex = Setlist_Overshadow
		Pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		z = 5.0}
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
			online_game_mode_ranked = 0
			online_difficulty = 0
			online_difficulty_ranked = 0
			online_num_songs = 0
			online_num_songs_ranked = 0
			online_tie_breaker = 0
			online_highway = 0
			unlock_Cheat_AirGuitar = 1
			unlock_Cheat_PerformanceMode = 1
			unlock_Cheat_Hyperspeed = 1
			unlock_Cheat_NoFail = 0
			unlock_Cheat_PrecisionMode = 1
		}}
endscript

script create_using_guitar_controller_menu 
	handle_signin_changed
endscript

script memcard_save_file \{overwriteconfirmed = 0}
	memcard_sequence_quit
endscript

script destroy_download_scan_menu 
	destroy_popup_warning_menu
endscript

script create_main_menu 
	ResetScoreUpdateReady
	GetGlobalTags \{user_options}
	menu_audio_settings_update_guitar_volume vol = <guitar_volume>
	menu_audio_settings_update_band_volume vol = <band_volume>
	menu_audio_settings_update_sfx_volume vol = <sfx_volume>
	SetSoundBussParams {Crowd = {vol = ($Default_BussSet.Crowd.vol)}}
	if ($main_menu_movie_first_time = 0)
		FadeToBlack \{ON
			Time = 0
			Alpha = 1.0
			z_priority = 900}
	endif
	create_main_menu_backdrop
	if ($main_menu_movie_first_time = 0 && $invite_controller = -1)
		Change \{main_menu_movie_first_time = 1}
		FadeToBlack \{OFF
			Time = 0}
	endif
	SetMenuAutoRepeatTimes \{(0.3, 0.05)}
	kill_start_key_binding
	UnPauseGame
	Change \{current_num_players = 1}
	Change StructureName = player1_status controller = ($primary_controller)
	Change \{player_controls_valid = 0}
	disable_pause
	SpawnScriptNow \{Menu_Music_On}
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] NOT_FOCUSABLE}
	else
		demo_mode_disable = {rgba = [80 80 80 255] not_focusable}
	endif
	DeRegisterAtoms
	RegisterAtoms \{Name = Achievement
		$Achievement_Atoms}
	Change \{setlist_previous_tier = 1}
	Change \{setlist_previous_song = 0}
	Change \{setlist_previous_tab = tab_setlist}
	Change \{current_song = beyondbeautiful}
	Change \{end_credits = 0}
	Change \{battle_sudden_death = 0}
	Change \{StructureName = player1_status
		character_id = Axel}
	Change \{StructureName = player2_status
		character_id = Axel}
	safe_create_gh3_pause_menu
	new_menu {
		scrollid = main_menu_scrolling_menu
		vmenuid = vmenu_main_menu
		use_backdrop = 0
		Menu_pos = ($g_mm_base_menu_pos)
		focus_color = dk_violet_red
		unfocus_color = md_violet_grey
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound Params = {UP}}
			{pad_down generic_menu_up_or_down_sound Params = {DOWN}}
		]
	}
	Change \{rich_presence_context = presence_main_menu}
	<text_x_scale> = 0.8
	<text_y_scale> = 1.0
	text_params = {
		Type = TextElement
		font = text_a5
		Scale = ((<text_x_scale> * (1.0, 0.0)) + (<text_y_scale> * (0.0, 1.0)))
		rgba = (($G_menu_colors).md_violet_grey)
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = (($G_menu_colors).Block)
		z_priority = 60
	}
	disabled_text_params = {
		Type = TextElement
		font = text_a5
		Scale = ((<text_x_scale> * (1.0, 0.0)) + (<text_y_scale> * (0.0, 1.0)))
		rgba = (($G_menu_colors).grey50)
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = (($G_menu_colors).Block)
		z_priority = 60
	}
	if ($went_into_song = 1)
		disable_due_to_crash_text = { <disabled_text_params> }
		disable_due_to_crash = { not_focusable }
	else
		disable_due_to_crash_text = { <text_params> }
		disable_due_to_crash = { }
	endif
	<menu_offset> = (0.0, 45.0)
	<HLBar_dims> = (240.0, 45.0)
	<BE_dims> = (32.0, 46.0)
	<BEL_pos> = ((((<HLBar_dims>.(-1.0, 0.0)) / 2) * (1.0, 0.0)) + (-16.0, 0.0))
	<BER_pos> = ((((<HLBar_dims>.(1.0, 0.0)) / 2) * (1.0, 0.0)) + (16.0, 0.0))
	mm_hilite_color = (($G_menu_colors).lt_plum)
	
	createscreenelement {
		type = textelement
		text = "PERMADEATH"
		pos = ($permadeath_title_offset)
		parent = main_menu_bg_container
		rgba = [200 0 0 255]
		font = text_a6
		just = [center top]
		scale = (1.0, 1.0)
	}
	if ($randomizer_toggle = 1)
		randomized_title_offset = ($permadeath_title_offset + (0.0, 60.0))
		createscreenelement {
			<text_params>
			text = ($setlist_randomized_text)
			pos = <randomized_title_offset>
			parent = main_menu_bg_container
			rgba = [200 0 0 255]
			font = text_a6
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
		}
	endif
	CreateScreenElement \{Type = ContainerElement
		Id = main_menu_career
		PARENT = vmenu_main_menu
		event_handlers = [
			{
				Focus
				main_menu_highlight
				Params = {
					option = 'career'
				}
			}
			{
				unfocus
				main_menu_unhighlight
				Params = {
					option = 'career'
				}
			}
			{
				pad_choose
				main_menu_select_career
			}
		]}
	CreateScreenElement {
		<text_params>
		PARENT = main_menu_career
		Id = main_menu_career_text
		Text = ($mm_career_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (($g_mm_menu_max_width) * (1.0, 0.0)))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement \{Type = ContainerElement
		Id = main_menu_career_HL
		Pos = (0.0, -8.0)
		PARENT = main_menu_career
		Alpha = 0}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_career_HLBar
		PARENT = main_menu_career_HL
		texture = hilite_bar_01
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <HLBar_dims>
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_career_BEL
		PARENT = main_menu_career_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BEL_pos>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_career_BER
		PARENT = main_menu_career_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BER_pos>
	}
	DoScreenElementMorph \{Id = main_menu_career_HL
		Scale = (1.0, 0.01)
		relative_scale}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_quickplay
		PARENT = vmenu_main_menu
		event_handlers = [
			{
				Focus
				main_menu_highlight
				Params = {
					option = 'quickplay'
				}
			}
			{
				unfocus
				main_menu_unhighlight
				Params = {
					option = 'quickplay'
				}
			}
			{
				pad_choose
				main_menu_select_quickplay
			}
		]
		<demo_mode_disable>
		}
	CreateScreenElement {
		<disabled_text_params>
		PARENT = main_menu_quickplay
		Id = main_menu_quickplay_text
		Pos = (<menu_offset>)
		Text = ($mm_quickplay_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (($g_mm_menu_max_width) * (1.0, 0.0)))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_quickplay_HL
		PARENT = main_menu_career
		Pos = (<menu_offset> + (0.0, -8.0))
		Alpha = 0
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_quickplay_HLBar
		PARENT = main_menu_quickplay_HL
		texture = hilite_bar_01
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <HLBar_dims>
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_quickplay_BEL
		PARENT = main_menu_quickplay_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BEL_pos>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_quickplay_BER
		PARENT = main_menu_quickplay_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BER_pos>
	}
	DoScreenElementMorph \{Id = main_menu_quickplay_HL
		Scale = (1.0, 0.01)
		relative_scale}
	CreateScreenElement {Type = ContainerElement
		Id = main_menu_multiplayer
		PARENT = vmenu_main_menu
		event_handlers = [
			{
				Focus
				main_menu_highlight
				Params = {
					option = 'multiplayer'
				}
			}
			{
				unfocus
				main_menu_unhighlight
				Params = {
					option = 'multiplayer'
				}
			}
			{
				pad_choose
				main_menu_select_multiplayer
			}
		]
		//<demo_mode_disable>
		}
	CreateScreenElement {
		<text_params>
		PARENT = main_menu_multiplayer
		Id = main_menu_multiplayer_text
		Pos = (<menu_offset> * 2)
		Text = ($mm_multiplayer_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (($g_mm_menu_max_width) * (1.0, 0.0)))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_multiplayer_HL
		PARENT = main_menu_career
		Pos = ((<menu_offset> * 2) + (0.0, -8.0))
		Alpha = 0
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_multiplayer_HLBar
		PARENT = main_menu_multiplayer_HL
		texture = hilite_bar_01
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <HLBar_dims>
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_multiplayer_BEL
		PARENT = main_menu_multiplayer_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BEL_pos>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_multiplayer_BER
		PARENT = main_menu_multiplayer_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BER_pos>
	}
	DoScreenElementMorph \{Id = main_menu_multiplayer_HL
		Scale = (1.0, 0.01)
		relative_scale}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_training
		PARENT = vmenu_main_menu
		event_handlers = [
			{Focus main_menu_highlight Params = {option = 'training'}}
			{unfocus main_menu_unhighlight Params = {option = 'training'}}
			{pad_choose main_menu_select_training}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = main_menu_training
		Id = main_menu_training_text
		Pos = (<menu_offset> * 3)
		Text = ($mm_training_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (($g_mm_menu_max_width) * (1.0, 0.0)))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_training_HL
		PARENT = main_menu_career
		Pos = ((<menu_offset> * 3) + (0.0, -8.0))
		Alpha = 0
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_training_HLBar
		PARENT = main_menu_training_HL
		texture = hilite_bar_01
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <HLBar_dims>
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_training_BEL
		PARENT = main_menu_training_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BEL_pos>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_training_BER
		PARENT = main_menu_training_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BER_pos>
	}
	DoScreenElementMorph \{Id = main_menu_training_HL
		Scale = (1.0, 0.01)
		relative_scale}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_leaderboards
		PARENT = vmenu_main_menu
		event_handlers = [
			{Focus main_menu_highlight Params = {option = 'leaderboards'}}
			{unfocus main_menu_unhighlight Params = {option = 'leaderboards'}}
			{pad_choose main_menu_select_xbox_live}
		]
		<disable_due_to_crash>
	}
	if IsXENON
		CreateScreenElement {
			<disable_due_to_crash_text>
			PARENT = main_menu_leaderboards
			Id = main_menu_leaderboards_text
			Pos = (<menu_offset> * 4)
			Text = ($randomize_setlist_text)
		}
	else
		CreateScreenElement {
			<disable_due_to_crash_text>
			PARENT = main_menu_leaderboards
			Id = main_menu_leaderboards_text
			Pos = (<menu_offset> * 4)
			Text = ($randomize_setlist_text)
		}
	endif
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (($g_mm_menu_max_width) * (1.0, 0.0)))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_leaderboards_HL
		PARENT = main_menu_career
		Pos = ((<menu_offset> * 4) + (0.0, -8.0))
		Alpha = 0
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_leaderboards_HLBar
		PARENT = main_menu_leaderboards_HL
		texture = hilite_bar_01
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <HLBar_dims>
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_leaderboards_BEL
		PARENT = main_menu_leaderboards_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BEL_pos>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_leaderboards_BER
		PARENT = main_menu_leaderboards_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BER_pos>
	}
	DoScreenElementMorph \{Id = main_menu_leaderboards_HL
		Scale = (1.0, 0.01)
		relative_scale}
	CreateScreenElement \{Type = ContainerElement
		Id = main_menu_options
		PARENT = vmenu_main_menu
		event_handlers = [
			{
				Focus
				main_menu_highlight
				Params = {
					option = 'options'
				}
			}
			{
				unfocus
				main_menu_unhighlight
				Params = {
					option = 'options'
				}
			}
			{
				pad_choose
				main_menu_select_options
			}
		]}
	CreateScreenElement {
		<text_params>
		PARENT = main_menu_options
		Id = main_menu_options_text
		Pos = (<menu_offset> * 5)
		Text = ($mm_options_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (($g_mm_menu_max_width) * (1.0, 0.0)))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = main_menu_options_HL
		PARENT = main_menu_career
		Pos = ((<menu_offset> * 5) + (0.0, -8.0))
		Alpha = 0
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_options_HLBar
		PARENT = main_menu_options_HL
		texture = hilite_bar_01
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <HLBar_dims>
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_options_BEL
		PARENT = main_menu_options_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BEL_pos>
		flip_v
	}
	CreateScreenElement {
		Type = SpriteElement
		Id = main_menu_options_BER
		PARENT = main_menu_options_HL
		texture = character_hub_hilite_bookend
		rgba = <mm_hilite_color>
		Alpha = 1
		Dims = <BE_dims>
		Pos = <BER_pos>
	}
	DoScreenElementMorph \{Id = main_menu_options_HL
		Scale = (1.0, 0.01)
		relative_scale}
	if ($enable_button_cheats = 1)
		CreateScreenElement \{Type = ContainerElement
			Id = main_menu_debug_menu
			PARENT = vmenu_main_menu
			event_handlers = [
				{
					Focus
					main_menu_highlight
					Params = {
						option = 'debug_menu'
					}
				}
				{
					unfocus
					main_menu_unhighlight
					Params = {
						option = 'debug_menu'
					}
				}
				{
					pad_choose
					ui_flow_manager_respond_to_action
					Params = {
						action = select_debug_menu
					}
				}
			]}
		CreateScreenElement {
			<text_params>
			Scale = (0.5, 0.5)
			PARENT = main_menu_debug_menu
			Id = main_menu_debug_menu_text
			Pos = (<menu_offset> * 6)
			Text = ($mm_debug_menu_text)
		}
	endif
	Change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	Change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	if ($hs_first_time = 1)
		setglobaltags {user_options
			params = {
				lag_calibration = ($calibration_val)
				lefty_flip_p1 = ($lefty_flip_p1_val)
				lefty_flip_p2 = ($lefty_flip_p2_val)
			}
		}
		new_hs = ($hyperspeed_setting_val)
		change cheat_hyperspeed = <new_hs>
		change structurename = player1_status resting_whammy_position = ($whammy_cal_val_1)
		change structurename = player2_status resting_whammy_position = ($whammy_cal_val_2)
		change structurename = player1_status star_tilt_threshold = ($star_power_pos_1)
		change structurename = player2_status star_tilt_threshold = ($star_power_pos_2)
		change \{hs_first_time = 0}
	endif
	add_user_control_helper \{Text = $text_button_select
		button = Green
		Z = 100}
	add_user_control_helper \{Text = $text_button_updown
		button = Strumbar
		Z = 100}
	if NOT ($invite_controller = -1)
		Change \{invite_controller = -1}
		ui_flow_manager_respond_to_action \{action = select_xbox_live}
		FadeToBlack \{OFF
			Time = 0}
	else
		LaunchEvent \{Type = Focus
			Target = vmenu_main_menu}
	endif
endscript

script create_pause_menu \{Player = 1
		for_options = 0
		for_practice = 0}
	if GotParam \{device_num}
		player_device = <device_num>
	else
		player_device = ($last_start_pressed_device)
	endif
	exclusive_device = <player_device>
	dont_show_options = 0
	if ($player1_device = <player_device>)
		<Player> = 1
	elseif ($player2_device = <player_device>)
		<Player> = 2
	else
		if NOT IsSinglePlayerGame
			if (<player_device> = -1)
				<dont_show_options> = 1
				exclusive_mp_controllers = [0 , 0]
				SetArrayElement ArrayName = exclusive_mp_controllers Index = 0 NewValue = ($player1_device)
				SetArrayElement ArrayName = exclusive_mp_controllers Index = 1 NewValue = ($player2_device)
				<exclusive_device> = <exclusive_mp_controllers>
			endif
		else
			<dont_show_options> = 1
			<exclusive_device> = ($player1_device)
		endif
	endif
	Change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	Change \{user_control_pill_color = [
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
			{pad_back ui_flow_manager_respond_to_action Params = {action = go_back}}
		]
	endif
	Change \{bunny_flame_index = 1}
	pause_z = 10000
	Spacing = -55
	if (<for_options> = 0)
		Menu_pos = (740.0, 190.0)
		if (<for_practice> = 1)
			<Menu_pos> = (640.0, 165.0)
			<Spacing> = -55
		endif
	else
		if NOT German
			<Spacing> = -55
		else
			<Spacing> = -35
		endif
		if IsGuitarController controller = <player_device>
			Menu_pos = (640.0, 265.0)
			if German
				<Menu_pos> = (<Menu_pos> + (0.0, -60.0))
			endif
		else
			Menu_pos = (640.0, 300.0)
			if German
				<Menu_pos> = (<Menu_pos> + (0.0, -30.0))
			endif
		endif
	endif
	new_menu {
		scrollid = scrolling_pause
		vmenuid = vmenu_pause
		Menu_pos = <Menu_pos>
		Rot_Angle = 2
		event_handlers = <flame_handlers>
		Spacing = <Spacing>
		use_backdrop = (0)
		exclusive_device = <exclusive_device>
		focus_color = light_brown
		unfocus_color = brown
	}
	create_simple_frame texture = frame_pause_A Z = (<pause_z> - 10) center_offset = (0.0, 0.0)
	if ($is_network_game = 0)
		if NOT ($current_num_players > 1)
			CreateScreenElement {
				Type = SpriteElement
				PARENT = pause_menu_frame_container
				texture = menu_pause_frame_banner
				Pos = (640.0, 570.0)
				just = [Center Center]
				rgba = (($G_menu_colors).lt_violet_grey)
				z_priority = (<pause_z> + 100)
			}
		endif
		if GotParam \{banner_text}
			pause_player_text = <banner_text>
			if GotParam \{banner_scale}
				pause_player_scale = <banner_scale>
			else
				pause_player_scale = (1.0, 1.0)
			endif
		else
			if (<for_options> = 0)
				if (<for_practice> = 1)
					<pause_player_text> = ($pause_paused_text)
				else
					if ((IsSinglePlayerGame) || <dont_show_options> = 1)
						<pause_player_text> = ($pause_paused_text)
					else
						FormatText TextName = pause_player_text ($pause_player_paused_text) D = <Player>
					endif
				endif
				pause_player_scale = (0.6, 0.75)
			else
				pause_player_text = ($mm_options_text)
				pause_player_scale = (0.75, 0.75)
			endif
		endif
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = <Id>
		Text = <pause_player_text>
		font = text_a6
		Pos = (125.0, 53.0)
		Scale = <pause_player_scale>
		rgba = (($G_menu_colors).BLACK)
		Scale = 0.8
	}
	text_scale = (1.0, 1.1)
	if (<for_options> = 0 && <for_practice> = 0)
		CreateScreenElement {
			Type = ContainerElement
			PARENT = pause_menu_frame_container
			Id = bunny_container
			Pos = (380.0, 170.0)
			just = [LEFT Top]
			z_priority = <pause_z>
		}
		I = 1
		begin
		FormatText ChecksumName = bunny_id 'pause_bunny_flame_%d' D = <I>
		FormatText ChecksumName = bunny_tex 'GH3_Pause_Bunny_Flame%d' D = <I>
		CreateScreenElement {
			Type = SpriteElement
			Id = <bunny_id>
			PARENT = bunny_container
			Pos = (160.0, 170.0)
			texture = <bunny_tex>
			rgba = [255 255 255 255]
			Dims = (300.0, 300.0)
			just = [RIGHT Bottom]
			z_priority = (<pause_z> + 3)
			Rot_Angle = 5
		}
		if (<I> > 1)
			DoScreenElementMorph Id = <bunny_id> Alpha = 0
		endif
		<I> = (<I> + 1)
		repeat 7
		CreateScreenElement {
			Type = SpriteElement
			Id = pause_bunny_shadow
			PARENT = bunny_container
			texture = GH3_Pause_Bunny
			rgba = [0 0 0 128]
			Pos = (20.0, -110.0)
			Dims = (500.0, 500.0)
			just = [Center Top]
			z_priority = (<pause_z> + 4)
		}
		CreateScreenElement {
			Type = SpriteElement
			Id = pause_bunny
			PARENT = bunny_container
			texture = GH3_Pause_Bunny
			rgba = [255 255 255 255]
			Pos = (0.0, -130.0)
			Dims = (500.0, 500.0)
			just = [Center Top]
			z_priority = (<pause_z> + 5)
		}
		RunScriptOnScreenElement \{Id = bunny_container
			bunny_hover
			Params = {
				hover_origin = (380.0, 170.0)
			}}
	endif
	container_params = {Type = ContainerElement PARENT = vmenu_pause Dims = (0.0, 100.0)}
	if (<for_options> = 0)
		if (<for_practice> = 1)
			if English
				text_scale = (0.95, 0.95)
				vmenu_pause :SetProps \{Pos = (0.0, 300.0)
					spacing_between = -60}
			else
				text_scale = (0.82, 0.82)
				vmenu_pause :SetProps \{spacing_between = -65}
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = pause_resume}}
					{unfocus retail_menu_unfocus Params = {Id = pause_resume}}
					{pad_choose gh3_start_pressed}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Id = pause_resume
				Text = ($pause_resume_text)
				just = [Center Top]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = pause_restart}}
					{unfocus retail_menu_unfocus Params = {Id = pause_restart}}
					{pad_choose ui_flow_manager_respond_to_action Params = {action = select_restart}}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Text = ($pause_restart_text)
				Id = pause_restart
				just = [Center Top]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			if (<dont_show_options> = 0)
				CreateScreenElement {
					<container_params>
					event_handlers = [
						{Focus retail_menu_focus Params = {Id = pause_options}}
						{unfocus retail_menu_unfocus Params = {Id = pause_options}}
						{pad_choose ui_flow_manager_respond_to_action Params = {action = select_options create_params = {player_device = <player_device>}}}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = ($menu_unfocus_color)
					Text = "OPTIONS"
					Id = pause_options
					just = [Center Top]
					Shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [0 0 0 255]
					z_priority = <pause_z>
					exclusive_device = <exclusive_device>
				}
				GetScreenElementDims Id = <Id>
				fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = pause_change_speed}}
					{unfocus retail_menu_unfocus Params = {Id = pause_change_speed}}
					{pad_choose ui_flow_manager_respond_to_action Params = {action = select_change_speed}}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Text = ($pause_change_speed_text)
				Id = pause_change_speed
				just = [Center Top]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = pause_change_section}}
					{unfocus retail_menu_unfocus Params = {Id = pause_change_section}}
					{pad_choose ui_flow_manager_respond_to_action Params = {action = select_change_section}}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Text = ($pause_change_section_text)
				Id = pause_change_section
				just = [Center Top]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($came_to_practice_from = main_menu)
				CreateScreenElement {
					<container_params>
					event_handlers = [
						{Focus retail_menu_focus Params = {Id = pause_new_song}}
						{unfocus retail_menu_unfocus Params = {Id = pause_new_song}}
						{pad_choose ui_flow_manager_respond_to_action Params = {action = select_new_song}}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = ($menu_unfocus_color)
					Text = ($pause_new_song_text)
					Id = pause_new_song
					just = [Center Top]
					Shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [0 0 0 255]
					z_priority = <pause_z>
					exclusive_device = <exclusive_device>
				}
				GetScreenElementDims Id = <Id>
				fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = pause_quit}}
					{unfocus retail_menu_unfocus Params = {Id = pause_quit}}
					{pad_choose ui_flow_manager_respond_to_action Params = {action = select_quit}}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Text = ($pause_quit_text)
				Id = pause_quit
				just = [Center Top]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = ((300.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			add_user_control_helper \{Text = $text_button_select
				button = Green
				Z = 100000}
			add_user_control_helper \{Text = $text_button_updown
				button = Strumbar
				Z = 100000}
		else
			if English
			else
				container_params = {Type = ContainerElement PARENT = vmenu_pause Dims = (0.0, 105.0)}
				text_scale = (0.8, 0.8)
			endif
			CreateScreenElement {
				<container_params>
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = pause_resume}}
					{unfocus retail_menu_unfocus Params = {Id = pause_resume}}
					{pad_choose gh3_start_pressed}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Text = ($pause_resume_text)
				Id = pause_resume
				just = [Center Top]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = ((250.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			if ($is_network_game = 0)
				if NOT ($end_credits = 1)
					CreateScreenElement {
						<container_params>
						event_handlers = [
							{Focus retail_menu_focus Params = {Id = pause_restart}}
							{unfocus retail_menu_unfocus Params = {Id = pause_restart}}
							{pad_choose ui_flow_manager_respond_to_action Params = {action = select_restart}}
						]
					}
					CreateScreenElement {
						Type = TextElement
						PARENT = <Id>
						font = fontgrid_title_gh3
						Scale = <text_scale>
						rgba = ($menu_unfocus_color)
						Text = ($pause_restart_text)
						Id = pause_restart
						just = [Center Top]
						Shadow
						shadow_offs = (3.0, 3.0)
						shadow_rgba [0 0 0 255]
						z_priority = <pause_z>
						exclusive_device = <exclusive_device>
					}
					GetScreenElementDims Id = <Id>
					fit_text_in_rectangle Id = <Id> Dims = ((250.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
					if ($is_demo_mode = 1)
						demo_mode_disable = {rgba = [80 80 80 255] NOT_FOCUSABLE}
					else
						demo_mode_disable = {rgba = [80 80 80 255] NOT_FOCUSABLE}
					endif
					if (($game_mode = p1_career && $boss_battle = 0) || ($game_mode = p1_quickplay))
						CreateScreenElement {
							<container_params>
							event_handlers = [
								{Focus retail_menu_focus Params = {Id = pause_practice}}
								{unfocus retail_menu_unfocus Params = {Id = pause_practice}}
								{pad_choose ui_flow_manager_respond_to_action Params = {action = select_practice}}
							]
						}
						CreateScreenElement {
							Type = TextElement
							PARENT = <Id>
							font = fontgrid_title_gh3
							Scale = <text_scale>
							rgba = ($menu_unfocus_color)
							Text = ($pause_practice_text)
							Id = pause_practice
							just = [Center Top]
							Shadow
							shadow_offs = (3.0, 3.0)
							shadow_rgba [0 0 0 255]
							z_priority = <pause_z>
							exclusive_device = <exclusive_device>
						}
						GetScreenElementDims Id = <Id>
						fit_text_in_rectangle Id = <Id> Dims = ((260.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
					endif
					if (<dont_show_options> = 0)
						CreateScreenElement {
							<container_params>
							event_handlers = [
								{Focus retail_menu_focus Params = {Id = pause_options}}
								{unfocus retail_menu_unfocus Params = {Id = pause_options}}
								{pad_choose ui_flow_manager_respond_to_action Params = {action = select_options create_params = {player_device = <player_device>}}}
							]
						}
						CreateScreenElement {
							Type = TextElement
							PARENT = <Id>
							font = fontgrid_title_gh3
							Scale = <text_scale>
							rgba = ($menu_unfocus_color)
							Text = ($mm_options_text)
							Id = pause_options
							just = [Center Top]
							Shadow
							shadow_offs = (3.0, 3.0)
							shadow_rgba [0 0 0 255]
							z_priority = <pause_z>
							exclusive_device = <exclusive_device>
						}
						GetScreenElementDims Id = <Id>
						fit_text_in_rectangle Id = <Id> Dims = ((260.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
					endif
				endif
			endif
			if NOT ($end_credits = 1)
				quit_script = ui_flow_manager_respond_to_action
				quit_script_params = {action = select_quit create_params = {Player = <Player>}}
				if ($is_network_game)
					quit_script = create_leaving_lobby_dialog
					quit_script_params = {
						create_pause_menu
						pad_back_script = return_to_pause_menu_from_net_warning
						pad_choose_script = pause_menu_really_quit_net_game
						Z = 300
					}
				endif
				CreateScreenElement {
					<container_params>
					event_handlers = [
						{Focus retail_menu_focus Params = {Id = pause_quit}}
						{unfocus retail_menu_unfocus Params = {Id = pause_quit}}
						{pad_choose <quit_script> Params = <quit_script_params>}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = ($menu_unfocus_color)
					Text = ($pause_quit_text)
					Id = pause_quit
					just = [Center Top]
					Shadow
					shadow_offs = (3.0, 3.0)
					shadow_rgba [0 0 0 255]
					z_priority = <pause_z>
					exclusive_device = <exclusive_device>
				}
				GetScreenElementDims Id = <Id>
				fit_text_in_rectangle Id = <Id> Dims = ((270.0, 0.0) + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
			endif
			if ($enable_button_cheats = 1)
				CreateScreenElement {
					<container_params>
					event_handlers = [
						{Focus retail_menu_focus Params = {Id = pause_debug_menu}}
						{unfocus retail_menu_unfocus Params = {Id = pause_debug_menu}}
						{pad_choose ui_flow_manager_respond_to_action Params = {action = select_debug_menu}}
					]
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = <Id>
					font = fontgrid_title_gh3
					Scale = <text_scale>
					rgba = [136 95 50 100]
					Text = "DEBUG"
					Id = pause_debug_menu
					just = [Center Top]
					z_priority = <pause_z>
					exclusive_device = <exclusive_device>
				}
			endif
			add_user_control_helper \{Text = $text_button_select
				button = Green
				Z = 100000}
			add_user_control_helper \{Text = $text_button_updown
				button = Strumbar
				Z = 100000}
		endif
	else
		<fit_dims> = (400.0, 0.0)
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			Dims = (0.0, 100.0)
			Pos = (0.0, 20.0)
			event_handlers = [
				{Focus retail_menu_focus Params = {Id = options_audio}}
				{unfocus generic_menu_up_or_down_sound}
				{unfocus retail_menu_unfocus Params = {Id = options_audio}}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_audio_settings create_params = {Player = <Player>}}}
			]
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = ($menu_unfocus_color)
			Text = ($options_set_audio_text)
			Id = options_audio
			just = [Center Center]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = <pause_z>
			exclusive_device = <exclusive_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> Dims = (<fit_dims> + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			Dims = (0.0, 100.0)
			event_handlers = [
				{Focus retail_menu_focus Params = {Id = options_calibrate_lag}}
				{unfocus generic_menu_up_or_down_sound}
				{unfocus retail_menu_unfocus Params = {Id = options_calibrate_lag}}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_calibrate_lag create_params = {Player = <Player>}}}
			]
		}
		CreateScreenElement {
			Type = TextElement
			PARENT = <Id>
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = ($menu_unfocus_color)
			Text = ($options_calibrate_lag_text)
			Id = options_calibrate_lag
			just = [Center Center]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = <pause_z>
			exclusive_device = <exclusive_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> Dims = (<fit_dims> + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		if IsGuitarController controller = <player_device>
			CreateScreenElement {
				Type = ContainerElement
				PARENT = vmenu_pause
				Dims = (0.0, 100.0)
				event_handlers = [
					{Focus retail_menu_focus Params = {Id = options_calibrate_whammy}}
					{unfocus generic_menu_up_or_down_sound}
					{unfocus retail_menu_unfocus Params = {Id = options_calibrate_whammy}}
					{pad_choose ui_flow_manager_respond_to_action Params = {action = select_calibrate_whammy_bar create_params = {Player = <Player> Popup = 1}}}
				]
			}
			CreateScreenElement {
				Type = TextElement
				PARENT = <Id>
				font = fontgrid_title_gh3
				Scale = <text_scale>
				rgba = ($menu_unfocus_color)
				Text = ($options_calibrate_whammy_text)
				Id = options_calibrate_whammy
				just = [Center Center]
				Shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba = [0 0 0 255]
				z_priority = <pause_z>
				exclusive_device = <exclusive_device>
			}
			GetScreenElementDims Id = <Id>
			fit_text_in_rectangle Id = <Id> Dims = (<fit_dims> + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		endif
		if isSinglePlayerGame
			lefty_flip_text = ($options_lefty_flip_text)
		else
			if (<player> = 1)
				lefty_flip_text = ($options_lefty_flip_p1_text)
			else
				lefty_flip_text = ($options_lefty_flip_p2_text)
			endif
		endif
		CreateScreenElement {
			Type = ContainerElement
			PARENT = vmenu_pause
			Dims = (0.0, 100.0)
			event_handlers = [
				{Focus retail_menu_focus Params = {Id = pause_options_lefty}}
				{unfocus generic_menu_up_or_down_sound}
				{unfocus retail_menu_unfocus Params = {Id = pause_options_lefty}}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_lefty_flip create_params = {Player = <Player>}}}
			]
		}
		<lefty_container> = <Id>
		CreateScreenElement {
			Type = TextElement
			PARENT = <lefty_container>
			Id = pause_options_lefty
			font = fontgrid_title_gh3
			Scale = <text_scale>
			rgba = ($menu_unfocus_color)
			Text = <lefty_flip_text>
			just = [Center Center]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = <pause_z>
			exclusive_device = <exclusive_device>
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle Id = <Id> Dims = (<fit_dims> + <Height> * (0.0, 1.0)) only_if_larger_x = 1 start_x_scale = (<text_scale>.(1.0, 0.0)) start_y_scale = (<text_scale>.(0.0, 1.0))
		GetGlobalTags \{user_options}
		if (<Player> = 1)
			if (<lefty_flip_p1> = 1)
				lefty_tex = Options_Controller_Check
			else
				lefty_tex = Options_Controller_X
			endif
		else
			if (<lefty_flip_p2> = 1)
				lefty_tex = Options_Controller_Check
			else
				lefty_tex = Options_Controller_X
			endif
		endif
		displaySprite {
			PARENT = <lefty_container>
			tex = <lefty_tex>
			just = [Center Center]
			Z = (<pause_z> + 10)
		}
		GetScreenElementDims \{Id = pause_options_lefty}
		<Id> :SetProps Pos = (<width> * (0.5, 0.0) + (22.0, 0.0))
		add_user_control_helper \{text = $text_button_select
			button = green
			z = 100000}
		add_user_control_helper \{text = $text_button_back
			button = red
			z = 100000}
		add_user_control_helper \{text = $text_button_updown
			button = Strumbar
			Z = 100000}
	endif
	if ($is_network_game = 0)
		if NOT IsSinglePlayerGame
			if (<for_practice> = 0 && <dont_show_options> = 0)
				FormatText TextName = player_paused_text ($pause_player_paused_text_extended) D = <Player>
				CreateScreenElement {
					Type = SpriteElement
					PARENT = pause_menu_frame_container
					Id = pause_helper_text_bg
					texture = Control_pill_body
					Pos = (640.0, 606.0)
					just = [Center Center]
					rgba = [90 85 100 255]
					z_priority = (<pause_z> - 8)
				}
				CreateScreenElement {
					Type = TextElement
					PARENT = pause_menu_frame_container
					Pos = (640.0, 609.0)
					just = [Center Center]
					Text = <player_paused_text>
					rgba = [170 120 100 255]
					Scale = (0.45000002, 0.6)
					z_priority = (<pause_z> - 0)
					font = text_a6
					Shadow
					shadow_offs = (1.0, 1.0)
				}
				GetScreenElementDims Id = <Id>
				bg_dims = (<width> * (1.0, 0.0) + (0.0, 32.0))
				pause_helper_text_bg :SetProps Dims = <bg_dims>
				CreateScreenElement {
					Type = SpriteElement
					PARENT = pause_menu_frame_container
					texture = Control_pill_end
					Pos = ((640.0, 606.0) - <width> * (0.5, 0.0))
					rgba = [90 85 100 255]
					just = [RIGHT Center]
					flip_v
					z_priority = (<pause_z> - 8)
				}
				CreateScreenElement {
					Type = SpriteElement
					PARENT = pause_menu_frame_container
					texture = Control_pill_end
					Pos = ((640.0, 606.0) + <width> * (0.5, 0.0))
					rgba = [90 85 100 255]
					just = [LEFT Center]
					z_priority = (<pause_z> - 8)
				}
			endif
		endif
	endif
	Change \{menu_choose_practice_destroy_previous_menu = 1}
	if (<for_options> = 0 && <for_practice> = 0)
		SpawnScriptNow \{animate_bunny_flame}
	endif
	UnPauseSpawnedScript \{sysnotify_handle_signin_change}
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

script signing_change_confirm_reboot 
	printf \{"signing_change_confirm_reboot"}
	destroy_signin_changed_menu
	enable_pause
	wait \{5
		gameframes}
	start_flow_manager \{flow_state = main_menu_fs}
	printf \{"signing_change_confirm_reboot end"}
endscript

script shutdown_game_for_signin_change \{unloadcontent = 1
		signin_change = 0}
	Printf \{"shutdown_game_for_signin_change"}
	Change \{shutdown_game_for_signin_change_flag = 1}
	StopAllSounds
	Change \{current_band = 1}
	Change \{options_for_manage_band = 0}
	Change \{store_view_cam_created = 0}
	Change \{store_camera_changing = 0}
	KillSpawnedScript \{Name = online_menu_init}
	KillSpawnedScript \{Name = do_calibration_update}
	KillSpawnedScript \{Name = cl_do_ping}
	KillSpawnedScript \{Name = play_calibrate_click}
	KillSpawnedScript \{Name = kill_off_and_finish_calibration}
	KillSpawnedScript \{Name = menu_calibrate_lag_create_circles}
	set_demonware_failed
	KillSpawnedScript \{Name = create_leaderboard_menu2}
	KillSpawnedScript \{Name = create_leaderboard_menu3}
	KillSpawnedScript \{Name = add_leaderboard_rows_to_menu}
	KillSpawnedScript \{Name = fall_controller}
	shutdown_options_video_monitor
	destroy_alert_popup \{Force = 1
		play_sound = 0}
	end_practice_song_slomo
	destroy_loading_screen
	memcard_sequence_cleanup_generic
	KillSpawnedScript \{Name = memcard_sequence_begin_bootup_logic}
	menu_store_go_back
	destroy_select_quickplay_mode
	Change \{create_band_member_lock = 0}
	Change \{create_band_member_lock_queue = 0}
	KillSpawnedScript \{Name = generic_select_monitor}
	Change \{generic_select_monitor_p1_changed = 0}
	Change \{generic_select_monitor_p2_changed = 0}
	KillSpawnedScript \{Name = cheats_do_guitar_morphs}
	KillSpawnedScript \{Name = cheats_watch_buttons}
	KillSpawnedScript \{Name = create_exploding_text}
	destroy_all_exploding_text
	KillSpawnedScript \{Name = do_ui_frame_morph}
	destroy_menu \{menu_id = select_style_container}
	destroy_menu \{menu_id = select_style_container_p2}
	shut_down_character_hub
	destroy_select_outfit_menu
	destroy_setlist_songpreview_monitor
	quit_network_game_early \{signin_change}
	tutorial_shutdown
	shut_down_flow_manager \{Player = 1
		resetstate}
	shut_down_flow_manager \{Player = 2
		resetstate}
	destroy_credits_menu
	store_monitor_goal_guitar_finish
	DeRegisterAtoms
	kill_gem_scroller \{no_render = 1}
	progression_push_current \{Force = 1}
	clean_up_user_control_helpers
	Menu_Music_Off
	unload_songqpak
	SetPakManCurrentBlock \{map = Zones
		pak = NONE
		block_scripts = 1}
	destroy_band \{unload_paks}
	if (<signin_change> = 1)
		clear_cheats
	endif
	if (<unloadcontent> = 1)
		ClearGlobalTags
		setup_globaltags
	endif
	if ScreenElementExists \{Id = ready_container_p2}
		DestroyScreenElement \{Id = ready_container_p2}
	endif
	if ScreenElementExists \{Id = search_results_container}
		DestroyScreenElement \{Id = search_results_container}
	endif
	set_default_misc_globals
	cleanup_songwon_event
	destroy_menu_transition
	destroy_calibrate_lag_dialog_menu
	Change \{menu_choose_practice_destroy_previous_menu = 1}
	destroy_choose_practice_section_menu
	if NOT ISPS3
		ResumeControllerChecking
	endif
	UnPauseGame
	destroy_bg_viewport
	setup_bg_viewport
	Change \{shutdown_game_for_signin_change_flag = 0}
	Printf \{"shutdown_game_for_signin_change end"}
endscript

script create_cheats_menu 
	disable_pause
	if ($entering_cheat = 0)
		CreateScreenElement \{Type = ContainerElement
			Id = cheats_container
			PARENT = root_window
			Pos = (0.0, 0.0)}
		if NOT ScreenElementExists \{Id = menu_backdrop_container}
			create_menu_backdrop \{texture = Venue_BG}
		endif
		if NOT ScreenElementExists \{Id = cheats_container}
			return
		endif
		displaySprite \{PARENT = cheats_container
			tex = options_video_poster
			Rot_Angle = 1
			Pos = (640.0, 215.0)
			Dims = (820.0, 440.0)
			just = [
				Center
				Center
			]
			Z = 1
			font = $video_settings_menu_font}
		displayText \{PARENT = cheats_container
			Pos = (910.0, 402.0)
			just = [
				RIGHT
				Center
			]
			Id = cheats_menu_title
			Text = $cheats_cheats_text
			Scale = 1.1
			rgba = [
				240
				235
				240
				255
			]
			font = text_a5
			noshadow}
		displaySprite \{PARENT = cheats_container
			tex = tape_H_03
			Pos = (270.0, 185.0)
			Rot_Angle = -50
			Scale = 0.5
			Z = 20}
		displaySprite {
			PARENT = <Id>
			tex = tape_H_03
			Pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			Z = 19
		}
		displaySprite \{PARENT = cheats_container
			tex = tape_H_04
			Pos = (930.0, 380.0)
			Rot_Angle = -120
			Scale = 0.5
			Z = 20}
		displaySprite {
			PARENT = <Id>
			tex = tape_H_04
			Pos = (5.0, 5.0)
			rgba = [0 0 0 128]
			Z = 19
		}
		CreateScreenElement \{Type = ContainerElement
			Id = cheats_warning_container
			PARENT = root_window
			Alpha = 0
			Scale = 0.5
			Pos = (640.0, 540.0)}
		displaySprite \{PARENT = cheats_warning_container
			Id = cheats_warning
			tex = Control_pill_body
			Pos = (0.0, 0.0)
			just = [
				Center
				Center
			]
			rgba = [
				96
				0
				0
				255
			]
			Z = 100}
		GetPlatform
		switch <Platform>
			case XENON
			warning = ($cheats_warning)
			warning_cont = ($cheats_warning_cont_360)
			case ps3
			warning = ($cheats_warning)
			warning_cont = ($cheats_warning_cont)
			case ps2
			warning = ($cheats_warning_ps2)
			warning_cont = ""
			default
			warning = ($cheats_warning)
			warning_cont = ($cheats_warning_cont)
		endswitch
		FormatText TextName = warning_text "%a %b" A = <warning> B = <warning_cont>
		CreateScreenElement {
			Type = TextBlockElement
			Id = first_warning
			PARENT = cheats_warning_container
			font = text_a6
			Scale = 1
			Text = <warning_text>
			rgba = [186 105 0 255]
			just = [Center Center]
			z_priority = 101.0
			Pos = (0.0, 0.0)
			Dims = (1400.0, 100.0)
			allow_expansion
		}
		GetScreenElementDims \{Id = first_warning}
		bg_dims = (<width> * (1.0, 0.0) + (<Height> * (0.0, 1.0) + (0.0, 40.0)))
		cheats_warning :SetProps Dims = <bg_dims>
		displaySprite {
			PARENT = cheats_warning_container
			tex = Control_pill_end
			Pos = (-1 * <width> * (0.5, 0.0))
			rgba = [96 0 0 255]
			Dims = ((64.0, 0.0) + (<Height> * (0.0, 1.0) + (0.0, 40.0)))
			just = [RIGHT Center]
			flip_v
			Z = 100
		}
		displaySprite {
			PARENT = cheats_warning_container
			tex = Control_pill_end
			Pos = (<width> * (0.5, 0.0))
			rgba = [96 0 0 255]
			Dims = ((64.0, 0.0) + (<Height> * (0.0, 1.0) + (0.0, 40.0)))
			just = [LEFT Center]
			Z = 100
		}
		cheats_create_guitar
	endif
	show_cheat_warning
	displaySprite \{PARENT = cheats_container
		Id = cheats_hilite
		tex = White
		rgba = [
			150
			0
			50
			255
		]
		Rot_Angle = 1
		Pos = (349.0, 382.0)
		Dims = (230.0, 20.0)
		Z = 2}
	new_menu \{scrollid = cheats_scroll
		vmenuid = cheats_vmenu
		Menu_pos = (360.0, 260.0)
		text_left
		Spacing = -12
		Rot_Angle = 1}
	LaunchEvent \{Type = unfocus
		Target = cheats_vmenu}
	text_params = {PARENT = cheats_vmenu Type = TextElement font = text_a3 rgba = [255 245 225 255] z_priority = 50 Rot_Angle = 0 Scale = 1}
	text_params2 = {PARENT = cheats_vmenu Type = TextElement font = text_a5 rgba = [255 245 225 255] z_priority = 50 Rot_Angle = 0 Scale = 0.63}
	hilite_pos = (349.0, 278.0)
	hilite_offset = (0.0, 19.0)
	GetGlobalTags \{user_options}
	<Text> = "locked"
	if (<unlock_Cheat_NoFail> > 0)
		if ($Cheat_NoFail = 1)
			formattext textname = text ($cheats_turned_on) c = ($guitar_hero_cheats [3].name_text)
		else
			if ($cheat_nofail < 0)
				change \{cheat_nofail = 2}
			endif
			formattext textname = text ($cheats_turned_off) c = ($guitar_hero_cheats [3].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		Text = <Text>
		Id = Cheat_NoFail_Text
		event_handlers = [
			{Focus cheats_morph_hilite Params = {Pos = (<hilite_pos>) Id = Cheat_NoFail_Text}}
			{pad_choose toggle_cheat Params = {cheat = Cheat_NoFail Id = Cheat_NoFail_Text Index = 3}}
		]
	}
	<Text> = "locked"
	if (<unlock_Cheat_AirGuitar> > 0)
		if ($Cheat_AirGuitar = 1)
			formattext textname = text ($cheats_turned_on) c = ($guitar_hero_cheats [0].name_text)
		else
			if ($Cheat_AirGuitar < 0)
				change \{Cheat_AirGuitar = 2}
			endif
			formattext textname = text ($cheats_turned_off) c = ($guitar_hero_cheats [0].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		Text = <Text>
		Id = Cheat_AirGuitar_Text
		event_handlers = [
			{Focus cheats_morph_hilite Params = {Pos = (<hilite_pos> + (<hilite_offset> * 1)) Id = Cheat_AirGuitar_Text}}
			{pad_choose toggle_cheat Params = {cheat = Cheat_AirGuitar Id = Cheat_AirGuitar_Text Index = 0}}
		]
	}
	<Text> = ($cheats_locked)
	if (<unlock_Cheat_Hyperspeed> > 0)
		if ($Cheat_HyperSpeed > 0)
			formattext textname = text ($cheats_turned_on) c = ($guitar_hero_cheats [2].name_text)
			formattext textname = text "%c, %d" c = <text> d = ($Cheat_Hyperspeed)
		else
			if ($Cheat_Hyperspeed < 0)
				change \{Cheat_Hyperspeed = 0}
			endif
			formattext textname = text ($cheats_turned_off) c = ($guitar_hero_cheats [2].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		Text = <Text>
		Id = Cheat_Hyperspeed_Text
		event_handlers = [
			{Focus cheats_morph_hilite Params = {Pos = (<hilite_pos> + (<hilite_offset> * 2)) Id = Cheat_Hyperspeed_Text}}
			{pad_choose toggle_hyperspeed Params = {cheat = Cheat_HyperSpeed Id = Cheat_Hyperspeed_Text Index = 2}}
		]
	}
	<Text> = ($cheats_locked)
	if (<unlock_Cheat_PerformanceMode> > 0)
		if ($Cheat_PerformanceMode = 1)
			formattext textname = text ($cheats_turned_on) c = ($guitar_hero_cheats [1].name_text)
		else
			if ($cheat_performancemode < 0)
				change \{cheat_performancemode = 2}
			endif
			formattext textname = text ($cheats_turned_off) c = ($guitar_hero_cheats [1].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		Text = <Text>
		Id = Cheat_PerformanceMode_Text
		event_handlers = [
			{Focus cheats_morph_hilite Params = {Pos = (<hilite_pos> + (<hilite_offset> * 3)) Id = Cheat_PerformanceMode_Text}}
			{pad_choose toggle_cheat Params = {cheat = Cheat_PerformanceMode Id = Cheat_PerformanceMode_Text Index = 1}}
		]
	}
	<Text> = ($cheats_locked)
	if (<unlock_Cheat_PrecisionMode> > 0)
		if ($Cheat_PrecisionMode = 1)
			formattext textname = text ($cheats_turned_on) c = ($guitar_hero_cheats [5].name_text)
		else
			if ($Cheat_PrecisionMode < 0)
				change \{Cheat_PrecisionMode = 2}
			endif
			formattext textname = text ($cheats_turned_off) c = ($guitar_hero_cheats [5].name_text)
		endif
	endif
	CreateScreenElement {
		<text_params2>
		Text = <Text>
		Id = Cheat_PrecisionMode_Text
		event_handlers = [
			{Focus cheats_morph_hilite Params = {Pos = (<hilite_pos> + (<hilite_offset> * 4)) Id = Cheat_PrecisionMode_Text}}
			{pad_choose toggle_cheat Params = {cheat = Cheat_PrecisionMode Id = Cheat_PrecisionMode_Text Index = 4}}
		]
	}
	clean_up_user_control_helpers
	Change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	Change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
		button = Strumbar
		Z = 100}
	Change \{entering_cheat = 0}
	Change \{guitar_hero_cheats_completed = [
			0
			0
			0
			0
			0
			0
			0
			0
		]}
	LaunchEvent \{Type = Focus
		Target = cheats_vmenu}
endscript

script create_enter_band_name_menu 
	Change \{ebn_reached_max_chars = 0}
	SetScreenElementProps \{Id = root_window
		event_handlers = [
			{
				pad_start
				null_script
			}
		]
		Replace_Handlers}
	NetSessionFunc \{func = stats_init}
	enter_band_name_reset_variables
	rotation_angle = -2
	CreateScreenElement \{Type = ContainerElement
		PARENT = root_window
		Id = ebn_container
		Pos = (0.0, 0.0)}
	CreateScreenElement \{Type = SpriteElement
		PARENT = ebn_container
		Id = ebn_menu_backdrop
		texture = Venue_BG
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		Scale = (1.25, 1.4)
		relative_scale
		just = [
			Center
			Center
		]
		z_priority = 0}
	CreateScreenElement \{Type = SpriteElement
		PARENT = ebn_container
		Id = light_overlay
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		Dims = (1280.0, 720.0)
		just = [
			Center
			Center
		]
		z_priority = 99}
	CreateScreenElement \{Type = SpriteElement
		PARENT = ebn_container
		Id = ticket_image
		texture = band_name_ticket
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		Scale = (1.25, 1.4)
		relative_scale
		just = [
			Center
			Center
		]
		z_priority = 1}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = ebn_container
		Id = random_image
		texture = band_name_graphic03
		rgba = [255 255 255 200]
		Pos = (($enter_band_name_big_vals).right_side_img_pos)
		Scale = (($enter_band_name_big_vals).right_side_img_scale)
		relative_scale
		z_priority = 2
	}
	rand = 0
	GetRandomValue \{Name = rand
		Integer
		A = 0
		B = 2}
	if (<rand> = 0)
		SetScreenElementProps \{Id = random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{Id = random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{Id = random_image
			texture = band_name_graphic03}
	endif
	BLACK = [70 10 10 255]
	BLUE = [30 110 150 255]
	nameColor = [95 112 147 255]
	activeColor = (($G_menu_colors).pink)
	CreateScreenElement {
		Type = TextElement
		PARENT = ebn_container
		font = text_a3
		Text = ($permadeath_lives_screen_title)
		Id = ebn_header_text
		Pos = (($enter_band_name_big_vals).header_pos)
		Rot_Angle = <rotation_angle>
		rgba = (($G_menu_colors).dk_violet_grey)
		just = [Center Top]
		Scale = (($enter_band_name_big_vals).header_scale)
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = ebn_container
		font = text_a3
		Text = ($band_legends_text_1)
		Id = top_title_text
		Pos = (($enter_band_name_big_vals).top_title_pos)
		Rot_Angle = <rotation_angle>
		rgba = [212 228 236 255]
		just = [Center Top]
		Scale = (($enter_band_name_big_vals).top_title_scale)
		Shadow
		shadow_offs = (2.0, 2.0)
		shadow_rgba = [142 134 160 255]
	}
	GetLocalSystemTime
	if English
		GetUpperCaseString (($us_month_names) [(<LocalSystemTime>.month)])
		FormatText TextName = date_text "%m %d, %y" M = (<UpperCaseString>) D = (<LocalSystemTime>.dayofmonth) Y = (<LocalSystemTime>.year)
	else
		GetUpperCaseString (($us_month_names) [(<LocalSystemTime>.month)])
		FormatText TextName = date_text "%d %m %y" D = (<LocalSystemTime>.dayofmonth) M = (<UpperCaseString>) Y = (<LocalSystemTime>.year)
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = ebn_container
		font = text_a3
		Text = <date_text>
		Id = ebn_date_text
		Pos = (($enter_band_name_big_vals).date_pos)
		Rot_Angle = <rotation_angle>
		rgba = <BLACK>
		just = [Center Top]
		Scale = (($enter_band_name_big_vals).date_scale)
	}
	CreateScreenElement {
		Type = ContainerElement
		PARENT = ebn_container
		Id = band_name_text_container
		Rot_Angle = <rotation_angle>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = band_name_text_container
		font = text_a3
		Scale = (($enter_band_name_big_vals).text_scale)
		rgba = <nameColor>
		Id = band_name_text
		Pos = (($enter_band_name_big_vals).text_pos)
		just = [Center Center]
		font_spacing = 2
	}
	CreateScreenElement {
		Type = TextElement
		Id = entry_character
		PARENT = band_name_text_container
		font = text_a3
		Scale = (($enter_band_name_big_vals).text_scale)
		rgba = <activeColor>
		Text = "1"
		Id = band_name_entry_char
		just = [Center Center]
	}
	RunScriptOnScreenElement Id = <Id> character_blinker
	CreateScreenElement {
		Type = SpriteElement
		PARENT = band_name_text_container
		Id = ebn_marker
		texture = band_name_underline
		just = [Center Center]
		event_handlers = [
			{pad_up enter_band_name_change_character Params = {UP}}
			{pad_down enter_band_name_change_character Params = {DOWN}}
			{pad_choose band_advance_pointer}
			{pad_back band_retreat_pointer}
			{pad_start confirm_band_name}
		]
		rgba = <activeColor>
		exclusive_device = ($primary_controller)
		Alpha = 0.6
	}
	LaunchEvent \{Type = Focus
		Target = ebn_marker}
	Change \{ebn_transitioning_back = 0}
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
	Menu_pos = (400.0, 270.0)
	new_menu {
		scrollid = scrolling_choose_band
		vmenuid = vmenu_choose_band
		use_backdrop = 0
		Menu_pos = <Menu_pos>
		Spacing = -9
		focus_color = lt_violet_grey
		unfocus_color = dark_red2
	}
	create_menu_backdrop \{texture = Venue_BG}
	rotation_angle = -2
	SetScreenElementProps \{Id = scrolling_choose_band}
	SetScreenElementProps \{Id = vmenu_choose_band
		internal_just = [
			Center
			Top
		]
		Dims = (650.0, 365.0)}
	CreateScreenElement \{Type = ContainerElement
		Id = cb_helper_container
		PARENT = root_window
		Pos = (0.0, 0.0)}
	CreateScreenElement {
		Type = ContainerElement
		PARENT = root_window
		Pos = ($Menu_pos)
		Id = choose_band_header_container
	}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = choose_band_header_container
		Id = big_blue_box
		just = [LEFT Bottom]
		rgba = [30 110 160 0]
		Pos = (-283.0, 165.0)
		Dims = (655.0, 80.0)
		Rot_Angle = <rotation_angle>
	}
	CreateScreenElement \{Type = SpriteElement
		PARENT = cb_helper_container
		Id = light_overlay
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		Dims = (1280.0, 720.0)
		just = [
			Center
			Center
		]
		z_priority = 99}
	CreateScreenElement \{Type = SpriteElement
		PARENT = cb_helper_container
		Id = ticket_image
		texture = band_name_ticket
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		Dims = (1280.0, 720.0)
		just = [
			Center
			Center
		]
		z_priority = 1}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = cb_helper_container
		Id = random_image
		texture = band_name_graphic03
		rgba = [255 255 255 200]
		Pos = (($enter_band_name_big_vals).right_side_img_pos)
		Scale = (($enter_band_name_big_vals).right_side_img_scale)
		relative_scale
		z_priority = 2
	}
	<rand> = 0
	GetRandomValue \{Name = rand
		Integer
		A = 0
		B = 2}
	if (<rand> = 0)
		SetScreenElementProps \{Id = random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{Id = random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{Id = random_image
			texture = band_name_graphic03}
	endif
	CreateScreenElement \{Type = SpriteElement
		PARENT = cb_helper_container
		Id = ticket_overlay
		texture = band_name_ticket_bar_overlay
		rgba = [
			255
			255
			255
			255
		]
		Pos = (734.0, 360.0)
		Dims = (684.0, 680.0)
		just = [
			Center
			Center
		]
		z_priority = 2}
	CreateScreenElement {
		Type = TextElement
		PARENT = big_blue_box
		just = [Center Bottom]
		font = text_a10_Large
		rgba = (($G_menu_colors).dk_violet_grey)
		Text = ($choose_band_text)
		Scale = 1.75
	}
	fit_text_in_rectangle Id = <Id> Dims = (850.0, 200.0) Pos = (330.0, 65.0)
	<cb_hlBar_pos> = [(6.0, 96.0) (6.0, 145.0) (6.0, 204.0) (8.0, 255.0) (9.0, 312.0)]
	<cb_hlBar_dims> = [(656.0, 48.0) (656.0, 58.0) (656.0, 48.0) (654.0, 58.0) (653.0, 54.0)]
	CreateScreenElement {
		Type = SpriteElement
		PARENT = big_blue_box
		texture = White
		rgba = (($G_menu_colors).pink)
		just = [Top LEFT]
		Pos = ((<cb_hlBar_pos>) [0])
		Dims = ((<cb_hlBar_dims>) [0])
		z_priority = 3
		Alpha = 0.8
	}
	<cb_hlBarID> = <Id>
	<loop_count> = 1
	band_index = 1
	begin
	band_name = ($new_band_name)
	get_band_game_mode_name
	FormatText ChecksumName = bandname_id 'band%i_info_%g' I = <band_index> G = <game_mode_name>
	GetGlobalTags <bandname_id> Param = Name
	if NOT (<Name> = "")
		<band_name> = <Name>
	endif
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_choose_band
		font = ($choose_band_menu_font)
		Scale = (1.0, 1.3)
		rgba = ($menu_unfocus_color)
		Text = "PERMADEATH"
		just = [Center Top]
		Rot_Angle = <rotation_angle>
		event_handlers = [
			{Focus retail_menu_focus}
			{Focus SetScreenElementProps Params = {
					Id = <cb_hlBarID>
					Pos = ((<cb_hlBar_pos>) [(<band_index> - 1)])
					Dims = ((<cb_hlBar_dims>) [(<band_index> - 1)])
				}
			}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_choose_band_make_selection Params = {band_index = <band_index>}}
		]
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 500)
		SetScreenElementProps Id = <Id> Scale = (0.9, 1.3)
	elseif (<width> > 300)
		SetScreenElementProps Id = <Id> Scale = (1.1, 1.3)
	else
		SetScreenElementProps Id = <Id> Scale = (1.4, 1.3)
	endif
	<band_index> = (<band_index> + 1)
	repeat <loop_count>
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
		button = Strumbar
		Z = 100}
endscript

script create_manage_band_menu 
	get_band_game_mode_name
	FormatText ChecksumName = bandname_id 'band%i_info_%g' I = ($current_band) G = <game_mode_name>
	GetGlobalTags <bandname_id>
	FormatText TextName = the_bands_name "''%n''" N = <Name>
	new_menu \{scrollid = mb_scroll
		vmenuid = mb_vmenu
		use_backdrop = 0
		Menu_pos = (732.0, 322.0)
		Rot_Angle = -2
		Spacing = 1}
	create_menu_backdrop \{texture = Venue_BG}
	CreateScreenElement \{Type = ContainerElement
		Id = mb_helper_container
		PARENT = root_window
		Pos = (0.0, 0.0)}
	CreateScreenElement \{Type = ContainerElement
		Id = mb_menu_container
		PARENT = mb_vmenu
		Pos = (0.0, 0.0)
		NOT_FOCUSABLE}
	CreateScreenElement \{Type = SpriteElement
		PARENT = mb_helper_container
		Id = light_overlay
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		Dims = (1280.0, 720.0)
		just = [
			Center
			Center
		]
		z_priority = 99}
	CreateScreenElement \{Type = SpriteElement
		PARENT = mb_helper_container
		Id = ticket_image
		texture = band_name_ticket
		rgba = [
			255
			255
			255
			255
		]
		Pos = (640.0, 360.0)
		Dims = (1280.0, 720.0)
		just = [
			Center
			Center
		]
		z_priority = 1}
	CreateScreenElement {
		Type = SpriteElement
		PARENT = mb_helper_container
		Id = mb_random_image
		texture = band_name_graphic03
		rgba = [255 255 255 255]
		Pos = (($enter_band_name_big_vals).right_side_img_pos)
		Scale = (($enter_band_name_big_vals).right_side_img_scale)
		relative_scale
		z_priority = 2
	}
	<rand> = 0
	GetRandomValue \{Name = rand
		Integer
		A = 0
		B = 2}
	if (<rand> = 0)
		SetScreenElementProps \{Id = mb_random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{Id = mb_random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{Id = mb_random_image
			texture = band_name_graphic03}
	endif
	CreateScreenElement \{Type = SpriteElement
		PARENT = mb_helper_container
		Id = ticket_overlay
		texture = band_name_ticket_bar_overlay
		rgba = [
			255
			255
			255
			255
		]
		Pos = (734.0, 360.0)
		Dims = (684.0, 680.0)
		just = [
			Center
			Center
		]
		z_priority = 2}
	<manage_band_pos> = (725.0, 190.0)
	CreateScreenElement {
		Type = TextElement
		PARENT = mb_helper_container
		Pos = <manage_band_pos>
		font = text_a10_Large
		rgba = (($G_menu_colors).dk_violet_grey)
		Text = ($manage_band_text)
		Scale = 1.75
		z_priority = 3
		Rot_Angle = -2
	}
	fit_text_in_rectangle Id = <Id> Dims = (850.0, 200.0) Pos = <manage_band_pos>
	CreateScreenElement {
		Type = TextElement
		PARENT = mb_helper_container
		Pos = (<manage_band_pos> + (0.0, 110.0))
		font = ($choose_band_menu_font)
		rgba = (($G_menu_colors).pink)
		Text = <the_bands_name>
		Scale = (1.75, 1.25)
		z_priority = 3
		Rot_Angle = -2
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 600)
		fit_text_in_rectangle Id = <Id> Dims = (1000.0, 70.0) Pos = (<manage_band_pos> + (0.0, 110.0))
	endif
	<mb_hlBar_pos_1> = (408.0, 385.0)
	<mb_hlBar_pos_2> = (408.0, 441.0)
	<mb_hlBar_dims> = (650.0, 58.0)
	CreateScreenElement {
		Type = SpriteElement
		Id = mb_hlBarID
		PARENT = mb_helper_container
		texture = White
		rgba = (($G_menu_colors).pink)
		just = [Top LEFT]
		Pos = <mb_hlBar_pos_1>
		Dims = <mb_hlBar_dims>
		z_priority = 3
		Rot_Angle = -2
		Alpha = 0.8
	}
	CreateScreenElement {
		Id = mb_rename_band_id
		PARENT = mb_menu_container
		Type = TextElement
		font = ($choose_band_menu_font)
		rgba = ($menu_unfocus_color)
		Text = ($text_button_back)
		just = [Center Top]
	}
	CreateScreenElement {
		PARENT = mb_vmenu
		Type = TextElement
		font = ($choose_band_menu_font)
		Text = ""
		Scale = 1.3
		just = [Center Top]
		event_handlers = [
			{Focus SetScreenElementProps Params = {
					Id = mb_hlBarID
					Pos = <mb_hlBar_pos_1>
				}
			}
			{Focus manage_band_highlighter Params = {Id = mb_rename_band_id SELECT}}
			{unfocus manage_band_highlighter Params = {Id = mb_rename_band_id unselect}}
			{pad_choose menu_manage_band_rename_band}
		]
	}
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
		button = Strumbar
		Z = 100}
endscript

script menu_manage_band_rename_band 
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script issongavailable \{for_bonus = 0}
	if ($coop_dlc_active = 1)
		if (<Song> = paintitblack)
			return \{FALSE}
		endif
	endif
	if ($is_network_game)
		return \{TRUE}
	endif
	if NOT is_song_downloaded song_checksum = <song>
		return \{FALSE}
	endif
	if (<for_bonus> = 1)
		GetGlobalTags <Song> Param = unlocked
	else
		GetGlobalTags <song_checksum> Param = unlocked
	endif
	if (<unlocked> = 1)
		return \{TRUE}
	endif
	return \{FALSE}
endscript

script create_store_menu 
	mark_unsafe_for_shutdown
	SpawnScriptNow \{Menu_Music_On}
	Change \{rich_presence_context = presence_store}
	Change \{soundcheck_in_store = 1}
	Change \{generic_select_monitor_p1_changed = 0}
	if ($store_view_cam_created = 0)
		Change store_saved_guitar_id = ($player1_status.instrument_id)
		get_initial_outfit_reference
		Change StructureName = player1_status style = <reference>
		unload_band
		destroy_bg_viewport
		setup_bg_viewport
		PlayIGCCam \{Name = store_view_cam
			viewport = Bg_Viewport
			ControlScript = store_camera_script
			Play_hold = 1}
		Change \{store_view_cam_created = 1}
	endif
	Change \{target_store_camera_prop = main_store_menu}
	setup_store_hub \{cash_pos = (-2000.0, -2000.0)}
	store_camera_wait
	if NOT ScreenElementExists \{Id = store_container}
		return
	endif
	SetScreenElementProps \{Id = store_cash_text
		Pos = (892.0, 517.0)}
	hilite_pos = [
		(897.0, 170.0)
		(897.0, 215.0)
		(897.0, 260.0)
		(897.0, 305.0)
		(897.0, 350.0)
		(897.0, 395.0)
		(897.0, 440.0)
		(897.0, 485.0)
	]
	create_store_window_frame Pos = (900.0, 360.0) hilite_pos = (<hilite_pos> [0]) Dims = (300.0, 512.0) hilite_dims = (290.0, 40.0)
	back_handlers = [
		{pad_up generic_menu_up_or_down_sound Params = {UP}}
		{pad_down generic_menu_up_or_down_sound Params = {DOWN}}
		{pad_back menu_store_go_back}
	]
	new_menu {
		scrollid = ms_scroll
		vmenuid = ms_vmenu
		Menu_pos = (897.0, 180.0)
		event_handlers = <back_handlers>
		Z = 50
		focus_color = pink
		unfocus_color = dk_violet_grey
	}
	<text_x_scale> = 1.0
	<text_y_scale> = 1.0
	text_params = {
		Type = TextElement
		font = ($store_menu_font)
		Scale = ((<text_x_scale> * (1.0, 0.0)) + (<text_y_scale> * (0.0, 1.0)))
		rgba = ($menu_unfocus_color)
		no_shadow
	}
	<menu_offset> = (0.0, 45.0)
	CreateScreenElement {
		Type = ContainerElement
		Id = store_guitars
		PARENT = ms_vmenu
		event_handlers = [
			{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [0]) option = 'guitars'}}
			{unfocus menu_store_unfocus Params = {option = 'guitars'}}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = select_guitars}}
			{pad_L3 store_debug_givebandcash}
			{PAD_LEFT store_debug_givebandcash}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = store_guitars
		Id = store_guitars_text
		Text = ($store_guitars_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = store_finishes
		PARENT = ms_vmenu
		event_handlers = [
			{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [1]) option = 'finishes'}}
			{unfocus menu_store_unfocus Params = {option = 'finishes'}}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = select_finishes}}
			{pad_L3 store_debug_givebandcash}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = store_finishes
		Id = store_finishes_text
		Pos = (<menu_offset>)
		Text = ($store_finishes_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = store_songs
		PARENT = ms_vmenu
		event_handlers = [
			{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [2]) option = 'songs'}}
			{unfocus menu_store_unfocus Params = {option = 'songs'}}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = select_songs}}
			{pad_L3 store_debug_givebandcash}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = store_songs
		Id = store_songs_text
		Pos = (<menu_offset> * 2)
		Text = ($store_songs_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = store_characters
		PARENT = ms_vmenu
		event_handlers = [
			{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [3]) option = 'characters'}}
			{unfocus menu_store_unfocus Params = {option = 'characters'}}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = select_characters}}
			{pad_L3 store_debug_givebandcash}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = store_characters
		Id = store_characters_text
		Pos = (<menu_offset> * 3)
		Text = ($store_characters_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = store_outfits
		PARENT = ms_vmenu
		event_handlers = [
			{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [4]) option = 'outfits'}}
			{unfocus menu_store_unfocus Params = {option = 'outfits'}}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = select_outfits}}
			{pad_L3 store_debug_givebandcash}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = store_outfits
		Id = store_outfits_text
		Pos = (<menu_offset> * 4)
		Text = ($store_outfits_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	CreateScreenElement {
		Type = ContainerElement
		Id = store_styles
		PARENT = ms_vmenu
		event_handlers = [
			{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [5]) option = 'styles'}}
			{unfocus menu_store_unfocus Params = {option = 'styles'}}
			{pad_choose ui_flow_manager_respond_to_action Params = {action = select_styles}}
			{pad_L3 store_debug_givebandcash}
		]
	}
	CreateScreenElement {
		<text_params>
		PARENT = store_styles
		Id = store_styles_text
		Pos = (<menu_offset> * 5)
		Text = ($store_styles_text)
	}
	GetScreenElementDims Id = <Id>
	fit_text_in_rectangle {
		Id = <Id>
		Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
		only_if_larger_x = 1
		start_x_scale = <text_x_scale>
		start_y_scale = <text_y_scale>
	}
	last_hilite_index = 7
	GetPlatform
	show_videos = 1
	if NOT English
		if (<Platform> = PS2 || <Platform> = PS3)
			<show_videos> = 0
		endif
	endif
	if (<show_videos> = 1)
		CreateScreenElement {
			Type = ContainerElement
			Id = store_videos
			PARENT = ms_vmenu
			event_handlers = [
				{Focus menu_store_focus Params = {hilite_pos = (<hilite_pos> [6]) option = 'videos'}}
				{unfocus menu_store_unfocus Params = {option = 'videos'}}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_videos}}
				{pad_L3 store_debug_givebandcash}
			]
		}
		CreateScreenElement {
			<text_params>
			PARENT = store_videos
			Id = store_videos_text
			Pos = (<menu_offset> * 6)
			Text = ($store_videos_text)
		}
		GetScreenElementDims Id = <Id>
		fit_text_in_rectangle {
			Id = <Id>
			Dims = ((<Height> * (0.0, 1.0)) + (250.0, 0.0))
			only_if_larger_x = 1
			start_x_scale = <text_x_scale>
			start_y_scale = <text_y_scale>
		}
	else
		<last_hilite_index> = 6
	endif
	clean_up_user_control_helpers
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
		button = Strumbar
		Z = 100}
	mark_safe_for_shutdown
endscript

script Progression_TierComplete 
	Printf \{"Progression_TierComplete"}
	if GotParam \{Bonus}
		get_progression_globals game_mode = ($game_mode) Bonus
	else
		get_progression_globals game_mode = ($game_mode)
	endif
	setlist_prefix = ($<tier_global>.prefix)
	FormatText ChecksumName = tiername '%ptier%i' P = <setlist_prefix> I = <Tier>
	SetGlobalTags <tiername> Params = {Complete = 1}
	if GotParam \{finished_game}
		Printf \{"FINISHED GAME"}
		Change \{end_credits = 0}
		if NOT ($progression_beat_game_last_song = 1)
			FormatText \{ChecksumName = bonus_song_checksum
				'%p_song%i_tier%s'
				P = 'bonus'
				I = 3
				S = 1}
			SetGlobalTags <bonus_song_checksum> Params = {unlocked = 1}
			SetGlobalTags ($GH3_Bonus_Songs.tier1.songs [2]) Params = {unlocked = 1}
		endif
		Change \{progression_beat_game_last_song = 1}
		get_difficulty_text_nl DIFFICULTY = ($current_difficulty)
		FormatText ChecksumName = gametype_checksum '%p_%s' P = <setlist_prefix> S = <difficulty_text_nl>
		SetGlobalTags <gametype_checksum> Params = {Complete = 1}
		if ($game_mode = p1_career)
			FormatText ChecksumName = bandname_id 'band%i_info_%g' I = ($current_band) G = 'p1_career'
			FormatText ChecksumName = hendrix_checksum 'hendrix_achievement_%s' S = <difficulty_text_nl>
			GetGlobalTags <bandname_id> Param = <hendrix_checksum>
			if ((<...>.<hendrix_checksum>) = 0)
				SetGlobalTags \{achievement_info
					Params = {
						hendrix_achievement_lefty_off = 1
					}}
			elseif ((<...>.<hendrix_checksum>) = 1)
				SetGlobalTags \{achievement_info
					Params = {
						hendrix_achievement_lefty_on = 1
					}}
			endif
			if ($current_difficulty = HARD || $current_difficulty = EXPERT)
				if NOT IsGuitarController controller = ($player1_status.controller)
					WriteAchievements \{Achievement = BUY_A_GUITAR_ALREADY}
				endif
			endif
		endif
	elseif GotParam \{Bonus}
		get_difficulty_text_nl DIFFICULTY = ($current_difficulty)
		FormatText ChecksumName = gametype_checksum '%p_%s' P = <setlist_prefix> S = <difficulty_text_nl>
		SetGlobalTags <gametype_checksum> Params = {Complete = 1}
	else
		Tier = (<Tier> + 1)
		Progression_UnlockTier Tier = <Tier>
		FormatText ChecksumName = tiername 'tier%i' I = <Tier>
		Progression_UnlockVenue level_checksum = ($<tier_global>.<tiername>.Level)
	endif
	update_coop_progression
endscript

