permadeath_text = "Permadeath Mode"
permadeath_lives = 3
permadeath_lives_total = 3
permadeath_fails = 0
permadeath_toggle = 1
permadeath_max_streak = 0
permadeath_max_song_count = 0
permadeath_current_song_count = 0
default_song_price = 500
ttfaf_money = 3722000

permadeath_disabled_easy = 0
permadeath_disabled_medium = 0
permadeath_disabled_hard = 0
permadeath_disabled_expert = 0
lose_a_life = TRUE

max_streaks = { 

}

songs_fcd = [
]

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
