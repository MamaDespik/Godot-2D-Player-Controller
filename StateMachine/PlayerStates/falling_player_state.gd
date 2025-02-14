extends State
class_name FallingPlayerState

@export var idle_player_state: State
@export var jumping_player_state: State


func enter():
	var player_parent:Player = parent
	player_parent.start_animation("falling")
	return

func process_physics(delta: float) -> State:
	var player_parent:Player = parent

	player_parent.apply_gravity(player_parent.get_gravity(), delta)
	var input_axis:float = Input.get_axis("move_left", "move_right")
	if input_axis == 0:
		player_parent.apply_air_resistance(delta)
	else:
		player_parent.handle_air_acceleration(input_axis, delta)
	player_parent.update_animations(input_axis)
	player_parent.move_and_slide()

	if player_parent.is_on_floor():
		return idle_player_state
	return

func process_input(event: InputEvent) -> State:
	var player_parent:Player = parent
	if event.is_action_pressed("jump") and \
	player_parent.coyote_jump_timer.time_left > 0:
		return jumping_player_state
	return
