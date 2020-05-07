extends Task
class_name Selector

var children_indexes = Array()
var current_index = 0

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	current_index = 0
	children_indexes = range(get_child_count())
	get_child(children_indexes[current_index]).task_enter(blackboard)
	
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	var curr_child = get_child(children_indexes[current_index])
	var status = curr_child.task_process(delta)
	if status == TaskStatus.FINISHED:
		curr_child.task_exit()
		return status
	elif status == TaskStatus.FAILED:
		curr_child.task_exit()
		current_index += 1
		if current_index >= children_indexes.size():
			return status
		get_child(children_indexes[current_index]).task_enter(blackboard)
	
	return TaskStatus.RUNNING
	
#Called when the task is exited
func task_exit():
	.task_exit()
