script testing_scripts_do_not_use
	FormatText textname = text "Colour Array: %i %j %k" i = <val1> j = <val2> k = <val3>
	displayText parent = user_control_container Scale = 1 text = <text>  rgba = [255 255 255 255] Pos = (870.0, 200.0) z = 50
endscript

script kill_gem_scroller \{no_render = 0}
	mark_unsafe_for_shutdown
	printf \{"kill_gem_scroller - Start"}
	if NOT GotParam \{restarting}
		stoprendering
	endif
	SongUnLoadFSBIfDownloaded
	disable_highway_prepass
	Kill_StarPower_Camera \{changecamera = 0}
	kill_walk_camera \{changecamera = 0}
	change \{structurename = player1_status
		star_power_amount = 0}
	change \{structurename = player2_status
		star_power_amount = 0}
	Kill_StarPower_StageFX player_text = ($player1_status.text) player_status = $player1_status ifempty = 0
	Kill_StarPower_StageFX player_text = ($player2_status.text) player_status = $player2_status ifempty = 0
	if ScreenElementExists \{id = starpower_container_leftp1}
		DoScreenElementMorph \{id = starpower_container_leftp1
			alpha = 0}
	endif
	if ScreenElementExists \{id = starpower_container_leftp2}
		DoScreenElementMorph \{id = starpower_container_leftp2
			alpha = 0}
	endif
	if ScreenElementExists \{id = starpower_container_rightp1}
		DoScreenElementMorph \{id = starpower_container_rightp1
			alpha = 0}
	endif
	if ScreenElementExists \{id = starpower_container_rightp2}
		DoScreenElementMorph \{id = starpower_container_rightp2
			alpha = 0}
	endif
	change \{showing_raise_axe = 0}
	kill_debug_elements
	GuitarEvent_ExitVenue
	destroy_cameracuts
	practicemode_deinit
	notemap_deinit
	destroy2dparticlesystem \{id = all}
	LaunchGemEvent \{event = kill_objects}
	destroy_credits_menu
	destroy_battle_alert_frames
	KillSpawnedScript \{name = move_2d_elements_to_default}
	KillSpawnedScript \{name = wait_and_play_you_rock_movie}
	KillSpawnedScript \{name = update_score_fast}
	KillSpawnedScript \{name = check_for_star_power}
	KillSpawnedScript \{name = wait_for_inactive}
	KillSpawnedScript \{name = pulsate_all_star_power_bulbs}
	KillSpawnedScript \{name = pulsate_star_power_bulb}
	KillSpawnedScript \{name = rock_meter_star_power_on}
	KillSpawnedScript \{name = rock_meter_star_power_off}
	KillSpawnedScript \{name = star_power_activate_and_drain}
	KillSpawnedScript \{name = hud_activated_star_power}
	KillSpawnedScript \{name = hud_move_note_scorebar}
	KillSpawnedScript \{name = hud_flash_red_bg_p1}
	KillSpawnedScript \{name = hud_flash_red_bg_p2}
	KillSpawnedScript \{name = hud_flash_red_bg_kill}
	KillSpawnedScript \{name = hud_lightning_alert}
	KillSpawnedScript \{name = hud_show_note_streak_combo}
	KillSpawnedScript \{name = highway_pulse_multiplier_loss}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> addtostringlookup
	FormatText textname = player_text 'p%i' i = <player> addtostringlookup
	change structurename = <player_status> star_power_used = 0
	GuitarEvent_KillSong <...>
	destroy_hud <...>
	destroy_highway <...>
	battlemode_deinit <...>
	bossbattle_deinit <...>
	faceoff_deinit <...>
	faceoff_volumes_deinit <...>
	player = (<player> + 1)
	repeat $max_num_players
	kill_startup_script <...>
	KillSpawnedScript \{name = GuitarEvent_MissedNote}
	KillSpawnedScript \{name = GuitarEvent_UnnecessaryNote}
	KillSpawnedScript \{name = GuitarEvent_HitNotes}
	KillSpawnedScript \{name = GuitarEvent_HitNote}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOn}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOff}
	KillSpawnedScript \{name = GuitarEvent_StarHitNote}
	KillSpawnedScript \{name = GuitarEvent_StarSequenceBonus}
	KillSpawnedScript \{name = GuitarEvent_StarMissNote}
	KillSpawnedScript \{name = GuitarEvent_WhammyOn}
	KillSpawnedScript \{name = GuitarEvent_WhammyOff}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOn}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOff}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Open}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Close}
	KillSpawnedScript \{name = GuitarEvent_crowd_poor_medium}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_good}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_poor}
	KillSpawnedScript \{name = GuitarEvent_crowd_good_medium}
	KillSpawnedScript \{name = GuitarEvent_CreateFirstGem}
	KillSpawnedScript \{name = highway_pulse_black}
	KillSpawnedScript \{name = GuitarEvent_HitNote_Spawned}
	KillSpawnedScript \{name = hit_note_fx}
	KillSpawnedScript \{name = Do_StarPower_StageFX}
	KillSpawnedScript \{name = do_starpower_camera}
	KillSpawnedScript \{name = first_gem_fx}
	KillSpawnedScript \{name = gem_iterator}
	KillSpawnedScript \{name = gem_array_stepper}
	KillSpawnedScript \{name = gem_array_events}
	KillSpawnedScript \{name = gem_step}
	KillSpawnedScript \{name = gem_step_end}
	KillSpawnedScript \{name = fretbar_iterator}
	KillSpawnedScript \{name = Strum_iterator}
	KillSpawnedScript \{name = FretPos_iterator}
	KillSpawnedScript \{name = FretFingers_iterator}
	KillSpawnedScript \{name = Drum_iterator}
	KillSpawnedScript \{name = Drum_cymbal_iterator}
	KillSpawnedScript \{name = WatchForStartPlaying_iterator}
	KillSpawnedScript \{name = gem_scroller}
	KillSpawnedScript \{name = button_checker}
	KillSpawnedScript \{name = check_buttons}
	KillSpawnedScript \{name = check_buttons_fast}
	KillSpawnedScript \{name = net_check_buttons}
	KillSpawnedScript \{name = fretbar_update_tempo}
	KillSpawnedScript \{name = fretbar_update_hammer_on_tolerance}
	KillSpawnedScript \{name = move_whammy}
	KillSpawnedScript \{name = create_fretbar}
	KillSpawnedScript \{name = move_highway_2d}
	KillSpawnedScript \{name = move_highway_prepass}
	KillSpawnedScript \{name = GuitarEvent_PreFretbar}
	KillSpawnedScript \{name = GuitarEvent_Fretbar}
	KillSpawnedScript \{name = check_note_hold}
	KillSpawnedScript \{name = net_check_note_hold}
	KillSpawnedScript \{name = star_power_whammy}
	KillSpawnedScript \{name = show_star_power_ready}
	KillSpawnedScript \{name = hud_glowburst_alert}
	change \{star_power_ready_on_p1 = 0}
	change \{star_power_ready_on_p2 = 0}
	KillSpawnedScript \{name = event_iterator}
	KillSpawnedScript \{name = win_song}
	KillSpawnedScript \{name = hand_note_iterator}
	KillSpawnedScript \{name = kill_object_later}
	KillSpawnedScript \{name = waitAndKillHighway}
	KillSpawnedScript \{name = testlevel_debug}
	KillSpawnedScript \{name = show_coop_raise_axe_for_starpower}
	KillSpawnedScript \{name = net_whammy_pitch_shift}
	KillSpawnedScript \{name = Crowd_AllPlayAnim}
	KillSpawnedScript \{name = hud_activated_star_power_spawned}
	KillSpawnedScript \{name = dispatch_player_state}
	KillSpawnedScript \{name = network_events}
	KillSpawnedScript \{name = online_win_song}
	new_net_logic_deinit
	destroy_net_popup
	destroy_gamertags
	LightShow_Shutdown
	Kill_LightShow_FX
	DestroyParticlesByGroupID \{groupid = zoneparticles}
	Transition_KillAll
	KillSpawnedScript \{name = GuitarEvent_SongFailed_Spawned}
	KillSpawnedScript \{name = play_intro}
	KillSpawnedScript \{name = begin_song_after_intro}
	hud_flash_red_bg_kill \{player = 1}
	hud_flash_red_bg_kill \{player = 2}
	printf \{"kill_gem_scroller - Killing Event Scripts"}
	KillSpawnedScript \{id = song_event_scripts}
	printf \{"kill_gem_scroller - Killing Event Scripts Finished"}
	KillSpawnedScript \{id = zone_scripts}
	printf \{"GetPakManCurrentName map = zones"}
	GetPakManCurrentName \{map = zones}
	printf \{"format Killsong"}
	FormatText checksumname = zone_killsong '%s_KillSong' s = <pakname>
	printf \{"Killsong check"}
	if ScriptExists <zone_killsong>
		printf \{"Kill the song"}
		<zone_killsong>
	endif
	printf \{"Destroy_AllWhammyFX"}
	Destroy_AllWhammyFX
	printf \{"LS_ResetVenueLights"}
	LS_ResetVenueLights
	printf \{"destroy_movie_viewport"}
	destroy_movie_viewport
	printf \{"destroy_crowd_models"}
	destroy_crowd_models
	printf \{"destroy_bg_viewport"}
	destroy_bg_viewport
	printf \{"destroy_intro"}
	destroy_intro
	printf \{"destroy_band"}
	destroy_band
	printf \{"change stance"}
	change \{structurename = guitarist_info
		stance = stance_frontend}
	printf \{"change next_stance"}
	change \{structurename = guitarist_info
		next_stance = stance_frontend}
	printf \{"change current_anim"}
	change \{structurename = guitarist_info
		current_anim = idle}
	printf \{"change cycle_anim"}
	change \{structurename = guitarist_info
		cycle_anim = TRUE}
	printf \{"change next_anim"}
	change \{structurename = guitarist_info
		next_anim = None}
	printf \{"change playing_missed_note"}
	change \{structurename = guitarist_info
		playing_missed_note = FALSE}
	printf \{"change bassist stance"}
	change \{structurename = bassist_info
		stance = stance_frontend}
	printf \{"change bassist next_stance"}
	change \{structurename = bassist_info
		next_stance = stance_frontend}
	printf \{"change bassist current_anim"}
	change \{structurename = bassist_info
		current_anim = idle}
	printf \{"change bassist cycle_anim"}
	change \{structurename = bassist_info
		cycle_anim = TRUE}
	printf \{"change bassist next_anim"}
	change \{structurename = bassist_info
		next_anim = None}
	printf \{"change bassist playing_missed_note"}
	change \{structurename = bassist_info
		playing_missed_note = FALSE}
	printf \{"destroy_debug_measure_text"}
	destroy_debug_measure_text
	printf \{"kill_character_scripts"}
	kill_character_scripts
	change \{check_for_unplugged_controllers = 0}
	shut_down_practice_mode
	destroy_menu \{menu_id = you_rock_container}
	KillMovie \{textureslot = 1}
	printf \{"kill_gem_scroller - waiting for dead objects"}
	wait \{2
		gameframes}
	printf \{"kill_gem_scroller - waiting for dead objects End"}
	end_song
	if NOT (<no_render> = 1)
		if ($shutdown_game_for_signin_change_flag = 0)
			startrendering
		endif
	endif
	printf \{"kill_gem_scroller - End"}
	mark_safe_for_shutdown
	change \{playing_song = 0}
