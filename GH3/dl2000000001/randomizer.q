randomizer_toggle = 0
randomizer_all = 0
randomizer_ttfaf = 0
went_into_song = 0
hide_store_data = 0

randomizer_title = "???????????"
randomizer_store_text = "??????? ??? ? ?? ??????? ?????? ???? ??? ???? ???? ???????????? ???????? ???? ????????"
randomizer_artist = "???????????"
randomizer_year = ", ????"

number_randomized = 0

Randomizer_Main_Setlist_Songs = [
	slowride
	talkdirtytome
	hitmewithyourbestshot
	storyofmylife
	rocknrollallnite
	mississippiqueen
	schoolsout
	sunshineofyourlove
	barracuda
	bullsonparade
	whenyouwereyoung
	missmurder
	theseeker
	laydown
	paintitblack
	paranoid
	anarchyintheuk
	koolthing
	mynameisjonas
	evenflow
	holidayincambodia
	rockulikeahurricane
	sameoldsonganddance
	lagrange
	welcometothejungle
	blackmagicwoman
	cherubrock
	blacksunshine
	themetal
	pridenjoy
	beforeiforget
	stricken
	threesandsevens
	knightsofcydonia
	cultofpersonality
	rainingblood
	cliffsofdover
	numberofthebeast
	one
]

Randomizer_Bonus_Songs = [
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
]

script add_bonus_to_array \{old_array = []}
	GetArraySize ($Randomizer_Bonus_Songs)
	j = 0
	begin
		AddArrayElement array = <old_array> element = ($Randomizer_Bonus_Songs [<j>])
		<old_array> = (<array>)
		<j> = (<j> + 1)
	repeat <array_size>
	return new_array = <old_array>
endscript

script get_all_songs_to_array
	main_array = ($Randomizer_Main_Setlist_Songs)
	GetArraySize ($Randomizer_Bonus_Songs)
	j = 0
	begin
		AddArrayElement array = <main_array> element = ($Randomizer_Bonus_Songs [<j>])
		<main_array> = (<array>)
		<j> = (<j> + 1)
	repeat <array_size>
	AddArrayElement array = <main_array> element = thrufireandflames
	<main_array> = (<array>)
	return all_songs = <main_array>
endscript

script revert_all_songs
	change \{randomizer_all = 0}
	change \{randomizer_ttfaf = 0}
	change \{randomizer_toggle = 0}
	curr_props = ($permanent_songlist_props_orig)
	new_props = ($gh3_songlist_props)
	get_all_songs_to_array
	GetArraySize <all_songs>
	j = 0
	begin
		to_replace = (<all_songs> [<j>])
		replace_with = (<curr_props>.<to_replace>)
		AddParam name = <to_replace> structure_name = new_props value = <replace_with>
		<j> = (<j> + 1)
	repeat <array_size>
	printstruct <new_props>
	change gh3_songlist_props = <new_props>
	save_hs_and_lag_settings
	handle_signin_changed
endscript

script new_seeds_for_randomizer
	GetRandomSeeds
	printf "Old Seeds: %a, %b, %c, %d, %e, %f" a = <seed1> b = <seed2> c = <seed3> d = <seed4> e = <seed5> f = <seed6>
	rand1 = <seed1>
	rand2 = <seed2>
	rand3 = <seed3>
	GetStartTime
	Randomize
	wait 5 frames
	GetRandomSeeds
	SetRandomSeeds seed1 = <seed1> seed2 = <seed2> seed3 = <seed3> seed4 = <rand1> seed5 = <rand2> seed6 = <rand3>
	/*GetRandomSeeds
	printf "New Seeds: %a, %b, %c, %d, %e, %f" a = <seed1> b = <seed2> c = <seed3> d = <seed4> e = <seed5> f = <seed6>*/
endscript

