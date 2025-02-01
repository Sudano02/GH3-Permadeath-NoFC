randomizer_toggle = 0

randomizer_title = "???????????"
randomizer_text = [
	"?????"
	"??????"
	"???????"
	"????????"
	"?????????"
	"??????????"
	"???????????"
	"????????????"
	"?????????????"
]
randomizer_artist = "???????????"
randomizer_year = ", ????"

number_randomized = 0

normal_setlist = { }

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

script randomize_main_setlist 
	GetArraySize \{$Randomizer_Main_Setlist_Songs}
	orig_array_size = <array_size>
	to_remove = ($Randomizer_Main_Setlist_Songs)
	rand_setlist =  [ ]
	i = 0
	begin
		GetArraySize <to_remove> 
		getrandomvalue name = rand_num a = 0 b = (<array_size> - 1 ) integer
		random_song = (<to_remove> [<rand_num>])
		printf "Random Song = %d, Random Int = %e, Array Size = %f" d = <random_song> e = <rand_num> f = <array_size>
		RemoveArrayElement array = (<to_remove>) index = (<rand_num>)
		<to_remove> = (<array>)
		AddArrayElement array = (<rand_setlist>) element = (<random_song>)
		<rand_setlist> = (<array>)
		<i> = (<i> + 1)
	repeat <orig_array_size>
	new_career = {
		prefix = 'career'
		num_tiers = 8
		initial_movie = 'singleplayer_01'
	}
	random_career = ($GH3_Career_Songs)
	<i> = 0
	tier_num = 1
	begin
		FormatText checksumname = tiername 'tier%i' i = <tier_num>
		curr_tier = (<random_career>.<tiername>)
		tiersongs =  [ ]
		curr_song = 1
		to_repeat = 5
		if (<tier_num> = 8)
			<to_repeat> = 4
		endif
		begin
			AddArrayElement array = (<tiersongs>) element = (<rand_setlist> [<i>])
			<tiersongs> = <array>
			if (<curr_song> = 4)
				switch <tier_num>
					case 2
						AddArrayElement array = (<tiersongs>) element = bosstom
						<tiersongs> = <array>
					case 5
						AddArrayElement array = (<tiersongs>) element = bossslash
						<tiersongs> = <array>
					case 8
						AddArrayElement array = (<tiersongs>) element = bossdevil
						<tiersongs> = <array>
				endswitch
			endif
			<curr_song> = (<curr_song> + 1)
			<i> = (<i> + 1)
		repeat <to_repeat>
		AddParam name = songs structure_name = curr_tier value = <tiersongs>
		AddParam name = <tiername> structure_name = new_career value = <curr_tier>
		<tier_num> = (<tier_num> + 1)
	repeat 8
	change GH3_Career_Songs = <new_career>
	printstruct ($GH3_Career_Songs)
	change \{randomizer_toggle = 1}
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
				func = randomize_main_setlist
				text = ($randomize_word_text)
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
