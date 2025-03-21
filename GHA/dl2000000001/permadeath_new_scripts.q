permadeath_text = "Permadeath Mode"
permadeath_lives = 3
permadeath_lives_total = 3
permadeath_fails = 0
permadeath_toggle = 1
permadeath_max_streak = 0
permadeath_max_song_count = 0
permadeath_current_song_count = 0

permadeath_disabled_easy = 0
permadeath_disabled_medium = 0
permadeath_disabled_hard = 0
permadeath_disabled_expert = 0
lose_a_life = TRUE

lives_are_missed_notes_shield = 2
permadeath_title_offset = (400.0, 500.0)
songs_practiced_offset = (670.0, 360.0)

text_scale_game = 0.8


max_streaks = { 

}

empty_array = [
]

songs_practiced = [
]

calibration_val = 0
hyperspeed_setting_val = 0
hs_first_time = 0
lefty_flip_p1_val = 0
lefty_flip_p2_val = 0
whammy_cal_val_1 = -0.76
whammy_cal_val_2 = -0.76
star_power_pos_1 = -1.0
star_power_pos_2 = -1.0


script save_hs_and_lag_settings
		change songs_practiced = ($empty_array)
		GetGlobalTags \{user_options}
		change calibration_val = <lag_calibration>
		change lefty_flip_p1_val = <lefty_flip_p1>
		change lefty_flip_p2_val = <lefty_flip_p2>
		change hyperspeed_setting_val = ($cheat_hyperspeed)
		change whammy_cal_val_1 = ($player1_status.resting_whammy_position)
		change whammy_cal_val_2 = ($player2_status.resting_whammy_position)
		change star_power_pos_1 = ($player1_status.star_tilt_threshold)
		change star_power_pos_2 = ($player2_status.star_tilt_threshold)
		change \{hs_first_time = 1}
		change \{progression_pop_count = 0}
endscript

script create_songs_practiced_text 
	destroy_songs_practiced_scroll
	GetArraySize \{$songs_practiced}
	if (<array_size> = 0)
		return
	endif
	curr_array = ($songs_practiced)
	CreateScreenElement {
		type = windowelement
		parent = user_control_container
		id = songs_practiced_window
		Pos = ($songs_practiced_offset + (0.0, 50.0))
		dims = (480.0, 250.0)
		allow_expansion
	}
	CreateScreenElement {
		type = ContainerElement
		id = songs_practiced
		parent = songs_practiced_window
		Pos = (0.0, 0.0)
		just = [left top]
		z_priority = 10000
		Scale = 1.0
	}
	text_pos = (0.0, 0.0)
	i = 0
	begin
		curr_song = (<curr_array> [<i>])
		get_song_title song = <curr_song>
		FormatText checksumname = text_id '%s_title' s = (<curr_song>)
		displayText parent = songs_practiced Scale = 1 text = <song_title>  rgba = [255 255 255 255] Pos = <text_pos> z = 50
		<text_pos> = (<text_pos> + (0.0, 40.0))
		<i> = (<i> + 1)
	repeat <array_size>
	printf "Running Script"
	spawnscriptnow scroll_songs_practiced params = {text_size = <array_size> to_scroll = songs_practiced}
	//printf "%s" s = <all_songs>
endscript

script scroll_songs_practiced \{text_size = 1}
	printf "Getting Height"
	text_height = (<text_size> * 40.0)
	printf "Height = %s" s = <text_height>
	<to_scroll> :getparentid
	printf "Got Parent ID: %d" d = <parent_id>
	GetScreenElementDims id = <parent_id>
	printf "Got Parent Dims"
	compare_height = <height>
	printf "Set Parent Height %s" s = <compare_height>
	diff = (<text_height> - <compare_height> + 20.0)
	printf "Set Diff %s" s = <diff>
	if (<text_height> > <compare_height>)
		scroll_time = ((<text_height> - <compare_height>) / 40.0)
		<to_scroll> :DoMorph alpha = 0
		<to_scroll> :DoMorph Pos = (0.0, 0.0)
		begin
		<to_scroll> :DoMorph alpha = 1 time = 1.5
		<to_scroll> :DoMorph Pos = (<diff> * (0.0, -1.0)) time = <scroll_time>
		wait 2 seconds
		<to_scroll> :DoMorph alpha = 0 time = 1.5
		<to_scroll> :DoMorph Pos = (0.0, 0.0)
		repeat
	endif
endscript

script destroy_songs_practiced_scroll
	KillSpawnedScript \{name = scroll_songs_practiced}
	if ScreenElementExists \{id = songs_practiced_window}
		DestroyScreenElement \{id = songs_practiced_window}
	endif
endscript

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

script calculate_max_streak_song 
	p1_note_streak = ($player1_status.notes_hit)
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
		get_formatted_songname song_prefix = <song_prefix> difficulty_text_nl = <difficulty_text_nl>
		GetGlobalTags <songname> Param = achievement_gold_star
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

