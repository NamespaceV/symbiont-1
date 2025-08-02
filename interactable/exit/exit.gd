extends Node2D

@export var level_name : String = ""

func _on_area_2d_body_entered(body: Node2D) -> void:
	var p = body as P1
	if p:
		call_deferred("change_level")

func _physics_process(_delta: float) -> void:
	if G.enemies_alive > 0:
		$EnemiesAlive.show()
		$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$EnemiesAlive.hide()
		$Area2D.process_mode = Node.PROCESS_MODE_INHERIT


func change_level()->void:
	G.load_level(level_name)
	
