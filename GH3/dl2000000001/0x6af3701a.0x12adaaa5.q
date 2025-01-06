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
permadeath_current_song_count = 0
ttfaf_money = 3722000

script create_fail_song_menu 
	change permadeath_lives = ($permadeath_lives - 1)
	calculate_max_streak_song
	if ($permadeath_lives > 0)
		fail_song_menu_select_new_song
	else
		change permadeath_lives = 3
		change permadeath_fails = ($permadeath_fails + 1)
		handle_signin_changed
	endif
endscript

max_streaks = { 

}

songs_fcd = [
]

script calculate_max_streak_song 
	p1_note_streak = ($player1_status.best_run)
	song_checksum = ($current_song)
	max_streak_temp = ($max_streaks)
	if StructureContains structure = <max_streak_temp> <song_checksum>
		if ((<max_streak_temp>.<song_checksum>) < <p1_note_streak>)
			AddParam name = <song_checksum> structure_name = max_streak_temp value = <p1_note_streak>
		endif
	else
		AddParam name = <song_checksum> structure_name = max_streak_temp value = <p1_note_streak>
	endif
	change max_streaks = <max_streak_temp>
endscript

script calculate_max_streak_total
	GetArraySize \{$gh3_songlist}
	streak_count = 0
	fc_count = 0
	i = 0
	begin
	get_songlist_checksum index = <i>
	get_song_struct song = <song_checksum>
	if NOT StructureContains structure = <song_struct> boss
		get_difficulty_text_nl { difficulty = ($current_difficulty) }
		get_song_prefix song = <song_checksum>
		FormatText checksumname = songname '%s_%d' s = <song_prefix> d = <difficulty_text_nl>
		GetGlobalTags <songname>
		if (<achievement_gold_star> = 1)
			fc_count = (<fc_count> + 1)
		endif
		if StructureContains structure = $max_streaks <song_checksum>
			<streak_count> = (<streak_count> + ($max_streaks.<song_checksum>))
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	change permadeath_max_streak = <streak_count>
	if (($permadeath_max_song_count) < <fc_count>)
		change permadeath_max_song_count = <fc_count>
	endif
	change permadeath_current_song_count = <fc_count>
endscript

script set_song_icon 
	if NOT GotParam \{no_wait}
		wait \{0.5
			seconds}
	endif
	if NOT GotParam \{song}
		<song> = ($target_setlist_songpreview)
	endif
	if (<song> = None && $current_tab = tab_setlist)
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
		text_option2 = $permadeath_stat_full_big
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
	tabs_text = ["setlist" "bonus" "statistics"]
	SetArrayElement arrayName = tabs_text index = 0 newValue = ($sl_setlist_tab)
	SetArrayElement arrayName = tabs_text index = 1 newValue = ($sl_bonus_tab)
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
	displayText parent = setlist_menu Scale = 1 text = (<buttons_text> [<i>]) rgba = [128 128 128 255] Pos = <button_text_pos> z = 50 font = buttonsxenon
	tab_text_pos = (<setlist_text_positions> [<i>])
	if ($current_tab = tab_downloads)
		<tab_text_pos> = (<download_text_positions> [<i>])
		FormatText textname = text ($permadeath_attempt_stat) i = ($permadeath_fails + 1)
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (330.0, 360.0) z = 50
		FormatText textname = text ($permadeath_max_streak_stat) i = $permadeath_max_streak usecommas
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (330.0, 400.0) z = 50
		FormatText textname = text ($permadeath_max_fc_count_stat) i = $permadeath_max_song_count
		displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (330.0, 440.0) z = 50
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

