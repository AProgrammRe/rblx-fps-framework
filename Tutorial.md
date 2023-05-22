# Tutorial
# Setup

First, make a server script.

```lua 
local moduleScript = require(game.ReplicatedStorage:WaitForChild("FPSFramework"):WaitForChild("ModuleScript"))

moduleScript.InitServer()
```
This part is important if you want the server to see actions made by players (shooting, damaging others, etc)

This script will setup a module script required from client to run remoteEvents to do things like equiping the gun for everyone else to see, damaging player, etc, etc.

# View Model setup

ViewModel setup time! Something like this:
![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/a6df41d4-3e7d-4361-928d-5958c3364d06)

A viewmodel is for the local player to see what they are holding and their arms for them to see, etc. A viewmodel won't be visible to the server. It is for the local player's perspective.

Make sure you make a camera part to where the camera viewing the arms will be for holding to gun. Name it CameraBone -- I realise this part is not that important. I was about to implement this but screw it. The part replacing it is the HRT.

Add the arms.

Add a AnimationController.

Add a HumanoidRootPart (just a part) and position it the same as the camera (Or atleast facing to the perspective of where you want the camera to look at)

Add 3 Motor6D to the HRT (HRT refer to HumanoidRootPart)

Name 1 as LeftArm and set the Part0 to the HRT itself and Part1 to the LeftArm of the viewModel same goes with the right one.

The last one as Handle and only set the Part0 to the HRT itself.

If you did it right, you should have this or atleast something similar (Ignore the selected objects): ![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/d5aa6268-dd68-4e68-a838-1a6bf90c6318)


# Gun Setup

Now, lets make the Guns!

You'd probably have something like this: 
![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/3500289e-d5f5-48ff-9f25-459024591987)

That's nice. Now, add a new part named bodyattach. Set it transparent and position it where the trigger is (Normally where I position it, you can do it near the gun)

Gotta install one plugin tho: https://create.roblox.com/marketplace/asset/804263305/Constraint-Editor

Do that, i'll wait.

Plugin: ![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/cc6d65bb-76db-4858-9254-c87fb76da2cb)

Now once installed, click on the bodyattach FIRST. Hold control and add a part you want to animate. Once done, go to the plugin and select it. There should be a button "new Motor6D".
Do this for each part to be animated.

For the rest EXCEPT the parts to be animated, select the bodyattach FIRST, then the rest that won't be animated and click the "new Weld" on the plugin.

Result should be similar as this: ![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/67c4715b-db4d-499a-93a0-d9fd2abe1caf)

Now we gotta animate it for two things: The viewModel and the player's character itself!
So to do that, we gotta weld the tool to both of these.

For the viewModel, it is fairly simple. Put the gun model inside the viewModel and select the HRT's Motor6D for the handle we made before and set Part1 to the bodyattach.

Same goes with the player's character but if you are using r6, use torso instead.

Open the animation plugin built in for Roblox Studio. You can also use Moon Animator, it'll do too.

Make animations for hold, shoot, walk, etc.

Publish it.

After the publish, make a folder in the model for the animation. Set the animationId.

Naming the animation: 
Name the one for viewmodel as: Hold, Shoot, Walk

For player's character (server side), the same as before but add "Server" next to it with no space. (ex: HoldServer)

Example: ![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/53662ca4-e6fe-4ec4-a0f3-69bc79c1e8c8)

# Finishing setup

Then set it all up with a localscript in StarterPlayerScripts

Here is a client setup and ready for use:


```lua
local gunModel = game.ReplicatedStorage:WaitForChild("GunModels") -- gunModels stored.
local viewModel = game.ReplicatedStorage:WaitForChild("Viewmodel") -- ViewModel
local module = require(game.ReplicatedStorage:WaitForChild("FPSFramework"):WaitForChild("ModuleScript")) -- Module Script

viewModel.Parent = game.Workspace.Camera -- Set the parent of our viewmodel to the workspace camera

repeat wait() until game.Players.LocalPlayer.Character -- Wait til player's character is loaded

module.setViewmodel(viewModel) -- Set the viewmodel
module.SetPlayerCharacter(game.Players.LocalPlayer.Character) -- Set the character
module.SetAnimationsFolder(game.ReplicatedStorage:WaitForChild("Animations")) -- Now for this, you can set this up anytime another item is equip. Set this as the animation folder you made before.

game:GetService("RunService").RenderStepped:Connect(function()
	module.update() -- Set it so that the viewmodel is always visible to the camera each frame.
end)
```
# Basic functions:

This will equip a gun you made earlier to the viewmodel and character
```lua 
module.equip(Model gunModel, intValue debounce) 
```


This will return any targets where ever you shoot. This is useful for the ``module.Shoot()`` function
```lua
module.FindTargetByRay(intValue distance)
```


This will damage the target if it is a valid player's character.
You can set the target as ``module.FindTargetByRay(intValue distance)``. Since this will return any targets found.
```lua
module.Shoot(Part target, intValue damage, boolean custom?, intValue headshot_damage, intValue torso_damage, intValue arms_damage, intValue legs_damage)
```

This will reset the viewmodel. (Use it only if the player dies.)
```lua
module.reset()
```



# Finish
