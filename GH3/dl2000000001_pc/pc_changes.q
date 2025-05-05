main_menu_fs = {
	Create = create_main_menu
	Destroy = destroy_main_menu
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
			action = select_winport_online
			flow_state = online_winport_start_connection_fs
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
			action = select_winport_exit
			flow_state = winport_confirm_exit_fs
			transition_left
		}
		{
			action = go_back
			flow_state = winport_confirm_exit_fs
			transition_left
		}
		{
			action = select_debug_menu
			flow_state = debug_menu_fs
		}
	]
}

script create_main_menu 
	if IsWinPort
		shut_down_net_play
		if ($main_menu_created = 0)
			if WinPortSioIsKeyboard \{deviceNum = $primary_controller}
				SetGlobalTags \{user_options
					Params = {
						lefty_flip_p1 = 1
					}}
			else
				guitarCount = 0
				if IsGuitarController \{controller = 0}
					guitarCount = (<guitarCount> + 1)
				endif
				if IsGuitarController \{controller = 1}
					guitarCount = (<guitarCount> + 1)
				endif
				if IsGuitarController \{controller = 2}
					guitarCount = (<guitarCount> + 1)
				endif
				if (<guitarCount> < 2)
					SetGlobalTags \{user_options
						Params = {
							lefty_flip_p2 = 1
						}}
				endif
			endif
			WinPortCreateLaptopUi
		endif
	endif
	Change \{winport_is_in_online_menu_system = 0}
	Change \{main_menu_created = 1}
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
		PlayMovieAndWait \{movie = 'GH3_Intro'
			noblack
			noletterbox}
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
	Change \{current_song = welcometothejungle}
	Change \{end_credits = 0}
	Change \{battle_sudden_death = 0}
	Change \{StructureName = player1_status
		character_id = Axel}
	Change \{StructureName = player2_status
		character_id = Axel}
	Change \{default_menu_focus_color = [
			125
			0
			0
			255
		]}
	Change \{default_menu_unfocus_color = $menu_text_color}
	safe_create_gh3_pause_menu
	base_menu_pos = (730.0, 90.0)
	main_menu_font = fontgrid_title_gh3
	new_menu scrollid = main_menu_scrolling_menu vmenuid = vmenu_main_menu use_backdrop = (0) Menu_pos = (<base_menu_pos>)
	Change \{rich_presence_context = presence_main_menu}
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
	exit_text_off = (<leaderboards_text_off> + (-20.0, 65.0))
	exit_text_scale = (1.1, 1.0)
	debug_menu_text_off = (<exit_text_off> + (0.0, 160.0))
	debug_menu_text_scale = 0.8
	if ($randomizer_toggle = 1)
		disable_randomize = { shadow_rgba = [0 0 0 255] }
	else
		disable_randomize = { shadow_rgba = [0 0 0 255] }
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_career_text
		PARENT = main_menu_text_container
		Text = ($mm_career_text)
		font = <main_menu_font>
		Pos = {(<career_text_off>) Relative}
		Scale = (<career_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		font_spacing = 0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((420.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_coop_career_text
		PARENT = main_menu_text_container
		Text = ($mm_coop_career_text)
		font = <main_menu_font>
		Pos = {(<coop_career_text_off>) Relative}
		Scale = (<coop_career_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		font_spacing = 0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 400)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((400.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_quickplay_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		Text = ($mm_quickplay_text)
		font_spacing = 0
		Pos = {(<quickplay_text_off>) Relative}
		Scale = (<quickplay_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
		<demo_mode_disable>
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 400)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((400.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_multiplayer_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		Text = ($mm_multiplayer_text)
		font_spacing = 1
		Pos = {(<multiplayer_text_off>) Relative}
		Scale = (<multiplayer_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
		<demo_mode_disable>
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 460)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((460.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		text = "PERMADEATH"
		pos = ($permadeath_title_offset)
		parent = main_menu_text_container
		rgba = [200 0 0 255]
		font = text_a6
		just = [center top]
		scale = (1.0, 1.0)
	}
	if ($randomizer_toggle = 1)
		randomized_title_offset = ($permadeath_title_offset + (0.0, 48.0))
		createscreenelement {
			type = textelement
			text = ($setlist_randomized_text)
			pos = <randomized_title_offset>
			parent = main_menu_text_container
			rgba = [200 0 0 255]
			font = text_a6
			just = [center top]
			scale = (<leaderboards_text_scale>)
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
		}
	endif
	createscreenelement {
		type = textelement
		Id = main_menu_training_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		Text = ($mm_training_text)
		font_spacing = 0
		Pos = {(<training_text_off>) Relative}
		Scale = (<training_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 345)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((345.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	GetScreenElementDims \{Id = main_menu_training_text}
	old_height = <Height>
	fit_text_in_rectangle Id = main_menu_training_text Dims = (350.0, 100.0) Pos = {(<training_text_off>) Relative} start_x_scale = (<training_text_scale>.(1.0, 0.0)) start_y_scale = (<training_text_scale>.(0.0, 1.0)) only_if_larger_x = 1 keep_ar = 1
	GetScreenElementDims \{Id = main_menu_training_text}
	Offset = ((<old_height> * ((<old_height> -24.0) / <old_height>)) - (<Height> * ((<Height> - (24.0 * ((1.0 * <Height>) / <old_height>))) / <Height>)))
	leaderboards_text_off = (<leaderboards_text_off> - <Offset> * (0.0, 1.0))
	options_text_off = (<options_text_off> - <Offset> * (0.0, 1.0))
	if IsXENON
		CreateScreenElement {
			Type = TextElement
			Id = main_menu_leaderboards_text
			PARENT = main_menu_text_container
			font = <main_menu_font>
			Text = ($randomize_setlist_text)
			font_spacing = 0
			Pos = {(<leaderboards_text_off>) Relative}
			Scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [LEFT Top]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
			<disable_randomize>
		}
		GetScreenElementDims Id = <Id>
		if (<width> > 360)
			SetScreenElementProps Id = <Id> Scale = 1
			fit_text_in_rectangle Id = <Id> Dims = ((360.0, 0.0) + <Height> * (0.0, 1.0))
		endif
	else
		CreateScreenElement {
			Type = TextElement
			Id = main_menu_leaderboards_text
			PARENT = main_menu_text_container
			font = <main_menu_font>
			Text = ($randomize_setlist_text)
			font_spacing = 0
			Pos = {(<leaderboards_text_off>) Relative}
			Scale = (<leaderboards_text_scale>)
			rgba = ($menu_text_color)
			just = [LEFT Top]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
			z_priority = 60
			<disable_randomize>
		}
		GetScreenElementDims Id = <Id>
		if (<width> > 360)
			SetScreenElementProps Id = <Id> Scale = 1
			fit_text_in_rectangle Id = <Id> Dims = ((360.0, 0.0) + <Height> * (0.0, 1.0))
		endif
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_options_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		Text = ($mm_options_text)
		font_spacing = 0
		Pos = {(<options_text_off>) Relative}
		Scale = (<options_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((420.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		Type = TextElement
		Id = main_menu_exit_text
		PARENT = main_menu_text_container
		font = <main_menu_font>
		Text = "EXIT"
		font_spacing = 0
		Pos = {(<exit_text_off>) Relative}
		Scale = (<exit_text_scale>)
		rgba = ($menu_text_color)
		just = [LEFT Top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 60
	}
	GetScreenElementDims Id = <Id>
	if (<width> > 420)
		SetScreenElementProps Id = <Id> Scale = 1
		fit_text_in_rectangle Id = <Id> Dims = ((420.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	if ($enable_button_cheats = 1)
		CreateScreenElement {
			Type = TextElement
			Id = main_menu_debug_menu_text
			PARENT = main_menu_text_container
			font = <main_menu_font>
			Text = "DEBUG MENU"
			Pos = {(<debug_menu_text_off>) Relative}
			Scale = (<debug_menu_text_scale>)
			rgba = ($menu_text_color)
			just = [LEFT Top]
			Shadow
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
			hDims = (240.0, 57.0)
		} ,
		{
			posL = (<coop_career_text_off> + <hilite_off> + (-33.0, 3.0))
			posR = (<coop_career_text_off> + <hilite_off> + (281.0, 3.0))
			beDims = (32.0, 32.0)
			posH = (<coop_career_text_off> + <hilite_off> + (-14.0, -1.0))
			hDims = (300.0, 37.0)
		} ,
		{
			posL = (<quickplay_text_off> + <hilite_off> + (-34.0, 4.0))
			posR = (<quickplay_text_off> + <hilite_off> + (251.0, 4.0))
			beDims = (40.0, 40.0)
			posH = (<quickplay_text_off> + <hilite_off> + (-14.0, -2.0))
			hDims = (267.0, 47.0)
		} ,
		{
			posL = (<multiplayer_text_off> + <hilite_off> + (-37.0, 4.0))
			posR = (<multiplayer_text_off> + <hilite_off> + (301.0, 4.0))
			beDims = (38.0, 38.0)
			posH = (<multiplayer_text_off> + <hilite_off> + (-14.0, -1.0))
			hDims = (320.0, 43.0)
		} ,
		{
			posL = (<training_text_off> + <hilite_off> + (-31.0, 9.0))
			posR = (<training_text_off> + <hilite_off> + (282.0, 9.0))
			beDims = (42.0, 42.0)
			posH = (<training_text_off> + <hilite_off> + (-13.0, -2.0))
			hDims = (295.0, 61.0)
		} ,
		{
			posL = (<leaderboards_text_off> + <hilite_off> + (-33.0, 3.0))
			posR = (<leaderboards_text_off> + <hilite_off> + (213.0, 3.0))
			beDims = (34.0, 34.0)
			posH = (<leaderboards_text_off> + <hilite_off> + (-13.0, -2.0))
			hDims = (232.0, 40.0)
		} ,
		{
			posL = (<options_text_off> + <hilite_off> + (-36.0, 5.0))
			posR = (<options_text_off> + <hilite_off> + (183.0, 5.0))
			beDims = (36.0, 36.0)
			posH = (<options_text_off> + <hilite_off> + (-14.0, 0.0))
			hDims = (205.0, 43.0)
		} ,
		{
			posL = (<exit_text_off> + <hilite_off> + (-36.0, 5.0))
			posR = (<exit_text_off> + <hilite_off> + (183.0, 5.0))
			beDims = (36.0, 36.0)
			posH = (<exit_text_off> + <hilite_off> + (-12.0, 0.0))
			hDims = (205.0, 43.0)
		}
	]
	<gm_hlIndex> = 0
	displaySprite {
		PARENT = main_menu_text_container
		tex = character_hub_hilite_bookend
		Pos = ((<gm_hlInfoList> [<gm_hlIndex>]).posL)
		Dims = ((<gm_hlInfoList> [<gm_hlIndex>]).beDims)
		rgba = <offwhite>
		Z = 2
	}
	<bookEnd1ID> = <Id>
	displaySprite {
		PARENT = main_menu_text_container
		tex = character_hub_hilite_bookend
		Pos = ((<gm_hlInfoList> [<gm_hlIndex>]).posR)
		Dims = ((<gm_hlInfoList> [<gm_hlIndex>]).beDims)
		rgba = <offwhite>
		Z = 2
	}
	<bookEnd2ID> = <Id>
	displaySprite {
		PARENT = main_menu_text_container
		tex = White
		rgba = <offwhite>
		Pos = ((<gm_hlInfoList> [<gm_hlIndex>]).posH)
		Dims = ((<gm_hlInfoList> [<gm_hlIndex>]).hDims)
		Z = 2
	}
	<whiteTexHighlightID> = <Id>
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_career_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_career_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 0
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_career_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_career_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_career_text}}
			{pad_choose main_menu_select_career}
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_coop_career_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_coop_career_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 1
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_coop_career_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_coop_career_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_coop_career_text}}
			{pad_choose main_menu_select_coop_career}
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_quickplay_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_quickplay_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 2
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_quickplay_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_quickplay_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_quickplay_text}}
			{pad_choose main_menu_select_quickplay}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_multiplayer_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_multiplayer_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 3
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_multiplayer_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_multiplayer_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_multiplayer_text}}
			{pad_choose main_menu_select_multiplayer}
		]
		z_priority = -1
		<demo_mode_disable>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_training_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_training_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 4
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_training_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_training_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_training_text}}
			{pad_choose main_menu_select_training}
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_options_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_options_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 6
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_options_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_options_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_options_text}}
			{pad_choose main_menu_select_options}
		]
		z_priority = -1
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = ""
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_leaderboards_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_leaderboards_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 5
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_leaderboards_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_leaderboards_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_leaderboards_text}}
			{pad_choose ui_flow_manager_respond_to_action params = {action = select_xbox_live}}
		]
		z_priority = -1
		<disable_randomize>
	}
	CreateScreenElement {
		Type = TextElement
		PARENT = vmenu_main_menu
		font = <main_menu_font>
		Text = "Exit placeholder"
		event_handlers = [
			{Focus retail_menu_focus Params = {Id = main_menu_exit_text}}
			{Focus SetScreenElementProps Params = {Id = main_menu_exit_text no_shadow}}
			{Focus guitar_menu_highlighter Params = {
					hlIndex = 7
					hlInfoList = <gm_hlInfoList>
					be1ID = <bookEnd1ID>
					be2ID = <bookEnd2ID>
					wthlID = <whiteTexHighlightID>
					text_id = main_menu_exit_text
				}
			}
			{unfocus SetScreenElementProps Params = {Id = main_menu_exit_text Shadow shadow_offs = (3.0, 3.0) shadow_rgba = [0 0 0 255]}}
			{unfocus retail_menu_unfocus Params = {Id = main_menu_exit_text}}
			{pad_choose main_menu_select_exit}
		]
		z_priority = -1
	}
	if ($enable_button_cheats = 1)
		CreateScreenElement {
			Type = TextElement
			PARENT = vmenu_main_menu
			font = <main_menu_font>
			Text = ""
			event_handlers = [
				{Focus retail_menu_focus Params = {Id = main_menu_debug_menu_text}}
				{Focus guitar_menu_highlighter Params = {
						zPri = -2
						hlIndex = 0
						hlInfoList = <gm_hlInfoList>
						be1ID = <bookEnd1ID>
						be2ID = <bookEnd2ID>
						wthlID = <whiteTexHighlightID>
					}
				}
				{unfocus retail_menu_unfocus Params = {Id = main_menu_debug_menu_text}}
				{pad_choose ui_flow_manager_respond_to_action Params = {action = select_debug_menu}}
			]
			z_priority = -1
		}
	endif
	if ($new_message_of_the_day = 1)
		SpawnScriptNow \{pop_in_new_downloads_notifier}
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
		/*
		setglobaltags \{user_options
			params = {
				lag_calibration = $calibration_val
			}} */
		new_hs = ($hyperspeed_setting_val)
		change cheat_hyperspeed = <new_hs>
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

