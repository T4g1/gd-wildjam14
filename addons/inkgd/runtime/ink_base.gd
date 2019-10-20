# ############################################################################ #
# Copyright © 2015-present inkle Ltd.
# Copyright © 2019-present Frédéric Maquin <fred@ephread.com>
# All Rights Reserved
#
# This file is part of inkgd.
# inkgd is licensed under the terms of the MIT license.
# ############################################################################ #

extends Reference

# ############################################################################ #
# Imports
# ############################################################################ #

# warning-ignore:unused_class_variable
var Utils = preload("res://addons/inkgd/runtime/extra/utils.gd")

# ############################################################################ #

func equals(_ink_base) -> bool:
    return false

func to_string() -> String:
    return str(self)

func is_class(type):
    return type == "InkBase" || .is_class(type)

func get_class():
    return "InkBase"
