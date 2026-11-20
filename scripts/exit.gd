extends Area2D

signal completed
signal blocked

var is_open := false

@onready var closed_visual: Polygon2D = $ClosedVisual
@onready var open_visual: Polygon2D = $OpenVisual

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func set_open(open: bool) -> void:
	is_open = open
	_update_visuals()

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if is_open:
		completed.emit()
	else:
		blocked.emit()

func _update_visuals() -> void:
	closed_visual.visible = not is_open
	open_visual.visible = is_open
