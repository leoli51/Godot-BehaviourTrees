extends Task
class_name Wait

export(float) var wait_time 

var elapsed_time : float

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	elapsed_time = 0
	
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	elapsed_time += delta
	if elapsed_time >= wait_time:
		return TaskStatus.FINISHED
	else :
		return TaskStatus.RUNNING
	
#Called when the task is exited
func task_exit():
	.task_exit()
