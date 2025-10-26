@tool
extends Node2D
class_name water

# Variables, @export is used so they are editible on the inspector.
@export var water_size: Vector2 = Vector2(8.0, 16.0) #Size of the body of water
@export var surface_pos_y: float = 0.5 
@export_range(2, 512) var segment_count: int = 64 #Amount of points in the surface of water. More points = More detailed.

@export var player_splash_multiplier: float = 0.12
@export_range(0.0, 1000.0) var water_physics_speed: float = 80.0 #How fast the water moves. 
@export var water_restoring_force: float = 0.02 #Amount of force that we apply to restore the water back to its resting position.
@export var wave_energy_loss: float = 0.04 #Makes the waves come down overtime.
@export var wave_strength: float = 0.25 #How big the waves are when interacted by a player.
@export_range(1, 64) var wave_spread_updates: int = 8

@export var surface_line_thickness: float = 1.0 #How thick the surface line is for the water.
@export var surface_color: Color = Color("3ce1da") #Colour of the line on the surface of water. 
@export var water_fill_color: Color = Color("37b0c5") #colour of the water beneath the surface.

var segment_data: Array = [] #stores the data of every point or segment.
var recently_splashed: bool = false 

var surface_line: Line2D
var fill_polygon: Polygon2D

@export_tool_button("Update Water") var update_water_button: Callable = func():
	_ready()
	update_visuals()

func _ready() -> void:
	for i in get_children():
		i.queue_free()
	
	_initiate_water()

# Water Functions
func _initiate_water() -> void:
	segment_data.clear()
	for i in range(segment_count):
		segment_data.append({
			"height": surface_pos_y, #Y position of the points.
			"velocity": 0.0, #velocity of the Y position.
			"wave_to_left": 0.0, #Amount of height the neighbouring points should have when this point is moving.
			"wave_to_right": 0.0 #Amount of height the neighbouring points should have when this point is moving.
		})

	#Visuals
	var new_line: Line2D = Line2D.new()
	new_line.width = surface_line_thickness
	new_line.default_color = surface_color
	add_child(new_line)
	surface_line = new_line
	
	var new_polygon: Polygon2D = Polygon2D.new()
	new_polygon.color = water_fill_color
	new_polygon.show_behind_parent = true
	surface_line.add_child(new_polygon)
	fill_polygon = new_polygon
	
	#Collision
	var new_area: Area2D = Area2D.new()
	new_area.body_entered.connect(_on_body_entered)
	new_area.body_exited.connect(_on_body_exited)
	new_area.visible = false
	add_child(new_area)
	
	var new_collisionshape: CollisionShape2D = CollisionShape2D.new()
	var new_shape: RectangleShape2D = RectangleShape2D.new()
	new_shape.size = water_size
	new_collisionshape.shape = new_shape
	new_collisionshape.position = water_size/2.0 + Vector2(0, surface_pos_y/2.0)
	new_area.add_child(new_collisionshape)
	
func _process(delta: float) -> void:
	update_physics(delta)
	update_visuals()
	
# Water Physics
func update_physics(delta: float) -> void:
	for i in range(segment_count):
		var displacement = segment_data[i]["height"] - surface_pos_y
		var acceleration = -water_restoring_force * displacement - segment_data[i]["velocity"] * wave_energy_loss
		
		segment_data[i]["velocity"] += acceleration * delta * water_physics_speed
		segment_data[i]["height"] += segment_data[i]["velocity"] * delta * water_physics_speed
	
	for updates in range(wave_spread_updates):
		for i in range(segment_count):
			if i > 0:
				segment_data[i]["wave_to_left"] = (segment_data[i]["height"] - segment_data[i-1]["height"]) * wave_strength
				segment_data[i-1]["velocity"] += segment_data[i]["wave_to_left"] * delta * water_physics_speed
			if i < segment_count - 1:
					segment_data[i]["wave_to_right"] = (segment_data[i]["height"] - segment_data[i+1]["height"]) * wave_strength
					segment_data[i+1]["velocity"] += segment_data[i]["wave_to_left"] * delta * water_physics_speed
		
	for i in range(segment_count):
		if i > 0:
			segment_data[i-1]["height"] += segment_data[i]["wave_to_left"] * delta * water_physics_speed
		if i < segment_count-1:
			segment_data[i+1]["height"] += segment_data[i]["wave_to_right"] * delta * water_physics_speed
	
	segment_data[0]["height"] = surface_pos_y
	segment_data[1]["height"] = surface_pos_y
	segment_data[0]["velocity"] = 0.0
	segment_data[1]["velocity"] = 0.0
	
	segment_data[segment_count - 1]["height"] = surface_pos_y
	segment_data[segment_count - 2]["height"] = surface_pos_y
	segment_data[segment_count - 1]["velocity"] = 0.0
	segment_data[segment_count - 2]["velocity"] = 0.0
	
	if !recently_splashed:
		var is_still: bool = true
		for i in surface_line.points:
			if abs(abs(i.y) - abs(surface_pos_y)) > 0.001:
				is_still = false
				break #stops the loop
		set_process(!is_still)
	else: 
		recently_splashed = false
		
func update_visuals() -> void:
	var points: Array[Vector2] = []
	var segment_width: float = water_size.x / (segment_count - 1)
	for i in range(segment_count):
		points.append(Vector2(i * segment_width, segment_data[i]["height"]))
		
	var left_static_point: Vector2 = Vector2(points[0].x, surface_pos_y)
	var right_static_point: Vector2 = Vector2(points[points.size()-1].x, surface_pos_y)
	
	var final_points: Array[Vector2] = []
	final_points.append(left_static_point)
	final_points += points
	final_points.append(right_static_point)
	
	surface_line.points = final_points
	
	var bottom_y: float = surface_pos_y + water_size.y
	final_points.append(Vector2(water_size.x, bottom_y))
	final_points.append(Vector2(0, bottom_y))
	fill_polygon.polygon = final_points
	
func splash(splash_pos: Vector2, splash_velocity: float) -> void: #Splashing Water
		var local_x_pos: float = to_local(splash_pos).x
		var segment_width: float = water_size.x / (segment_count -1)
		var index: int = int(clamp(local_x_pos / segment_width, 0, segment_count -1))
		segment_data[index]["velocity"] = splash_velocity
		recently_splashed = true
		set_process(true)
	
	
	
	
func _on_body_entered(_body: Node2D) -> void:
	pass
	
func _on_body_exited(_body: Node2D) -> void:
	pass
