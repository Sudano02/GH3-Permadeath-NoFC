main_menu_fs = {
	Create = create_main_menu
	destroy = destroy_main_menu
	actions = [
		{
			action = select_career
			flow_state_func = main_menu_career_flow_state_func
			transition_right
		}
		{
			action = select_coop_career
			flow_state = coop_career_select_controllers_fs
			transition_right
		}
		{
			action = select_quickplay
			flow_state = quickplay_select_difficulty_fs
			transition_right
		}
		{
			action = select_multiplayer
			flow_state = mp_select_controller_fs
			transition_right
		}
		{
			action = select_xbox_live
			flow_state = randomize_warning_fs
		}
		{
			action = select_options
			flow_state = options_select_option_fs
			transition_right
		}
		{
			action = select_training
			flow_state = practice_select_mode_fs
			transition_right
		}
		{
			action = select_debug_menu
			flow_state = debug_menu_fs
		}
	]
}

script setlist_scroll \{dir = down}
	if ($setlist_num_songs = 0)
		return
	endif
	if (<dir> = down)
		if ($setlist_selection_index + 1 = $setlist_num_songs)
			return
		endif
	else
		if ($setlist_selection_index - 1 < 0)
			return
		endif
	endif
	generic_menu_up_or_down_sound <dir>
	FormatText \{checksumname = textid
		'id_song%i'
		i = $setlist_selection_index
		addtostringlookup = TRUE}
	retail_menu_unfocus id = <textid>
	SetScreenElementProps id = <textid> no_shadow
	if (<dir> = down)
		jump_tier = 0
		change setlist_selection_index = ($setlist_selection_index + 1)
		setlist_prefix = ($g_gh3_setlist.prefix)
		begin
		FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = $setlist_selection_tier
		FormatText \{checksumname = tier_checksum
			'tier%s'
			s = $setlist_selection_tier}
		GetArraySize ($g_gh3_setlist.<tier_checksum>.songs)
		change setlist_selection_song = ($setlist_selection_song + 1)
		if ($setlist_selection_song = <array_size>)
			change \{setlist_selection_song = 0}
			change setlist_selection_tier = ($setlist_selection_tier + 1)
			jump_tier = 1
		endif
		FormatText checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = ($setlist_selection_song + 1) s = $setlist_selection_tier addtostringlookup = TRUE
		for_bonus = 0
		if ($current_tab = tab_bonus)
			<for_bonus> = 1
		endif
		if issongavailable song_checksum = <song_checksum> song = ($g_gh3_setlist.<tier_checksum>.songs [$setlist_selection_song]) for_bonus = <for_bonus>
			break
		endif
		repeat
		jump_tier_amt = (0.0, -240.0)
		if ($setlist_selection_index = 1)
			song_jump_amt = (0.0, -160.0)
			GetScreenElementProps \{id = sl_clipart}
			SetScreenElementProps id = sl_clipart Pos = (<Pos> - (0.0, 80.0))
			GetScreenElementProps \{id = sl_clipart_shadow}
			SetScreenElementProps id = sl_clipart_shadow Pos = (<Pos> - (0.0, 80.0))
			GetScreenElementProps \{id = sl_clip}
			SetScreenElementProps id = sl_clip Pos = (<Pos> - (0.0, 80.0))
			GetScreenElementProps \{id = sl_highlight}
			SetScreenElementProps id = sl_highlight Pos = (<Pos> - (0.0, 80.0))
		else
			song_jump_amt = (0.0, -80.0)
		endif
	else
		jump_tier = 0
		change setlist_selection_index = ($setlist_selection_index - 1)
		setlist_prefix = ($g_gh3_setlist.prefix)
		begin
		FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = $setlist_selection_tier
		FormatText \{checksumname = tier_checksum
			'tier%s'
			s = $setlist_selection_tier}
		GetArraySize ($g_gh3_setlist.<tier_checksum>.songs)
		change setlist_selection_song = ($setlist_selection_song - 1)
		if ($setlist_selection_song = -1)
			change setlist_selection_tier = ($setlist_selection_tier - 1)
			FormatText checksumname = tiername '%ptier%i' p = <setlist_prefix> i = $setlist_selection_tier
			FormatText \{checksumname = tier_checksum
				'tier%s'
				s = $setlist_selection_tier}
			GetArraySize ($g_gh3_setlist.<tier_checksum>.songs)
			change setlist_selection_song = (<array_size> - 1)
			jump_tier = 1
		endif
		FormatText checksumname = song_checksum '%p_song%i_tier%s' p = <setlist_prefix> i = ($setlist_selection_song + 1) s = $setlist_selection_tier addtostringlookup = TRUE
		for_bonus = 0
		if ($current_tab = tab_bonus)
			<for_bonus> = 1
		endif
		if issongavailable song_checksum = <song_checksum> song = ($g_gh3_setlist.<tier_checksum>.songs [$setlist_selection_song]) for_bonus = <for_bonus>
			break
		endif
		repeat
		jump_tier_amt = (0.0, 240.0)
		if ($setlist_selection_index = 0)
			song_jump_amt = (0.0, 160.0)
			GetScreenElementProps \{id = sl_clipart}
			SetScreenElementProps id = sl_clipart Pos = (<Pos> + (0.0, 80.0))
			GetScreenElementProps \{id = sl_clipart_shadow}
			SetScreenElementProps id = sl_clipart_shadow Pos = (<Pos> + (0.0, 80.0))
			GetScreenElementProps \{id = sl_clip}
			SetScreenElementProps id = sl_clip Pos = (<Pos> + (0.0, 80.0))
			GetScreenElementProps \{id = sl_highlight}
			SetScreenElementProps id = sl_highlight Pos = (<Pos> + (0.0, 80.0))
		else
			song_jump_amt = (0.0, 80.0)
		endif
	endif
	FormatText \{checksumname = tier_checksum
		'tier%s'
		s = $setlist_selection_tier}
	song = ($g_gh3_setlist.<tier_checksum>.songs [$setlist_selection_song])
	get_song_formatted song_checksum = <song>
	GetGlobalTags <songname>
	if (<achievement_gold_star> = 1 || ($randomizer_toggle = 0) || ($current_tab = tab_bonus))
		change target_setlist_songpreview = <song>
	else
		change target_setlist_songpreview = None
	endif
	clear_setlist_clip_and_art
	KillSpawnedScript \{name = set_song_icon}
	spawnscriptnow \{set_song_icon}
	FormatText \{checksumname = textid
		'id_song%i'
		i = $setlist_selection_index
		addtostringlookup = TRUE}
	retail_menu_focus id = <textid>
	SetScreenElementProps id = <textid> shadow
	<not_header> = 1
	if ($current_tab = tab_setlist)
		if (<jump_tier> = 1)
			change setlist_begin_text = ($setlist_begin_text + <jump_tier_amt>)
			SetScreenElementProps \{id = scrolling_setlist
				Pos = $setlist_begin_text}
			change setlist_background_pos = ($setlist_background_pos + <jump_tier_amt>)
			<not_header> = 0
		endif
	endif
	if (<not_header>)
		change setlist_begin_text = ($setlist_begin_text + <song_jump_amt>)
		SetScreenElementProps \{id = scrolling_setlist
			Pos = $setlist_begin_text}
		change setlist_background_pos = ($setlist_background_pos + <song_jump_amt>)
	endif
	SetScreenElementProps \{id = setlist_menu
		Pos = $setlist_background_pos}
	SetScreenElementProps \{id = setlist_bg_container
		Pos = $setlist_background_pos}
	SetScreenElementProps \{id = setlist_loops_menu
		Pos = $setlist_background_pos}
	if ($setlist_clip_rot_neg)
		SetScreenElementProps id = sl_clip rot_angle = (0 - $setlist_clip_last_rot)
		change \{setlist_clip_rot_neg = 0}
	else
		getrandomvalue \{name = rot
			a = 10.0
			b = -30.0}
		SetScreenElementProps id = sl_clip rot_angle = <rot>
		change setlist_clip_last_rot = <rot>
		change \{setlist_clip_rot_neg = 1}
	endif
	if (<dir> = down)
		change setlist_random_images_scroll_num = ($setlist_random_images_scroll_num + 1)
		if ($setlist_random_images_scroll_num > $setlist_random_images_highest_num)
			change setlist_random_images_highest_num = ($setlist_random_images_scroll_num)
			mod a = ($setlist_random_images_highest_num) b = 4
			if (<mod> = 0)
				setlist_display_random_bg_image
			endif
		endif
		change setlist_background_loop_num = ($setlist_background_loop_num + 1)
		if ($setlist_background_loop_num = 10)
			change \{setlist_background_loop_num = 0}
			change setlist_background_loop_pos = ($setlist_background_loop_pos + (0.0, 1308.0))
			displaySprite \{parent = setlist_menu
				tex = Setlist_BG_Loop
				Pos = $setlist_background_loop_pos
				dims = (1280.0, 1308.0)
				z = 3.1}
		endif
		change setlist_page1_num = ($setlist_page1_num + 1)
		if ($setlist_page1_num = 4)
			change \{setlist_page1_num = 0}
			change setlist_page1_loop_pos = ($setlist_page1_loop_pos + (0.0, 512.0))
			displaySprite \{parent = setlist_loops_menu
				tex = Setlist_Page1_Loop
				Pos = $setlist_page1_loop_pos
				dims = $setlist_page1_dims
				z = $setlist_page1_z}
		endif
		if ($current_tab = tab_bonus)
			change setlist_page2_num = ($setlist_page2_num + 1)
			if ($setlist_page2_num = 5)
				change \{setlist_page2_num = 0}
				change setlist_page2_pos = ($setlist_page2_pos + (0.0, 665.5))
				displaySprite \{parent = setlist_loops_menu
					tex = Setlist_Page2_Loop
					Pos = $setlist_page2_pos
					dims = $setlist_page2_dims
					z = $setlist_page2_z}
			endif
		endif
		change setlist_line_num = ($setlist_line_num + 1)
		if ($setlist_line_num = 1)
			change \{setlist_line_num = 0}
			<i> = 1
			if NOT (<not_header>)
				<i> = 3
			endif
			begin
			if ($setlist_line_index = $setlist_line_max)
				change \{setlist_line_index = 0}
			endif
			<Line> = Random (@ ($setlist_solid_lines [0]) @ ($setlist_solid_lines [1]) @ ($setlist_solid_lines [2]) )
			displaySprite parent = setlist_menu tex = <Line> Pos = $setlist_solid_line_pos dims = (896.0, 16.0) z = ($setlist_page1_z + 0.1)
			change setlist_line_index = ($setlist_line_index + 1)
			if ($setlist_line_index = $setlist_line_max)
				change \{setlist_line_index = 0}
			endif
			<Line> = Random (@ ($setlist_dotted_lines [0]) @ ($setlist_dotted_lines [1]) @ ($setlist_dotted_lines [2]) )
			displaySprite parent = setlist_menu tex = <Line> Pos = $setlist_dotted_line_pos dims = (896.0, 16.0) z = ($setlist_page1_z + 0.1)
			change setlist_line_index = ($setlist_line_index + 1)
			change setlist_solid_line_pos = (($setlist_solid_line_pos) + ($setlist_solid_line_add))
			change setlist_dotted_line_pos = (($setlist_dotted_line_pos) + ($setlist_solid_line_add))
			repeat <i>
		endif
		change setlist_page3_num = ($setlist_page3_num + 1)
		if ($setlist_page3_num = 5)
			change \{setlist_page3_num = 0}
			change setlist_page3_pos = ($setlist_page3_pos + (0.0, 532.0))
			displaySprite \{parent = setlist_loops_menu
				tex = Setlist_Page3_Loop
				Pos = $setlist_page3_pos
				dims = $setlist_page3_dims
				z = $setlist_page3_z}
		endif
	else
		change setlist_random_images_scroll_num = ($setlist_random_images_scroll_num - 1)
		change setlist_background_loop_num = ($setlist_background_loop_num - 1)
		change setlist_page1_num = ($setlist_page1_num - 1)
		change setlist_line_num = ($setlist_line_num - 1)
		change setlist_line_index = ($setlist_line_index + 1)
		if ($setlist_line_index = $setlist_line_max)
			change \{setlist_line_index = 0}
		endif
		change setlist_page3_num = ($setlist_page3_num - 1)
		change setlist_page2_num = ($setlist_page2_num - 1)
	endif
	if GotParam \{up}
		generic_menu_up_or_down_sound \{up}
	endif
	if GotParam \{down}
		generic_menu_up_or_down_sound \{down}
	endif
