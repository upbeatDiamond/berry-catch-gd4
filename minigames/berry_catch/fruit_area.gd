extends Area2D
class_name FruitArea # The first child of a Fruit node subtree

@export var fruit_type := 0
@export var fruit_speed := 500
var gravity_velocity = 0.0
var is_paused := false

const DEFAULT_RADIUS := 32
const GRAVITATIONAL_PULL := 20
const PRESET_Y_RESET := -200
const PRESET_Y_RESET_RANGE := -200

signal fruit_caught( fruit_index:int )
signal fruit_reset( fruit_body:FruitArea )

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_paused:
		gravity_velocity += delta * GRAVITATIONAL_PULL
		get_parent().position.y = get_parent().position.y + fruit_speed * delta + gravity_velocity
	#print("fruit ", get_rid(), " at ", get_parent().position.y)
	pass

# If you wanted to change its field called 'position', just use that.
# This is for gameplay.
func set_new_position( pos:int = -1 ):
	
	is_paused = true 	# Keep the fruit stuck in place until its hitbox and sprite get fixed
	
	if pos < 0:
		pos = randi_range(0, ProjectSettings.get_setting("display/window/size/viewport_width"))
		#print("Squadala! We're off: ", pos)
	
	gravity_velocity = 0.0
	
	get_parent().position = Vector2( pos, randi_range(PRESET_Y_RESET, PRESET_Y_RESET + PRESET_Y_RESET_RANGE) )
	fruit_reset.emit( self )
	# Have the minigame change the fruit type
	
	pass



func set_new_fruit( new_fruit:FruitData ):
	
	# This is probably a Sprite2D... probably...
	var wrapper = get_parent()
	
	# Make sure the sprite (node) and sprite (graphics) are the same width
	wrapper.sprite.set_texture( new_fruit.picture )
	var picture_ratio = wrapper.texture.get_size().x / wrapper.sprite.texture.get_size().x
	wrapper.sprite.scale = Vector2(picture_ratio,picture_ratio)
	
	# Then make sure the sprite(node) is scaled to the supposed fruit size
	var scale_ratio = new_fruit.fruit_size / wrapper.texture.get_size().x
	wrapper.transform = Transform2D( wrapper.transform.get_rotation(), Vector2(scale_ratio,scale_ratio), wrapper.transform.get_skew(), wrapper.transform.get_origin() )
	
	# Finish up by making sure the fruit holds the right data...
	fruit_type = new_fruit.fruit_index
	
	# And let it continue falling
	is_paused = false
	pass

func _on_area_entered(body):
	if body is BasketArea:
		fruit_caught.emit(fruit_type)
		set_new_position()
	elif body is FruitArea:
		return
	else:
		set_new_position()
	
	pass # Replace with function body.
