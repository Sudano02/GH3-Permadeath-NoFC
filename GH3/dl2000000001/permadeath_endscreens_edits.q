GH3_Career_Progression = [
	{
		name = set_initial_states
		type = scr
		atom_script = Progression_Init
		atom_params = {
		}
	}
	{
		name = career_tier1_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 1
		}
		depends_on = [
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 1
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier1_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 1
		}
		depends_on = [
			{
				type = atom
				atom = career_tier1_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier1_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 1
		}
		depends_on = [
			{
				type = atom
				atom = career_tier1_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 1
				}
			}
		]
	}
	{
		name = career_tier1_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 1
		}
		depends_on = [
			{
				type = atom
				atom = career_tier1_songscomplete
			}
			{
				type = atom
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
		name = career_tier2_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 2
		}
		depends_on = [
			{
				type = atom
				atom = career_tier1_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 2
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier2_bossunlock
		type = scr
		atom_script = Progression_TierBossUnlock
		atom_params = {
			tier = 2
		}
		depends_on = [
			{
				type = atom
				atom = career_tier2_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier2_bosscomplete
		type = scr
		atom_script = Progression_TierBossComplete
		atom_params = {
			tier = 2
		}
		depends_on = [
			{
				type = atom
				atom = career_tier2_bossunlock
			}
			{
				type = scr
				scr = Progression_CheckBossComplete
				params = {
					tier = 2
				}
			}
		]
	}
	{
		name = career_tier2_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 2
		}
		depends_on = [
			{
				type = atom
				atom = career_tier2_songscomplete
			}
			{
				type = atom
				atom = career_tier2_bosscomplete
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
		name = career_tier2_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 2
		}
		depends_on = [
			{
				type = atom
				atom = career_tier2_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 2
				}
			}
		]
	}
	{
		name = career_tier2_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 2
		}
		depends_on = [
			{
				type = atom
				atom = career_tier2_songscomplete
			}
			{
				type = atom
				atom = career_tier2_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
			{
				type = atom
				atom = career_tier2_bosscomplete
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
		name = career_tier3_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 3
		}
		depends_on = [
			{
				type = atom
				atom = career_tier2_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 3
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier3_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 3
		}
		depends_on = [
			{
				type = atom
				atom = career_tier3_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier3_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 3
		}
		depends_on = [
			{
				type = atom
				atom = career_tier3_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 3
				}
			}
		]
	}
	{
		name = career_tier3_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 3
		}
		depends_on = [
			{
				type = atom
				atom = career_tier3_songscomplete
			}
			{
				type = atom
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
		name = career_tier4_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 4
		}
		depends_on = [
			{
				type = atom
				atom = career_tier3_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 4
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier4_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 4
		}
		depends_on = [
			{
				type = atom
				atom = career_tier4_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier4_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 4
		}
		depends_on = [
			{
				type = atom
				atom = career_tier4_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 4
				}
			}
		]
	}
	{
		name = career_tier4_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 4
		}
		depends_on = [
			{
				type = atom
				atom = career_tier4_songscomplete
			}
			{
				type = atom
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
		name = career_tier5_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 5
		}
		depends_on = [
			{
				type = atom
				atom = career_tier4_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 5
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier5_bossunlock
		type = scr
		atom_script = Progression_TierBossUnlock
		atom_params = {
			tier = 5
		}
		depends_on = [
			{
				type = atom
				atom = career_tier5_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier5_bosscomplete
		type = scr
		atom_script = Progression_TierBossComplete
		atom_params = {
			tier = 5
		}
		depends_on = [
			{
				type = atom
				atom = career_tier5_bossunlock
			}
			{
				type = scr
				scr = Progression_CheckBossComplete
				params = {
					tier = 5
				}
			}
		]
	}
	{
		name = career_tier5_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 5
		}
		depends_on = [
			{
				type = atom
				atom = career_tier5_songscomplete
			}
			{
				type = atom
				atom = career_tier5_bosscomplete
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
		name = career_tier5_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 5
		}
		depends_on = [
			{
				type = atom
				atom = career_tier5_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 5
				}
			}
		]
	}
	{
		name = career_tier5_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 5
		}
		depends_on = [
			{
				type = atom
				atom = career_tier5_songscomplete
			}
			{
				type = atom
				atom = career_tier5_encorecomplete
				required = [
					1
					1
					1
					1
				]
			}
			{
				type = atom
				atom = career_tier5_bosscomplete
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
		name = career_tier6_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 6
		}
		depends_on = [
			{
				type = atom
				atom = career_tier5_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 6
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier6_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 6
		}
		depends_on = [
			{
				type = atom
				atom = career_tier6_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier6_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 6
		}
		depends_on = [
			{
				type = atom
				atom = career_tier6_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 6
				}
			}
		]
	}
	{
		name = career_tier6_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 6
		}
		depends_on = [
			{
				type = atom
				atom = career_tier6_songscomplete
			}
			{
				type = atom
				atom = career_tier6_encorecomplete
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
		name = career_tier7_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 7
		}
		depends_on = [
			{
				type = atom
				atom = career_tier6_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 7
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier7_encoreunlock
		type = scr
		atom_script = Progression_TierEncoreUnlock
		atom_params = {
			tier = 7
		}
		depends_on = [
			{
				type = atom
				atom = career_tier7_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier7_encorecomplete
		type = scr
		atom_script = Progression_TierEncoreComplete
		atom_params = {
			tier = 7
		}
		depends_on = [
			{
				type = atom
				atom = career_tier7_encoreunlock
			}
			{
				type = scr
				scr = Progression_CheckEncoreComplete
				params = {
					tier = 7
				}
			}
		]
	}
	{
		name = career_tier7_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 7
		}
		depends_on = [
			{
				type = atom
				atom = career_tier7_songscomplete
			}
			{
				type = atom
				atom = career_tier7_encorecomplete
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
		name = career_tier8_songscomplete
		type = scr
		atom_script = Progression_TierSongsComplete
		atom_params = {
			tier = 8
		}
		depends_on = [
			{
				type = atom
				atom = career_tier7_complete
			}
			{
				type = scr
				scr = Progression_CheckSongComplete
				params = {
					tier = 8
					numsongstoprogress = $GH3_Career_NumSongToProgress
				}
			}
		]
	}
	{
		name = career_tier8_bossunlock
		type = scr
		atom_script = Progression_TierBossUnlock
		atom_params = {
			tier = 8
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_songscomplete
			}
			{
				type = scr
				scr = Progression_AlwaysBlock
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
		name = career_tier8_bosscomplete
		type = scr
		atom_script = Progression_TierBossComplete
		atom_params = {
			tier = 8
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_bossunlock
			}
			{
				type = scr
				scr = Progression_CheckBossComplete
				params = {
					tier = 8
				}
			}
		]
	}
	{
		name = career_tier8_complete
		type = scr
		atom_script = Progression_TierComplete
		atom_params = {
			tier = 8
			finished_game
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_songscomplete
			}
			{
				type = atom
				atom = career_tier8_bosscomplete
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
		name = unlock_guitar1
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 1
			for_difficulty
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_complete
			}
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = easy
					mode = p1_career
				}
			}
		]
	}
	{
		name = unlock_guitar2
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 2
			for_stars
		}
		depends_on = [
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = easy
					mode = p1_career
				}
			}
			{
				type = scr
				scr = Progression_CheckSong5Star
				params = {
				}
			}
		]
	}
	{
		name = unlock_guitar3
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 3
			for_difficulty
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_complete
			}
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = medium
					mode = p1_career
				}
			}
		]
	}
	{
		name = unlock_guitar4
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 4
			for_stars
		}
		depends_on = [
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = medium
					mode = p1_career
				}
			}
			{
				type = scr
				scr = Progression_CheckSong5Star
				params = {
				}
			}
		]
	}
	{
		name = unlock_guitar5
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 5
			for_difficulty
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_complete
			}
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = hard
					mode = p1_career
				}
			}
		]
	}
	{
		name = unlock_guitar6
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 6
			for_stars
		}
		depends_on = [
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = hard
					mode = p1_career
				}
			}
			{
				type = scr
				scr = Progression_CheckSong5Star
				params = {
				}
			}
		]
	}
	{
		name = unlock_guitar7
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 7
			for_difficulty
		}
		depends_on = [
			{
				type = atom
				atom = career_tier8_complete
			}
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = expert
					mode = p1_career
				}
			}
		]
	}
	{
		name = unlock_guitar8
		type = scr
		atom_script = Progression_UnlockGuitar
		atom_params = {
			guitar = 8
			for_stars
		}
		depends_on = [
			{
				type = scr
				scr = Progression_CheckDiff
				params = {
					diff = expert
					mode = p1_career
				}
			}
			{
				type = scr
				scr = Progression_CheckSong5Star
				params = {
				}
			}
		]
	}
	{
		name = career_bonus_songscomplete
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
		name = end_of_first_update
		type = scr
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
	GetGlobalTags <band_info> param = name
	band_name = <name>
	FormatText textname = band_name_text "%s" s = <band_name>
	difficulty_text = ($def_expert_text)
	next_difficulty_text = "PRECISION MODE CHEAT"
	<difficulty> = ($current_difficulty)
	if ($game_mode = p2_career)
		<index1> = ($difficulty_list_props.($current_difficulty).index)
		<index2> = ($difficulty_list_props.($current_difficulty2).index)
		if (<index2> < <index1>)
			<difficulty> = ($current_difficulty2)
		endif
	endif
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
		rgba = [140 70 70 255]
		Pos = (640.0, 366.0)
	}
	GetScreenElementDims \{id = bgs_band_name}
	if (<width> > 300)
		fit_text_in_rectangle \{id = bgs_band_name
			dims = (1060.0, 130.0)
			Pos = (640.0, 366.0)}
	endif
	FormatText textname = title_text $beat_game_title d = <difficulty_text>
	CreateScreenElement {
		type = TextElement
		parent = beat_game_container
		id = bgs_under_title
		just = [left top]
		font = <menu_font>
		text = <title_text>
		Scale = 1.0
		rgba = [250 245 145 255]
	}
	fit_text_in_rectangle \{id = bgs_under_title
		dims = (700.0, 65.0)
		Pos = (300.0, 428.0)}
	if (<difficulty> = expert)
		FormatText textname = motivation_text ($beat_game_message_expert) n = <next_difficulty_text>
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
		rgba = [250 245 145 255]
		just = [center top]
		internal_just = [center top]
		Scale = 0.7
		z_priority = 3
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
	spawnscriptnow scroll_band_name params = {band_text = <band_name_text>}
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

