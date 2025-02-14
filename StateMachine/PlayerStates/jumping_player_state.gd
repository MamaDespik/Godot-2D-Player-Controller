extends State
class_name JumpingPlayerState

@export var idle_player_state:State
@export var falling_player_state:State

var gravity:Vector2

func enter():
	var player_parent:Player = parent
	player_parent.start_animation("jumping")
	player_parent.velocity.y = player_parent.movement.jump_velocity
	gravity = player_parent.get_gravity()/2
	#player_parent.move_and_slide()
	return

func process_physics(delta: float) -> State:
	var player_parent:Player = parent

	player_parent.apply_gravity(gravity, delta)
	var input_axis:float = Input.get_axis("move_left", "move_right")
	if input_axis == 0:
		player_parent.apply_air_resistance(delta)
	else:
		player_parent.handle_air_acceleration(input_axis, delta)
	player_parent.update_animations(input_axis)
	player_parent.move_and_slide()

	if player_parent.is_on_floor():
		return idle_player_state

	if player_parent.velocity.y >= 0:
		return falling_player_state

	return

func process_input(event: InputEvent) -> State:
	var player_parent:Player = parent
	if event.is_action_released("jump"):
		#player_parent.velocity.y *= .5
		gravity = player_parent.get_gravity()
	return