endscript

script play_outro 
	SongUnLoadFSBIfDownloaded
	Kill_StarPower_Camera \{changecamera = 0}
	kill_walk_camera \{changecamera = 0}
	change \{structurename = player1_status
		star_power_amount = 0}
	change \{structurename = player2_status
		star_power_amount = 0}
	Kill_StarPower_StageFX player_text = ($player1_status.text) player_status = $player1_status ifempty = 0
	Kill_StarPower_StageFX player_text = ($player2_status.text) player_status = $player2_status ifempty = 0
	change \{showing_raise_axe = 0}
	destroy2dparticlesystem \{id = all}
	LaunchGemEvent \{event = kill_objects}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> addtostringlookup
	FormatText textname = player_text 'p%i' i = <player> addtostringlookup
	GuitarEvent_KillSong <...>
	destroy_hud <...>
	battlemode_deinit <...>
	bossbattle_deinit <...>
	faceoff_deinit <...>
	faceoff_volumes_deinit <...>
	player = (<player> + 1)
	repeat $max_num_players
	practicemode_deinit
	notemap_deinit
	kill_startup_script <...>
	KillSpawnedScript \{name = GuitarEvent_MissedNote}
	KillSpawnedScript \{name = GuitarEvent_UnnecessaryNote}
	KillSpawnedScript \{name = GuitarEvent_HitNotes}
	KillSpawnedScript \{name = GuitarEvent_HitNote}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOn}
	KillSpawnedScript \{name = GuitarEvent_StarPowerOff}
	KillSpawnedScript \{name = GuitarEvent_StarHitNote}
	KillSpawnedScript \{name = GuitarEvent_StarSequenceBonus}
	KillSpawnedScript \{name = GuitarEvent_StarMissNote}
	KillSpawnedScript \{name = GuitarEvent_WhammyOn}
	KillSpawnedScript \{name = GuitarEvent_WhammyOff}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOn}
	KillSpawnedScript \{name = GuitarEvent_StarWhammyOff}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Open}
	KillSpawnedScript \{name = GuitarEvent_Note_Window_Close}
	KillSpawnedScript \{name = GuitarEvent_crowd_poor_medium}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_good}
	KillSpawnedScript \{name = GuitarEvent_crowd_medium_poor}
	KillSpawnedScript \{name = GuitarEvent_crowd_good_medium}
	KillSpawnedScript \{name = GuitarEvent_CreateFirstGem}
	KillSpawnedScript \{name = highway_pulse_black}
	KillSpawnedScript \{name = GuitarEvent_HitNote_Spawned}
	KillSpawnedScript \{name = hit_note_fx}
	KillSpawnedScript \{name = Do_StarPower_StageFX}
	KillSpawnedScript \{name = do_starpower_camera}
	KillSpawnedScript \{name = first_gem_fx}
	KillSpawnedScript \{name = gem_iterator}
	KillSpawnedScript \{name = gem_array_stepper}
	KillSpawnedScript \{name = gem_array_events}
	KillSpawnedScript \{name = gem_step}
	KillSpawnedScript \{name = gem_step_end}
	KillSpawnedScript \{name = fretbar_iterator}
	KillSpawnedScript \{name = Strum_iterator}
	KillSpawnedScript \{name = FretPos_iterator}
	KillSpawnedScript \{name = FretFingers_iterator}
	KillSpawnedScript \{name = Drum_iterator}
	KillSpawnedScript \{name = Drum_cymbal_iterator}
	KillSpawnedScript \{name = WatchForStartPlaying_iterator}
	KillSpawnedScript \{name = gem_scroller}
	KillSpawnedScript \{name = button_checker}
	KillSpawnedScript \{name = check_buttons}
	KillSpawnedScript \{name = check_buttons_fast}
	KillSpawnedScript \{name = fretbar_update_tempo}
	KillSpawnedScript \{name = fretbar_update_hammer_on_tolerance}
	KillSpawnedScript \{name = move_whammy}
	KillSpawnedScript \{name = create_fretbar}
	KillSpawnedScript \{name = move_highway_2d}
	KillSpawnedScript \{name = update_score_fast}
	KillSpawnedScript \{name = check_for_star_power}
	KillSpawnedScript \{name = wait_for_inactive}
	KillSpawnedScript \{name = GuitarEvent_PreFretbar}
	KillSpawnedScript \{name = GuitarEvent_Fretbar}
	KillSpawnedScript \{name = check_note_hold}
	KillSpawnedScript \{name = star_power_whammy}
	KillSpawnedScript \{name = show_star_power_ready}
	KillSpawnedScript \{name = hud_glowburst_alert}
	change \{star_power_ready_on_p1 = 0}
	change \{star_power_ready_on_p2 = 0}
	KillSpawnedScript \{name = event_iterator}
	KillSpawnedScript \{name = win_song}
	KillSpawnedScript \{name = hand_note_iterator}
	KillSpawnedScript \{name = kill_object_later}
	KillSpawnedScript \{name = show_coop_raise_axe_for_starpower}
	KillSpawnedScript \{name = net_whammy_pitch_shift}
	KillSpawnedScript \{name = Crowd_AllPlayAnim}
	KillSpawnedScript \{name = hud_activated_star_power_spawned}
	KillSpawnedScript \{name = pulsate_all_star_power_bulbs}
	KillSpawnedScript \{name = pulsate_star_power_bulb}
	KillSpawnedScript \{name = rock_meter_star_power_on}
	KillSpawnedScript \{name = rock_meter_star_power_off}
	KillSpawnedScript \{name = hud_activated_star_power}
	KillSpawnedScript \{name = hud_move_note_scorebar}
	KillSpawnedScript \{name = hud_flash_red_bg_p1}
	KillSpawnedScript \{name = hud_flash_red_bg_p2}
	KillSpawnedScript \{name = hud_flash_red_bg_kill}
	KillSpawnedScript \{name = hud_lightning_alert}
	KillSpawnedScript \{name = hud_show_note_streak_combo}
	KillSpawnedScript \{name = play_intro}
	KillSpawnedScript \{name = begin_song_after_intro}
	if GotParam \{kill_cameracuts_iterator}
		KillSpawnedScript \{name = cameracuts_iterator}
	endif
	printf \{"kill_gem_scroller - Killing Event Scripts"}
	KillSpawnedScript \{id = song_event_scripts}
	printf \{"kill_gem_scroller - Killing Event Scripts Finished"}
	printf \{"Destroy_AllWhammyFX"}
	Destroy_AllWhammyFX
	printf \{"destroy_intro"}
	destroy_intro
	printf \{"end_song"}
	end_song <...>
	printf \{"finished_end_song"}
