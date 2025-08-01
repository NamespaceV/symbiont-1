class_name P1
extends CharacterBody2D

const VELOCITY = 500

const SLOW_DISTANCE = 280
var velocity_mod = 1.0
const MOD_MIN = 0.1
const MOD_MAX =  1
const MOD_ACC = 0.3

func _ready() -> void:
	G.p1 = self


func _physics_process(delta: float) -> void:
	handle_move()
	handle_slow(delta)


func handle_move():
	var i = Input.get_vector("p1_l", "p1_r", "p1_u", "p1_d")
	velocity = i * VELOCITY * velocity_mod
	var old_pos = global_position
	move_and_slide()
	var delta_pos = global_position - old_pos
	G.p2.position += delta_pos


func handle_slow(delta:float):
	var distance_sq = (G.p2.global_position - global_position).length_squared()
	#print("vel d",sqrt(distance_sq))
	if distance_sq > SLOW_DISTANCE * SLOW_DISTANCE:
		velocity_mod -= delta * MOD_ACC
		velocity_mod = max(velocity_mod, MOD_MIN)
		$SlowLabel.add_theme_color_override("font_color", Color.RED)
		#$SlowLabel.text = "SLOW "+velocity_mod
	else:
		velocity_mod += delta * MOD_ACC
		velocity_mod = min(velocity_mod, MOD_MAX)
		$SlowLabel.add_theme_color_override("font_color", Color.GREEN)
	
	if velocity_mod > 0.8:
		$SlowLabel.hide()
	else:
		$SlowLabel.show()
	

func ammo_pickup_anim():
	$AnimationPlayer.play("ammo_picekd_up")

func damaged_anim():
	$AnimationPlayer.play("damaged")
