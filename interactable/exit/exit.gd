extends Node2D

@export var level_name : String = ""

func _on_area_2d_body_entered(body: Node2D) -> void:
	var p = body as P1
	if p:
		call_deferred("change_level")


func change_level()->void:
	G.load_level(level_name)
	
