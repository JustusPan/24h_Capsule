extends Node

var loader = null
var wait_frames
var current_scene
var default_loader_progress_scene = preload("res://ui_design/loader_progress/LoaderProgress.tscn")
#var thread = Thread.new()

const TIME_MAX = 100 # msec

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	

func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	if wait_frames > 0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + TIME_MAX: # use "TIME_MAX" to control how much time we block this thread

		# poll your loader
		var err = loader.poll()

		if err == ERR_FILE_EOF: # load finished
			update_progress_finish()
			var resource = loader.get_resource()
			loader = null
			current_scene.queue_free()
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # error during loading
			#show_error()
			loader = null
			break


func update_progress_finish():
	if current_scene.has_method("set_progress"):
		current_scene.set_progress(1)


func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	# update your progress bar?
	
	#get_node("progress").set_progress(progress)
	print("progress = ", progress)
	current_scene.set_progress(progress)
	#OS.delay_msec(1000) #debug_justus

#    # or update a progress animation?
#    var anim_len = get_node("animation").get_current_animation_length()
#
#    # call this on a paused animation. use "true" as the second parameter to force the animation to update
#    get_node("animation").seek(progress * anim_len, true)

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)


##############################################################################################
# Changing scenes is most easily done using the functions `change_scene`
# and `change_scene_to` of the SceneTree. This script demonstrates how to
# change scenes without those helpers.


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function from the running scene.
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.

	# The way around this is deferring the load to a later time, when
	# it is ensured that no code from the current scene is running:
		
	#call_deferred("_deferred_goto_scene",path)
	call_deferred("_deferred_goto_scene_with_progress",path)

func _deferred_goto_scene_with_progress(path): # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		#show_error()
		return
	set_process(true)

	current_scene.free() # get rid of the old scene
	# enter progross scene
	set_new_scene(default_loader_progress_scene)
	#thread.start(self,"prep_scene", ResourceLoader.load_interactive(path))

	# start your "loading..." animation
	#get_node("animation").play("loading")
	print("start loading")

	wait_frames = 1
	
#func prep_scene(interactive_ldr):
#	while (true):
#		var err = interactive_ldr.poll();
#		if(err == ERR_FILE_EOF):
#			call_deferred("_on_load_level_done");
#			return interactive_ldr.get_resource();
#
#func _on_load_level_done():
#	var level_res = thread.wait_to_finish()
#	var scene = level_res.instance()
#	#add_child(scene);
#	get_node("/root").add_child(scene)

func _deferred_goto_scene(path):
	# Immediately free the current scene, there is no risk here.
	get_tree().get_current_scene().free()

	# Load new scene
	var packed_scene = ResourceLoader.load(path)

	# Instance the new scene
	var instanced_scene = packed_scene.instance()

	# Add it to the scene tree, as direct child of root
	get_tree().get_root().add_child(instanced_scene)

	# Set it as the current scene, only after it has been added to the tree
	get_tree().set_current_scene(instanced_scene)