script randomize_all_songs \{bonus_songs = FALSE 
	ttfaf = FALSE}
	change \{randomizer_all = 0}
	change \{randomizer_ttfaf = 0}
	new_seeds_for_randomizer
	to_randomize = ($Randomizer_Main_Setlist_Songs)
	if ((<bonus_songs> = TRUE))
		change \{randomizer_all = 1}
		add_bonus_to_array old_array = <to_randomize>
		<to_randomize> = (<new_array>)
	endif
	if ((<ttfaf> = TRUE))
		AddArrayElement array = <to_randomize> element = thrufireandflames
		<to_randomize> = (<array>)
		change \{randomizer_ttfaf = 1}
	endif
	curr_props = ($permanent_songlist_props_orig)
	getrandomvalue name = random_seed a = 2 b = 13 integer
	begin
		PermuteArray array = <to_randomize> newarrayname = rand_setlist
	repeat <random_seed>
	GetArraySize <rand_setlist>
	i = 0
	begin
		old_song = (<to_randomize> [<i>])
		new_song = (<rand_setlist> [<i>])
		new_song_props = ($permanent_songlist_props_orig.<new_song>)
		AddParam name = <old_song> structure_name = curr_props value = <new_song_props>
		<i> = (<i> + 1)
	repeat <array_size>
	new_props = ($gh3_songlist_props)
	get_all_songs_to_array
	GetArraySize <all_songs>
	j = 0
	begin
		to_replace = (<all_songs> [<j>])
		replace_with = (<curr_props>.<to_replace>)
		AddParam name = <to_replace> structure_name = new_props value = <replace_with>
		<j> = (<j> + 1)
	repeat <array_size>
	// printstruct <new_props>
	change gh3_songlist_props = <new_props>
	change \{randomizer_toggle = 1}
	// printf "randomizer_toggle %s randomizer_all %t randomizer_ttfaf %u" s = ($randomizer_toggle) t = ($randomizer_all) u = ($randomizer_ttfaf)
	save_hs_and_lag_settings
	handle_signin_changed
endscript

script create_randomize_warning 
	destroy_popup_warning_menu
	create_popup_warning_menu {
		title = ($randomize_setlist_text)
		title_props = {
			scale = 1.0
		}
		textblock = {
			text = ($randomize_warning_text)
			pos = (640.0, 390.0)
		}
		menu_pos = (640.0, 510.0)
		options = [
			{
				func = {ui_flow_manager_respond_to_action params = {action = go_back}}
				text = ($text_button_back)
			}
			{
				func = randomize_all_songs
				text = ($randomize_word_text)
			}
			{
				func = {randomize_all_songs params = {bonus_songs = TRUE}}
				text = ($randomize_no_ttfaf_word_text)
			}
			{
				func = {randomize_all_songs params = {bonus_songs = TRUE ttfaf = TRUE}}
				text = ($randomize_ttfaf_word_text)
			}
			{
				func = revert_all_songs
				text = ($revert_setlist_text)
			}
		]}
endscript

script destroy_randomize_warning 
	destroy_popup_warning_menu
endscript

randomize_warning_fs = {
	Create = create_randomize_warning
	destroy = destroy_randomize_warning
	actions = [
		{
			action = go_back
			flow_state = main_menu_fs
		}
	]
}

script is_not_randomized \{song = invalid}
	printf "%s" s = <song>
	randomized = FALSE
	if ($randomizer_toggle = 0)
		<randomized> = TRUE
	elseif ((<song> = thrufireandflames) && ($randomizer_ttfaf = 0))
		<randomized> = TRUE
	elseif (($current_tab = tab_bonus) && ($randomizer_all = 0))
		<randomized> = TRUE
	endif
	return not_randomized = <randomized>
endscript

