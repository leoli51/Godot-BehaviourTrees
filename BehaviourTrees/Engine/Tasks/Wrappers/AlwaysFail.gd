extends Wrapper
class_name AlwaysFail

func task_process(delta):
	var status = .task_process(delta)
	if status != TaskStatus.RUNNING:
		return TaskStatus.FAILED
	else :
		return TaskStatus.RUNNING
