extends Node2D
@onready var canvas_layer = $"."
var origin
var screenRect
var random
var magicNumber
var maxWidth
var minWidth = 0
var maxHeight
var minHeight = 0

func _ready():
	# setup backround size
	origin = Vector2(0, 0)
	var screenSize = get_window().get("size")
	maxWidth = screenSize.x
	maxHeight = screenSize.y
	screenRect = Rect2(origin, screenSize)
	
	# setup star randomizer
	random = RandomNumberGenerator.new()
	random.randomize()
	magicNumber = random.randi() % 1000
	
	# connect to window size changes
	get_window().size_changed.connect(OnWindowSizeChanged)

func _draw():
	DrawBlackBackground()
	DrawStarsRandomly()

func OnWindowSizeChanged():
	canvas_layer.queue_redraw()

func DrawBlackBackground():
	canvas_layer.draw_rect(screenRect, Color.BLACK)

func DrawStarsRandomly():
	for x in range(minWidth, maxWidth):
		for y in range(minHeight, maxHeight):
			if random.randi() % 1000 == magicNumber:
				var coord = Vector2(x, y)
				canvas_layer.draw_circle(coord, 1, Color.WHITE)
	minWidth = maxWidth
	minHeight = maxHeight
