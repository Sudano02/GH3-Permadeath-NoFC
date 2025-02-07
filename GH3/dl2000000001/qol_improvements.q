song_covers_wavegroup = {
	slowride
	blacksunshine
	cliffsofdover
	holidayincambodia
	storyofmylife
	shebangsadrum
}

song_covers_steve = {
	barracuda
	citiesonflame
	hitmewithyourbestshot
	mississippiqueen
	rockulikeahurricane
	schoolsout
	talkdirtytome
}

song_covers_line6 = {
	blackmagicwoman
	lagrange
	paranoid
	pridenjoy
	rocknrollallnite
	theseeker
	sunshineofyourlove
}

script get_song_covered_by \{song = invalid}
	if StructureContains structure = $gh3_songlist_props <song>
		if StructureContains structure = ($gh3_songlist_props.<song>) covered_by
			return covered_by = ($gh3_songlist_props.<song>.covered_by) TRUE
		elseif StructureContains structure = $song_covers_wavegroup ($gh3_songlist_props.<song>.checksum)
			return covered_by = "WaveGroup" TRUE
		elseif StructureContains structure = $song_covers_steve ($gh3_songlist_props.<song>.checksum)
			return covered_by = "Steve Ouimette" TRUE
		elseif StructureContains structure = $song_covers_line6 ($gh3_songlist_props.<song>.checksum)
			return covered_by = "Line 6" TRUE
		else
			return \{FALSE}
		endif
	endif
	printstruct <...>
	scriptassert \{"Song not found"}
endscript

