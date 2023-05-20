# rblx-fps-framework
I created this framework and decide to open source. It is fairly simple. This is my first time making one so, yeah.

I will update this til it is finished for me.
I made it for fun lol.

# Setup

First, make a server script.

```lua 
local moduleScript = require(game.ReplicatedStorage:WaitForChild("FPSFramework"):WaitForChild("ModuleScript"))

moduleScript.InitServer()
```
ViewModel setup time! Something like this:
![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/a6df41d4-3e7d-4361-928d-5958c3364d06)

Make sure you make a camera part to where the camera viewing the arms will be for holding to gun. Name it CameraBone -- I realise this part is not that important. I was about to implement this but screw it. The part replacing it is the HRT.

Add the arms.

Add a AnimationController.

Add a HumanoidRootPart (just a part) and position it the same as the camera (Or atleast facing to the perspective of where you want the camera to look at)

Add 3 Motor6D to the HRT (HRT refer to HumanoidRootPart)

Name 1 as LeftArm and set the Part0 to the HRT itself and Part1 to the LeftArm of the viewModel same goes with the right one.

The last one as Handle and only set the Part0 to the HRT itself.

-- Guns setup
Now, lets make the Guns!

You'd probably have something like this: 
![image](https://github.com/AProgrammRe/rblx-fps-framework/assets/121419504/3500289e-d5f5-48ff-9f25-459024591987)

That's nice. Now, add a new part named bodyattach. Set it transparent and position it where the trigger is (Normally where I position it, you can do it near the gun)

Gotta install one plugin tho: https://create.roblox.com/marketplace/asset/804263305/Constraint-Editor

Do that, i'll wait.

Now once installed, click on the bodyattach FIRST. Hold control and add a part you want to animate. Once done, go to the plugin and select it. There should be a button "new Motor6D".
Do this for each part to be animated.

For the rest EXCEPT the parts to be animated, select the bodyattach FIRST, then the rest that won't be animated and click the "new Weld" on the plugin.

Now we gotta animate it for two things: The viewModel and the player's character itself!
So to do that, we gotta weld the tool to both of these.

For the viewModel, it is fairly simple. Put the gun model inside the viewModel and select the HRT's Motor6D for handle and set Part1 to the bodyattach.

Same goes with the player's character but if you are using r6, use torso instead.

Open the animation plugin built in for Roblox Studio. You can also use Moon Animator, it'll do too.

Make animations for hold, shoot, walk, etc.

Publish it.


Then set it all up with a localscript in StarterPlayerScripts



```lua
local gunModel = game.ReplicatedStorage:WaitForChild("GunModels") -- gunModels stored.
local viewModel = game.ReplicatedStorage:WaitForChild("Viewmodel") 
local module = require(game.ReplicatedStorage:WaitForChild("FPSFramework"):WaitForChild("ModuleScript"))
viewModel.Parent = game.Workspace.Camera

repeat wait() until game.Players.LocalPlayer.Character

module.setViewmodel(viewModel)
module.SetPlayerCharacter(game.Players.LocalPlayer.Character)
module.SetAnimationsFolder(game.ReplicatedStorage:WaitForChild("Animations"))

game:GetService("RunService").RenderStepped:Connect(function()
	module.update()
end)
```

