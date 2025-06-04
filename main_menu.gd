extends Control

func _ready():
    pass

func _process(delta):
    pass

func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://Level/game_level.tscn")


func _on_options_pressed() -> void:
    print()


func _on_exit_pressed() -> void:
    get_tree().quit()
