extends Node2D

var InkRuntime = load("res://addons/inkgd/runtime.gd")

func _ready():
    InkRuntime.init(get_tree().root)

func _exit_tree():
    call_deferred("_remove_runtime")

func _add_runtime():
    InkRuntime.init(get_tree().root)

func _remove_runtime():
    InkRuntime.deinit(get_tree().root)