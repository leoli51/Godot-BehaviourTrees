extends Node
class_name Task

enum TaskStatus {
	FINISHED,
	RUNNING, 
	FAILED
}

var blackboard : Dictionary

func task_enter(blackboard):
	self.blackboard = blackboard
	
func task_process(delta):
	pass
	
func task_exit():
	pass
