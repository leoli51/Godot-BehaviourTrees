extends Wrapper
class_name UntilFail

func task_process(delta):
	var status = .task_process(delta)
	if status == TaskStatus.RUNNING:
		return TaskStatus.RUNNING
	elif status == TaskStatus.FINISHED:
		task.task_exit()
		task.task_enter(blackboard)
	else :
		return TaskStatus.FINISHED
