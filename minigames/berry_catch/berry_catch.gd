extends Node2D

var fruit_caught := 0

@onready var ground_area = $GroundArea
@onready var ground_shape = $GroundArea/GroundShape
@onready var background = $Background/BackgroundPlane
@onready var text_display = $RichTextLabel
@export var fruit_types : Array[FruitData]

@export var fruit_template := preload("res://minigames/berry_catch/fruit.tscn")

var is_prepared := false

var falling_fruit : int = 15

func _init( available_fruit : Array[FruitData], fruitfall_count := 5 ):
	
	fruit_types = available_fruit
	falling_fruit = fruitfall_count
	
	var i:int = 1
	while i < fruit_types.size():
		fruit_types[i].chance_weight = fruit_types[i].chance_weight + fruit_types[i-1].chance_weight
		i += 1
	
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	prepare()
	pass # Replace with function body.


func prepare():
	ground_shape.shape.size = Vector2(background.size.x*2, background.size.y)
	ground_area.position = Vector2(background.size.x/2, background.size.y/2)
	
	print("Ground at ", ground_area.position, " with shape ", ground_shape.shape.size)
	
	var new_fruit
	var i:int = 0
	print( fruit_template.can_instantiate() )
	while i < falling_fruit:
		new_fruit = fruit_template.instantiate()
		add_child( new_fruit )
		new_fruit.position = Vector2(32, i*10)
		new_fruit.fruit_caught.connect(_on_fruit_area_fruit_caught)
		i += 1
	
	is_prepared = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !is_prepared:
		prepare()
	pass


func _on_fruit_area_fruit_caught( _fruit_type ):
	
	fruit_caught += 1;
	text_display.text = str("fruit: ", fruit_caught)
	
	pass # Replace with function body.
