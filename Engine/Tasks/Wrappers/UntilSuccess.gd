extends Wrapper
class_name UntilSuccess

func task_process(delta):
	var status = .task_process(delta)
	if status == TaskStatus.RUNNING:
		return TaskStatus.RUNNING
	elif status == TaskStatus.FAILED:
		task.task_exit()
		task.task_enter(blackboard)
	else :
		return TaskStatus.FINISHED
