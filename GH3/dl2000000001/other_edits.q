cash_deduction_types = [
	{
		desc = $cash_deduction_1
		val = 2500
		currency = "$"
	}
	{
		desc = $cash_deduction_2
		val = 80
		currency = "$"
	}
	{
		desc = $cash_deduction_3
		val = 210
		currency = "$"
	}
	{
		desc = $cash_deduction_4
		val = 550
		currency = "$"
	}
	{
		desc = $cash_deduction_5
		val = 330
		currency = "$"
	}
	{
		desc = $cash_deduction_6
		val = 300
		currency = "$"
	}
	{
		desc = $cash_deduction_7
		val = 1867
		currency = "C$"
	}
	{
		desc = $cash_deduction_8
		val = 1901
		currency = "A$"
	}
]

base_deduction_index_array = [
	0
	1
	2
	3
	4
	5
	6
	7
]

script create_deductions_list \{Pos = (200.0, 200.0)
		Scale = 1
		dims = (400.0, 400.0)
		received = 1200}
	dl_width = ((1.0, 0.0).<dims>)
	dl_height = ((0.0, 1.0).<dims>)
	CreateScreenElement {
		type = ContainerElement
		parent = cash_reward_container
		id = deductions_container
		Pos = <Pos>
	}
	pay = <received>
	deduction_count = 4
	PermuteArray array = ($base_deduction_index_array) newarrayname = perm_deduction_array
	index = 0
	begin
	perm_index = (<perm_deduction_array> [<index>])
	<pay> = (<pay> + $cash_deduction_types [<perm_index>].val)
	<index> = (<index> + 1)
	repeat <deduction_count>
	FormatText textname = gross_pay_text "$%d" d = <pay>
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		Pos = ((1.0, 0.0) * <dl_width>)
		Scale = <Scale>
		text = <gross_pay_text>
		font = ($cash_reward_font)
		rgba = [15 70 0 255]
		just = [RIGHT top]
		z_priority = 3
	}
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		id = cd_pay_text
		Pos = (15.0, 0.0)
		Scale = <Scale>
		text = ($career_pay_text)
		font = ($cash_reward_font)
		rgba = [15 70 0 255]
		just = [left top]
		z_priority = 3
	}
	GetScreenElementDims \{id = cd_pay_text}
	separation_height = (<height> * 0.9)
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		Pos = (((0.0, 1.0) * <separation_height>) + (15.0, 0.0))
		Scale = (<Scale> * 0.95)
		text = ($career_minus_deductions_text)
		font_spacing = 4
		font = ($cash_reward_font)
		rgba = [150 60 35 255]
		just = [left top]
		z_priority = 3
	}
	index = 0
	begin
	perm_index = (<perm_deduction_array> [<index>])
	deduction_string = ($cash_deduction_types [<perm_index>].desc)
	FormatText textname = deduction_value "-%c%v" c = ($cash_deduction_types [<perm_index>].currency) v = ($cash_deduction_types [<perm_index>].val)
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		Pos = (((0.0, 1.0) * (<separation_height> * (<index> + 2))) + (15.0, 0.0))
		Scale = (<Scale> * 0.95)
		text = <deduction_string>
		font = ($cash_reward_font)
		rgba = [0 0 0 255]
		just = [left top]
		z_priority = 3
	}
	GetScreenElementDims id = <id>
	if (<width> > 400)
		SetScreenElementProps id = <id> Scale = 1
		fit_text_in_rectangle id = <id> dims = ((400.0, 0.0) + <height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		type = TextElement
		parent = deductions_container
		Pos = ((1.0, 0.0) * <dl_width> + (0.0, 1.0) * (<separation_height> * (<index> + 2)))
		Scale = (<Scale> * 0.95)
		text = <deduction_value>
		font = ($cash_reward_font)
		rgba = [150 60 35 255]
		just = [RIGHT top]
		z_priority = 3
	}
	<index> = (<index> + 1)
	repeat <deduction_count>
endscript
