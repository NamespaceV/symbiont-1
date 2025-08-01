class_name P1
extends CharacterBody2D


func _ready() -> void:
	G.p1 = self


func _physics_process(delta: float) -> void:
	var i = Input.get_vector("p1_l", "p1_r", "p1_u", "p1_d")
	velocity = i * 500
	move_and_slide()
	G.p2.position += velocity * delta
