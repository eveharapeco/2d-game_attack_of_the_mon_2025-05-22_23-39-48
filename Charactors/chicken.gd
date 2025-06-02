extends CharacterBody2D

enum CHICKEN_STATE { IDLE, WALK }

@export var move_speed : float = 27 
@export var idle_time : float = 5
@export var walk_time : float = 2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var move_direction : Vector2 = Vector2.ZERO
var current_state : CHICKEN_STATE = CHICKEN_STATE.IDLE

func _ready():
	select_new_direction()

func _physics_process(_delta):
	velocity = move_direction * move_speed
	
	move_and_slide()


func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	
	#if (move_direction.x < 0):
		#sprite.flip_h = true
	#elif (move_direction.x > 0):
		#sprite.flip_h = false
		
#😘
func pick_new_state():
	if(current_state == CHICKEN_STATE.IDLE):
		state_machine.travel("walk_right")
	   # state_machine.travel("walk")
		current_state = CHICKEN_STATE.WALK
		timer.start(walk_time)
		select_new_direction()
	elif (current_state == CHICKEN_STATE.WALK):
		state_machine.travel("idle")
		current_state = CHICKEN_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout() -> void:
	pick_new_state() # Replace with function body.
