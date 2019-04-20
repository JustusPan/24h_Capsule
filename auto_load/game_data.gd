extends Node

var score = 0 setget set_score
var high_score = 0 setget set_high_score
signal score_changed(new_score)
signal high_score_changed(new_high_score)
# Called when the node enters the scene tree for the first time.

func set_score(new_score):
	score = new_score
	emit_signal("score_changed",score)
	
	#print("score = ", score, "; high_score = ", high_score) #debug_justus
	if score > high_score:
		self.high_score = score # trigger setter

func set_high_score(new_high_score):
	high_score = new_high_score
	emit_signal("high_score_changed", high_score)
	
func _ready():
	global_manager.load_game()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save():
	var save_dict = {"persist_token": "global","high_score" : self.high_score}
	return save_dict
	
func restore(dict):
	if dict.has("persist_token") and dict["persist_token"] == "global":
		self.high_score = dict["high_score"]
	pass
	
# Note: This can be called from anywhere inside the tree.  This function is path independent.
# Go through everything in the persist category and ask them to return a dict of relevant variables
func save_game():
	var save_game = File.new()
	save_game.open_encrypted_with_pass("user://24h_capsule.save", File.WRITE,"internal_code_20190102")
	save_game.store_line(to_json(self.save()))
#	var save_nodes = get_tree().get_nodes_in_group("Persist")
#	for i in save_nodes:
#		var node_data = i.save()
#		print("global::save_game::", to_json(node_data)) #debug_justus
#		save_game.store_line(to_json(node_data))
	save_game.close()
	
# Note: This can be called from anywhere inside the tree.  This function is path independent.
func load_game():
	if OS.is_userfs_persistent():
		var save_game = File.new()
		#var error_code = save_game.open("user://savegame.save", File.READ)
		if not save_game.file_exists("user://24h_capsule.save"):
		#if error_code != 0:
			return # Error!  We don't have a save to load.
	
		# We need to revert the game state so we're not cloning objects during loading.  This will vary wildly depending on the needs of a project, so take care with this step.
		# For our example, we will accomplish this by deleting savable objects.
	#	var save_nodes = get_tree().get_nodes_in_group("Persist")
	#	for i in save_nodes:
	#		i.queue_free()
	
		# Load the file line by line and process that dictionary to restore the object it represents
		save_game.open_encrypted_with_pass("user://24h_capsule.save", File.READ,"internal_code_20190102")
		while not save_game.eof_reached():
			var current_line = parse_json(save_game.get_line())
			print("global::load_game::typeof", typeof(current_line)) #debug_justus
			print("global::load_game::", current_line) #debug_justus
			if current_line == null:
				continue 
			if "global" == current_line["persist_token"]:
				get_node("/root/global_manager").restore(current_line)
			
		save_game.close()

func erase_save_data():
	var dir = Directory.new()
	dir.remove("user://24h_capsule.save")
	
	# hardcode for easing remaining data
	self.high_score = 0