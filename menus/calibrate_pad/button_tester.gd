extends Polygon2D

@export var action_name : String = "p1_u"
func _process(_delta: float) -> void:

	if Input.is_action_just_pressed(action_name):
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.stop()
		$AnimationPlayer.play("click")