endscript

script GuitarEvent_SongFailed_Spawned 
	if NOT ($boss_battle = 1)
		disable_highway_prepass
		disable_bg_viewport
	endif
	if ($is_network_game)
		KillSpawnedScript \{name = dispatch_player_state}
		kill_start_key_binding
		if ($ui_flow_manager_state [0] = online_pause_fs)
			net_unpausegh3
		endif
		mark_unsafe_for_shutdown
	endif
	getsongtimems
	change failed_song_time = <time>
	Achievements_SongFailed
	pausegame
	Progression_SongFailed
	if ($boss_battle = 1)
		kill_start_key_binding
		if ($current_song = bossdevil)
			preload_movie = 'Satan-Battle_LOSS'
		else
			preload_movie = 'Player2_wins'
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
		FormatText textname = winner_text "%s Rocks!" s = ($current_boss.character_name)
		winner_space_between = (50.0, 0.0)
		winner_scale = 1.0
		if ($current_boss.character_profile = Morello)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		if ($current_boss.character_profile = Slash)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		if ($current_boss.character_profile = Satan)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		spawnscriptnow \{wait_and_play_you_rock_movie}
		wait \{0.2
			seconds}
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		StringLength string = <winner_text>
		<fit_dims> = (<str_len> * (23.0, 0.0))
		if (<fit_dims>.(1.0, 0.0) >= 350)
			<fit_dims> = (350.0, 0.0)
		endif
		split_text_into_array_elements {
			id = yourock_text
			text = <winner_text>
			text_pos = (640.0, 360.0)
			space_between = <winner_space_between>
			just = [center center]
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
		spawnscriptnow \{waitAndKillHighway}
		KillSpawnedScript \{name = jiggle_text_array_elements}
		spawnscriptnow \{jiggle_text_array_elements
			params = {
				id = yourock_text
				time = 1.0
				wait_time = 3000
				explode = 1
			}}
	endif
	if ($is_network_game = 0)
		xenon_singleplayer_session_begin_uninit
		spawnscriptnow \{xenon_singleplayer_session_complete_uninit}
	endif
	UnPauseGame
	SoundEvent \{event = Crowd_Fail_Song_SFX}
	SoundEvent \{event = GH_SFX_You_Lose_Single_Player}
	printf {"Transition_Play"}
	Transition_Play \{type = songlost}
	printf {"Transition_Wait"}
	Transition_Wait
	change \{current_transition = None}
	pausegame
	restore_start_key_binding
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = fail_song
		}}
	if ($current_num_players = 1)
		SoundEvent \{event = Crowd_Fail_Song_SFX}
	else
		SoundEvent \{event = Crowd_Med_To_Good_SFX}
	endif
	if ($is_network_game)
		mark_safe_for_shutdown
	endif
endscript

