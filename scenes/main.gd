extends Node2D


func _input(event):
	if event.is_action_pressed("ui_left"):
		$Dialog.start_story([$MoriartysShadow, $Moriarty])