extends Timer

export(float, 0, 600) var min_interval = 10
export(float, 0, 600) var max_interval = 30

func _ready():
	init_rand()
	connect("timeout",self,"init_rand")
	pass

func start(time_sec = -1):
	init_rand()
	.start()
	
func init_rand():
	wait_time = rand_range(min_interval,max_interval)
