# ############################################################################ #
# Copyright © 2015-present inkle Ltd.
# Copyright © 2019-present Frédéric Maquin <fred@ephread.com>
# All Rights Reserved
#
# This file is part of inkgd.
# inkgd is licensed under the terms of the MIT license.
# ############################################################################ #

extends "res://addons/inkgd/runtime/ink_object.gd"

# ############################################################################ #
# Imports
# ############################################################################ #

# warning-ignore:unused_class_variable
var CallStack = load("res://addons/inkgd/runtime/call_stack.gd")

# ############################################################################ #

# warning-ignore:unused_class_variable
var text # String

# () -> String
# (String) -> void
# warning-ignore:unused_class_variable
var path_string_on_choice setget set_path_string_on_choice, get_path_string_on_choice
func get_path_string_on_choice():
    return target_path.to_string()

func set_path_string_on_choice(value):
    target_path = InkPath.get_ref().new_with_components_string(value)

# warning-ignore:unused_class_variable
var source_path = null # String
# warning-ignore:unused_class_variable
var index = 0 # index
var target_path = null # InkPath
# warning-ignore:unused_class_variable
var thread_at_generation = null # CallStack.InkThread
# warning-ignore:unused_class_variable
var original_thread_index = 0 # int
# warning-ignore:unused_class_variable
var is_invisible_default = false # bool

# ############################################################################ #
# GDScript extra methods
# ############################################################################ #

func is_class(type):
    return type == "Choice" || .is_class(type)

func get_class():
    return "Choice"
