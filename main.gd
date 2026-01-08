extends Node2D

signal screen_size_changed(newSize: Rect2, oldSize: Rect2)

var origin = Vector2(0, 0)
var screenRect: Rect2
var screenRectPrev = Rect2(0, 0, 0, 0)

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

func OnPlayerDefeated(player : PlayerController, collision_normal : Vector2):
	print("big loser")
	SpawnDefeatBodies(player, collision_normal)

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

func SpawnDefeatBodies(player : PlayerController, collision_normal : Vector2):
	var defeat_bottom_left = preload("res://player/defeat/defeat_b_l.tscn")
	var defeat_bottom_right = preload("res://player/defeat/defeat_b_r.tscn")
	var defeat_top_left = preload("res://player/defeat/defeat_t_l.tscn")
	var defeat_top_right = preload("res://player/defeat/defeat_t_r.tscn")
	
	var corner_bl = defeat_bottom_left.instantiate()
	var corner_br = defeat_bottom_right.instantiate()
	var corner_tl = defeat_top_left.instantiate()
	var corner_tr = defeat_top_right.instantiate()
	
	var rotationPlayer = Vector2.from_angle(player.rotation)
	var rotation_bl = Vector2.from_angle(player.rotation+3*PI/4)
	var rotation_br = Vector2.from_angle(player.rotation+PI/4)
	var rotation_tl = Vector2.from_angle(player.rotation-3*PI/4)
	var rotation_tr = Vector2.from_angle(player.rotation-PI/4)
	
	# i do not understand why 46
	var offset_bl = 46*rotation_bl
	var offset_br = 46*rotation_br
	var offset_tl = 46*rotation_tl
	var offset_tr = 46*rotation_tr
	
	corner_bl.rotation = player.rotation
	corner_br.rotation = player.rotation
	corner_tl.rotation = player.rotation
	corner_tr.rotation = player.rotation
	
	var position = player.global_position
	corner_bl.global_position = position + offset_bl
	corner_br.global_position = position + offset_br
	corner_tl.global_position = position + offset_tl
	corner_tr.global_position = position + offset_tr
	
	for child in player.get_children():
		child.queue_free()
	
	player.queue_free()
	
	self.add_child(corner_bl)
	self.add_child(corner_br)
	self.add_child(corner_tl)
	self.add_child(corner_tr)
	
	var explosionVector = 750 * collision_normal
	
	corner_bl.apply_central_impulse(explosionVector + Vector2(randf_range(-500, 0), 0))
	corner_br.apply_central_impulse(explosionVector + Vector2(randf_range(0, 500), 0))
	corner_tl.apply_central_impulse(explosionVector + Vector2(randf_range(-500, 0), 0))
	corner_tr.apply_central_impulse(explosionVector + Vector2(randf_range(0, 500), 0))
