extends State
class_name IdlePlayerState

@export var walking_player_state: State
@export var jumping_player_state: State
@export var falling_player_state: State

func enter():
	var player_parent:Player = parent
	player_parent.start_animation("idle")
	return

func process_physics(delta: float) -> State:
	var player_parent:Player = parent

	player_parent.apply_friction(delta)
	player_parent.move_and_slide()

	if !player_parent.is_on_floor():
		player_parent.coyote_jump_timer.start()
		return falling_player_state
	if Input.get_axis("move_left","move_right") != 0:
		return walking_player_state
	return

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return jumping_player_state
	return
