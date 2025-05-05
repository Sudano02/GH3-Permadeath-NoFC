# GH3-Permadeath-NoFC
GH3 Permadeath mod made by AddyMills and FregRB, but it does not requires to Full Combo to complete.
There are two versions of this mod, one that restores and uses the vanilla Health Regen when hitting notes, and the other that cuts the health regen by somewhat half of it if you want a little more of a challenge or want to warm up for the FC version.

## What is Permadeath?
Inspired by a mod for Guitar Hero II by jnack, permadeath forces you to Full Combo (FC) every song in a row. If you miss one note, your progress will be deleted and you have to start over. 

Please note that this patch does _not_ touch your save file. It will not overwrite or delete your save progress. However, as with any kind of mod, caution is urged and you should back up your save regardless.

## Installation Instructions

### Xbox 360
Simply place the patch in your DLC folder (`/Hdd1/Content/0000000000000000/415607F7/00000002`). Any DLC or customs currently installed will be ignored by the patch. To play them again, simply delete or move the Permadeath patch.

### PS3/RPCS3
Grab your region's PKG file (NTSC or PAL) and install the permadeath patch. Any DLC or customs currently installed will be ignored by the patch. To play them again, simply delete or move the Permadeath patch.

### PC
For PC, you need to install the GH3ML mod by Vultu ([link](https://github.com/nsneverhax/gh3ml)). You can install gh3ml by simply placing all files from the GitHub release into your Guitar Hero III PC folder (the same folder where your exe file is). Once that’s installed, grab the Permadeath PC file zip folder and place the contents into the same folder.
This will place the mod into your mods folder and installs the Permadeath mod


## Compilation Instructions

If you want to edit the permadeath scripts and make your own version. Do the following steps:
- Compile each `dl2000000001` folder with Honeycomb using the `pak compile -g gh3` command and your console
- Copy the pak files into the STFS or PKG folders, depending on your console of choice
- Using the Onyx CLI, perform either the STFS or PKG command
-   For 360, the command is `onyx stfs {STFS folder} --to {save_path}`
-   For PS3, the command is `onyx pkg {PKG Folder} {Content-ID} {PKG Folder} --to {save_path}.pkg`
