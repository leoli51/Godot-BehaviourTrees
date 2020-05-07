extends Task
class_name DynamicCondition

export(bool) var use_bool_from_blackboard_as_condition = false
export(String) var bool_tag 

export(NodePath) var condition_task_path
export(NodePath) var task_path

var condition : Task
var result_task : Task
var task_entered : bool

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	result_task = get_node(task_path)
	task_entered = false
	if not use_bool_from_blackboard_as_condition:
		condition = get_node(condition_task_path)
		condition.task_enter(blackboard)
	
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	var condition_status = check_condition(delta)
	var task_status 
	if condition_status == TaskStatus.RUNNING:
		return TaskStatus.RUNNING
	elif condition_status == TaskStatus.FINISHED:
		if not task_entered:
			task_entered = true
			result_task.task_enter(blackboard)
			return TaskStatus.RUNNING
		else :
			task_status = result_task.task_process(delta)
			if task_status != TaskStatus.RUNNING:
				result_task.task_exit()
			return task_status
	else :
		if task_entered:
			result_task.task_exit()
		return TaskStatus.FAILED
	 
	

func check_condition(delta):
	if use_bool_from_blackboard_as_condition:
		return TaskStatus.FINISHED if blackboard[bool_tag] else TaskStatus.FAILED
	else :
		var status = condition.task_process(delta)
		if status != TaskStatus.FINISHED:
			return status
		else :
			condition.task_exit()
			condition.task_enter(blackboard)
			return status
		
	
#Called when the task is exited
func task_exit():
	.task_exit()
