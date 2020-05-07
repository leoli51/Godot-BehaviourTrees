extends Wrapper
class_name AlwaysSucceed


func task_process(delta):
	var status = .task_process(delta)
	if status != TaskStatus.RUNNING:
		return TaskStatus.FINISHED
	else :
		return TaskStatus.RUNNING
