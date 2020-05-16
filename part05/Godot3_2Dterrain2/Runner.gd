extends KinematicBody2D

export var speed = 200
export var gravity = 1500
var velocity = Vector2()

func _input(event):
	if event.is_action_pressed('scroll_up'):
		$Camera2D.zoom -= Vector2(0.1, 0.1)
	if event.is_action_pressed('scroll_down'):
		$Camera2D.zoom += Vector2(0.1, 0.1)
		
func _physics_process(delta):
	velocity.x = 0
	velocity.y += gravity * delta
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	velocity.x *= speed
	velocity = move_and_slide(velocity, Vector2(0, -1))