endscript

script change_tab \{tab = tab_setlist
		button = 0}
	change \{changing_tab = 1}
	if ($current_tab = <tab> && <button> = 1)
		change \{changing_tab = 0}
		return
	endif
	if (<tab> = tab_setlist)
		if NOT ($current_tab = <tab>)
			menu_setlist_setlist_tab_sound
		endif
		get_progression_globals game_mode = ($game_mode)
	elseif (<tab> = tab_bonus)
		if NOT ($current_tab = <tab>)
			menu_setlist_bonus_tab_sound
		endif
		get_progression_globals game_mode = ($game_mode) bonus
	elseif (<tab> = tab_downloads)
		if NOT ($current_tab = <tab>)
			menu_setlist_downloads_tab_sound
		endif
		get_progression_globals game_mode = ($game_mode) download
	endif
	change g_gh3_setlist = <tier_global>
	change current_tab = <tab>
	destroy_setlist_scrolling_menu
	create_setlist_scrolling_menu
	reset_vars \{del}
	destroy_menu \{menu_id = setlist_original_artist}
	destroy_menu \{menu_id = setlist_loops_menu}
	destroy_menu \{menu_id = setlist_menu}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = setlist_loops_menu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	switch <tab>
		case tab_setlist
		change \{setlist_page3_z = 3.3}
		change \{setlist_page2_z = 3.4}
		change \{setlist_page1_z = 3.5}
		displaySprite \{parent = setlist_loops_menu
			tex = Setlist_Page1_Loop
			Pos = $setlist_page1_loop_pos
			dims = $setlist_page1_dims
			z = $setlist_page1_z}
		displaySprite parent = setlist_loops_menu tex = Setlist_Page3_Loop Pos = ($setlist_page3_pos + (-180.0, 614.0)) dims = $setlist_page3_dims z = $setlist_page3_z
		case tab_downloads
		change \{setlist_page3_z = 3.5}
		change \{setlist_page2_z = 3.4}
		change \{setlist_page1_z = 3.3}
		displaySprite \{parent = setlist_loops_menu
			tex = Setlist_Page1_Loop
			Pos = $setlist_page1_loop_pos
			dims = $setlist_page1_dims
			z = $setlist_page1_z}
		change setlist_page3_pos = ($setlist_page3_pos + (0.0, 40.0))
		displaySprite parent = setlist_loops_menu tex = Setlist_Page3_Loop Pos = ($setlist_page3_pos + (-180.0, 614.0)) dims = $setlist_page3_dims z = $setlist_page3_z
		case tab_bonus
		change \{setlist_page3_z = 3.3}
		change \{setlist_page2_z = 3.8}
		change \{setlist_page1_z = 3.4}
		displaySprite \{parent = setlist_loops_menu
			tex = Setlist_Page1_Loop
			Pos = $setlist_page1_loop_pos
			dims = $setlist_page1_dims
			z = $setlist_page1_z}
		displaySprite parent = setlist_loops_menu tex = Setlist_Page3_Loop Pos = ($setlist_page3_pos + (-180.0, 614.0)) dims = $setlist_page3_dims z = $setlist_page3_z
		displaySprite parent = setlist_loops_menu tex = Setlist_Page2_Loop Pos = ($setlist_page2_pos + (0.0, 553.0)) dims = $setlist_page2_dims z = $setlist_page2_z
	endswitch
	create_sl_assets <tab>
	SetScreenElementProps \{id = setlist_bg_container
		Pos = (0.0, 0.0)}
	change \{setlist_random_images_scroll_num = 0}
	change setlist_page2_pos = ($setlist_page2_pos + (0.0, 553.0))
	change setlist_page3_pos = ($setlist_page3_pos + (-180.0, 614.0))
	SetScreenElementProps \{id = sl_page3_head
		z_priority = $setlist_page3_z}
	SetScreenElementProps \{id = sl_page2_head
		z_priority = $setlist_page2_z}
	SetScreenElementProps \{id = sl_page1_head
		z_priority = $setlist_page1_z}
	if ($setlist_selection_found = 1)
		FormatText \{checksumname = tier_checksum
			'tier%s'
			s = $setlist_selection_tier}
		song = ($g_gh3_setlist.<tier_checksum>.songs [$setlist_selection_song])
		get_song_formatted song_checksum = <song>
		GetGlobalTags <songname>
		if (<achievement_gold_star> = 1 || ($randomizer_toggle = 0) || <tab> = tab_bonus)
			change target_setlist_songpreview = <song>
		else
			change target_setlist_songpreview = None
		endif
	else
		change \{target_setlist_songpreview = None}
	endif
	KillSpawnedScript \{name = set_song_icon}
	spawnscriptnow \{set_song_icon
		params = {
			no_wait
		}}
	if ($is_network_game = 0)
		LaunchEvent \{type = focus
			target = vmenu_setlist}
	else
		if ($net_current_flow_state = song)
			LaunchEvent \{type = focus
				target = vmenu_setlist}
		endif
	endif
	change \{changing_tab = 0}
endscript