script create_sl_assets 
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = setlist_menu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
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
		BlendMode = subtract}
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
	displaySprite parent = setlist_menu tex = <Line> Pos = <solid_line_pos> dims = (883.0, 16.0) z = ($setlist_page1_z + 0.1)
	repeat 8
	begin
	<Line> = Random (@ ($setlist_dotted_lines [0]) @ ($setlist_dotted_lines [1]) @ ($setlist_dotted_lines [2]) )
	<dotted_line_pos> = (<dotted_line_pos> + <dotted_line_add>)
	displaySprite parent = setlist_menu tex = <Line> Pos = <dotted_line_pos> dims = (883.0, 16.0) z = ($setlist_page1_z + 0.1)
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
		displaySprite id = sl_page1_title parent = setlist_menu tex = <setlist_header_tex> Pos = (330.0, 220.0) dims = (512.0, 128.0) alpha = 0.7 z = ($setlist_page1_z + 0.2) rot_angle = 0
		displaySprite parent = sl_page1_title tex = <setlist_header_tex> Pos = (-5.0, 10.0) dims = (512.0, 128.0) alpha = 0.2 z = ($setlist_page1_z + 0.2) rot_angle = -2
		GetUpperCaseString ($g_gh3_setlist.tier1.Title)
		displayText id = sl_text_1 parent = setlist_menu Scale = (1.0, 1.0) text = <uppercasestring> rgba = [195 80 45 255] Pos = <title_pos> z = $setlist_text_z noshadow
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
		displayText \{parent = setlist_menu
			id = sl_text_1
			text = "BONUS SONGS"
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
				displayText parent = setlist_menu Scale = (1.0, 1.0) text = <uppercasestring> rgba = [190 75 40 255] Pos = <text_pos> z = $setlist_text_z noshadow
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
						rgba = [50 30 10 255]
						z_priority = $setlist_text_z
						font = text_a5
						just = [left top]
						font_spacing = 0.5
						no_shadow
						shadow_offs = (1.0, 1.0)
						shadow_rgba = [0 0 0 255]
					}
					get_difficulty_text_nl difficulty = ($current_difficulty)
					get_song_prefix song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
					FormatText checksumname = songname '%s_%d' s = <song_prefix> d = <difficulty_text_nl>
					GetGlobalTags <song_checksum>
					GetGlobalTags <songname>
					if ($game_mode = p1_quickplay)
						get_quickplay_song_stars song = <song_prefix>
					endif
					if NOT ($game_mode = training || $game_mode = p2_faceoff || $game_mode = p2_pro_faceoff || $game_mode = p2_battle)
						if Progression_IsBossSong tier_global = $g_gh3_setlist tier = <tier> song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
							stars = 0
						endif
						if ($game_mode = p1_quickplay)
							GetGlobalTags <songname> param = percent100
						else
							GetGlobalTags <song_checksum> param = percent100
						endif
						if (<stars> > 2)
							<star_space> = (20.0, 0.0)
							<star_pos> = (<text_pos> + (660.0, 0.0))
							begin
							if (<percent100> = 1)
								<star> = Setlist_Goldstar
							else
								<star> = Random (@ ($setlist_loop_stars [0]) @ ($setlist_loop_stars [1]) @ ($setlist_loop_stars [2]) )
							endif
							<star_pos> = (<star_pos> - <star_space>)
							displaySprite parent = setlist_menu tex = <star> rgba = [233 205 166 255] z = $setlist_text_z Pos = <star_pos>
							repeat <stars>
						endif
						GetGlobalTags <song_checksum> param = Score
						if ($game_mode = p1_quickplay)
							get_quickplay_song_score song = <song_prefix>
						endif
						if (<Score> > 0)
							if Progression_IsBossSong tier_global = $g_gh3_setlist tier = <tier> song = ($g_gh3_setlist.<tier_checksum>.songs [<song_count>])
								if (<Score> = 1)
									FormatText \{textname = score_text
										"WUSSED OUT"}
								else
									FormatText \{textname = score_text
										"BATTLE WON"}
								endif
							else
								FormatText textname = score_text "%d" d = <Score> usecommas
							endif
							<score_pos> = (<text_pos> + (660.0, 40.0))
							CreateScreenElement {
								type = TextElement
								parent = setlist_menu
								Scale = (0.75, 0.75)
								text = <score_text>
								Pos = <score_pos>
								rgba = [100 120 160 255]
								z_priority = $setlist_text_z
								font = text_a5
								just = [RIGHT top]
								noshadow
							}
						endif
					endif
					<text_pos> = (<text_pos> + (60.0, 40.0))
					FormatText \{checksumname = artistid
						'artist_id%d'
						d = $setlist_num_songs}
					GetUpperCaseString <song_artist>
					song_artist = <uppercasestring>
					displayText parent = setlist_menu Scale = (0.6, 0.6) id = <artistid> text = <song_artist> rgba = [60 100 140 255] Pos = <text_pos> z = $setlist_text_z font_spacing = 1 noshadow
					<text_pos> = (<text_pos> + (-60.0, 40.0))
					change setlist_num_songs = ($setlist_num_songs + 1)
					num_songs_unlocked = (<num_songs_unlocked> + 1)
					change \{we_have_songs = TRUE}
				endif
				song_count = (<song_count> + 1)
				repeat <num_songs>
			endif
			if ((($game_mode = p1_career) || ($game_mode = p2_career)) && (GotParam tab_setlist) && $is_demo_mode = 0)
				GetGlobalTags <tiername> param = complete
				if (<complete> = 0)
					GetGlobalTags <tiername> param = boss_unlocked
					GetGlobalTags <tiername> param = encore_unlocked
					if (<encore_unlocked> = 1)
						FormatText \{textname = completeText
							"Beat encore song to continue"}
					elseif (<boss_unlocked> = 1)
						FormatText \{textname = completeText
							"Beat boss song to continue"}
					else
						GetGlobalTags <tiername> param = num_songs_to_progress
						FormatText textname = completeText "Beat %d of %p songs to continue" d = <num_songs_to_progress> p = <num_songs_unlocked>
					endif
					displayText parent = setlist_menu Scale = (0.6, 0.6) text = <completeText> Pos = (<text_pos> + (160.0, 0.0)) z = $setlist_text_z rgba = [30 30 30 255] noshadow
				endif
			endif
		endif
		repeat <num_tiers>
	endif
	if ((($game_mode = p1_career) || ($game_mode = p2_career)) && $is_demo_mode = 0 && (not ($current_tab = tab_downloads)))
		get_progression_globals game_mode = ($game_mode)
		summation_career_score tier_global = <tier_global>
		FormatText textname = total_score_text "Career Score: %d" d = <career_score> usecommas
		displayText {
			parent = setlist_menu
			Scale = 0.7
			text = <total_score_text>
			Pos = ((640.0, 120.0) + (<text_pos>.(0.0, 1.0) * (0.0, 1.0)))
			just = [center top]
			z = $setlist_text_z
			rgba = [30 30 30 255]
			noshadow
		}
	endif
	change \{setlist_begin_text = $setlist_menu_pos}
	if ($setlist_num_songs > 0)
		retail_menu_focus \{id = id_song0}
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
	if ($current_tab = tab_downloads)
		if ScreenElementExists \{sl_clipart}
			DestroyScreenElement \{sl_clipart}
		endif
		if ScreenElementExists \{sl_clipart_shadow}
			DestroyScreenElement \{sl_clipart_shadow}
		endif
		if ScreenElementExists \{sl_clip}
			DestroyScreenElement \{sl_clip}
		endif
	else
		<clip_pos> = (160.0, 390.0)
		displaySprite id = sl_clipart parent = sl_fixed Pos = <clip_pos> dims = (160.0, 160.0) z = ($setlist_text_z + 0.1) rgba = [200 200 200 255]
		displaySprite id = sl_clipart_shadow parent = sl_fixed Pos = (<clip_pos> + (3.0, 3.0)) dims = (160.0, 160.0) z = ($setlist_text_z) rgba = [0 0 0 128]
		<clip_pos> = (<clip_pos> + (15.0, 50.0))
		displaySprite id = sl_clip parent = sl_fixed tex = Setlist_Clip just = [-0.5 -0.9] Pos = <clip_pos> dims = (141.0, 102.0) z = ($setlist_text_z + 0.2)
	endif
	if ($current_tab = tab_setlist)
		hilite_dims = (737.0, 80.0)

	elseif ($current_tab = tab_bonus)
		hilite_dims = (690.0, 80.0)
	endif
	displaySprite id = sl_highlight parent = sl_fixed tex = white Pos = (326.0, 428.0) dims = <hilite_dims> z = ($setlist_text_z - 0.1) rgba = [255 255 255 128]
	<bg_helper_pos> = (140.0, 585.0)
	<helper_rgba> = [105 65 7 160]
	change \{user_control_pill_gap = 100}
	if ($current_tab = tab_setlist)
		setlist_show_helperbar Pos = (<bg_helper_pos> + (64.0, 4.0))
	elseif ($current_tab = tab_bonus)
		GetUpperCaseString ($sl_setlist_tab)
		setlist_show_helperbar {
			Pos = (<bg_helper_pos> + (64.0, 4.0))
			text_option1 = <uppercasestring>
			text_option2 = ($permadeath_stat_full_big)
			button_option1 = "\\b6"
			button_option2 = "\\b8"
		}
	else
		GetUpperCaseString ($sl_setlist_tab)
		sl_text_big = <uppercasestring>
		GetUpperCaseString ($sl_bonus_tab)
		bonus_big = <uppercasestring>
		setlist_show_helperbar {
			Pos = (<bg_helper_pos> + (64.0, 4.0))
			text_option1 = <sl_text_big>
			text_option2 = <bonus_big>
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
			text = $i_covered_by_text
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

script create_using_guitar_controller_menu 
	handle_signin_changed
endscript

script memcard_save_file \{overwriteconfirmed = 0}
	memcard_sequence_quit
endscript

script destroy_download_scan_menu 
	destroy_popup_warning_menu
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
		text = ($mm_career_text)
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
		text = ($mm_coop_career_text)
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
		text = ($mm_quickplay_text)
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
		text = ($mm_multiplayer_text)
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
		text = ($mm_training_text)
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
			text = ($mm_online_text)
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
		text = ($mm_options_text)
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
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_updown
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
			add_user_control_helper \{text = $text_button_select
				button = green
				z = 100000}
			add_user_control_helper \{text = $text_button_updown
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
			add_user_control_helper \{text = $text_button_select
				button = green
				z = 100000}
			add_user_control_helper \{text = $text_button_updown
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
		add_user_control_helper \{text = $text_button_select
			button = green
			z = 100000}
		add_user_control_helper \{text = $text_button_back
			button = red
			z = 100000}
		add_user_control_helper \{text = $text_button_updown
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
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
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
		text = ($permadeath_lives_screen_title)
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
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
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
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
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

script set_store_purchase_price \{price = 0}
	if ScreenElementExists \{id = store_price_tag_text}
		FormatText textname = price_text "$%d" d = (<price>) usecommas
		store_price_tag_text :setprops text = <price_text>
		store_price_tag_text :settags tag_price = <price>
		SetScreenElementProps \{id = store_price_tag_text
			Scale = 1}
		fit_text_in_rectangle \{id = store_price_tag_text
			dims = (150.0, 90.0)}
	endif
endscript

store_song_data = {
	avalancha = {
		price = 500
	}
	bellyofashark = {
		price = 500
	}
	cantbesaved = {
		price = 500
	}
	citiesonflame = {
		price = 500
	}
	closer = {
		price = 500
	}
	dontholdback = {
		price = 500
	}
	downndirty = {
		price = 500
	}
	fcpremix = {
		price = 500
	}
	generationrock = {
		price = 500
	}
	gothatfar = {
		price = 500
	}
	helicopter = {
		price = 500
	}
	hierkommtalex = {
		price = 500
	}
	imintheband = {
		price = 500
	}
	impulse = {
		price = 500
	}
	inlove = {
		price = 500
	}
	mauvaisgarcon = {
		price = 500
	}
	metalheavylady = {
		price = 500
	}
	minuscelsius = {
		price = 500
	}
	monsters = {
		price = 500
	}
	mycurse = {
		price = 500
	}
	nothingformehere = {
		price = 500
	}
	prayeroftherefugee = {
		price = 500
	}
	radiosong = {
		price = 500
	}
	reptilia = {
		price = 500
	}
	ruby = {
		price = 500
	}
	sabotage = {
		price = 500
	}
	shebangsadrum = {
		price = 500
	}
	suckmykiss = {
		price = 500
	}
	takethislife = {
		price = 500
	}
	thewayitends = {
		price = 500
	}
	thrufireandflames = {
		price = $ttfaf_money
	}
}
Bonus_Songs_Info = [
	{
		item = avalancha
		text = $avalancha_store_text
		album_cover = HeroesDelSilencioAvalancha
	}
	{
		item = bellyofashark
		text = $bellyofashark_store_text
		album_cover = store_song_default
	}
	{
		item = cantbesaved
		text = $cantbesaved_store_text
		album_cover = SensesFailStillSearching
	}
	{
		item = citiesonflame
		text = $citiesonflame_store_text
		album_cover = store_song_default
	}
	{
		item = closer
		text = $closer_store_text
		album_cover = LacunaCoilKarmaCode
	}
	{
		item = dontholdback
		text = $dontholdback_store_text
		album_cover = TheSleepingQuestionsAndAnswers
	}
	{
		item = downndirty
		text = $downndirty_store_text
		album_cover = store_song_default
	}
	{
		item = fcpremix
		text = $fcpremix_store_text
		album_cover = FallofTroyDoppelganger
	}
	{
		item = generationrock
		text = $generationrock_store_text
		album_cover = RevolverheldRevolverheld
	}
	{
		item = gothatfar
		text = $gothatfar_store_text
		album_cover = BretMichealsBandGoThatFar
	}
	{
		item = helicopter
		text = $helicopter_store_text
		album_cover = store_song_default
	}
	{
		item = hierkommtalex
		text = $hierkommtalex_store_text
		album_cover = store_song_default
	}
	{
		item = imintheband
		text = $imintheband_store_text
		album_cover = store_song_default
	}
	{
		item = impulse
		text = $impulse_store_text
		album_cover = endlesssporadic
	}
	{
		item = inlove
		text = $inlove_store_text
		album_cover = store_song_ScoutsStSebastian
	}
	{
		item = mauvaisgarcon
		text = $mauvaisgarcon_store_text
		album_cover = NaastAntichambre
	}
	{
		item = metalheavylady
		text = $metalheavylady_store_text
		album_cover = LionsLions
	}
	{
		item = minuscelsius
		text = $minuscelsius_store_text
		album_cover = BackyardBabiesStockholmSyndrome
	}
	{
		item = monsters
		text = $monsters_store_text
		album_cover = store_song_default
	}
	{
		item = mycurse
		text = $mycurse_store_text
		album_cover = KillswitchEngageAsDaylightDies
	}
	{
		item = nothingformehere
		text = $nothingformehere_store_text
		album_cover = Dope_PosterCover_edsel
	}
	{
		item = prayeroftherefugee
		text = $prayeroftherefugee_store_text
		album_cover = RiseAgainstTheSuffererAndTheWitness
	}
	{
		item = radiosong
		text = $radiosong_store_text
		album_cover = SuperbusPopnGum
	}
	{
		item = reptilia
		text = $reptilia_store_text
		album_cover = store_song_default
	}
	{
		item = ruby
		text = $ruby_store_text
		album_cover = KaiserChiefsYoursTrulyAngry_Mob
	}
	{
		item = sabotage
		text = $sabotage_store_text
		album_cover = store_song_default
	}
	{
		item = shebangsadrum
		text = $shebangsadrum_store_text
		album_cover = StoneRosesStoneRoses
	}
	{
		item = suckmykiss
		text = $suckmykiss_store_text
		album_cover = store_song_default
	}
	{
		item = takethislife
		text = $takethislife_store_text
		album_cover = InFlamesComeClarity
	}
	{
		item = thewayitends
		text = $thewayitends_store_text
		album_cover = prototype_continuum_cover
	}
	{
		item = thrufireandflames
		text = $thrufireandflames_store_text
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
		text = ($store_guitars_text)
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
		text = ($store_finishes_text)
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
		text = ($store_songs_text)
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
		text = ($store_characters_text)
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
		text = ($store_outfits_text)
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
		text = ($store_styles_text)
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
			text = ($store_videos_text)
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
			text = ($awesomeness_detection)
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
	add_user_control_helper \{text = $text_button_select
		button = green
		z = 100}
	add_user_control_helper \{text = $text_button_back
		button = red
		z = 100}
	add_user_control_helper \{text = $text_button_updown
		button = strumbar
		z = 100}
	mark_safe_for_shutdown
endscript

script ShowTTFAFcash
	FormatText textname = text ($ttfaf_money_earned) i = $ttfaf_money usecommas
	FormatText \{checksumname = ttfaf_unlocked
		'ttfaf_unlocked'}
	if ScreenElementExists id = <ttfaf_unlocked>
		DestroyScreenElement id = <ttfaf_unlocked>
	endif
	CreateScreenElement {
		type = TextElement
		id = <ttfaf_unlocked>
		parent = yourock_text
		Pos = (634.0, 620.0)
		text = <text>
		font = text_a11
		Scale = 0.8
		rgba = [255 255 255 255]
		just = [center bottom]
		z_priority = 500
		shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [0 0 0 255]
	}
	wait \{3
		seconds}
	if ScreenElementExists id = <ttfaf_unlocked>
		DoScreenElementMorph {
			id = <ttfaf_unlocked>
			alpha = 0
			time = 1
		}
	wait \{1
		second}
	DestroyScreenElement id = <ttfaf_unlocked>
	endif
endscript

script EarnTtfafMoney
	get_current_band_info
	GetGlobalTags <band_info>
	<cash> = (<cash> + ($ttfaf_money))
	SetGlobalTags <band_info> params = {cash = <cash>}
	spawnscriptnow \{ShowTTFAFcash}
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
			if NOT ($progression_beat_game_last_song = 1)
				if ($current_song = bossdevil)
					EarnTtfafMoney
				endif
			endif
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

battle_explanation_text = {
	bossslash = {
		image = battle_help_boss_bg_slash
		Title = $slash_battle_title_text
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
	bosstom = {
		image = battle_help_boss_bg_morello
		Title = $morello_battle_title_text
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
	bossdevil = {
		image = battle_help_boss_bg_satan
		Title = $lou_battle_title_text
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
