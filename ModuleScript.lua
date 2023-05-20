local module = {}

-- Client Side settings!
local viewmodel
local equipped
local animations
local character


-- Settings configurations
function module.SetPlayerCharacter(char)
	character = char
end

function module.SetAnimationsFolder(fold)
	animations = fold
end

function module.setViewmodel(part)
	viewmodel = part
end

-- Basic functions
function module.update()
	viewmodel.HumanoidRootPart.CFrame = game.Workspace.Camera.CFrame
end

function module.equip(object)
	equipped = object:Clone()
	equipped.Parent = viewmodel
	module.Weldgun(equipped)
	module.Weldgun(object,true)
	-- run hold animation (viewmodel)
	local controller = viewmodel.AnimationController
	local animationLoaded = controller:LoadAnimation(animations.Hold)
	animationLoaded.Looped = true
	animationLoaded:Play()
	
	-- run hold animation (server view)
	local controllerHumanoid = character.Humanoid
	local animationLoadedForHumanoid = controllerHumanoid:LoadAnimation(animations.HoldServer)
	animationLoadedForHumanoid.Looped = true
	animationLoadedForHumanoid:Play()
	
end

function module.Weldgun(object, isServer)
	if isServer then
		script.HumanoidTool:FireServer(object)
		return
	end
	viewmodel.HumanoidRootPart.Handle.Part1 = object.bodyattach
end


-- Init server for module to access module sending client info to server. Informing the server events
function module.InitServer()
	local runservice = game:GetService("RunService")
	if runservice:IsServer() then
		-- Setting server
		script.HumanoidTool.OnServerEvent:Connect(function(plr,object)
			local tool = object.char:Clone()

			tool.Parent = plr.Character
			if plr.Character.Torso:FindFirstChild("Motor6D") then
				plr.Character.Torso.Motor6D:Destroy()
			end
			local Motor6D_handle = Instance.new("Motor6D")
			Motor6D_handle.Parent = plr.Character:WaitForChild("Torso")
			Motor6D_handle.Part0 = Motor6D_handle.Parent
			plr.Character.Torso.Motor6D.Part1 = tool.bodyattach
		end)
	else
		warn("Must be server sided to run this!")
	end
	
	
end

-- return module
return module
