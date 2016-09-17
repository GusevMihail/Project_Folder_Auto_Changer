-- This script must automaticaly change Project Folder to actualy for current scene. 
-- For ex. you open scene_01.max in C:\3d_projects\project_12\scenes
-- Script change Project folder to "C:\3d_projects\project_12"
-- If your scenes stored in its own project folders, it's must work good.

--Changelog
-- v0.1. Script see a path of opened scene, generate Project Folder path and verify it. 
--If path is valid, script change Project Folder. Otherwise, it print a error message.

-- Get current scene path
current_scene_path = maxFilePath 
-- Trim this path, that del \scenes subfolder
pos1  = findstring current_scene_path "scenes\\"
project_folder_path = substring current_scene_path 1 (pos1-2)
-- Check, that Project Folder path is valid
if pathConfig.isProjectFolder project_folder_path then
(
	-- If OK, change Project Folder and print success message
	pathConfig.setCurrentProjectFolder project_folder_path
	print "project folder is set to: " + project_folder_path
)
else
	print "Error: invalid project folder path"

