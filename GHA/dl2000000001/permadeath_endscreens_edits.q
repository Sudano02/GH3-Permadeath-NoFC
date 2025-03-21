GH3_Career_Progression = [
	{
		Name = set_initial_states
		Type = Scr
		atom_script = Progression_Init
		atom_params = {
		}
	}
	{
		Name = career_tier1_intro_songscomplete
		Type = Scr
		atom_script = Progression_TierAerosmithUnlock
		atom_params = {
			Tier = 1
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckIntroSongsComplete
				Params = {
					Tier = 1
				}
			}
		]
	}
	{
		Name = career_tier1_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			Tier = 1
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 1
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		Name = career_tier1_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			Tier = 1
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier1_songscomplete
			}
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [
					0
					0
					0
					0
				]
			}
		]
	}
	{
		Name = career_tier1_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			Tier = 1
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier1_encoreunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = {
					Tier = 1
				}
			}
		]
	}
	{
		Name = career_tier1_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 1
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier1_songscomplete
			}
			{
				Type = atom
				atom = career_tier1_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
		]
	}
	{
		Name = career_tier2_intro_songscomplete
		Type = Scr
		atom_script = Progression_TierAerosmithUnlock
		atom_params = {
			Tier = 2
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckIntroSongsComplete
				Params = {
					Tier = 2
				}
			}
		]
	}
	{
		Name = career_tier2_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			Tier = 2
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier1_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 2
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		Name = career_tier2_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			Tier = 2
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier2_songscomplete
			}
		]
	}
	{
		Name = career_tier2_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			Tier = 2
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier2_encoreunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = {
					Tier = 2
				}
			}
		]
	}
	{
		Name = career_tier2_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 2
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier2_songscomplete
			}
			{
				Type = atom
				atom = career_tier2_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
		]
	}
	{
		Name = career_tier3_intro_songscomplete
		Type = Scr
		atom_script = Progression_TierAerosmithUnlock
		atom_params = {
			Tier = 3
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckIntroSongsComplete
				Params = {
					Tier = 3
				}
			}
		]
	}
	{
		Name = career_tier3_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			Tier = 3
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier2_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 3
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		Name = career_tier3_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			Tier = 3
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier3_songscomplete
			}
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [
					0
					0
					0
					0
				]
			}
		]
	}
	{
		Name = career_tier3_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			Tier = 3
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier3_encoreunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = {
					Tier = 3
				}
			}
		]
	}
	{
		Name = career_tier3_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 3
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier3_songscomplete
			}
			{
				Type = atom
				atom = career_tier3_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
		]
	}
	{
		Name = career_tier4_intro_songscomplete
		Type = Scr
		atom_script = Progression_TierAerosmithUnlock
		atom_params = {
			Tier = 4
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckIntroSongsComplete
				Params = {
					Tier = 4
				}
			}
		]
	}
	{
		Name = career_tier4_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			Tier = 4
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier3_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 4
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		Name = career_tier4_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			Tier = 4
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier4_songscomplete
			}
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [
					0
					0
					0
					0
				]
			}
		]
	}
	{
		Name = career_tier4_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			Tier = 4
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier4_encoreunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = {
					Tier = 4
				}
			}
		]
	}
	{
		Name = career_tier4_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 4
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier4_songscomplete
			}
			{
				Type = atom
				atom = career_tier4_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
		]
	}
	{
		Name = career_tier5_intro_songscomplete
		Type = Scr
		atom_script = Progression_TierAerosmithUnlock
		atom_params = {
			Tier = 5
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckIntroSongsComplete
				Params = {
					Tier = 5
				}
			}
		]
	}
	{
		Name = career_tier5_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			Tier = 5
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier4_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 5
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		Name = career_tier5_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			Tier = 5
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier5_songscomplete
			}
		]
	}
	{
		Name = career_tier5_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			Tier = 5
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier5_encoreunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = {
					Tier = 5
				}
			}
		]
	}
	{
		Name = career_tier5_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 5
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier5_songscomplete
			}
			{
				Type = atom
				atom = career_tier5_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
		]
	}
	{
		Name = career_tier6_bossunlock
		Type = Scr
		atom_script = Progression_TierBossUnlock
		atom_params = {
			Tier = 6
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckIntroSongsComplete
				Params = {
					Tier = 6
				}
			}
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [
					0
					0
					0
					0
				]
			}
		]
	}
	{
		Name = career_tier6_bosscomplete
		Type = Scr
		atom_script = Progression_TierBossComplete
		atom_params = {
			Tier = 6
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_bossunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckBossComplete
				Params = {
					Tier = 6
				}
			}
		]
	}
	{
		Name = career_tier6_intro_songscomplete
		Type = Scr
		atom_script = Progression_TierAerosmithUnlock
		atom_params = {
			Tier = 6
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_bosscomplete
			}
		]
	}
	{
		Name = career_tier6_songscomplete
		Type = Scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			Tier = 6
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier5_complete
			}
			{
				Type = atom
				atom = career_tier6_bosscomplete
			}
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 6
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		Name = career_tier6_encoreunlock
		Type = Scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			Tier = 6
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_songscomplete
			}
			{
				Type = Scr
				Scr = Progression_AlwaysBlock
				required = [
					0
					0
					0
					0
				]
			}
		]
	}
	{
		Name = career_tier6_encorecomplete
		Type = Scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			Tier = 6
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_encoreunlock
			}
			{
				Type = Scr
				Scr = Progression_CheckEncoreComplete
				Params = {
					Tier = 6
				}
			}
		]
	}
	{
		Name = career_tier6_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 6
			finished_game
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_songscomplete
			}
			{
				Type = atom
				atom = career_tier6_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
			{
				Type = atom
				atom = career_tier6_bosscomplete
				required = [
					1
					1
					1
					1
				]
			}
		]
	}
	{
		Name = career_bonus_songs_complete
		Type = Scr
		atom_script = Progression_TierComplete
		atom_params = {
			Tier = 1
			Bonus
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckSongComplete
				Params = {
					Tier = 1
					numsongstoprogress = $GH3_Career_NumSongToProgress
					Bonus
				}
			}
		]
	}
	{
		Name = unlock_guitar1
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 1
			for_difficulty
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = EASY
					mode = p1_career
				}
			}
		]
	}
	{
		Name = unlock_guitar2
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 2
			for_stars
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = EASY
					mode = p1_career
				}
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {
				}
			}
		]
	}
	{
		Name = unlock_guitar3
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 3
			for_difficulty
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = MEDIUM
					mode = p1_career
				}
			}
		]
	}
	{
		Name = unlock_guitar4
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 4
			for_stars
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = MEDIUM
					mode = p1_career
				}
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {
				}
			}
		]
	}
	{
		Name = unlock_guitar5
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 5
			for_difficulty
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = HARD
					mode = p1_career
				}
			}
		]
	}
	{
		Name = unlock_guitar6
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 6
			for_stars
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = HARD
					mode = p1_career
				}
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {
				}
			}
		]
	}
	{
		Name = unlock_guitar7
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 7
			for_difficulty
		}
		depends_on = [
			{
				Type = atom
				atom = career_tier6_complete
			}
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = EXPERT
					mode = p1_career
				}
			}
		]
	}
	{
		Name = unlock_guitar8
		Type = Scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			GUITAR = 8
			for_stars
		}
		depends_on = [
			{
				Type = Scr
				Scr = Progression_CheckDiff
				Params = {
					diff = EXPERT
					mode = p1_career
				}
			}
			{
				Type = Scr
				Scr = Progression_CheckSong5Star
				Params = {
				}
			}
		]
	}
	{
		name = permadeath_bonus_songscomplete
		type = scr
		atom_script = Permadeath_BonusComplete
		atom_params = {
		}
		depends_on = [
			{
				type = scr
				scr = Permadeath_CheckBonusSongComplete
				params = {
					tier = 1
					numsongstoprogress = $PD_Bonus_NumSongToProgress
				}
			}
		]
	}
	{
		Name = end_of_first_update
		Type = Scr
		atom_script = Progression_EndOfFirstUpdate
		atom_params = {
		}
	}
]

