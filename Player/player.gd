extends CharacterBody2D
class_name Player

@export var movement : PlayerMovementData
@export var idle_player_movement_state:State

@onready var coyote_jump_timer: Timer = $CoyoteJumpTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var direction = -1

func _ready():
	state_machine.init(self)
	state_machine.start()
	return

func _process(delta):
	state_machine.process_frame(delta)
	return

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	return

func _input(event):
	state_machine.process_input(event)
	return

func apply_gravity(gravity: Vector2, delta):
	velocity += gravity * delta
	return

func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, movement.friction * delta)
	return

func apply_air_resistance(delta):
	velocity.x = move_toward(velocity.x, 0, movement.air_resistance * delta)
	velocity.x = move_toward(velocity.x, 0, movement.air_resistance * delta)
	return

func handle_acceleration(input_axis, delta):
	velocity.x = move_toward(velocity.x, movement.speed * input_axis, movement.acceleration * delta)
	return

func handle_air_acceleration(input_axis, delta):
	velocity.x = move_toward(velocity.x, movement.speed * input_axis, movement.air_acceleration * delta)
	return

func update_animations(input_axis):
	if input_axis != 0:
		sprite_2d.flip_h = (input_axis > 0)
	return

func start_animation(animation:String):
	#animation_player.play(animation)
	return
