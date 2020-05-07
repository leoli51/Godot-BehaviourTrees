extends Task


#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	return TaskStatus.FINISHED
	
#Called when the task is exited
func task_exit():
	.task_exit()