script career_check_for_beat_game 
	if ($progression_beat_game_last_song = 1)
		return \{flow_state = career_beat_game_fs}
	elseif ($fcd_all_songs_last_song = 1)
		return \{flow_state = permadeath_fgfc_fs}
	else
		return \{flow_state = career_newspaper_fs}
	endif
endscript

script create_beat_game_menu 
	create_menu_backdrop \{texture = Beat_Game_BG}
	menu_font = fontgrid_title_gh3
	get_current_band_info
	GetGlobalTags <band_info> Param = Name
	band_name = <Name>
	FormatText TextName = band_name_text "%s" S = <band_name>
	difficulty_text = ($def_expert_text)
	next_difficulty_text = "PRECISION MODE CHEAT"
	<DIFFICULTY> = ($current_difficulty)
	switch (<DIFFICULTY>)
		case EASY
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
	CreateScreenElement \{Type = ContainerElement
		PARENT = root_window
		Id = beat_game_container
		Pos = (0.0, 0.0)
		just = [
			LEFT
			Top
		]}
	CreateScreenElement {
		Type = TextElement
		PARENT = beat_game_container
		Id = bgs_band_name
		just = [Center Top]
		font = <menu_font>
		Text = <band_name_text>
		Scale = 1.38
		rgba = (($G_menu_colors).pink)
		Pos = (640.0, 366.0)
	}
	GetScreenElementDims \{Id = bgs_band_name}
	if (<width> > 300)
		fit_text_in_rectangle \{Id = bgs_band_name
			Dims = (1060.0, 130.0)
			Pos = (640.0, 366.0)}
	endif
	FormatText TextName = Title_text $beat_game_title D = <difficulty_text>
	CreateScreenElement {
		Type = TextElement
		PARENT = beat_game_container
		Id = bgs_under_title
		just = [LEFT Top]
		font = <menu_font>
		Text = <Title_text>
		Scale = 1.0
		rgba = (($G_menu_colors).lt_violet_grey)
	}
	fit_text_in_rectangle \{Id = bgs_under_title
		Dims = (700.0, 65.0)
		Pos = (300.0, 428.0)}
	if (<DIFFICULTY> = EXPERT)
		FormatText TextName = motivation_text ($beat_game_message_expert) N = <next_difficulty_text>
	else
		FormatText TextName = motivation_text ($beat_game_message) N = <next_difficulty_text>
	endif
	CreateScreenElement {
		Type = TextBlockElement
		PARENT = beat_game_container
		font = text_a4
		Text = <motivation_text>
		Dims = (1100.0, 700.0)
		Pos = (640.0, 468.0)
		rgba = (($G_menu_colors).dk_violet_grey)
		just = [Center Top]
		internal_just = [Center Top]
		Scale = 0.7
		z_priority = 3
	}
	button_font = buttonsxenon
	displaySprite \{Id = bgs_black_banner
		PARENT = beat_game_container
		tex = White
		Pos = (0.0, -2.0)
		Dims = (1240.0, 100.0)
		rgba = [
			0
			0
			0
			255
		]
		Z = -2}
	CreateScreenElement {
		Type = TextElement
		PARENT = beat_game_container
		Id = continue_text
		Scale = 1.0
		Pos = (40.0, 20.0)
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [LEFT Center]
		event_handlers = [
			{pad_choose ui_flow_manager_respond_to_action Params = {action = Continue}}
		]
	}
	SpawnScriptNow scroll_ticker_text Params = {ticker_text = <band_name_text>}
	LaunchEvent \{Type = Focus
		Target = continue_text}
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
	add_user_control_helper \{Text = $text_button_continue
		button = Green
		Z = 100}
