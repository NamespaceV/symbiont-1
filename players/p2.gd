class_name P2
extends Area2D

var boom_scn = load("res://players/boom.tscn") as PackedScene

var cooldown = 0.0

func _ready() -> void:
	G.p2 = self


func _physics_process(delta: float) -> void:
	var i = Input.get_vector("p2_l", "p2_r", "p2_u", "p2_d")
	var velocity = i * 700
	position += velocity * delta
	
	if cooldown > 0:
		cooldown -= delta
	
	if Input.is_action_just_pressed("p2_a") && cooldown <= 0:
		cooldown = 0.2
		if G.ammo > 0:
			G.ammo -= 1
			var b = boom_scn.instantiate() as Node2D
			b.global_position = self.global_position
			get_tree().root.add_child(b)
