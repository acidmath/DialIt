extends Node2D

signal screen_size_changed(newSize: Rect2, oldSize: Rect2)

var origin = Vector2(0, 0)
var screenRect: Rect2
var screenRectPrev = Rect2(0, 0, 0, 0)

#var defeat_bottom_left = preload("res://player/defeat/corner_bl.png")
#var defeat_bottom_right = preload("res://player/defeat/corner_br.png")
#var defeat_top_left = preload("res://player/defeat/corner_tl.png")
#var defeat_top_right = preload("res://player/defeat/corner_tr.png")

func _ready():
	# setup backround size
	SetupScreenRect()
	# emit initial increase
	EmitScreenSizeChanged()
	# connect to window size changes
	get_window().size_changed.connect(OnWindowSizeChanged)

func OnWindowSizeChanged():
	if SetupScreenRect():
		EmitScreenSizeChanged()

func OnPlayerDefeated(player : PlayerController):
	print("big loser")
	SpawnDefeatBodies(player)

func SetupScreenRect() -> bool:
	var screenSize = get_window().get("size")
	if screenSize.x != screenRectPrev.size.x or screenSize.y != screenRectPrev.size.y:
		screenRect = Rect2(origin, screenSize)
		return true
	else:
		return false
		
func EmitScreenSizeChanged():
	screen_size_changed.emit(screenRect, screenRectPrev)
	screenRectPrev.size.x = screenRect.size.x
	screenRectPrev.size.y = screenRect.size.y
	
func SpawnDefeatBodies(player : PlayerController):
	var defeat_bottom_left = preload("res://player/defeat/defeat_b_l.tscn")
	var defeat_bottom_right = preload("res://player/defeat/defeat_b_r.tscn")
	var defeat_top_left = preload("res://player/defeat/defeat_t_l.tscn")
	var defeat_top_right = preload("res://player/defeat/defeat_t_r.tscn")
	
	var corner_bl = defeat_bottom_left.instantiate()
	var corner_br = defeat_bottom_right.instantiate()
	var corner_tl = defeat_top_left.instantiate()
	var corner_tr = defeat_top_right.instantiate()
	print(player)
	var position = player.global_position
	corner_bl.global_position = position
	corner_br.global_position = position
	corner_tl.global_position = position
	corner_tr.global_position = position
	
	self.remove_child(player)
	
	self.add_child(corner_bl)
	self.add_child(corner_br)
	self.add_child(corner_tl)
	self.add_child(corner_tr)
