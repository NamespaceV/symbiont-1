class_name Enemy
extends CharacterBody2D

@onready var nav = $"Navigation" as NavigationAgent2D

@export var speed = 200
	
func _physics_process(delta: float) -> void:
	if (nav.target_position - G.p1.position).length_squared() > 1:
		nav.set_target_position(G.p1.global_position)
		#print("new_pos", G.p1.global_position)

	var goal = nav.get_next_path_position()
	velocity = (goal - global_position).normalized() * speed
	move_and_slide()
	
	var distSq = (global_position - G.p1.position).length_squared()
	#print("d",sqrt(distSq))
	if distSq < 90*90:
		G.deal_damage(5 * delta)

func hit() -> void:
	queue_free()
