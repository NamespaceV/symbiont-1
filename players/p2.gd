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
	position = clamp_to_camera_bounds(position)
	
	if cooldown > 0:
		cooldown -= delta
	
	if Input.is_action_just_pressed("p2_a") && cooldown <= 0:
		cooldown = 0.2
		if G.ammo > 0:
			G.ammo -= 1
			var b = boom_scn.instantiate() as Node2D
			b.global_position = self.global_position
			get_tree().root.add_child(b)
	
	if G.ammo == 0:
		$AnimationPlayer.play("no_ammo")
	else:
		$AnimationPlayer.play("RESET")
	$AmmoLabel.text = str(G.ammo)


func clamp_to_camera_bounds(position: Vector2) -> Vector2:
	var camera = get_viewport().get_camera_2d()
	var viewport_rect = camera.get_viewport_rect()  # Size of viewport in pixels
	
	# Get camera zoom factor
	var zoom = camera.zoom
	
	# Calculate half size of visible area in world units (considering zoom)
	var half_width = viewport_rect.size.x * 0.5 * zoom.x
	var half_height = viewport_rect.size.y * 0.5 * zoom.y

	# Camera position is center of view in world space
	var cam_pos = camera.global_position

	# Calculate clamped position limits
	var left_bound = cam_pos.x - half_width
	var right_bound = cam_pos.x + half_width
	var top_bound = cam_pos.y - half_height
	var bottom_bound = cam_pos.y + half_height

	# Clamp position within bounds
	position.x = clamp(position.x, left_bound, right_bound)
	position.y = clamp(position.y, top_bound, bottom_bound)

	return position
