tool
extends EditorPlugin

func _enter_tree():
	var node_icon = get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")
	add_custom_type("TaskExecutor", "Node", preload("res://addons/EasyTasks/Engine/TaskExecutor.gd"), node_icon)
	ProjectSettings["editor/script_templates_search_path"] = "res://addons/EasyTasks/Engine/TaskTemplate/"
	
func _exit_tree():
	remove_custom_type("TaskExecutor")
