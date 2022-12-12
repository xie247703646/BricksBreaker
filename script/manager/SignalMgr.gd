extends Node

#ui
signal ui_opened(ui_name)
signal ui_closed(ui_name)

#game
signal brick_broken(global_pos)
