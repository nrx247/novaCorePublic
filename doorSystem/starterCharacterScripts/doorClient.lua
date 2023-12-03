local proximityPromptService = game:GetService("ProximityPromptService")
local tweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local char = plr.Character

proximityPromptService.PromptShown:Connect(function(px)
	if px.ActionText == "_DOOR_PROMPT" then
		local readerModels = px.Parent.Parent:WaitForChild("_READERS")
		
		tweenService:Create(px.Parent, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(1.55, 1.55, 1.24)}):Play()
		
		px.Parent:FindFirstChildWhichIsA("Beam").Attachment1 = char:FindFirstChild("UpperTorso"):WaitForChild("BodyFrontAttachment")
	end
end)

proximityPromptService.PromptHidden:Connect(function(px)
	if px.ActionText == "_DOOR_PROMPT" then
		
		tweenService:Create(px.Parent, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(0, 0, 0)}):Play()
		
		px.Parent:FindFirstChildWhichIsA("Beam").Attachment1 = nil
	end
end)

proximityPromptService.PromptButtonHoldBegan:Connect(function(px)
	if px.ActionText == "_DOOR_PROMPT" then
		
		for i, v in ipairs(px.Parent:GetChildren()) do
			if v:IsA("SurfaceGui") then
				local pgBar = v:WaitForChild("_PRIMARY"):FindFirstChildWhichIsA("Frame")
				local t = tweenService:Create(pgBar, TweenInfo.new(px.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,1,0)}) ; t:Play()

				proximityPromptService.PromptButtonHoldEnded:Connect(function(px)
					t:Cancel()
					tweenService:Create(pgBar, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,0)}):Play()
				end)
			end
		end
		
	end
end)
