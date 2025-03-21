randomizer_toggle = 0
randomizer_all = 0
randomizer_ttfaf = 0
went_into_song = 0
hide_store_data = 0

randomizer_title = "???????????"
randomizer_store_text = "??????? ??? ? ?? ??????? ?????? ???? ??? ???? ???? ???????????? ???????? ???? ????????"
randomizer_artist = "???????????"
randomizer_year = ", ????"

Randomizer_Career_songs = [
	dreampolice
	alltheyoungdudes
	ihatemyselfforlovingyou
	alldayandallofthenight
	completecontrol
	personalitycrisis
	shesellssanctuary
	kingofrock
	hardtohandle
	alwaysontherun
	catscratchfever
	sextypething
	makeit
	unclesalty
	DrawTheLine
	nosurprize
	movinout
	sweetemotion
	livinontheedge
	Ragdoll
	loveinanelevator
	nobodysfault
	brightlightfright
	walkthiswayrundmc
	BackInTheSaddle
	beyondbeautiful
	dreamon
	mamakin
	ToysInTheAttic
	trainkeptarollin
]

Randomizer_Bonus_Songs = [
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
	main_array = ($Randomizer_Career_songs)
	GetArraySize ($Randomizer_Bonus_Songs)
	j = 0
	begin
		AddArrayElement array = <main_array> element = ($Randomizer_Bonus_Songs [<j>])
		<main_array> = (<array>)
		<j> = (<j> + 1)
	repeat <array_size>
	return all_songs = <main_array>
endscript

script revert_all_songs
	change \{randomizer_all = 0}
	change \{randomizer_ttfaf = 0}
	change \{randomizer_toggle = 0}
	change songs_practiced = ($empty_array)
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

script randomize_all_songs \{bonus_songs = FALSE}
	change \{randomizer_all = 0}
	curr_props = ($permanent_songlist_props_orig)
	to_randomize_guest = ($Randomizer_Career_songs)
	if ((<bonus_songs> = TRUE))
		change \{randomizer_all = 1}
		add_bonus_to_array old_array = <to_randomize_guest>
		<to_randomize_guest> = (<new_array>)
	endif
	getrandomvalue name = random_seed a = 2 b = 13 integer
	begin
		PermuteArray array = <to_randomize_guest> newarrayname = rand_setlist_songs
	repeat <random_seed>
	GetArraySize <rand_setlist_songs>
	printf \{"Shuffling Songs"}
	i = 0
	begin
		old_song = (<to_randomize_guest> [<i>])
		new_song = (<rand_setlist_songs> [<i>])
		new_song_props = ($permanent_songlist_props_orig.<new_song>)
		printf "Old song: %o, New Song: %n" o = <old_song> n = <new_song>
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
	elseif (($current_tab = tab_bonus) && ($randomizer_all = 0))
		<randomized> = TRUE
	endif
	return not_randomized = <randomized>
endscript

permanent_songlist_props_orig = {
	alldayandallofthenight = {
		Checksum = alldayandallofthenight
		Name = 'alldayandallofthenight'
		Title = "All Day and All of the Night"
		Artist = "The Kinks"
		covered_by = "Wavegroup"
		year = ", 1964"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
	}
	alltheyoungdudes = {
		Checksum = alltheyoungdudes
		Name = 'alltheyoungdudes'
		Title = "All the Young Dudes"
		Artist = "Mott the Hoople"
		covered_by = "Wavegroup"
		year = ", 1972"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
	}
	alwaysontherun = {
		Checksum = alwaysontherun
		Name = 'alwaysontherun'
		Title = "Always On The Run"
		Artist = "Lenny Kravitz feat. Slash"
		year = ", 1991"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.5
		rhythm_track = 0
	}
	BackInTheSaddle = {
		Checksum = BackInTheSaddle
		Name = 'backinthesaddle'
		Title = "Back In The Saddle"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1976"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_backinthesaddle
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_saddle.pak'
	}
	beyondbeautiful = {
		Checksum = beyondbeautiful
		Name = 'BeyondBeautiful'
		Title = "Beyond Beautiful"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 2001"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_beyondbeautiful
		keyboard = FALSE
		use_coop_notetracks
		band_playback_volume = 1.0
		guitar_playback_volume = 1.0
		countoff = 'hihat01'
		rhythm_track = 1
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_byndbeautfl.pak'
	}
	bossjoe = {
		Checksum = bossjoe
		Name = 'bossjoe'
		Title = "Guitar Battle vs. Joe Perry"
		Artist = "Joe Perry"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 0
		gem_offset = 0
		input_offset = 0
		boss = Boss_Joe_Props
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
	}
	brightlightfright = {
		Checksum = brightlightfright
		Name = 'brightlightfright'
		Title = "Bright Light Fright"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1977"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = aerosmith_band_brightlightfright
		input_offset = 0
		countoff = 'sticks_normal'
		perry_mic_stand = 1
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
	}
	catscratchfever = {
		Checksum = catscratchfever
		Name = 'catscratchfever'
		Title = "Cat Scratch Fever"
		Artist = "Ted Nugent"
		year = ", 1977"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
	}
	combination = {
		Checksum = combination
		Name = 'combination'
		Title = "Combination"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1976"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_combination
		keyboard = FALSE
		perry_mic_stand = 1
		countoff = 'hihat02'
		band_playback_volume = 0.0
		guitar_playback_volume = 1.0
		rhythm_track = 0
	}
	completecontrol = {
		Checksum = completecontrol
		Name = 'completecontrol'
		Title = "Complete Control"
		Artist = "The Clash"
		year = ", 1977"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		countoff = 'hihat02'
		rhythm_track = 0
		thin_fretbar_8note_params_high_bpm = 185
	}
	DrawTheLine = {
		Checksum = DrawTheLine
		Name = 'drawtheline'
		Title = "Draw the Line"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1977"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		BAND = aerosmith_band_drawtheline
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_drawtheline.pak'
	}
	dreamon = {
		Checksum = dreamon
		Name = 'dreamon'
		Title = "Dream On"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_dreamon
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_dreamon.pak'
	}
	dreampolice = {
		Checksum = dreampolice
		Name = 'dreampolice'
		Title = "Dream Police"
		Artist = "Cheap Trick"
		year = ", 1979"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
	}
	hardtohandle = {
		Checksum = hardtohandle
		Name = 'hardtohandle'
		Title = "Hard To Handle"
		Artist = "The Black Crowes"
		covered_by = "Steve Ouimette"
		year = ", 1990"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
	}
	ihatemyselfforlovingyou = {
		Checksum = ihatemyselfforlovingyou
		Name = 'ihatemyselfforlovingyou'
		Title = "I Hate Myself For Loving You"
		Artist = "Joan Jett and the Blackhearts"
		year = ", 1988"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Female
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0
		rhythm_track = 0
	}
	joeperryguitarbattle = {
		Checksum = joeperryguitarbattle
		Name = 'joeperryguitarbattle'
		Title = "Joe Perry Guitar Battle"
		Artist = "Joe Perry"
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = NONE
		BAND = aerosmith_band_joeperrybossbattle
		use_coop_notetracks
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0
		rhythm_track = 1
	}
	kingofrock = {
		Checksum = kingofrock
		Name = 'kingofrock'
		Title = "King of Rock"
		Artist = "Run DMC"
		year = ", 1985"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = dmc_band
		input_offset = 0
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Singer_DMC\\Singer_DMC_Anims_kingofrock.pak'
	}
	kingsandqueens = {
		Checksum = kingsandqueens
		Name = 'KingsAndQueens'
		Title = "Kings and Queens"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1977"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_kingsandqueens
		keyboard = FALSE
		countoff = 'hihat01'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = 2.5
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_kingqueen.pak'
	}
	kingsandqueenscredits = {
		Checksum = kingsandqueenscredits
		Name = 'KingsAndQueensCredits'
		Title = "Kings and Queens"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1977"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 0
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_kingsandqueens
		keyboard = FALSE
		countoff = 'hihat01'
		rhythm_track = 0
		band_playback_volume = 1.0
		guitar_playback_volume = 2.5
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_kq_credits.pak'
	}
	letthemusicdothetalking = {
		Checksum = letthemusicdothetalking
		Name = 'letthemusicdothetalking'
		Title = "Let the Music Do the Talking"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1985"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_letthemusicdothetalkin
		keyboard = FALSE
		countoff = 'hihat01'
		rhythm_track = 1
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_letmusictalk.pak'
	}
	livinontheedge = {
		Checksum = livinontheedge
		Name = 'livinontheedge'
		Title = "Livin' on the Edge"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1993"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = aerosmith_band_livinontheedge
		input_offset = 0
		countoff = 'hihat01'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_livinonedge.pak'
	}
	loveinanelevator = {
		Checksum = loveinanelevator
		Name = 'loveinanelevator'
		Title = "Love in an Elevator"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1989"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_loveinanelevator
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 1.5
		guitar_playback_volume = 1.0
		rhythm_track = 1
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_loveinelev.pak'
	}
	makeit = {
		Checksum = makeit
		Name = 'MakeIt'
		Title = "Make It"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_makeit
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 1.5
		guitar_playback_volume = 1.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_makeit.pak'
	}
	mamakin = {
		Checksum = mamakin
		Name = 'mamakin'
		Title = "Mama Kin"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_mamakin
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_mamakin.pak'
	}
	mercy = {
		Checksum = mercy
		Name = 'mercy'
		Title = "Mercy"
		Artist = "Joe Perry"
		year = ", 2005"
		guitarist_checksum = AEROSMITH
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = NONE
		BAND = aerosmith_band_mercy
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0.0
	}
	movinout = {
		Checksum = movinout
		Name = 'movinout'
		Title = "Movin' Out"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 2007"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_movinout
		keyboard = FALSE
		band_playback_volume = 0
		guitar_playback_volume = 0
		countoff = 'sticks_normal'
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_movinout.pak'
	}
	nobodysfault = {
		Checksum = nobodysfault
		Name = 'nobodysfault'
		Title = "Nobody's Fault"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1976"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_nobodysfault
		keyboard = FALSE
		band_playback_volume = 1.5
		guitar_playback_volume = 1.0
		countoff = 'sticks_normal'
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_nobodysfault.pak'
	}
	nosurprize = {
		Checksum = nosurprize
		Name = 'nosurprize'
		Title = "No Surprize"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1979"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = aerosmith_band_nosurprize
		input_offset = 0
		use_coop_notetracks
		countoff = 'hihat01'
		rhythm_track = 1
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_nosurprize.pak'
	}
	pandorasbox = {
		Checksum = pandorasbox
		Name = 'pandorasbox'
		Title = "Pandora's Box"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1974"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_pandorasbox
		keyboard = FALSE
		band_playback_volume = 0
		guitar_playback_volume = 0
		countoff = 'sticks_normal'
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_pandorasbox.pak'
	}
	personalitycrisis = {
		Checksum = personalitycrisis
		Name = 'personalitycrisis'
		Title = "Personality Crisis"
		Artist = "New York Dolls"
		covered_by = "Steve Ouimette"
		year = ", 1973"
		artist_text = $artist_text_as_made_famous_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0
		rhythm_track = 0
	}
	pink = {
		Checksum = pink
		Name = 'Pink'
		Title = "Pink"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1998"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_pink
		keyboard = FALSE
		countoff = 'hihat02'
		band_playback_volume = 0.0
		guitar_playback_volume = 1.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_pink.pak'
	}
	Ragdoll = {
		Checksum = Ragdoll
		Name = 'ragdoll'
		Title = "Rag Doll"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1987"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_ragdoll
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 1
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_ragdoll.pak'
	}
	ratsinthecellar = {
		Checksum = ratsinthecellar
		Name = 'ratsinthecellar'
		Title = "Rats in the Cellar"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1976"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_ratsinthecellar
		keyboard = FALSE
		use_coop_notetracks
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 1
		hammer_on_measure_scale = 1.9499999
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_rats.pak'
	}
	sextypething = {
		Checksum = sextypething
		Name = 'sextypething'
		Title = "Sex Type Thing"
		Artist = "Stone Temple Pilots"
		year = ", 1992"
		artist_text = $artist_text_by
		original_artist = 0
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
		hammer_on_measure_scale = 100
	}
	shakinmycage = {
		Checksum = shakinmycage
		Name = 'shakinmycage'
		Title = "Shakin' My Cage"
		Artist = "Joe Perry"
		year = ", 2005"
		guitarist_checksum = AEROSMITH
		artist_text = $artist_text_by
		original_artist = 0
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = NONE
		BAND = JoePerryProject_Band_shakinmycage
		keyboard = FALSE
		perry_mic_stand = 1
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		countoff = 'sticks_normal'
		rhythm_track = 0
		hammer_on_measure_scale = 1.9499999
	}
	shesellssanctuary = {
		Checksum = shesellssanctuary
		Name = 'shesellssanctuary'
		Title = "She Sells Sanctuary"
		Artist = "The Cult"
		year = ", 1985"
		artist_text = $artist_text_by
		original_artist = 0
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = default_band
		keyboard = FALSE
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		countoff = 'sticks_normal'
		rhythm_track = 0
		hammer_on_measure_scale = 100
	}
	sweetemotion = {
		Checksum = sweetemotion
		Name = 'sweetemotion'
		Title = "Sweet Emotion"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1975"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = aerosmith_band_miracas
		perry_mic_stand = 1
		input_offset = 0
		countoff = 'shaker'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_sweetemotion.pak'
	}
	talktalking = {
		Checksum = crash
		Name = 'talktalking'
		Title = "Talk Talkin'"
		Artist = "Joe Perry"
		year = ", 2005"
		artist_text = $artist_text_by
		guitarist_checksum = AEROSMITH
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = NONE
		BAND = aerosmith_band_talktalkin
		keyboard = FALSE
		use_coop_notetracks
		perry_mic_stand = 1
		countoff = 'sticks_normal'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 1
	}
	ToysInTheAttic = {
		Checksum = ToysInTheAttic
		Name = 'toysintheattic'
		Title = "Toys in the Attic"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1975"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = aerosmith_band_toysintheattic
		input_offset = 0
		countoff = 'hihat01'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		hammer_on_measure_scale = 1.9499999
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_toys.pak'
	}
	trainkeptarollin = {
		Checksum = trainkeptarollin
		Name = 'trainkeptarollin'
		Title = "Train Kept a Rollin'"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1974"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_trainkeptarollin
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_trainrollin.pak'
	}
	unclesalty = {
		Checksum = unclesalty
		Name = 'UncleSalty'
		Title = "Uncle Salty"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1975"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_unclesalty
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = -0.5
		guitar_playback_volume = 0.5
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_unclesalty.pak'
	}
	WalkThisWay = {
		Checksum = WalkThisWay
		Name = 'walkthisway'
		Title = "Walk This Way"
		Artist = "Aerosmith"
		guitarist_checksum = AEROSMITH
		year = ", 1975"
		artist_text = $artist_text_by
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		input_offset = 0
		Singer = Male
		BAND = aerosmith_band_walkthisway
		keyboard = FALSE
		countoff = 'hihat01'
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		rhythm_track = 0
		singer_anim_pak = 'pak\\models\\Band\\Aero_Singer\\Aero_singer_anims_walkthisway.pak'
	}
	walkthiswayrundmc = {
		Checksum = walkthiswayrundmc
		Name = 'walkthiswayrundmc'
		Title = "Walk This Way (Run DMC)"
		Artist = "Run DMC feat. Aerosmith"
		year = ", 1986"
		artist_text = $artist_text_by
		guitarist_checksum = AEROSMITH
		original_artist = 1
		version = gh3
		Leaderboard = 1
		gem_offset = 0
		BAND = aerosmith_band_walkthiswayDMC
		input_offset = 0
		countoff = 'sticks_normal'
		rhythm_track = 0
		band_playback_volume = 0.0
		guitar_playback_volume = 0.0
		singer_anim_pak = 'pak\\models\\Band\\Singer_DMC\\singer_dmc_anims_wtydmc.pak'
	}
}

