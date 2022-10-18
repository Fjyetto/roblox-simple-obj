import json
import sys

n = len(sys.argv)
if n!=2:
    raise ValueError("FOOL!!! TOO MANY/FEW ARGUMENTS")

try:
    encmap = open(sys.argv[1],"r").read()
except:
    raise RuntimeError("FOOL!!! FILE NOT FOUND")

map = json.loads(encmap)

Obj = "# henry rochet OBJ file \n# watch this!\n"

vcount = 0
facestr = ""

for f in map["Faces"]: #All quads
    for v in f: #Vertices
        vcount = vcount+1
        Obj = Obj + "v "+str(v["X"])+" "+str(v["Y"])+" "+str(v["Z"])+"\n"
    facestr = facestr+"f "+str(vcount-2)+"//"+str(vcount-2)+" "+str(vcount-3)+"//"+str(vcount-3)+" "+str(vcount-1)+"//"+str(vcount-1)+" "+str(vcount)+"//"+str(vcount)+"\n"
    
for v in map["Normals"]: 
    Obj = Obj + "vn "+str(v["X"])+" "+str(v["Y"])+" "+str(v["Z"])+"\n"
    
Obj = Obj+facestr

objoutput = open("output.obj","w")
objoutput.write(Obj)
objoutput.close()
print("Wrote output.obj")