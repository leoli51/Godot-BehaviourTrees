extends Wrapper
class_name Invert

func task_process(delta):
	var status = .task_process(delta)
	if status == TaskStatus.FINISHED:
		return TaskStatus.FAILED
	elif status == TaskStatus.FAILED:
		return TaskStatus.FINISHED
	else :
		return TaskStatus.RUNNING