download_songlist_props = {

}

gh3_songlist_props = {
	$permanent_songlist_props
	$permadeath_songlist_props
}

gh3_songlist = [
	anarchyintheuk
	avalancha
	Barracuda
	beforeiforget
	bellyofashark
	blackmagicwoman
	blacksunshine
	bossslash
	bosstom
	bossdevil
	bullsonparade
	cantbesaved
	cherubrock
	citiesonflame
	cliffsofdover
	closer
	CultOfPersonality
	dontholdback
	downndirty
	evenflow
	fcpremix
	generationrock
	gothatfar
	helicopter
	HitMeWithYourBestShot
	hierkommtalex
	holidayincambodia
	imintheband
	Impulse
	inlove
	koolthing
	knightsofcydonia
	lagrange
	LayDown
	mauvaisgarcon
	metalheavylady
	minuscelsius
	mississippiqueen
	MissMurder
	monsters
	mycurse
	mynameisjonas
	nothingformehere
	numberofthebeast
	ONE
	paintitblack
	Paranoid
	prayeroftherefugee
	pridenjoy
	radiosong
	RainingBlood
	reptilia
	rocknrollallnite
	rockulikeahurricane
	ruby
	sabotage
	sameoldsonganddance
	schoolsout
	shebangsadrum
	slowride
	slowridefull
	dlc1504750512
	stricken
	storyofmylife
	suckmykiss
	sunshineofyourlove
	talkdirtytome
	takethislife
	themetal
	theseeker
	thewayitends
	threesandsevens
	thrufireandflames
	welcometothejungle
	whenyouwereyoung
	synctest
	synctestplaytoaudio
	synctestaudioandvisual
	Tutorial_1B
	Tutorial_1C
	Tutorial_1D
	Tutorial_1E
	Tutorial_2A
	Tutorial_2B
	Tutorial_2C
	Tutorial_3A
	Tutorial_3B
	Tutorial_3C
	Tutorial_3D
	Tutorial_4C
	Tutorial_4E
	
]
