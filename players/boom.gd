extends Node2D

func _ready() -> void:
	kill_stuff()
	get_tree().create_timer(0.3).timeout.connect(func ():
		queue_free()
	)

func kill_stuff():
	var params = PhysicsShapeQueryParameters2D.new()
	params.transform = Transform2D(0, global_position)
	var shape = CircleShape2D.new()
	shape.radius = 30
	params.shape = shape
	var hit = get_world_2d().direct_space_state.intersect_shape(params)
	for h in hit:
		var e = h["collider"] as Node
		if e.has_meta("hittable"):
			print("hit ", e.name)
			e.hit()
		else:
			print("hit ignored on ", e.name)
		
	if hit.is_empty():
		print("hit nothing")
		
	
