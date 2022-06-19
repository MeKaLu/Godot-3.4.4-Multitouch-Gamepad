extends Node2D

export(int) var circle0_radius: float = 50
export(Color) var circle0_color: Color = Color.white

export(int) var circle1_radius: float = 50
export(Color) var circle1_color: Color = Color.white

var circle0_index: int = -1
var circle1_index: int = -1

var circle0_pressing: bool = false
var circle1_pressing: bool = false

var circle0_position: Vector2 = Vector2.ZERO
var circle1_position: Vector2 = Vector2.ZERO

func is_inside_circle0(pos: Vector2) -> bool:
	if pos.distance_to(position) > circle0_radius: return false
	return true

func is_inside_circle1(pos: Vector2) -> bool:
	if pos.distance_to(position + Vector2(700, 0)) > circle1_radius: return false
	return true

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			print("finger no: ", event.index, " is pressing")
			print(event.position)
			if is_inside_circle0(event.position):
				print("circle0 touch")
				circle0_pressing = true
				circle0_index = event.index
				circle0_position = event.position
			elif is_inside_circle1(event.position):
				print("circle1 touch")
				circle1_pressing = true
				circle1_index = event.index
				circle1_position = event.position
		else:
			print("finger no: ", event.index, " is released")
			if event.index == circle0_index: 
				circle0_pressing = false
				circle0_index = -1
				circle0_position = event.position
			elif event.index == circle1_index: 
				circle1_pressing = false
				circle1_index = -1
				circle1_position = event.position
	elif event is InputEventScreenDrag:
		if event.index == circle0_index:
			print("circle0 drag")
			circle0_position = event.position
		elif event.index == circle1_index: 
			print("circle1 drag")
			circle1_position = event.position

func _process(delta) -> void:
	if circle0_pressing:
		print((position - circle0_position).normalized())
		$Sprite.position += -(position - circle0_position).normalized() * 500 * delta
	if circle1_pressing:
		print(((position + Vector2(700, 0)) - circle1_position).normalized())
		$Sprite.scale += ((position + Vector2(700, 0) - circle1_position)).normalized() * 10 * delta

func _draw() -> void:
	draw_circle(Vector2.ZERO, circle0_radius, circle0_color)
	draw_circle(Vector2(700, 0), circle1_radius, circle1_color)
