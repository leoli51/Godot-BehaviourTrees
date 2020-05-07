extends Task
class_name Parallel

export(int, "Sequence Policy", "Selector Policy") var status_policy = 0

var children_running = Array()

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	children_running.clear()
	for i in range(get_child_count()):
		children_running.append(true)
		get_child(i).task_enter(blackboard)
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	for index in get_child_count():
		if children_running[index]:
			var child = get_child(index)
			var status = child.task_process(delta)
			if status == TaskStatus.FAILED:
				if status_policy == 0: #sequence policy
					exit_all()
					return TaskStatus.FAILED
				else : #selector policy
					children_running[index] = false
					child.task_exit()
			elif status == TaskStatus.FINISHED:
				if status_policy == 0:#sequence policy
					children_running[index] = false
					child.task_exit()
				else : #Selector policy
					exit_all()
					return TaskStatus.FINISHED
					
					
	
	if children_running.has(true):
		return TaskStatus.RUNNING
	else :
		return TaskStatus.FINISHED
		
func exit_all():
	for index in get_child_count():
		get_child(index).task_exit()
		children_running[index] = false
	
#Called when the task is exited
func task_exit():
	.task_exit()
	children_running.clear()
