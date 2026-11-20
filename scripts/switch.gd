extends Area2D

signal activated(active: bool)

var is_active := false

@onready var inactive_visual: Polygon2D = $InactiveVisual
@onready var active_visual: Polygon2D = $ActiveVisual
@onready var prompt_label: Label = $PromptLabel

func _physics_process(_delta: float) -> void:
	var box_inside := _box_inside()
	prompt_label.visible = box_inside

	if box_inside != is_active:
		is_active = box_inside
		_update_visuals()
		activated.emit(is_active)

func _box_inside() -> bool:
	for body in get_overlapping_bodies():
		if body.is_in_group("box"):
			return true
	return false

func _update_visuals() -> void:
	inactive_visual.visible = not is_active
	active_visual.visible = is_active
