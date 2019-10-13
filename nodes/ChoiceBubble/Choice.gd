extends Label
class_name Choice


var value = ""


func set_text(_value: String):
	value = _value
	text = "  " + value


func select():
	text = "> " + value


func deselect():
	text = "  " + value