endscript

script create_setlist_menu 
	if (($is_network_game = 1) && ($net_can_send_approval = 1))
		net_lobby_state_message {
			current_state = ($net_current_flow_state)
			action = request
			request_state = Song
		}
	endif
	if ($is_network_game = 1)
		Change \{current_tab = tab_setlist}
		Change \{setlist_previous_tier = 1}
		Change \{setlist_previous_song = 0}
		Change \{setlist_previous_tab = tab_setlist}
	endif
	if ($end_credits = 1 && $current_song = trainkeptarollin)
		Progression_EndCredits
		return
	elseif ($fcd_all_songs_last_song = 1)
		change \{fcd_all_songs_last_song = 0}
		if ($end_credits = 1)
			Progression_EndCreditsPermadeath
			return
		endif
	endif
	Change \{boss_wuss_out = 0}
	if ($progression_play_completion_movie = 1)
		get_progression_globals game_mode = ($game_mode)
		FormatText ChecksumName = tiername 'tier%i' I = ($progression_completion_tier)
		if StructureContains Structure = ($<tier_global>.<tiername>) completion_movie
			Menu_Music_Off
			PlayMovieAndWait movie = ($<tier_global>.<tiername>.completion_movie)
			get_movie_id_by_name movie = ($<tier_global>.<tiername>.completion_movie)
			SetGlobalTags <Id> Params = {unlocked = 1}
		endif
		Change \{progression_play_completion_movie = 0}
	endif
	Change \{progression_unlocked_guitar = -1}
	Change \{progression_unlocked_guitar2 = -1}
	Change \{rich_presence_context = presence_song_list}
	Menu_Music_Off
	get_progression_globals game_mode = ($game_mode)
	Change g_gh3_setlist = <tier_global>
	create_setlist_scrolling_menu
	change \{setlist_page3_z = 3.3}
	Change \{setlist_page2_z = 3.4}
	Change \{setlist_page1_z = 3.5}
	Change \{setlist_random_images_scroll_num = 0}
	Change \{setlist_random_images_highest_num = 0}
	change_tab tab = ($setlist_previous_tab)
	setlist_display_random_bg_image
	if ($is_network_game)
		Change \{setlist_previous_tier = 1}
		Change \{setlist_previous_song = 0}
		Change \{setlist_previous_tab = tab_setlist}
		create_setlist_popup
		<bg_helper_pos> = (140.0, 585.0)
		if ($current_tab = tab_setlist)
			setlist_show_helperbar Pos = (<bg_helper_pos> + (64.0, 4.0))
		elseif ($current_tab = tab_bonus)
			setlist_show_helperbar {
				Pos = (<bg_helper_pos> + (64.0, 4.0))
				text_option1 = ($sl_setlist_big)
				button_option1 = "\\b6"
			}
		endif
	endif
	Change \{disable_menu_sounds = 1}
	begin
	if ($setlist_selection_tier >= $setlist_previous_tier)
		if ($setlist_selection_song >= $setlist_previous_song)
			break
		endif
	endif
	last_tier = ($setlist_selection_tier)
	last_song = ($setlist_selection_song)
	LaunchEvent \{Type = pad_down
		Target = vmenu_setlist}
	if (<last_tier> = $setlist_selection_tier)
		if (<last_song> = $setlist_selection_song)
			break
		endif
	endif
	repeat
	Change \{disable_menu_sounds = 0}
	if ($setlist_selection_found = 1)
		FormatText \{ChecksumName = tier_checksum
			'tier%s'
			S = $setlist_selection_tier}
		Song = ($g_gh3_setlist.<tier_checksum>.songs [$setlist_selection_song])
		if ($game_mode = p2_quickplay)
			get_difficulty_text_nl DIFFICULTY = ($current_difficulty_coop)
		else
			get_difficulty_text_nl DIFFICULTY = ($current_difficulty)
		endif
		get_song_prefix Song = <song>
		get_formatted_songname song_prefix = (<song_prefix>) difficulty_text_nl = <difficulty_text_nl>
		GetGlobalTags <songname>
		is_not_randomized song = <song>
		if (<achievement_gold_star> = 1 || (<not_randomized> = TRUE))
			change target_setlist_songpreview = <song>
		else
			change target_setlist_songpreview = None
		endif
	else
		Change \{target_setlist_songpreview = NONE}
	endif
	if ($g_keep_song_preview = 0)
		destroy_setlist_songpreview_monitor
		SpawnScriptLater \{setlist_songpreview_monitor}
	endif
	if (($is_network_game = 1) && ($net_can_send_approval = 1))
		net_lobby_state_message \{current_state = Song
			action = approval}
		Change \{net_can_send_approval = 0}
	endif