script create_setlist_menu 
	if (($is_network_game = 1) && ($net_can_send_approval = 1))
		net_lobby_state_message {
			current_state = ($net_current_flow_state)
			action = request
			request_state = song
		}
	endif
	if ($is_network_game = 1)
		change \{current_tab = tab_setlist}
		change \{setlist_previous_tier = 1}
		change \{setlist_previous_song = 0}
		change \{setlist_previous_tab = tab_setlist}
	endif
	if ($end_credits = 1 && $current_song = bossdevil)
		Progression_EndCredits
		return
	elseif ($fcd_all_songs_last_song = 1)
		change \{fcd_all_songs_last_song = 0}
		if ($end_credits = 1)
			Progression_EndCreditsPermadeath
			return
		endif
	endif
	change \{boss_wuss_out = 0}
	if ($progression_play_completion_movie = 1)
		get_progression_globals game_mode = ($game_mode)
		FormatText checksumname = tiername 'tier%i' i = ($progression_completion_tier)
		if StructureContains structure = ($<tier_global>.<tiername>) completion_movie
			Menu_Music_Off
			PlayMovieAndWait movie = ($<tier_global>.<tiername>.completion_movie)
			get_movie_id_by_name movie = ($<tier_global>.<tiername>.completion_movie)
			SetGlobalTags <id> params = {unlocked = 1}
		endif
		change \{progression_play_completion_movie = 0}
	endif
	change \{progression_unlocked_guitar = -1}
	change \{progression_unlocked_guitar2 = -1}
	change \{rich_presence_context = presence_song_list}
	Menu_Music_Off
	get_progression_globals game_mode = ($game_mode)
	change g_gh3_setlist = <tier_global>
	create_setlist_scrolling_menu
	change \{setlist_page3_z = 3.3}
	change \{setlist_page2_z = 3.4}
	change \{setlist_page1_z = 3.5}
	change \{setlist_random_images_scroll_num = 0}
	change \{setlist_random_images_highest_num = 0}
	change_tab tab = ($setlist_previous_tab)
	setlist_display_random_bg_image
	if ($is_network_game)
		change \{setlist_previous_tier = 1}
		change \{setlist_previous_song = 0}
		change \{setlist_previous_tab = tab_setlist}
		create_setlist_popup
	endif
	change \{disable_menu_sounds = 1}
	begin
	if ($setlist_selection_tier >= $setlist_previous_tier)
		if ($setlist_selection_song >= $setlist_previous_song)
			break
		endif
	endif
	last_tier = ($setlist_selection_tier)
	last_song = ($setlist_selection_song)
	LaunchEvent \{type = pad_down
		target = vmenu_setlist}
	if (<last_tier> = $setlist_selection_tier)
		if (<last_song> = $setlist_selection_song)
			break
		endif
	endif
	repeat
	change \{disable_menu_sounds = 0}
	if ($setlist_selection_found = 1)
		FormatText \{checksumname = tier_checksum
			'tier%s'
			s = $setlist_selection_tier}
		song = ($g_gh3_setlist.<tier_checksum>.songs [$setlist_selection_song])
		get_song_formatted song_checksum = <song>
		GetGlobalTags <songname>
		is_not_randomized song = <song>
		printf "not_randomized = %b" b = <not_randomized>
		if (<achievement_gold_star> = 1 || (<not_randomized> = TRUE))
			change target_setlist_songpreview = <song>
		else
			change target_setlist_songpreview = None
		endif
	else
		change \{target_setlist_songpreview = None}
	endif
	SpawnScriptLater \{setlist_songpreview_monitor}
	if (($is_network_game = 1) && ($net_can_send_approval = 1))
		net_lobby_state_message \{current_state = song
			action = approval}
		change \{net_can_send_approval = 0}
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
