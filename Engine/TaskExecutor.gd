extends Node

export var repeat_on_end = true
export var physics_update = false
export(Dictionary) var blackboard
export(PackedScene) var behaviour_tree_scene

var behaviour_tree : Task
var running = true

func _ready():
	behaviour_tree = behaviour_tree_scene.instance()
	call_deferred("_btree_enter")

func _btree_enter():
	behaviour_tree.task_enter(blackboard)
	
func _process(delta):
	if not physics_update:
		update_tree(delta)
	
func _physics_process(delta):
	if physics_update:
		update_tree(delta)

func update_tree(delta):
	var status
	if running:
		status = behaviour_tree.task_process(delta)
	if status != behaviour_tree.TaskStatus.RUNNING:
		behaviour_tree.task_exit()
		running = false
		if repeat_on_end:
			running = true
			behaviour_tree.task_enter(blackboard)
