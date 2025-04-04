extends Node

## referred to as PT

enum Combo {
	DOWN,
	UP,
}

enum BeatQuality {
	MISS,
	EARLY,
	PERFECT,
	LATE,
	NONE, ## none is to stop too early miss
}


func array_combo_to_string(arr: Array[Combo]) -> String:
	var string := ""
	for c in arr:
		if c == Combo.DOWN:
			string += "0"
		else:
			string += "1"
	return string


func string_to_array_combo(string: String) -> Array[Combo]:
	var arr: Array[Combo] = []
	for c in string:
		if c == "0":
			arr.append(Combo.DOWN)
		else :
			arr.append(Combo.UP)
	return arr
