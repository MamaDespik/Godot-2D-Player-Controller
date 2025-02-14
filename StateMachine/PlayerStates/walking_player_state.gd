extends State
class_name WalkingPlayerState

@export var idle_player_state:State
@export var jumping_player_state:State
@export var falling_player_state:State

func enter():
	var player_parent:Player = parent
	player_parent.start_animation("walking")
	return

func process_physics(delta: float) -> State:
	var player_parent:Player = parent

	var input_axis:float = Input.get_axis("move_left","move_right")
	player_parent.handle_acceleration(input_axis, delta)
	player_parent.update_animations(input_axis)
	player_parent.move_and_slide()

	if !player_parent.is_on_floor():
		player_parent.coyote_jump_timer.start()
		return falling_player_state

	if input_axis == 0:
		return idle_player_state

	return

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return jumping_player_state
	return
