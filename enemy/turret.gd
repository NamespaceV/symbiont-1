extends Polygon2D

@export var bullet_scene : PackedScene

@export var cooldown : float = 2
@export var rotate_bullet : bool = true

@export var destroy_chain_parent : Node2D = null

@export var needs_to_be_killed : bool = true 

var  cooldown_left =  cooldown

func _ready() -> void:
	if needs_to_be_killed:
		G.enemies_alive += 1

	if destroy_chain_parent:
		destroy_chain_parent.tree_exited.connect( func ():
			queue_free()
		)


func _physics_process(delta: float) -> void:
	look_at(G.p1.position)
	cooldown_left -= delta
	if cooldown_left < 0:
		cooldown_left =  cooldown
		shoot()


func shoot():
	if !bullet_scene: return
	var b = bullet_scene.instantiate() as Node2D
	get_tree().current_scene.add_child(b)
	b.global_position = $BarrelMarker2D.global_position
	if rotate_bullet:
		b.global_rotation = $BarrelMarker2D.global_rotation


func _exit_tree() -> void:
	if needs_to_be_killed:
		G.enemies_alive -= 1
