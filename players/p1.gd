## doc string
class_name P1
extends CharacterBody2D

const VELOCITY = 500

const SLOW_DISTANCE = 280
var velocity_mod = 1.0
const MOD_MIN = 0.1
const MOD_MAX =  1
const MOD_ACC = 0.3

var show_slow_indicator = false

func _ready() -> void:
	G.p1 = self

func _physics_process(delta: float) -> void:
	handle_move()
	handle_slow(delta)


## move stuff
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
	var c:Color
	if distance_sq > SLOW_DISTANCE * SLOW_DISTANCE:
		show_slow_indicator = true
		velocity_mod -= delta * MOD_ACC
		velocity_mod = max(velocity_mod, MOD_MIN)
		c = Color.RED
	else:
		show_slow_indicator = false
		velocity_mod += delta * MOD_ACC
		velocity_mod = min(velocity_mod, MOD_MAX)
		c = Color.GREEN
	queue_redraw()
	var slow_pct = (velocity_mod-MOD_MIN)/(MOD_MAX-MOD_MIN)
	c.a = lerp(1, 0, slow_pct)
	$SlowBar.value = velocity_mod
	$SlowLabel.add_theme_color_override("font_color", c)

func _draw() -> void:
	if show_slow_indicator:
		var slow_pct = (velocity_mod-MOD_MIN)/(MOD_MAX-MOD_MIN)
		var c = lerp_color_hsv(Color.RED, Color.GREEN, slow_pct)
		draw_line(G.p2.global_position-global_position, Vector2.ZERO, c)

func lerp_color_hsv(color_a: Color, color_b: Color, t: float) -> Color:
	# Interpolate hue correctly around the circle using lerp_angle (in radians)
	var h = lerp_angle(color_a.h * TAU, color_b.h * TAU, t) / TAU
	var s = lerp(color_a.s, color_b.s, t)
	var v = lerp(color_a.v, color_b.v, t)
	var a = lerp(color_a.a, color_b.a, t)
	
	return Color.from_hsv(h, s, v, a)

func ammo_pickup_anim():
	$AnimationPlayer.play("ammo_picekd_up")

func damaged_anim():
	$AnimationPlayer.play("damaged")
