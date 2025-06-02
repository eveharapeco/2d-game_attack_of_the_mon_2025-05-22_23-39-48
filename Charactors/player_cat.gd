extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)
# parameters/Idle/blend_position
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	# animation_tree.set("parameters/Idle/blend_position", starting_direction)
	update_animation_parameters(starting_direction)
	
# get calculated and moved around the same time (physics of the character movement)
func _physics_process(_delta): # underscore represents empty variable avoids warning message
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	# moving velocity 
	velocity = input_direction * move_speed
	

# Move and slide fucntion uses velocity of character body
	move_and_slide()
	
	pick_new_state()
	
func update_animation_parameters(move_input : Vector2):
	# if there is no move input then don't change the animation 
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
