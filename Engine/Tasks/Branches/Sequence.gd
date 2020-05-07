extends Task
class_name Sequence

var children_indexes : Array = Array()
var current_index = 0

func task_enter(blackboard):
	.task_enter(blackboard)
	children_indexes = range(get_child_count())
	current_index = 0
	get_child(children_indexes[current_index]).task_enter(blackboard)
	
func task_process(delta):
	var curr_child = get_child(children_indexes[current_index])
	var status = curr_child.task_process(delta)
	if status == TaskStatus.FAILED:
		return TaskStatus.FAILED
	elif status == TaskStatus.FINISHED:
		curr_child.task_exit()
		current_index += 1
		if current_index >= children_indexes.size():
			return TaskStatus.FINISHED
		get_child(children_indexes[current_index]).task_enter(blackboard)
	return TaskStatus.RUNNING
	
func task_exit():
	.task_exit()

