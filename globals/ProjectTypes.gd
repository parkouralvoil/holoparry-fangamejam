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
	var str := ""
	for c in arr:
		if c == Combo.DOWN:
			str += "0"
		else:
			str += "1"
	return str


func string_to_array_combo(str: String) -> Array[Combo]:
	var arr: Array[Combo] = []
	for c in str:
		if c == "0":
			arr.append(Combo.DOWN)
		else :
			arr.append(Combo.UP)
	return arr
