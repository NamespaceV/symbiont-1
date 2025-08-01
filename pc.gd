extends CharacterBody2D



func _physics_process(delta: float) -> void:
	var i = Input.get_vector("p1_l", "p1_r", "p1_u", "p1_d")
	velocity = i * 500
	move_and_slide()
