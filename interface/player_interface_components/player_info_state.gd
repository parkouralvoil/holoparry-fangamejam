extends Resource
class_name CharacterInfoState

signal combo_changed()

var combo_parry: String: 
	set(str):
		combo_parry = str
		combo_changed.emit()
var combo_skill_1: String: 
	set(str):
		combo_skill_1 = str
		combo_changed.emit()
var combo_skill_2: String: 
	set(str):
		combo_skill_2 = str
		combo_changed.emit()
var combo_skill_3: String: 
	set(str):
		combo_skill_3 = str
		combo_changed.emit()
