tool extends Task
class_name CustomTask

export(GDScript) var task setget set_task

func set_task(new_task):
	if new_task != null:
		set_script(new_task)

