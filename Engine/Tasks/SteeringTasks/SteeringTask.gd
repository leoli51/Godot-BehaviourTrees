extends Task
class_name SteeringTask

export(String) var agent_tag = "agent"
export(String) var acceleration_tag = "acceleration"

var agent : GSAISpecializedAgent
var acceleration : GSAITargetAcceleration

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)	
	agent = blackboard[agent_tag]
	acceleration = blackboard[acceleration_tag]
