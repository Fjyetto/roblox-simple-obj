-- written by papatomique feel free to uhh

local hs = game:GetService("HttpService")
local sc = require(script.Parent.StringCompression)

-- Tables to convert faceIDs to Vertices

local FtVS = {[Enum.NormalId.Top]={Vector3.new(1,1,1),Vector3.new(-1,1,1),Vector3.new(1,1,-1),Vector3.new(-1,1,-1)},
[Enum.NormalId.Bottom]={Vector3.new(1,-1,1),Vector3.new(-1,-1,1),Vector3.new(1,-1,-1),Vector3.new(-1,-1,-1)},
[Enum.NormalId.Right]={Vector3.new(1,1,1),Vector3.new(1,-1,1),Vector3.new(1,1,-1),Vector3.new(1,-1,-1)},
[Enum.NormalId.Left]={Vector3.new(-1,1,1),Vector3.new(-1,-1,1),Vector3.new(-1,1,-1),Vector3.new(-1,-1,-1)},
[Enum.NormalId.Front]={Vector3.new(1,1,1),Vector3.new(1,-1,1),Vector3.new(-1,1,1),Vector3.new(-1,-1,1)},
[Enum.NormalId.Back]={Vector3.new(1,1,-1),Vector3.new(1,-1,-1),Vector3.new(-1,1,-1),Vector3.new(-1,-1,-1)}}

-- convert faceIDs to CFrame directions and multipliers

local FtCFDV = {[Enum.NormalId.Top]="UpVector",[Enum.NormalId.Bottom]="UpVector",[Enum.NormalId.Right]="RightVector",[Enum.NormalId.Left]="RightVector",[Enum.NormalId.Front]="LookVector",[Enum.NormalId.Back]="LookVector"}
local FtCFDVS = {[Enum.NormalId.Top]=1,[Enum.NormalId.Bottom]=-1,[Enum.NormalId.Right]=1,[Enum.NormalId.Left]=-1,[Enum.NormalId.Front]=1,[Enum.NormalId.Back]=-1}

local faces = {}
local lights = {}
local normals = {}

for i,v in pairs(workspace.Parts:GetDescendants()) do
	if v.ClassName=="Part" and v.Name~="light" then
		for ii,d in pairs(v:GetChildren()) do
			if d.ClassName=="Decal" then --Only make a face if there is a decal
				local face = {}
				
				for iii,vecs in pairs(FtVS[d.Face]) do  
					face[#face+1]=(v.CFrame*CFrame.new(Vector3.new(v.Size.X/2,v.Size.Y/2,v.Size.Z/2)*vecs)).Position
					normals[#normals+1]=v.CFrame[FtCFDV[d.Face]]*FtCFDVS[d.Face]
					
				end
				faces[#faces+1]=face
			end
		end
	end
	if v.Name=="light" then
		lights[#lights+1]=v.Position
	end
end

--[[for t,n in pairs(faces) do
	for i,vertex in n do
		local b = Instance.new("Part")
		b.Shape = 0
		b.Size = Vector3.new(.2,.2,.2)
		b.Position = vertex
		b.Anchored = true
		b.Parent = workspace
	end
end]]

function v3tnt(v3: Vector3) --Vector3 to XYZ Dictionnary for JSON encoding
	return {["X"]=v3.X,["Y"]=v3.Y,["Z"]=v3.Z}
end

local efaces,elights,enorms = {},{},{}

-- convert all of it into json

for t,n in pairs(faces) do
	efaces[t]={}
	for i,vertex in n do
		efaces[t][i]=v3tnt(vertex)
	end
end
for i,light in lights do
	elights[i]=v3tnt(light)
end
for i,v in normals do
	enorms[i]=v3tnt(v)
end

local data = {["Faces"]=efaces,["Lights"]=elights,["Normals"]=enorms}
local sv = Instance.new("StringValue")
sv.Name = "Result"
sv.Parent = workspace
sv.Value = hs:JSONEncode(data)

-- the j