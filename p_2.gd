extends Area2D



func _physics_process(delta: float) -> void:
	var i = Input.get_vector("p2_l", "p2_r", "p2_u", "p2_d")
	var velocity = i * 500
	position += velocity * delta
