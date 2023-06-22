extends Area2D
class_name FruitArea # The first child of a Fruit node subtree

@export var fruit_type := 0
@export var fruit_speed := 500
var gravity_velocity = 0.0

const GRAVITATIONAL_PULL := 20
const PRESET_Y_RESET := -200

signal fruit_caught(fruit_index)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gravity_velocity += delta * GRAVITATIONAL_PULL
	get_parent().position.y = get_parent().position.y + fruit_speed * delta + gravity_velocity
	#print("fruit at ", get_parent().position.y)
	pass

# If you wanted to change its field called 'position', just use that.
# This is for gameplay.
func set_new_position( pos:int = -1 ):
	if pos < 0:
		pos = randi_range(0, ProjectSettings.get_setting("display/window/size/viewport_width"))
		#print("Squadala! We're off: ", pos)
	
	gravity_velocity = 0.0
	
	get_parent().position = Vector2( pos, PRESET_Y_RESET )
	pass


func _on_area_entered(body):
	if body is BasketArea:
		#print("Gee, I shure do hope this body changes position!")
		fruit_caught.emit(fruit_type)
		set_new_position()
	else:
		#print("Mah boy! Dinner. is what all true warriors strive for!")
		set_new_position()
	
	
	pass # Replace with function body.
