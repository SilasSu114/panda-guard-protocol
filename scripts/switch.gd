extends Area2D

signal activated(active: bool)

var is_active := false

@onready var inactive_visual: Polygon2D = $InactiveVisual
@onready var active_visual: Polygon2D = $ActiveVisual
@onready var prompt_label: Label = $PromptLabel

func _physics_process(_delta: float) -> void:
	var player_inside := _player_inside()
	prompt_label.visible = player_inside

	if player_inside and Input.is_action_just_pressed("interact"):
		is_active = not is_active
		_update_visuals()
		activated.emit(is_active)

func _player_inside() -> bool:
	for body in get_overlapping_bodies():
		if body.is_in_group("player"):
			return true
	return false

func _update_visuals() -> void:
	inactive_visual.visible = not is_active
	active_visual.visible = is_active
