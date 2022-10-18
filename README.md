# roblox-simple-obj
Convert individual ROBLOX Faces to .obj waveform File

## what does this do
With this, you can build a map in ROBLOX using decals, and this script will only export the faces with decals on them.

## ok how do i use it
#### you need:
- python 3.9.2
- ROBLOX (if you don't have it why are you here)
- Download the python and lua script.

#### exporting
- Put the lua script in your game.
- Build a map out of parts with decals on surfaces you want to export.
- Run the script.
- If it ran correctly, there should be a StringValue called result in the workspace. Copy its contents into a .json file.
- Run the python script with the .JSON file as first and only argument.
```py "encoded map decoder.py" "encodedmap.json"```
- If it also ran correctly, it will print 
```Wrote output.obj```
- Enjoy a .obj with incorrect normals.

#### whatev
you can also download and open the included .rbxl to see a working example
i only tested this on windows 
