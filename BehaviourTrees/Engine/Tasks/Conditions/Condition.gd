extends Task
class_name Condition

export(bool) var use_bool_from_blackboard_as_condition = false
export(String) var bool_tag 

export(NodePath) var condition_task_path
export(NodePath) var task_path

var condition : Task
var result_task : Task
var condition_processed : bool

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	condition_processed = false
	result_task = get_node(task_path)
	if not use_bool_from_blackboard_as_condition:
		condition = get_node(condition_task_path)
		condition.task_enter(blackboard)
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	#Condition has already been processed
	if condition_processed:
		var status = result_task.task_process(delta)
		if status != TaskStatus.RUNNING:
			result_task.task_exit()
		return status
		
	#Condition still must be processed
	else:
		if use_bool_from_blackboard_as_condition:
			if blackboard[bool_tag]:
				result_task.task_enter(blackboard)
			else :
				return TaskStatus.FAILED
			condition_processed = true
			
		else :
			var status = condition.task_process(delta)
			if status == TaskStatus.FINISHED:
				condition.task_exit()
				condition_processed = true
				result_task.task_enter(blackboard)
			else :
				return status
	
	return TaskStatus.RUNNING
	
	
#Called when the task is exited
func task_exit():
	.task_exit()