permanent_songlist_props_orig = {
	avalancha = {
		checksum = avalancha
		name = 'avalancha'
		Title = "Avalancha"
		artist = "Heroes del Silencio"
		year = ", 1995"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 1
		band_playback_volume = -1.0
		guitar_playback_volume = -1.0
	}
	anarchyintheuk = {
		checksum = anarchyintheuk
		name = 'anarchyintheuk'
		Title = "Anarchy in the U.K."
		artist = "The Sex Pistols"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_huge'
		band_playback_volume = 0.0
		guitar_playback_volume = 2.25
		rhythm_track = 0
	}
	barracuda = {
		checksum = barracuda
		name = 'barracuda'
		Title = "Barracuda"
		artist = "Heart"
		year = ", 1977"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 0.5
		countoff = 'sticks_tiny'
		rhythm_track = 0
	}
	beforeiforget = {
		checksum = beforeiforget
		name = 'beforeiforget'
		Title = "Before I Forget"
		artist = "Slipknot"
		year = ", 2004"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 0.5
		guitar_playback_volume = 0.0
		countoff = 'HiHat02'
		rhythm_track = 0
	}
	bellyofashark = {
		checksum = bellyofashark
		name = 'bellyofashark'
		Title = "In The Belly Of A Shark"
		artist = "Gallows"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 1.0
		guitar_playback_volume = 1.0
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	blackmagicwoman = {
		checksum = blackmagicwoman
		name = 'blackmagicwoman'
		Title = "Black Magic Woman"
		artist = "Santana"
		year = ", 1970"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = -1.5
	}
	blacksunshine = {
		checksum = blacksunshine
		name = 'blacksunshine'
		Title = "Black Sunshine"
		artist = "White Zombie"
		year = ", 1992"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = -2.75
		guitar_playback_volume = -2.75
	}
	bossslash = {
		checksum = bossslash
		name = 'bossslash'
		Title = "Guitar Battle vs. Slash"
		artist = "Slash"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 0
		gem_offset = 0
		input_offset = 0
		boss = Boss_Slash_Props
		band_playback_volume = 0.0
		guitar_playback_volume = 1.0
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	bullsonparade = {
		checksum = bullsonparade
		name = 'bullsonparade'
		Title = "Bulls on Parade"
		artist = "Rage Against the Machine"
		year = ", 1996"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		bassist = "Morello"
		countoff = 'HiHat02'
		rhythm_track = 0
	}
	cantbesaved = {
		checksum = cantbesaved
		name = 'cantbesaved'
		Title = "Can't Be Saved"
		artist = "Senses Fail"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 1.0
	}
	cherubrock = {
		checksum = cherubrock
		name = 'cherubrock'
		Title = "Cherub Rock"
		artist = "The Smashing Pumpkins"
		year = ", 1993"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
	}
	citiesonflame = {
		checksum = citiesonflame
		name = 'citiesonflame'
		Title = "Cities On Flame with Rock & Roll"
		artist = "Blue Oyster Cult"
		year = ", 1972"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	cliffsofdover = {
		checksum = cliffsofdover
		name = 'cliffsofdover'
		Title = "Cliffs Of Dover"
		artist = "Eric Johnson"
		year = ", 1990"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = None
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = -0.75
		guitar_playback_volume = -0.75
	}
	closer = {
		checksum = closer
		name = 'closer'
		Title = "Closer"
		artist = "Lacuna Coil"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		countoff = 'sticks_tiny'
		rhythm_track = 0
	}
	credits = {
		checksum = credits
		name = 'cultofpersonality'
		Title = "PLACEHOLDER - Credits Song"
		artist = "Credits"
		year = ", 2007"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 0
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	cultofpersonality = {
		checksum = cultofpersonality
		name = 'cultofpersonality'
		Title = "Cult Of Personality"
		artist = "Living Colour"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	dontholdback = {
		checksum = dontholdback
		name = 'dontholdback'
		Title = "Don't Hold Back"
		artist = "The Sleeping"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = -1.0
	}
	downndirty = {
		checksum = downndirty
		name = 'downndirty'
		Title = "Down 'N Dirty"
		artist = "LA Slum Lords"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		countoff = 'HiHat02'
		rhythm_track = 0
		band_playback_volume = 1.5
		guitar_playback_volume = 0.5
	}
	evenflow = {
		checksum = evenflow
		name = 'evenflow'
		Title = "Even Flow"
		artist = "Pearl Jam"
		year = ", 1991"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 1.0
		countoff = 'HiHat02'
		rhythm_track = 0
	}
	fcpremix = {
		checksum = fcpremix
		name = 'fcpremix'
		Title = "F.C.P.R.E.M.I.X."
		artist = "The Fall of Troy"
		year = ", 2005"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat03'
		rhythm_track = 0
		band_playback_volume = 2.75
		guitar_playback_volume = 1.5
	}
	generationrock = {
		checksum = generationrock
		name = 'generationrock'
		Title = "Generation Rock"
		artist = "Revolverheld"
		year = ", 2005"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 2.0
		guitar_playback_volume = 2.0
	}
	gothatfar = {
		checksum = gothatfar
		name = 'gothatfar'
		Title = "Go That Far"
		artist = "Bret Michaels Band"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = bRet
		keyboard = FALSE
		countoff = 'HiHat02'
		rhythm_track = 1
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
	}
	helicopter = {
		checksum = helicopter
		name = 'helicopter'
		Title = "Helicopter"
		artist = "Bloc Party"
		year = ", 2005"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_tiny'
		rhythm_track = 1
		band_playback_volume = -0.5
		guitar_playback_volume = 1.0
	}
	hierkommtalex = {
		checksum = hierkommtalex
		name = 'hierkommtalex'
		Title = "Hier Kommt Alex"
		artist = "Die Toten Hosen"
		year = ", 1993"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = -0.5
		guitar_playback_volume = -0.5
		countoff = 'HiHat03'
		rhythm_track = 0
	}
	hitmewithyourbestshot = {
		checksum = hitmewithyourbestshot
		name = 'hitmewithyourbestshot'
		Title = "Hit Me With Your Best Shot"
		artist = "Pat Benatar"
		year = ", 1980"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = -1.0
		countoff = 'sticks_huge'
		rhythm_track = 0
	}
	holidayincambodia = {
		checksum = holidayincambodia
		name = 'holidayincambodia'
		Title = "Holiday In Cambodia"
		artist = "The Dead Kennedys"
		year = ", 1980"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = 2.0
		hammer_on_measure_scale = 1.9499999
	}
	imintheband = {
		checksum = imintheband
		name = 'imintheband'
		Title = "I'm In The Band"
		artist = "Hellacopters"
		year = ", 2005"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = 0.0
	}
	impulse = {
		checksum = impulse
		name = 'impulse'
		Title = "Impulse"
		artist = "An Endless Sporadic"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = None
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = -0.25
		guitar_playback_volume = -1.0
	}
	inlove = {
		checksum = inlove
		name = 'inlove'
		Title = "In Love"
		artist = "Scouts of St. Sebastian"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	koolthing = {
		checksum = koolthing
		name = 'KoolThing'
		Title = "Kool Thing"
		artist = "Sonic Youth"
		year = ", 1990"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = 2.5
	}
	knightsofcydonia = {
		checksum = knightsofcydonia
		name = 'KnightsOfCydonia'
		Title = "Knights of Cydonia"
		artist = "Muse"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = -1.0
	}
	lagrange = {
		checksum = lagrange
		name = 'lagrange'
		Title = "La Grange"
		artist = "ZZ Top"
		year = ", 1973"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_tiny'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = -0.5
	}
	laydown = {
		checksum = laydown
		name = 'laydown'
		Title = "Lay Down"
		artist = "Priestess"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 1.5
		guitar_playback_volume = 1.0
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	mauvaisgarcon = {
		checksum = mauvaisgarcon
		name = 'mauvaisgarcon'
		Title = "Mauvais Garçon"
		artist = "NAAST"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat02'
		rhythm_track = 0
		band_playback_volume = 0.5
		guitar_playback_volume = -1.0
	}
	metalheavylady = {
		checksum = metalheavylady
		name = 'metalheavylady'
		Title = "Metal Heavy Lady"
		artist = "Lions"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = -0.5
		guitar_playback_volume = -1.5
	}
	minuscelsius = {
		checksum = minuscelsius
		name = 'minuscelsius'
		Title = "Minus Celsius"
		artist = "Backyard Babies"
		year = ", 2003"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = -1.75
		guitar_playback_volume = -1.75
		countoff = 'HiHat03'
		rhythm_track = 0
	}
	mississippiqueen = {
		checksum = mississippiqueen
		name = 'mississippiqueen'
		Title = "Mississippi Queen"
		artist = "Mountain"
		year = ", 1970"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	missmurder = {
		checksum = missmurder
		name = 'missmurder'
		Title = "Miss Murder"
		artist = "AFI"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.75
		guitar_playback_volume = 0.5
	}
	monsters = {
		checksum = monsters
		name = 'monsters'
		Title = "Monsters"
		artist = "Matchbook Romance"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = -1.0
		guitar_playback_volume = -1.0
	}
	mycurse = {
		checksum = mycurse
		name = 'mycurse'
		Title = "My Curse"
		artist = "Killswitch Engage"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 1.5
		guitar_playback_volume = -0.5
	}
	mynameisjonas = {
		checksum = mynameisjonas
		name = 'mynameisjonas'
		Title = "My Name Is Jonas"
		artist = "Weezer"
		year = ", 1994"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	nothingformehere = {
		checksum = nothingformehere
		name = 'nothingformehere'
		Title = "Nothing For Me Here"
		artist = "Dope"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = -0.5
	}
	numberofthebeast = {
		checksum = numberofthebeast
		name = 'numberofthebeast'
		Title = "The Number of the Beast"
		artist = "Iron Maiden"
		year = ", 1982"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = -0.5
		guitar_playback_volume = 0.0
	}
	one = {
		checksum = one
		name = 'one'
		Title = "One"
		artist = "Metallica"
		year = ", 1988"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		use_coop_notetracks
		countoff = 'sticks_normal'
		rhythm_track = 1
		band_playback_volume = 3.0
		guitar_playback_volume = 2.5
	}
	paintitblack = {
		checksum = paintitblack
		name = 'paintitblack'
		Title = "Paint It Black"
		artist = "The Rolling Stones"
		year = ", 1966"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 2.0
		guitar_playback_volume = 1.0
		countoff = 'HiHat03'
		rhythm_track = 0
		no_rhythm_track
	}
	paranoid = {
		checksum = paranoid
		name = 'paranoid'
		Title = "Paranoid"
		artist = "Black Sabbath"
		year = ", 1970"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_huge'
		rhythm_track = 0
		band_playback_volume = -0.5
		guitar_playback_volume = -1.5
	}
	prayeroftherefugee = {
		checksum = prayeroftherefugee
		name = 'prayeroftherefugee'
		Title = "Prayer Of The Refugee"
		artist = "Rise Against"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 1.5
		guitar_playback_volume = 1.0
		countoff = 'hihat03'
		rhythm_track = 0
	}
	pridenjoy = {
		checksum = pridenjoy
		name = 'pridenjoy'
		Title = "Pride and Joy"
		artist = "Stevie Ray Vaughan"
		year = ", 1983"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = -0.5
		guitar_playback_volume = 1.75
	}
	rainingblood = {
		checksum = rainingblood
		name = 'rainingblood'
		Title = "Raining Blood"
		artist = "Slayer"
		year = ", 1986"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 1.25
		guitar_playback_volume = 1.0
	}
	radiosong = {
		checksum = radiosong
		name = 'radiosong'
		Title = "Radio Song"
		artist = "Superbus"
		year = ", 2004"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Female
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 2.0
		guitar_playback_volume = 2.0
	}
	reptilia = {
		checksum = reptilia
		name = 'reptilia'
		Title = "Reptilia"
		artist = "The Strokes"
		year = ", 2003"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		countoff = 'sticks_tiny'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
	}
	rocknrollallnite = {
		checksum = rocknrollallnite
		name = 'rocknrollallnite'
		Title = "Rock and Roll All Nite"
		artist = "Kiss"
		year = ", 1975"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = -0.5
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	rockulikeahurricane = {
		checksum = rockulikeahurricane
		name = 'rockulikeahurricane'
		Title = "Rock You Like A Hurricane"
		artist = "Scorpions"
		year = ", 1984"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 2.5
		guitar_playback_volume = 3.0
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	ruby = {
		checksum = ruby
		name = 'ruby'
		Title = "Ruby"
		artist = "The Kaiser Chiefs"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = -0.75
		guitar_playback_volume = -0.75
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	sabotage = {
		checksum = sabotage
		name = 'sabotage'
		Title = "Sabotage"
		artist = "Beastie Boys"
		year = ", 1994"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 2.0
		countoff = 'HiHat02'
		rhythm_track = 0
	}
	sameoldsonganddance = {
		checksum = sameoldsonganddance
		name = 'sameoldsonganddance'
		Title = "Same Old Song and Dance"
		artist = "Aerosmith"
		year = ", 1974"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 1
		band_playback_volume = 1.5
		guitar_playback_volume = 1.0
	}
	schoolsout = {
		checksum = schoolsout
		name = 'schoolsout'
		Title = "School's Out"
		artist = "Alice Cooper"
		year = ", 1972"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 1.0
		guitar_playback_volume = 0.25
		countoff = 'sticks_tiny'
		rhythm_track = 0
	}
	shebangsadrum = {
		checksum = shebangsadrum
		name = 'shebangsadrum'
		Title = "She Bangs The Drums"
		artist = "The Stone Roses"
		year = ", 1989"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = 2.5
		guitar_playback_volume = 0.5
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	slowride = {
		checksum = slowride
		name = 'slowride'
		Title = "Slow Ride"
		artist = "Foghat"
		year = ", 1975"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		band_playback_volume = -3.0
		guitar_playback_volume = -4.0
		countoff = 'sticks_normal'
		rhythm_track = 0
	}
	storyofmylife = {
		checksum = storyofmylife
		name = 'storyofmylife'
		Title = "Story Of My Life"
		artist = "Social Distortion"
		year = ", 1990"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.75
		guitar_playback_volume = 1.75
	}
	stricken = {
		checksum = stricken
		name = 'stricken'
		Title = "Stricken"
		artist = "Disturbed"
		year = ", 2005"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat02'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = -1.0
	}
	suckmykiss = {
		checksum = suckmykiss
		name = 'suckmykiss'
		Title = "Suck My Kiss"
		artist = "Red Hot Chili Peppers"
		year = ", 1991"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 0.4
		guitar_playback_volume = 1.0
	}
	sunshineofyourlove = {
		checksum = sunshineofyourlove
		name = 'sunshineofyourlove'
		Title = "Sunshine of Your Love"
		artist = "Cream"
		year = ", 1968"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		countoff = 'sticks_tiny'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
	}
	takethislife = {
		checksum = takethislife
		name = 'takethislife'
		Title = "Take This Life"
		artist = "In Flames"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 3.0
		guitar_playback_volume = 1.75
	}
	talkdirtytome = {
		checksum = talkdirtytome
		name = 'talkdirtytome'
		Title = "Talk Dirty to Me"
		artist = "Poison"
		year = ", 1986"
		artist_text = "feat. Bret Michaels, as made famous by"
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		band_playback_volume = -0.5
		guitar_playback_volume = -0.5
		singer = bRet
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
	}
	themetal = {
		checksum = themetal
		name = 'themetal'
		Title = "The Metal"
		artist = "Tenacious D"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = -1.0
		guitar_playback_volume = -1.0
	}
	theseeker = {
		checksum = theseeker
		name = 'theseeker'
		Title = "The Seeker"
		artist = "The Who"
		year = ", 1971"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 0
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = -2.0
		guitar_playback_volume = -1.0
	}
	thewayitends = {
		checksum = thewayitends
		name = 'thewayitends'
		Title = "The Way It Ends"
		artist = "Prototype"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat02'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = -0.5
	}
	threesandsevens = {
		checksum = threesandsevens
		name = 'threesandsevens'
		Title = "3's & 7's"
		artist = "Queens of the Stone Age"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
	}
	thrufireandflames = {
		checksum = thrufireandflames
		name = 'thrufireandflames'
		Title = "Through The Fire And Flames"
		artist = "Dragonforce"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		use_coop_notetracks
		countoff = 'HiHat01'
		band_playback_volume = -0.5
		guitar_playback_volume = 0.5
		rhythm_track = 1
	}
	welcometothejungle = {
		checksum = welcometothejungle
		name = 'welcometothejungle'
		Title = "Welcome To The Jungle"
		artist = "Guns N Roses"
		year = ", 1987"
		artist_text = $artist_text_by
		original_artist = 1
		startup_script = LS_SetupVenueLights
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		bassist = "slash"
		countoff = 'HiHat01'
		rhythm_track = 0
		band_playback_volume = 2.0
		guitar_playback_volume = 2.0
	}
	whenyouwereyoung = {
		checksum = whenyouwereyoung
		name = 'whenyouwereyoung'
		Title = "When You Were Young"
		artist = "The Killers"
		year = ", 2006"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		leaderboard = 1
		gem_offset = 0
		input_offset = 0
		singer = Male
		keyboard = FALSE
		countoff = 'hihat01'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = 0.0
	}
}

