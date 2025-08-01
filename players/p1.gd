class_name P1
extends CharacterBody2D


func _ready() -> void:
	G.p1 = self


func _physics_process(delta: float) -> void:
	var i = Input.get_vector("p1_l", "p1_r", "p1_u", "p1_d")
	velocity = i * 500
	var old_pos = global_position
	move_and_slide()
	var delta_pos = global_position - old_pos
	G.p2.position += delta_pos
