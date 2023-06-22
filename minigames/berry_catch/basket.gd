extends Area2D
class_name BasketArea # The first child of a Basket node subtree

const SELECT_COOLDOWN_RESET := 20
const SELECT_COOLDOWN_SCALE := 5
var select_cooldown := 0
var selected := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		snap_to_mouse()
	
	if select_cooldown > -1:
		select_cooldown = select_cooldown - ( delta * SELECT_COOLDOWN_SCALE + 0.5 ) as int
	
	#print( select_cooldown )


func snap_to_mouse():
	get_parent().position = get_global_mouse_position()


func _on_input_event( _viewport:Node, event:InputEvent, _shape_idx:int):
	if select_cooldown <= 0:
		if event is InputEventMouseButton:
			if (event.button_index & MOUSE_BUTTON_LEFT):
				#print("oop!")
				selected = !selected
				select_cooldown = SELECT_COOLDOWN_RESET
	
	pass



