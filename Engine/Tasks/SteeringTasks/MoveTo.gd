extends SteeringTask
class_name MoveTo

export(String) var target_tag = "moveTo target"
export(String) var arrival_tolerance_tag = "arrival tolerance tag"
export(String) var deceleration_radius_tag = "deceleration radius tag"

var arrive_behaviour : GSAIArrive
var target : GSAIAgentLocation

#Called when the task is entered
func task_enter(blackboard):
	.task_enter(blackboard)
	target = GSAIAgentLocation.new()
	target.position = blackboard[target_tag]
	
	arrive_behaviour = GSAIArrive.new(agent, target)	
	if blackboard.has(arrival_tolerance_tag):
		arrive_behaviour.arrival_tolerance = blackboard[arrival_tolerance_tag]
	if blackboard.has(deceleration_radius_tag):
		arrive_behaviour.deceleration_radius = blackboard[deceleration_radius_tag]
		
	
#Called on each process / physicsprocess when the task is active
#must return one of TaskStatus.FINISHED, TaskStatus.RUNNING, TaskStatus.FAILED
func task_process(delta):
	.task_process(delta)
	arrive_behaviour._calculate_steering(acceleration)
	agent._apply_steering(acceleration, delta)
	if acceleration.linear.is_equal_approx(Vector3.ZERO):
		return TaskStatus.FINISHED
	else :
		return TaskStatus.RUNNING
