extends "res://nodes/UI/TextDisplay/TextDisplay.gd"
class_name SpeechBubble
"""
Handle a bubble for speech with various window style
"""

export (Texture) var normal_bubble
export (Texture) var think_bubble

onready var patch = $Background
onready var name_label = $Background/NameBackground/Name
onready var bounce_tween = $BounceTween


func set_name(text: String):
	name_label.text = text


func say(text: String):
	patch.texture = normal_bubble
	patch.region_rect = Rect2(0, 0, normal_bubble.get_width(), normal_bubble.get_height())
	patch.patch_margin_left = 25
	patch.patch_margin_top = 25
	patch.patch_margin_right = 25
	patch.patch_margin_bottom = 125
	set_text(text)


func think(text: String):
	patch.texture = think_bubble
	patch.region_rect = Rect2(0, 0, think_bubble.get_width(), think_bubble.get_height())
	patch.patch_margin_left = 150
	patch.patch_margin_top = 45
	patch.patch_margin_right = 25
	patch.patch_margin_bottom = 160
	set_text(text)


func display():
	.display()
	
	bounce_tween.interpolate_property(self, "rect_scale", Vector2(0.0, 0.0), Vector2(1.0, 1.0), 0.1, Tween.TRANS_LINEAR, 0)
	bounce_tween.start()