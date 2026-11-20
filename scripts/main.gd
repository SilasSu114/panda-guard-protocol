extends Node2D

const ROTATION_STEP := PI / 2.0

@onready var level_root: Node2D = $LevelRoot
@onready var player: CharacterBody2D = $LevelRoot/Player
@onready var message_label: Label = $UI/MessageLabel

func _ready() -> void:
	$LevelRoot/Switch.activated.connect($LevelRoot/Exit.set_open)
	$LevelRoot/Switch.activated.connect(_on_switch_activated)
	$LevelRoot/Exit.completed.connect(_on_level_completed)
	$LevelRoot/Exit.blocked.connect(_on_exit_blocked)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate"):
		_rotate_level()
	elif event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

func _rotate_level() -> void:
	if not player.is_on_floor():
		return

	player.frozen = true
	level_root.rotation += ROTATION_STEP
	_counter_rotate_children()
	player.frozen = false

func _counter_rotate_children() -> void:
	for child in [$LevelRoot/Player, $LevelRoot/Box, $LevelRoot/Switch, $LevelRoot/Exit]:
		if child is Node2D:
			child.rotation = -level_root.rotation

func _on_level_completed() -> void:
	player.frozen = true
	message_label.text = "通关！"

func _on_switch_activated(_active: bool) -> void:
	message_label.text = "把箱子推到开关上"

func _on_exit_blocked() -> void:
	message_label.text = "出口还没开"
