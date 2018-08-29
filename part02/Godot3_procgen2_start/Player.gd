extends KinematicBody2D

export var speed = 50

var velocity = Vector2()
var zoom = 0.1
var zoom_step = 0.05

func _ready():
	$Camera2D.zoom = Vector2(zoom, zoom)
	$Camera2D.current = true
	
func _input(event):
	if event.is_action_pressed('scroll_up'):
		zoom -= zoom_step
	if event.is_action_pressed('scroll_down'):
		zoom += zoom_step
	zoom = clamp(zoom, 0.05, 0.8)
	$Camera2D.zoom = Vector2(zoom, zoom)
		
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)