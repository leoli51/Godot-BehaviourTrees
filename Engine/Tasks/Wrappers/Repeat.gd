extends Wrapper
class_name Repeat

export(int) var times = 1
var repeated_times = 0

func task_enter(blackboard):
	.task_enter(blackboard)	
	repeated_times = 0
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	var status = .task_process(delta)
	if status != TaskStatus.RUNNING:
		repeated_times += 1
		if repeated_times >= times:
			return TaskStatus.FINISHED
		else :
			task.task_exit()
			task.task_enter(blackboard)
	else :
		return TaskStatus.RUNNING
	
