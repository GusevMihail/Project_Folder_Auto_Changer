-- This script must automaticaly change Project Folder to actualy for current scene. 
-- For ex. you open scene_01.max in C:\3d_projects\project_12\scenes
-- Script change Project folder to "C:\3d_projects\project_12"
-- If your scenes stored in its own project folders, it's must work good.

--Changelog
--v0.1. Script see a path of opened scene, generate Project Folder path and verify it. 
--	If path is valid, script change Project Folder. Otherwise, it print an error message.
--v0.2. Logic move into "change_project_folder" function. 
--	Added callback, that call change_project_folder function when user open any scene.
-- v0.3. Added scene path verification.
--	Now project folder path will be generated only if scene locate on \scenes folder. Otherwise, print an error message and quit.

-- Definition main function
function change_project_folder =
(
	-- Get current scene path
	current_scene_path = maxFilePath 

	pos1  = findstring current_scene_path "\\scenes\\"

	-- Check that scene locate in \scenes folder. If not, print error message and quit
	if (pos1 == undefined) or (current_scene_path.count - pos1 + 1 != "\\scenes\\".count) then
	(
		print "Error: current scene not in \"scene\" folder. Project folder not changed."
		break
	)
	else -- scene file realy in \scenes folder
	(
		-- Trim scene path, that del "\scenes\" subfolder
		project_folder_path = substring current_scene_path 1 (pos1-1)
		
		-- Check, that Project Folder path is valid
		if pathConfig.isProjectFolder project_folder_path then
		(
			-- If OK, change Project Folder and print success message
			pathConfig.setCurrentProjectFolder project_folder_path
			print ("project folder is set to: " + project_folder_path)
		)
		else
			print "Error: invalid project folder path"
	)
)

--Register callback "after file was opened". This call function that change Project Folder
callbacks.addScript #filePostOpen  "change_project_folder()" 
