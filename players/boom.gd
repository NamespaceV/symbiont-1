extends Node2D

func _ready() -> void:
	kill_stuff()
	get_tree().create_timer(0.3).timeout.connect(func ():
		queue_free()
	)

func kill_stuff():
	var params = PhysicsPointQueryParameters2D.new()
	params.position = global_position
	var hit = get_world_2d().direct_space_state.intersect_point(params)
	for h in hit:
		var e = h["collider"] as Enemy
		if e:
			e.kill()
	
