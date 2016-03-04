# Skyrim Save Reader

The objective of this project is to create a system that can read a game savefile for the game "The Elder Scrolls V: Skyrim" and output the data as a JSON string. The system should also be able to acept a properly formated JSON string and save as a valid savefile.

Some of my builds in Skyrim make use of Alchemy and I would like to be able to extract a listing of alchemical ingredients from a characters inventory using the savefile.

This aplication is to function as a utility that can be called by other systems.


The structure of a savefile is found here http://www.uesp.net/wiki/Tes5Mod:Save_File_Format

Format conventions can be found here http://www.uesp.net/wiki/Tes5Mod:File_Format_Conventions

** TODO **

* clean-up existing code
* add more documentation to existing code
* figure out how to effectively test the code
* export all data as JSON string (to be done after parsing of all data)


Sections that still need to be parsed

* Change Formsy
* unknown 3 Table
* parse RefId data


Global Data


1. Combat
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Combat

~~2. Interface~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Interface

~~3. Actor Causes~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Actor_Causes

~~4. Unknown 104~~
      http://www.uesp.net/w/index.php?title=Tes5Mod:Save_File_Format/Unknown_104&action=edit&redlink=1

~~5. Detection Manager~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Detection_Manager

~~6. Location MetaData~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Location_MetaData

~~7. Quest Static Data~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Quest_Static_Data

~~8. StoryTeller~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/StoryTeller

~~9. Magic Favorites~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Magic_Favorites

~~10. Player Controls~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/PlayerControls

~~11. Story Event Manager~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Story_Event_Manager

~~12. Ingredient Shared~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Ingredient_Shared

13. Menu Controls
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/MenuControls

14. Menu Topic Manager
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/MenuTopicManager

15. Temp Effects
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Temp_Effects

16. Papyrus
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Papyrus

17. Anim Objects
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Anim_Objects

18. Timer
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Timer

19. Synchronized Animations
      http://www.uesp.net/w/index.php?title=Tes5Mod:Save_File_Format/Synchronized_Animations&action=edit&redlink=1

20. Main
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Main

~~21. TES~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/TES

~~22. Effects~~
      http://www.uesp.net/wiki/Tes5Mod:Save_File_Format/Effects