endscript

script GuitarEvent_SongWon_Spawned 
	if ($is_network_game)
		mark_unsafe_for_shutdown
		if ($shutdown_game_for_signin_change_flag = 1)
			return
		endif
		if ($ui_flow_manager_state [0] = online_pause_fs)
			net_unpausegh3
		endif
		KillSpawnedScript \{name = dispatch_player_state}
		if ($player2_present)
			SendNetMessage {
				type = net_win_song
				stars = ($player1_status.stars)
				note_streak = ($player1_status.best_run)
				notes_hit = ($player1_status.notes_hit)
				total_notes = ($player1_status.total_notes)
			}
		endif
		if NOT ($game_mode = p2_battle || $cheat_nofail = 1 || $cheat_easyexpert = 1)
			if ($game_mode = p2_coop)
				online_song_end_write_stats \{song_type = coop}
			else
				online_song_end_write_stats \{song_type = single}
			endif
		endif
	endif
	if ($is_attract_mode = 1)
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = exit_attract_mode
				play_sound = 0
			}}
		return
	endif
	if ($game_mode = training || $game_mode = tutorial)
		return
	endif
	if ($current_song = bossdevil && $devil_finish = 0)
		change \{devil_finish = 1}
	else
		change \{devil_finish = 0}
	endif
	Progression_EndCredits_Done
	pausegame
	kill_start_key_binding
	if ($battle_sudden_death = 1)
		SoundEvent \{event = GH_SFX_BattleMode_Sudden_Death}
	else
		if ($game_mode = p1_career || $game_mode = p2_career || $game_mode = p2_coop || $game_mode = p1_quickplay)
			SoundEvent \{event = You_Rock_End_SFX}
		endif
	endif
	spawnscriptnow \{You_Rock_Waiting_Crowd_SFX}
	if ($game_mode = p2_battle || $boss_battle = 1)
		if ($player1_status.current_health >= $player2_status.current_health)
			if ($current_song = bossdevil)
				preload_movie = 'Satan-Battle_WIN'
			else
				preload_movie = 'Player1_wins'
			endif
		else
			if ($current_song = bossdevil)
				preload_movie = 'Satan-Battle_LOSS'
			else
				preload_movie = 'Player2_wins'
			endif
		endif
		if ($current_song = bossdevil && $devil_finish = 0)
			preload_movie = 'Golden_Guitar'
		endif
		if ($battle_sudden_death = 1)
			preload_movie = 'Fret_Flames'
		endif
		KillMovie \{textureslot = 1}
		PreLoadMovie {
			movie = <preload_movie>
			textureslot = 1
			texturepri = 70
			no_looping
			no_hold
			nowait
		}
	endif
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		spawnscriptnow \{wait_and_play_you_rock_movie}
	endif
	destroy_menu \{menu_id = yourock_text}
	destroy_menu \{menu_id = yourock_text_2}
	tie = FALSE
	text_pos = (640.0, 360.0)
	rock_legend = 0
	fit_dims = (350.0, 0.0)
	if ($battle_sudden_death = 1)
		winner_text = ($win_text_sudden_death)
		winner_space_between = (65.0, 0.0)
		winner_scale = 1.8
	else
		if ($game_mode = p2_battle)
			p1_health = ($player1_status.current_health)
			p2_health = ($player2_status.current_health)
			if (<p2_health> > <p1_health>)
				winner = ($number_text_two)
				SoundEvent \{event = UI_2ndPlayerWins_SFX}
			else
				winner = ($number_text_one)
				SoundEvent \{event = UI_1stPlayerWins_SFX}
			endif
			if ($is_network_game)
				if (<p2_health> > <p1_health>)
					name = ($opponent_gamertag)
				else
					NetSessionFunc \{obj = match
						func = get_gamertag}
				endif
				FormatText textname = winner_text <name>
				<text_pos> = (640.0, 240.0)
			else
				FormatText textname = winner_text ($player_x_rocks) s = <winner>
			endif
			winner_space_between = (50.0, 0.0)
			winner_scale = 1.5
		elseif ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
			p1_score = ($player1_status.Score)
			p2_score = ($player2_status.Score)
			if (<p2_score> > <p1_score>)
				winner = ($number_text_two)
				SoundEvent \{event = UI_2ndPlayerWins_SFX}
			elseif (<p1_score> > <p2_score>)
				winner = ($number_text_one)
				SoundEvent \{event = UI_1stPlayerWins_SFX}
			else
				<tie> = TRUE
				SoundEvent \{event = You_Rock_End_SFX}
			endif
			if (<tie> = TRUE)
				winner_text = ($winner_text_tie)
				winner_space_between = (15.0, 0.0)
				winner_scale = 0.5
				fit_dims = (100.0, 0.0)
			else
				if ($is_network_game)
					if (<p2_score> > <p1_score>)
						name = ($opponent_gamertag)
					else
						NetSessionFunc \{obj = match
							func = get_gamertag}
					endif
					FormatText textname = winner_text <name>
					<text_pos> = (640.0, 240.0)
				else
					FormatText textname = winner_text ($player_x_rocks) s = <winner>
				endif
				winner_space_between = (50.0, 0.0)
				winner_scale = 1.5
			endif
		else
			winner_text = ($win_text_you_rock)
			winner_space_between = (40.0, 0.0)
			fit_dims = (350.0, 0.0)
			winner_scale = 1.0
		endif
		if ($devil_finish = 1)
			winner_text = ($win_text_finish_him)
			winner_space_between = (55.0, 0.0)
			winner_scale = 1.8
		endif
		if ($current_song = bossdevil && $devil_finish = 0)
			<rock_legend> = 1
			winner_text = ($win_text_rock_legend_1)
			<text_pos> = (800.0, 300.0)
			winner_space_between = (40.0, 0.0)
			winner_scale = 1.1
			fit_dims = (200.0, 0.0)
		endif
	endif
	StringLength string = <winner_text>
	<fit_dims> = (<str_len> * (23.0, 0.0))
	if (<fit_dims>.(1.0, 0.0) >= 350)
		<fit_dims> = (350.0, 0.0)
	endif
	split_text_into_array_elements {
		id = yourock_text
		text = <winner_text>
		text_pos = <text_pos>
		space_between = <winner_space_between>
		fit_dims = <fit_dims>
		flags = {
			rgba = [255 255 255 255]
			Scale = <winner_scale>
			z_priority = 95
			font = text_a10_Large
			rgba = [223 223 223 255]
			just = [center center]
			alpha = 1
		}
		centered
	}
	if (<rock_legend> = 1)
		split_text_into_array_elements {
			id = yourock_text_legend
			text = ($win_text_rock_legend_2)
			text_pos = (800.0, 420.0)
			space_between = <winner_space_between>
			fit_dims = (200.0, 0.0)
			flags = {
				rgba = [255 255 255 255]
				Scale = <winner_scale>
				z_priority = 95
				font = text_a10_Large
				rgba = [223 223 223 255]
				just = [center center]
				alpha = 1
			}
			centered
		}
	endif
	if (($is_network_game) && ($battle_sudden_death = 0) && (<tie> = FALSE))
		if NOT ($game_mode = p2_coop)
			split_text_into_array_elements {
				id = yourock_text_2
				text = ($player_text_rocks)
				text_pos = (640.0, 380.0)
				fit_dims = <fit_dims>
				space_between = <winner_space_between>
				flags = {
					rgba = [255 255 255 255]
					Scale = <winner_scale>
					z_priority = 95
					font = text_a10_Large
					rgba = [223 223 223 255]
					just = [center center]
					alpha = 1
				}
				centered
			}
		endif
	endif
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		spawnscriptnow \{waitAndKillHighway}
		KillSpawnedScript \{name = jiggle_text_array_elements}
		spawnscriptnow \{jiggle_text_array_elements
			params = {
				id = yourock_text
				time = 1.0
				wait_time = 3000
				explode = 1
			}}
		if (<rock_legend> = 1)
			spawnscriptnow \{jiggle_text_array_elements
				params = {
					id = yourock_text_legend
					time = 1.0
					wait_time = 3000
					explode = 1
				}}
		endif
		if ($is_network_game)
			spawnscriptnow \{jiggle_text_array_elements
				params = {
					id = yourock_text_2
					time = 1.0
					wait_time = 3000
					explode = 1
				}}
		endif
		if ($current_song = bossslash || $current_song = bosstom || $current_song = bossdevil)
			boss_character = -1
			if ($current_song = bossslash)
				<boss_character> = 0
			elseif ($current_song = bosstom)
				<boss_character> = 1
			elseif ($current_song = bossdevil)
				<boss_character> = 2
			endif
			if (<boss_character> >= 0)
				unlocked_for_purchase = 1
				GetGlobalTags ($Secret_Characters [<boss_character>].id)
				if (<unlocked_for_purchase> = 0)
					spawnscriptnow \{Boss_Unlocked_Text
						params = {
							parent_id = yourock_text
						}}
					SetGlobalTags ($Secret_Characters [<boss_character>].id) params = {unlocked_for_purchase = 1}
				endif
			endif
		endif
	endif
	change \{old_song = None}
	if NOT ($devil_finish = 1)
		if NOT ($battle_sudden_death = 1)
			Progression_SongWon
			if ($current_transition = preencore)
				end_song
				UnPauseGame
				Transition_Play \{type = preencore}
				Transition_Wait
				change \{current_transition = None}
				pausegame
				ui_flow_manager_respond_to_action \{action = preencore_win_song}
				encore_transition = 1
			elseif ($current_transition = preboss)
				end_song
				UnPauseGame
				Transition_Play \{type = preboss}
				Transition_Wait
				change \{current_transition = None}
				pausegame
				change \{use_last_player_scores = 1}
				change old_song = ($current_song)
				change \{show_boss_helper_screen = 1}
				ui_flow_manager_respond_to_action \{action = preboss_win_song}
				if ($is_network_game = 0)
					if NOT ($boss_battle = 1)
						if NOT ($devil_finish)
							agora_write_stats
						endif
					endif
					net_write_single_player_stats
					SpawnScriptLater \{xenon_singleplayer_session_complete_uninit}
				endif
				return
			else
				UnPauseGame
				Transition_Play \{type = songWon}
				Transition_Wait
				change \{current_transition = None}
				pausegame
			endif
		else
			UnPauseGame
			Transition_Play \{type = songWon}
			spawnscriptnow \{wait_and_play_you_rock_movie}
			KillSpawnedScript \{name = jiggle_text_array_elements}
			spawnscriptnow \{jiggle_text_array_elements
				params = {
					id = yourock_text
					time = 1.0
					wait_time = 3000
					explode = 1
				}}
			spawnscriptnow \{Sudden_Death_Helper_Text
				params = {
					parent_id = yourock_text
				}}
			wait \{0.1
				seconds}
			spawnscriptnow \{waitAndKillHighway}
			wait \{4
				seconds}
			change \{current_transition = None}
			pausegame
		endif
	else
		UnPauseGame
		Transition_Play \{type = songWon}
		spawnscriptnow \{wait_and_play_you_rock_movie}
		KillSpawnedScript \{name = jiggle_text_array_elements}
		spawnscriptnow \{jiggle_text_array_elements
			params = {
				id = yourock_text
				time = 1.0
				wait_time = 2000
				explode = 1
			}}
		devil_finish_anim
		wait \{0.15
			seconds}
		spawnscriptnow \{waitAndKillHighway}
		wait \{2.5
			seconds}
		SoundEvent \{event = Devil_Die_Transition_SFX}
		wait \{0.5
			seconds}
		change \{current_transition = None}
		pausegame
	endif
	if ($end_credits = 1 && $current_song = bossdevil)
		Menu_Music_Off
		PlayMovieAndWait \{movie = 'singleplayer_end'}
		get_movie_id_by_name \{movie = 'singleplayer_end'}
		SetGlobalTags <id> params = {unlocked = 1}
	endif
	if ($battle_sudden_death = 1)
		stopsoundevent \{GH_SFX_BattleMode_Sudden_Death}
		printf \{"BATTLE MODE, Song Won, Begin Sudden Death"}
		change \{battle_sudden_death = 1}
		if ($is_network_game)
			ui_flow_manager_respond_to_action \{action = sudden_death_begin}
			SpawnScriptLater \{load_and_sync_timing
				params = {
					start_delay = 4000
					player_status = player1_status
				}}
		else
			ui_flow_manager_respond_to_action \{action = select_retry}
			spawnscriptnow \{restart_song
				params = {
					sudden_death = 1
				}}
		endif
		if ScreenElementExists \{id = yourock_text}
			DestroyScreenElement \{id = yourock_text}
		endif
	elseif ($end_credits = 1 && $current_song = thrufireandflames && force_credits = 0)
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		change \{end_credits = 0}
		career_song_ended_select_quit
		start_flow_manager \{flow_state = career_credits_autosave_fs}
	elseif ($end_credits = 1 && $current_song = dlc1504750512)
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		change \{end_credits = 0}
		change \{force_credits = 0}
		career_song_ended_select_quit
		start_flow_manager \{flow_state = career_credits_autosave_fs}
	elseif ($devil_finish = 1)
		start_devil_finish
	else
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		destroy_menu \{menu_id = yourock_text_legend}
		ui_flow_manager_respond_to_action \{action = win_song}
	endif
	if ($is_network_game = 1)
		if ishost
			agora_write_stats
		endif
	elseif NOT ($boss_battle = 1)
		if NOT ($devil_finish)
			agora_write_stats
		endif
	endif
	if ($is_network_game = 0)
		net_write_single_player_stats
	endif
	if (($game_mode = p1_career) || ($game_mode = p2_career))
		agora_update
	endif
	if ($is_network_game = 0)
		if NOT ($devil_finish = 1)
			if NOT ($battle_sudden_death = 1)
				if NOT GotParam \{encore_transition}
					spawnscriptnow \{xenon_singleplayer_session_complete_uninit}
				endif
			endif
		endif
	endif
	SoundEvent \{event = Crowd_Med_To_Good_SFX}
	if ($is_network_game)
		mark_safe_for_shutdown
	endif
endscript
