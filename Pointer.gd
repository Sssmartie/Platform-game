extends AnimatedSprite2D
@onready var pointer = $Pointer

# Called when the node enters the scene tree for the first time.
func _ready():
	pointer.anim = "Pointer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
