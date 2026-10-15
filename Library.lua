    local ServiceCache = {};      
    getgenv().Services = setmetatable({}, {
        __index = function(Self, Index)
            if not ServiceCache[Index] then
                ServiceCache[Index] = cloneref(game:GetService(Index));
            end;

            return ServiceCache[Index];
        end
    });

    local Keys = {
        [Enum.KeyCode.LeftShift] = "Left Shift",
        [Enum.KeyCode.RightShift] = "Right Shift",
        [Enum.KeyCode.LeftControl] = "Left Ctrl",
        [Enum.KeyCode.RightControl] = "Right Ctrl",
        [Enum.KeyCode.Insert] = "Insert",
        [Enum.KeyCode.Backspace] = "Backspace",
        [Enum.KeyCode.Return] = "Return",
        [Enum.KeyCode.LeftAlt] = "Left Alt",
        [Enum.KeyCode.RightAlt] = "Right Alt",
        [Enum.KeyCode.CapsLock] = "Capslock",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MouseButton1",
        [Enum.UserInputType.MouseButton2] = "MouseButton2",
        [Enum.UserInputType.MouseButton3] = "MouseButton3",
        [Enum.KeyCode.Escape] = "Escape",
        [Enum.KeyCode.Space] = "Space",
    }

    local Camera = workspace.CurrentCamera
    local LocalPlayer = Services.Players.LocalPlayer
    local GuiInset = Services.GuiService:GetGuiInset().Y
    local Mouse = LocalPlayer:GetMouse()

    local NumSeq = NumberSequence.new
    local ColorSeq = ColorSequence.new

    local NumKey = NumberSequenceKeypoint.new
    local ColorKey = ColorSequenceKeypoint.new

    local function Color3ToRGB(color3)
        local r = math.round(color3.R * 255)
        local g = math.round(color3.G * 255)
        local b = math.round(color3.B * 255)
        return r, g, b
    end

if getgenv().Library and getgenv().Library.Unload then
    getgenv().Library:Unload()
end

local Library; do
    Library = {
        Directory = "Atlanta",
        Folders = {
            "/Fonts",
            "/Configs",
            "/Themes",
        },

        Flags = {},
        ConfigFlags = {},
        FlagCount = 0;
        Connections = {},
        Threads = {},
        Blurs = {},
        Elements = {},
        Notifications = {},

        OpenElement = {},
        Moderators = {},
        Keybinds = {},
        Guis = {},
        Glows = {}, 

        EasingDirection = Enum.EasingDirection.InOut,
        EasingStyle = Enum.EasingStyle.Quint,
        TweeningSpeed = .3,
        DraggingSpeed = .05,
        Tweening = false,
    };  

    Library.__index = Library;
    getgenv().Library = Library

    for _, path in Library.Folders do
        makefolder(Library.Directory .. path)
    end

    if not isfile(Library.Directory .. "/Autoload.txt") then
        writefile(Library.Directory .. "/Autoload.txt", "")
    end

    local Flags = Library.Flags
    local ConfigFlags = Library.ConfigFlags
    local Notifications = Library.Notifications
    local Elements = Library.Elements

    local Themes = {
       Preset = {
            ["High Contrast"] = Color3.fromRGB(38, 38, 38),
            ["Low Contrast"] = Color3.fromRGB(25, 25, 25),
            ["TabButtonUnselected"] = Color3.fromRGB(17, 17, 17),

            ["Outline"] = Color3.fromRGB(1, 1, 1),
            ["Inline"] = Color3.fromRGB(54, 54, 54),

            ["MenuBackground"] = Color3.fromRGB(29, 29, 29),
            ["PageBackground"] = Color3.fromRGB(24, 24, 24),
            ["SectionBackground"] = Color3.fromRGB(19, 19, 19),

            ["TextMisc"] = Color3.fromRGB(134, 134, 134),
            ["TextMain"] = Color3.fromRGB(160, 160, 160),

            ["Accent"] = Color3.fromRGB(245, 20, 136),
        },
        Utility = {},
        GradientsThemes = {}, 
    }; do
        for Theme, Color in Themes.Preset do
            Themes.Utility[Theme] = {
                BackgroundColor3 = {},
                TextColor3 = {},
                ImageColor3 = {},
                ScrollBarImageColor3 = {},
                Color = {},
                PlaceholderColor3 = {},
            }
        end

        Library.Themify = function(self, Theme, Property)
            table.insert(Themes.Utility[Theme][Property], self.Instance)

            return self 
        end

        Library.GradientCheck = function(self, Keypoint, NewColor, Theme)
            if Color3ToRGB(Keypoint.Value) == Color3ToRGB(Themes.Preset[Theme]) then 
                return {Time = Keypoint.Time, Value = NewColor}    
            end
        end

        Library.ConstructGradient = function(self, Constructor)
            local Returner = {} 

            for Index, Value in Constructor do
                Returner[Index] = ColorSequenceKeypoint.new(Value.Time, Value.Value)
            end

            return ColorSequence.new(Returner)
        end 

        Library.SameColor = function(self, Color, CheckedTheme)
            for Name,Theme in Themes.Preset do 
                if Name == CheckedTheme then 
                    continue 
                end 

                if Color3ToRGB(Color) == Color3ToRGB(Theme) then 
                    return true
                end 
            end

            return false
        end

        Library.Refresh = function(self, Theme, Color)
            if self:SameColor(Color, Theme) then 
                return 
            end 

            for Property, Data in Themes.Utility[Theme] do
                for _, Object in Data do
                    if (property == "Transparency") and not (Object:IsA("UIStroke")) then
                        continue
                    end

                    if Object:IsA("UIGradient") then
                        local Constructor = {}

                        for Index,Keypoint in Object.Color.Keypoints do 
                            local Return = self:GradientCheck(Keypoint, Color, Theme)

                            if Return then 
                                Constructor[Index] = Return
                            else 
                                Constructor[Index] = {Time = Keypoint.Time, Value = Keypoint.Value} 
                            end 
                        end

                        local NewColor = self:ConstructGradient(Constructor)
                        Object.Color = NewColor
                    else 
                        if (Object[Property] == Themes.Preset[Theme]) then
                            Object[Property] = Color
                        end
                    end 
                end
            end

            Themes.Preset[Theme] = Color
        end

        Library.ThemeListener = function(self, Theme, Statement, Property, Dumper)
            local Instance = self.Instance 

            Dumper = Dumper or "BackgroundColor3"
            Property = Property or "TextColor3"
            Theme = Theme or "Accent"

            Instance[Dumper] = Themes.Preset[Theme]   
            self:Themify(Theme, Dumper)

            Instance:GetPropertyChangedSignal(Dumper):Connect(function()
                if Statement() then 
                    Instance[Property] = Themes.Preset[Theme]
                end 
            end)

            return self
        end

        Library.GetTheme = function(self)
            local Config = {}

            for Idx, Value in Themes.Preset do
                if Idx == "Font" then
                    continue
                end

                Config[Idx] = { Transparency = 1, Color = Value:ToHex() }
            end

            for Idx, Value in { "Blur Intensity", "Misc Transparency", "Main Transparency" } do
                Config[Value] = Library.Flags[Value]
            end

            return Services.HttpService:JSONEncode(Config)
        end

        Library.SaveTheme = function(self, Config)
            if Config == "" then
                return
            end

            local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Themes", Config)
            writefile(Path, self:GetTheme())
        end

        Library.DeleteTheme = function(self, Config)
            local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Themes", Config)

            if isfile(Path) then
                delfile(Path)
            end
        end

        Library.UpdateThemingList = function(self)
            local List = {}

            for _, File in listfiles(Library.Directory .. "/Themes") do
                local Name = File:gsub(Library.Directory .. "/Themes\\", ""):gsub(".Cfg", ""):gsub(
                Library.Directory .. "\\Themes\\", "")
                List[#List + 1] = Name
            end

            self:RefreshDropdown(List)
        end
    end Library.Themes = Themes

    local Fonts = {}; do
        function Fonts:New(Name, Weight, Style, Data)
            if not isfile(Library.Directory .. "/Fonts/" .. Data.Id) then
                writefile(Library.Directory .. "/Fonts/" .. Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Library.Directory .. "/Fonts/" .. Data.Id)
                    }
                }
            }

            writefile(Library.Directory .. "/Fonts/" .. Name .. ".font", Services.HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(Library.Directory .. "/Fonts/" .. Name .. ".font"))
        end

        Fonts.Main = Fonts:New("ProggyClean", 400, "Regular", {
            Id = "ProggyClean",
            Url = "https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/ProggyClean.ttf"  
        })
    end

    local EasingStyles = {
        [Enum.EasingStyle.Linear] = {
            [Enum.EasingDirection.In] = function(Delta)
                return Delta
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return Delta
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                return Delta
            end
        },
        [Enum.EasingStyle.Cubic] = {
            [Enum.EasingDirection.In] = function(Delta)
                return Delta ^ 3
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return ((Delta - 1) ^ 3) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return (4 * Delta ^ 3)
                elseif 0.5 <= Delta and Delta <= 1 then
                    return (4 * (Delta - 1) ^ 3) + 1
                end
            end
        },
        [Enum.EasingStyle.Quad] = {
            [Enum.EasingDirection.In] = function(Delta)
                return Delta ^ 2
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return (-(Delta - 1) ^ 2) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return (2 * Delta ^ 2)
                elseif 0.5 <= Delta and Delta <= 1 then
                    return -(2 * (Delta - 1) ^ 2) + 1
                end
            end
        },
        [Enum.EasingStyle.Quart] = {
            [Enum.EasingDirection.In] = function(Delta)
                return Delta ^ 4
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return (-(Delta - 1) ^ 4) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return (8 * Delta ^ 4)
                elseif 0.5 <= Delta and Delta <= 1 then
                    return -(8 * (Delta - 1) ^ 4) + 1
                end
            end
        },
        [Enum.EasingStyle.Quint] = {
            [Enum.EasingDirection.In] = function(Delta)
                return Delta ^ 5
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return ((Delta - 1) ^ 5) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return (16 * Delta ^ 5)
                elseif 0.5 <= Delta and Delta <= 1 then
                    return (16 * (Delta - 1) ^ 5) + 1
                end
            end
        },
        [Enum.EasingStyle.Sine] = {
            [Enum.EasingDirection.In] = function(Delta)
                return math.sin(((math.pi / 2) * Delta) - (math.pi / 2)) + 1
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return math.sin((math.pi / 2) * Delta)
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                return (0.5 * math.sin((math.pi * Delta) - (math.pi / 2))) + 0.5
            end
        },
        [Enum.EasingStyle.Exponential] = {
            [Enum.EasingDirection.In] = function(Delta)
                return (2 ^ ((10 * Delta) - 10)) - 0.001
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return 1.001 * (-2 ^ -(10 * Delta)) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return 0.5 * (2 ^ ((20 * Delta) - 10)) - 0.0005
                elseif 0.5 <= Delta and Delta <= 1 then
                    return 0.50025 * (-2 ^ (-(20 * Delta) + 10)) + 1
                end
            end
        },
        [Enum.EasingStyle.Back] = {
            [Enum.EasingDirection.In] = function(Delta)
                return (Delta * Delta) * (Delta * (1.70158 + 1) - 1.70158)
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return ((Delta - 1) ^ 2) * ((Delta - 1) * (1.70158 + 1) + 1.70158) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return (2 * (Delta * Delta)) * ((2 * Delta) * (2.5949095 + 1) - 2.5949095)
                elseif 0.5 <= Delta and Delta <= 1 then
                    return (0.5 * ((2 * Delta) - 2) ^ 2) * (((2 * Delta) - 2) * (2.5949095 + 1) + 2.5949095) + 1
                end
            end
        },
        [Enum.EasingStyle.Bounce] = {
            [Enum.EasingDirection.In] = function(Delta)
                if 0 <= Delta and Delta <= (1 / 2.75) then
                    return 7.5625 * (Delta * Delta)
                elseif (1 / 2.75) <= Delta and Delta <= (2 / 2.75) then
                    return 7.5625 * (Delta - (1.5 / 2.75)) ^ 2 + 0.75
                elseif (2 / 2.75) <= Delta and Delta <= (2.5 / 2.75) then
                    return 7.5625 * (Delta - (2.25 / 2.75)) ^ 2 + 0.9375
                elseif (2.5 / 2.75) <= Delta and Delta <= 1 then
                    return 7.5625 * (Delta - (2.625 / 2.75)) ^ 2 + 0.984375
                end
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                if 0 <= Delta and Delta <= (0.25 / 2.75) then
                    return -7.5625 * (1 - Delta - (2.625 / 2.75)) ^ 2 + 0.015625
                elseif (0.25 / 2.75) <= Delta and Delta <= (0.75 / 2.75) then
                    return -7.5625 * (1 - Delta - (2.25 / 2.75)) ^ 2 + 0.0625
                elseif (0.75 / 2.75) <= Delta and Delta <= (1.75 / 2.75) then
                    return -7.5625 * (1 - Delta - (1.5 / 2.75)) ^ 2 + 0.25
                elseif (1.75 / 2.75) <= Delta and Delta <= 1 then
                    return 1 - 7.5625 * (1 - Delta) ^ 2
                end
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= (0.125 / 2.75) then
                    return 0.5 * (-7.5625 * (1 - (2 * Delta) - (2.625 / 2.75)) ^ 2 + 0.015625)
                elseif (0.125 / 2.75) <= Delta and Delta <= (0.375 / 2.75) then
                    return 0.5 * (-7.5625 * (1 - (2 * Delta) - (2.25 / 2.75)) ^ 2 + 0.0625)
                elseif (0.375 / 2.75) <= Delta and Delta <= (0.875 / 2.75) then
                    return 0.5 * (-7.5625 * (1 - (2 * Delta) - (1.5 / 2.75)) ^ 2 + 0.25)
                elseif (0.875 / 2.75) <= Delta and Delta <= 0.5 then
                    return 0.5 * (1 - 7.5625 * (1 - (2 * Delta)) ^ 2)
                elseif 0.5 <= Delta and Delta <= (1.875 / 2.75) then
                    return 0.5 + 3.78125 * ((2 * Delta) - 1) ^ 2
                elseif (1.875 / 2.75) <= Delta and Delta <= (2.375 / 2.75) then
                    return 3.78125 * ((2 * Delta) - (4.25 / 2.75)) ^ 2 + 0.875
                elseif (2.375 / 2.75) <= Delta and Delta <= (2.625 / 2.75) then
                    return 3.78125 * ((2 * Delta) - (5 / 2.75)) ^ 2 + 0.96875
                elseif (2.625 / 2.75) <= Delta and Delta <= 1 then
                    return 3.78125 * ((2 * Delta) - (5.375 / 2.75)) ^ 2 + 0.9921875
                end
            end
        },
        [Enum.EasingStyle.Elastic] = {
            [Enum.EasingDirection.In] = function(Delta)
                return (-2 ^ (10 * (Delta - 1))) * math.sin(((2 * math.pi) * (Delta - 1 - (0.3 / 4))) / 0.3)
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return (2 ^ (-10 * Delta)) * math.sin(((2 * math.pi) * (Delta - (0.3 / 4))) / 0.3) + 1
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return -0.5 * (2 ^ ((20 * Delta) - 10)) * math.sin(((2 * math.pi) * ((2 * Delta) - 1.1125)) / 0.45)
                elseif 0.5 <= Delta and Delta <= 1 then
                    return 0.5 * (2 ^ ((-20 * Delta) + 10)) * math.sin(((2 * math.pi) * ((2 * Delta) - 1.1125)) / 0.45) + 1
                end
            end
        },
        [Enum.EasingStyle.Circular] = {
            [Enum.EasingDirection.In] = function(Delta)
                return -math.sqrt(1 - Delta ^ 2) + 1
            end,
            [Enum.EasingDirection.Out] = function(Delta)
                return math.sqrt(-(Delta - 1) ^ 2 + 1)
            end,
            [Enum.EasingDirection.InOut] = function(Delta)
                if 0 <= Delta and Delta <= 0.5 then
                    return -math.sqrt(-Delta ^ 2 + 0.25) + 0.5
                elseif 0.5 <= Delta and Delta <= 1 then
                    return math.sqrt(-(Delta - 1) ^ 2 + 0.25) + 0.5
                end
            end
        }
    }

    local EasingStyleNames = {"Linear", "Cubic", "Quad", "Quart", "Quint", "Sine", "Exponential", "Back", "Bounce", "Elastic", "Circular"}

    do

        Library.SetMenuVisible = function(self, Bool)
            if self.Tweening then
                return  
            end

            Library.Items:TweenDescendants(Bool, self)

            Library.Elements.Instance.Enabled = Bool
            self.Open = Bool  
        end

        Library.CheckPriority = function(self)

            local Order = self.PageCount 
            local Max = self.Window.PageCount 

            if Order == 1 then 
                self.Items.Left.Instance.Visible = false;
                self.Items.Right.Instance.Visible = true;       
            elseif Order == Max then 
                self.Items.Left.Instance.Visible = true;
                self.Items.Right.Instance.Visible = false;
            else 
                self.Items.Left.Instance.Visible = true;
                self.Items.Right.Instance.Visible = true;
            end 
        end 

        Library.OpenPage = function(self)
            if self.Tweening then return end 

            local Window = self.Window
            local OldTab = Window.TabInfo

            local Items = self.Items

            if OldTab == self or (self.Tweening or (OldTab and OldTab.Tweening)) then
                return
            end

            if OldTab then
                local OldItems = OldTab.Items

                OldItems.Filler:Tween({BackgroundTransparency = 1})
                OldItems.Button:Tween({BackgroundTransparency = 1})
                OldItems.Left:Tween({BackgroundTransparency = 1})
                OldItems.Right:Tween({BackgroundTransparency = 1})
                OldItems.Stroke:Tween({Transparency = 1})
                OldItems.Title:Tween({TextColor3 = Themes.Preset.TextMain})

                OldItems.Page:TweenDescendants(false, OldTab)
                OldItems.Page.Parent = Library.Other.Instance
            end

            Items.Button:Tween({BackgroundTransparency = 0})
            Items.Filler:Tween({BackgroundTransparency = 0})
            Items.Left:Tween({BackgroundTransparency = 0})
            Items.Right:Tween({BackgroundTransparency = 0})
            Items.Stroke:Tween({Transparency = 0})
            Items.Title:Tween({TextColor3 = Themes.Preset.Accent})

            Items.Page:TweenDescendants(true, self)
            Items.Page.Parent = self.Parent;
            self:CheckPriority()

            Window.TabInfo = self
        end

        Library.OpenMultiPage = function(self)

        end

        Library.CreateMultiPage = function(self, Data)
            Data = Data or {} 

            local Cfg = {
                Items = {}
            }

            local Items = Cfg.Items; do  
                Items.Icon = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset.UnselectedMultiPage; ScaleType = Enum.ScaleType.Fit; Parent = Items.IconHolder.Instance; Image = Cfg.Icon; Image = "rbxassetid://83328191811567"; BackgroundTransparency = 1; Size = UDim2.new(0, 37, 0, 37); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("UnselectedMultiPage", "ImageColor3"):Themify("Accent", "ImageColor3")
                Items.Seperator = Library:Create("Frame",{Parent = Items.Icon.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 1, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})

                Items.Page = Library:Create("Frame",{Visible = false; Parent = self.Items.BackgroundInner.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Reparent(self.Items.BackgroundInner.Instance)
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.Page.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})

                for Index = 1, Cfg.Columns do
                    Items[tostring(Index)] = Library:Create("ScrollingFrame",{ScrollBarImageColor3 = Themes.Preset["Outline"]; Active = true; AutomaticCanvasSize = Enum.AutomaticSize.Y; ScrollBarThickness = 0; Parent = Items.Page.Instance; BackgroundTransparency = 1; BackgroundColor3 = Color3.fromRGB(255, 255, 255); BorderSizePixel = 0; CanvasSize = UDim2.new(0, 0, 0, 0)}):Themify("Outline", "ScrollBarImageColor3")
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items[tostring(Index)].Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder; HorizontalFlex = Enum.UIFlexAlignment.Fill});
                end
            end 

            local MultiPage = setmetatable(Cfg, Library)

            return MultiPage
        end

        Library.CreateElements = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Parent = Data.Parent or self.Items.Section or self.Instance,
                Position = Data.Position or UDim2.new(0, 4, 0, 25),
                Size = Data.Size or UDim2.new(1, -8, 0, 0),

                Items = {},
                DataElements = {},
            }

            local Items = Cfg.Items; do
                Items.Elements = Library:Create( "Frame", {
                    Parent = Cfg.Parent,
                    BackgroundTransparency = 1;
                    Position = Cfg.Position;
                    Size = Cfg.Size;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                Library:Create( "UIListLayout", {
                    Parent = Items.Elements.Instance;
                    Padding = UDim.new(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Library:Create( "UIPadding", {
                    PaddingBottom = UDim.new(0, 2);
                    Parent = Items.Elements.Instance
                })
            end

            Cfg.SetVisible = function(Bool)
                Items.Elements.Instance.Visible = Bool
            end

            return setmetatable(Cfg, Library)
        end

        Library.CheckMultiPriority = function(self)

            local Order = self.Count 
            local Max = self.Old.Count 

            if Order == 1 then 
                self.Items.Left.Instance.Visible = false;
                self.Items.Right.Instance.Visible = true;       
            elseif Order == Max then 
                self.Items.Left.Instance.Visible = true;
                self.Items.Right.Instance.Visible = false;
            else 
                self.Items.Left.Instance.Visible = true;
                self.Items.Right.Instance.Visible = true;
            end 
        end

        Library.CreateMultiSection = function(self, Data)
            self.Count += 1
            Data = Data or {} 

            local Cfg = {
                Text = Data.Name or Data.Text or Data.Title or "Section";
                Items = {};
                Count = self.Count;
                Old = self;
            }

            local Elements;
            local Items = Cfg.Items; do 

                Elements = Library:CreateElements({
                    Parent = self.Items.Background.Instance;
                    Position = UDim2.new(0, 4, 0, 29)
                })

                Items.Elements = Elements.Items.Elements
                Elements.SetVisible(false)

                Items.Button = Library:Create("TextButton",{Active = false; Parent = self.Items.TabButtonHolder.Instance; BackgroundTransparency = 1; Selectable = false; TextTransparency = 1; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Text = Library:Create("TextLabel",{BackgroundColor3 = Themes.Preset.Accent; TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Button.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BackgroundColor3 = Themes.Preset.Accent; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY}):Themify("Accent", "BackgroundColor3")
                Items.Stroke = Library:Create("UIStroke",{Transparency = 1; Parent = Items.Button.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Text.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Button.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Themes.Preset.SectionBackground)}})
                Items.Filler = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, 0, 0, 2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.SectionBackground})
                Items.Right = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(1, -1, 0, 0); Size = UDim2.new(0, 1, 1, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Left = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 1, 1, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})

                Items.Text:ThemeListener("Accent", function() 
                    return Cfg == self.OldSection;
                end, "TextColor3", "BackgroundColor3")
            end     

            local Multi = setmetatable(Cfg, Library)

            function Cfg.SetVisible(Bool)
                Items.Button:Tween({BackgroundTransparency = Bool and 0 or 1})
                Items.Filler:Tween({BackgroundTransparency = Bool and 0 or 1})
                Items.Left:Tween({BackgroundTransparency = Bool and 0 or 1})
                Items.Right:Tween({BackgroundTransparency = Bool and 0 or 1})
                Items.Stroke:Tween({Transparency = Bool and 0 or 1})
                Items.Text:Tween({TextColor3 = Bool and Themes.Preset.Accent or Themes.Preset.TextMain})
                Multi:CheckMultiPriority() 

                Elements.SetVisible(Bool)
            end

            Items.Button:OnClick(function()
                if self.OldSection == Cfg then 
                    return 
                end 

                if self.OldSection then 
                    self.OldSection.SetVisible(false)
                end 

                Cfg.SetVisible(true)

                self.OldSection = Cfg;
            end)

            return Multi
        end

        Library.SetupElement = function(self, Default, Extra)
            if self.Set and self.Flag then
                ConfigFlags[self.Flag] = self.Set
                self.Set(Default)
            end

            if self.Items.Object and self.Names and self.Elements then
                table.insert(self.Names, self.Text)
                table.insert(self.Elements, self.Items.Object)
            end

            if self.Hovering and self.Type ~= "Label" and self.DataElements and self.IsHovering then
                table.insert(self.DataElements, self.IsHovering)
            end
        end

        Library.UpdateSlider = function(self, Input)
            local Items = self.Items

            local Size = (Input.Position.X - Items.Outline.Instance.AbsolutePosition.X) / Items.Outline.Instance.AbsoluteSize.X
            local Value = ((self.Max - self.Min) * Size) + self.Min

            self.Set(Value)
        end

        Library.UpdateRangeSlider = function(self, Input)
            local Items = self.Items 

            local MouseX = Input.Position.X
            local BarX = Items.Holder.Instance.AbsolutePosition.X
            local BarW = Items.Holder.Instance.AbsoluteSize.X

            local Scale = math.clamp((MouseX - BarX) / BarW, 0, 1)
            local Value = Library:Round((Scale * (self.Max - self.Min)) + self.Min, self.Intervals)

            if self.SlidingHandle == Items.Min then
                self.Set(Value, self.Value[2])
            else
                self.Set(self.Value[1], Value)
            end
        end

        Library.UpdateSliderPosition = function(self, Bool, Debounce)
            local Items = self.Items

            local YOffset = 81 - 5
            local Position = Debounce and Items.Settings.Instance.AbsolutePosition or Vector2.new(Mouse.X, Mouse.Y)
            local Width = Library:Round(Position.X, 0.5)
            local FrameWidth = Library:Round(Items.Value.Instance.AbsoluteSize.X, 0.5)

            if Debounce then
                return
            end

            if Bool then
                Items.Settings.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15)))
                Items.Settings:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset)) })
            else
                Items.Settings:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15))) })
            end
        end

        Library.RenderDropdownOption = function(self, Text)
            local Items = self.Items
            local Items = {}    

            Items.Value = Library:Create("TextButton",{BackgroundColor3 = Themes.Preset.Accent; Parent = self.Items.OptionsHolder.Instance; TextColor3 = Themes.Preset.Accent; Text = Text; Size = UDim2.new(1, 0, 0, 0); ClipsDescendants = true; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; RichText = true; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextMisc", "TextColor3"):Themify("Accent", "BackgroundColor3")
            Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter, ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 4); Parent = Items.Value.Instance; PaddingRight = UDim.new(0, 4); PaddingLeft = UDim.new(0, 5)})

            Items.Value.Instance.Text = Text

            Items.Value:ThemeListener("Accent", function() 
                local Value = Flags[self.Flag]
                local Text = Items.Value.Instance.Text
                local IsTable = type(Value) == "table"

                return (Text == Value or (IsTable and table.find(Value, Text)))
            end, "TextColor3", "BackgroundColor3")

            local Hover = function()
                local Value = Flags[self.Flag]
                local Text = Items.Value.Instance.Text
                local IsTable = type(Value) == "table"

                if not (Text == Value or (IsTable and table.find(Value, Text))) then 
                    Items.Value:Tween({TextColor3 = Themes.Preset.TextMain})
                end 
            end 

            local NoHover = function()
                local Value = Flags[self.Flag]
                local Text = Items.Value.Instance.Text
                local IsTable = type(Value) == "table"

                if not (Text == Value or (IsTable and table.find(Value, Text))) then 
                    Items.Value:Tween({TextColor3 = Themes.Preset.TextMisc})
                end 
            end 

            Items.Value:OnHover(Hover, NoHover)

            table.insert(self.OptionInstances, Items)

            return Items
        end 

        Library.RefreshDropdown = function(self, Options)
            local Items = self.Items

            for _, Option in self.OptionInstances do
                Option.Value.Instance:Destroy()
            end

            self.OptionInstances = {}

            for _, Option in Options do
                local Object = self:RenderDropdownOption(Option)
                local Button = Object.Value
                local Text = Object.Value.Instance.Text

                Button:OnClick(function()
                    if self.Multi then
                        local Selected = table.find(self.MultiItems, Text)

                        if Selected then
                            table.remove(self.MultiItems, Selected)
                        else
                            table.insert(self.MultiItems, Text)
                        end

                        self.Set(self.MultiItems)
                    else
                        self.Set(Text)
                    end
                end)
            end

            if #self.OptionInstances >= 10 or self.Scrolling then
                Items.OptionsHolder.Instance.Size = UDim2.new(1, 0, 0, 100)
                Items.OptionsHolder.Instance.AutomaticSize = Enum.AutomaticSize.None
            else
                Items.OptionsHolder.Instance.Size = UDim2.new(1, 0, 0, 0)
                Items.OptionsHolder.Instance.AutomaticSize = Enum.AutomaticSize.Y
            end
        end

        Library.RenderListOption = function(self, Text)
            local Items = {}    

            Items.Value = Library:Create("TextLabel",{BackgroundColor3 = Themes.Preset.Accent; Parent = self.Items.Holder.Instance; TextColor3 = Themes.Preset.TextMisc; Text = Text; Size = UDim2.new(1, 0, 0, 0); ClipsDescendants = true; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; RichText = true; AutomaticSize = Enum.AutomaticSize.Y}):Themify("Accent", "BackgroundColor3"):Themify("TextMisc", "TextColor3")
            Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
            Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 4); Parent = Items.Value.Instance; PaddingRight = UDim.new(0, 4); PaddingLeft = UDim.new(0, 4)})

            Items.Value.Instance.TextTransparency = 0

            Items.Value.Instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                local Value = Flags[self.Flag]
                local Text = Items.Value.Instance.Text
                local IsTable = type(Value) == "table"

                if (Text == Value or (IsTable and table.find(Value, Text))) then 
                    Items.Value.Instance.TextColor3 = Themes.Preset.Accent
                end  
            end)

            local Hover = function()
                local Value = Flags[self.Flag]
                local Text = Items.Value.Instance.Text
                local IsTable = type(Value) == "table"

                if not (Text == Value or (IsTable and table.find(Value, Text))) then 
                    Items.Value:Tween({TextColor3 = Themes.Preset.TextMain})
                end 
            end 

            local NoHover = function()
                local Value = Flags[self.Flag]
                local Text = Items.Value.Instance.Text
                local IsTable = type(Value) == "table"

                if not (Text == Value or (IsTable and table.find(Value, Text))) then 
                    Items.Value:Tween({TextColor3 = Themes.Preset.TextMisc})
                end 
            end 

            Items.Value:OnHover(Hover, NoHover)

            table.insert(self.OptionInstances, Items)

            return Items
        end 

        Library.RefreshList = function(self, Options)
            local Items = self.Items

            for _, Option in self.OptionInstances do
                Option.Value.Instance:Destroy()
            end

            self.OptionInstances = {}

            for _, Option in Options do
                local Object = self:RenderListOption(Option)
                local Button = Object.Value
                local Text = Object.Value.Instance.Text

                Button:OnClick(function()
                    if self.Multi then
                        local Selected = table.find(self.MultiItems, Text)

                        if Selected then
                            table.remove(self.MultiItems, Selected)
                        else
                            table.insert(self.MultiItems, Text)
                        end

                        self.Set(self.MultiItems)
                    else
                        self.Set(Text)
                    end
                end)
            end
        end

        Library.UpdateDropdownPosition = function(self, Bool, Debounce)
            local Items = self.Items

            local YOffset = 82
            local Position = Items.Outline.Instance.AbsolutePosition
            local Width = Library:Round(Position.X, 0.5)
            local FrameWidth = Library:Round(Items.Outline.Instance.AbsoluteSize.X, 0.5)

            Items.DropdownHolder.Instance.Size = UDim2.fromOffset(FrameWidth,
            Items.DropdownHolder.Instance.AbsoluteSize.Y)

            if Debounce then
                Items.DropdownHolder.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset))

                return
            end

            if Bool then
                Items.DropdownHolder.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15)))
                Items.DropdownHolder:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset)) })
            else
                Items.DropdownHolder:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15))) })
            end
        end

        Library.SetMode = function(self, Mode)
            local Items = self.Items;
            self.Mode = Mode

            if Mode == "Always" then
                self.Set(true)
            elseif Mode == "Hold" then
                self.Set(false)
            end

            Flags[self.Flag].Mode = Mode
        end

        Library.NewKey = function(self)
            if self.Binding then
                return
            end

            task.wait()

            local Items = self.Items

            Items.Value.Instance.Text = "Selecting"

            self.Binding = Library:Connect(Services.UserInputService.InputBegan, function(Input, GameProcessedEvent)
                if GameProcessedEvent then  
                    return
                end

                self.Set(Input.KeyCode ~= Enum.KeyCode.Unknown and Input.KeyCode or Input.UserInputType)

                self.Binding.Connection:Disconnect()
                self.Binding = nil
            end)
        end

        Library.UpdateKeyPickerPosition = function(self, Bool, Debounce)
            local Items = self.Items

            local YOffset = 81 - 5
            local Position = Items.Value.Instance.AbsolutePosition
            local Width = Library:Round(Position.X, 0.5)
            local FrameWidth = Library:Round(Items.Value.Instance.AbsoluteSize.X, 0.5)

            if Debounce then
                Items.Settings.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset))

                return
            end

            if Bool then
                Items.Settings.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15)))
                Items.Settings:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset)) })
            else
                Items.Settings:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15))) })
            end
        end

        Library.Colorpicker = function(self, properties)
            local Cfg = {
                Text = properties.Text or properties.Name or properties.Title or "Color",
                Flag = properties.Flag or properties.Name or properties.Title or properties.Text or Library:NextFlag(),
                Callback = properties.Callback or function() end,

                Color = properties.Color or Color3.fromRGB(1, 1, 1),
                Alpha = properties.Alpha or properties.Transparency or 0,
                Colors = properties.Colors or {},

                Open = false,
                PageCount = 0;
                Items = {},
                OldTab; 
                Tweening = false,

                Type = properties.Type or "Animation",  
                Colorpickers = {},
                ColorpickerMetadata = {},

                DataElements = self.DataElements,
            }   

            local DraggingSat = false
            local DraggingHue = false
            local DraggingAlpha = false

            local h, s, v = Cfg.Color:ToHSV()
            local a = Cfg.Alpha

            local OldHue = h;
            local OldAlpha = a;

            local Colorpicker = setmetatable(Cfg, Library)

            local Items = Cfg.Items; do

                Items.ComponentsHolder = self.Items.ComponentsHolder

                if not self.Items.ComponentsHolder then
                    local Label = self:AddLabel({ Text = Cfg.Text })
                    Items.ComponentsHolder = Label.Items.ComponentsHolder

                    Label.Items.Label.Instance.Position = UDim2.new(0, 0, 0, 3)
                end

                Items.Object = Library:Create("TextButton",{Parent = Items.ComponentsHolder.Instance; Size = UDim2.new(0, 24, 0, 12); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Object = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Object.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(255, 255, 255)), ColorKey(1, Color3.fromRGB(148, 148, 148))}})

                Items.Outline = Library:Create("TextButton",{Visible = false; Parent = Library.Other.Instance; Size = UDim2.new(0, 218, 0, 248); Position = UDim2.new(0, 281, 0, 575); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3"):Reparent(Library.Elements.Instance):Resizify()
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Outline.Instance})
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                Items.Colorpicker = Library:Create("Frame",{Parent = Items.Outline.Instance; Size = UDim2.new(1, -2, 1, -2); Position = UDim2.new(0, 1, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.Background = Library:Create("Frame",{Parent = Items.Colorpicker.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["SectionBackground"]}):Themify("SectionBackground", "BackgroundColor3")
                Items.TabButtonOutline = Library:Create("Frame",{ClipsDescendants = true; Parent = Items.Colorpicker.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 0, 25); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["TabButtonUnselected"]}):Themify("TabButtonUnselected", "BackgroundColor3")
                Items.InlineLine = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; Position = UDim2.new(0, 0, 1, -1); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.OutlineLine = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; Position = UDim2.new(0, 0, 1, -2); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.TabButtonHolder = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, -2); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.TabButtonHolder.Instance; Padding = UDim.new(0, 1); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, -2); Parent = Items.Colorpicker.Instance})

            end

            local Page2 = Colorpicker:CreateColorpickerPage({Name = "Color"}); do 
                Page2.Items.Page.Instance.Size = UDim2.new(1, -8, 1, -29)
                Page2.Items.Page.Instance.Position = UDim2.new(0, 4, 0, 29)

                Items.Elements = Page2.Items.Page
                Items.Elements.Instance.AutomaticSize = Enum.AutomaticSize.None 

                Items.SatValBackground = Library:Create("Frame",{AnchorPoint = Vector2.new(0, 1); Parent = Items.Elements.Instance; Position = UDim2.new(0, 0, 1, -48); Size = UDim2.new(1, -44, 1, -48); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.SatValBackground.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.ColorpickerBackground = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(0, 208, 255)})
                Items.SatValPickerHolder = Library:Create("Frame",{Parent = Items.ColorpickerBackground.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 2, 0, 2); Size = UDim2.new(1, -4, 1, -4); ZIndex = 100; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.SatValPicker = Library:Create("Frame",{AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.SatValPickerHolder.Instance; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(0, 2, 0, 2); ZIndex = 100; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.HueOutlinePicker = Library:Create("UIStroke",{Color = Color3.fromRGB(52, 52, 52); LineJoinMode = Enum.LineJoinMode.Miter; Parent = Items.SatValPicker.Instance})
                Items.Saturation = Library:Create("Frame",{Parent = Items.ColorpickerBackground.Instance; Size = UDim2.new(1, 0, 1, 0); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 270; Transparency = NumSeq{NumKey(0, 0), NumKey(1, 1)}; Parent = Items.Saturation.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(0, 0, 0)), ColorKey(1, Color3.fromRGB(0, 0, 0))}})
                Items.Value = Library:Create("Frame",{Parent = Items.ColorpickerBackground.Instance; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Parent = Items.Value.Instance; Transparency = NumSeq{NumKey(0, 0), NumKey(1, 1)}})
                Items.Hue = Library:Create("Frame",{AnchorPoint = Vector2.new(1, 0); Parent = Items.Elements.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 18, 1, -48); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{AnchorPoint = Vector2.new(0, 1); Parent = Items.Hue.Instance; Position = UDim2.new(0, 1, 1, -1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.GradientHolder = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.GradientHolder.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(255, 0, 0)), ColorKey(0.17, Color3.fromRGB(255, 255, 0)), ColorKey(0.33, Color3.fromRGB(0, 255, 0)), ColorKey(0.5, Color3.fromRGB(0, 255, 255)), ColorKey(0.67, Color3.fromRGB(0, 0, 255)), ColorKey(0.83, Color3.fromRGB(255, 0, 255)), ColorKey(1, Color3.fromRGB(255, 0, 0))}})
                Items.Holder = Library:Create("Frame",{Parent = Items.GradientHolder.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 2); Size = UDim2.new(1, 0, 1, -4); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.HuePicker = Library:Create("Frame",{AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.Holder.Instance; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(1, 0, 0, 1); ZIndex = 100; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.HuePicker.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.Alpha = Library:Create("Frame",{AnchorPoint = Vector2.new(1, 0); Parent = Items.Elements.Instance; Position = UDim2.new(1, -22, 0, 0); Size = UDim2.new(0, 18, 1, -48); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{AnchorPoint = Vector2.new(0, 1); Parent = Items.Alpha.Instance; Position = UDim2.new(0, 1, 1, -1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.GradientHolder = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(0, 255, 204)})
                Items.Holder = Library:Create("Frame",{Parent = Items.GradientHolder.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 0); Size = UDim2.new(1, 0, 1, 0); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.AlphaPicker = Library:Create("Frame",{AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.Holder.Instance; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(1, 0, 0, 1); ZIndex = 100; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.AlphaPicker.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.Gradient = Library:Create("ImageLabel",{ScaleType = Enum.ScaleType.Tile; Parent = Items.GradientHolder.Instance; Image = "rbxassetid://18274452449"; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); TileSize = UDim2.new(0, 4, 0, 4); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = -90; Transparency = NumSeq{NumKey(0, 0), NumKey(0.5, 0.7437499761581421), NumKey(1, 1)}; Parent = Items.Gradient.Instance})

                local Color = Cfg.Color
                local Elements = Items.Elements.Instance

                Items.Elements = Library:Create("Frame",{Parent = Elements; AnchorPoint = Vector2.new(0, 1); BackgroundTransparency = 1; Position = UDim2.new(0, 0, 1, -24); Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                local Section = setmetatable(Cfg, Library)
                Items.RgbInput = Section:AddInput({FocusLost = true, Flag = Cfg.Flag .. "_RGB", Placeholder = "", Default = string.format("%s, %s, %s", Library:Round(Color.R * 255), Library:Round(Color.G * 255), Library:Round(Color.B * 255)), Callback = function(Text)
                    if not (Text and Cfg.Set) then 
                        return 
                    end 

                    local r, g, b = Library:GroupRGB(Text)

                    if r and g and b then 
                        Cfg.Set(Color3.fromRGB(r, g, b), Cfg.Alpha)
                    else 
                        Cfg.Set(Cfg.Color, Cfg.Alpha)
                    end 
                end})

                Items.Elements = Library:Create("Frame",{Parent = Elements; AnchorPoint = Vector2.new(0, 1); BackgroundTransparency = 1; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                local Section = setmetatable(Cfg, Library)
                Items.HexInput = Section:AddInput({FocusLost = true, Placeholder = "", Default = Library:ConvertToHex(Color), Flag = Cfg.Flag .. "_ALPHA", Callback = function(Text)
                    if not (Text and Cfg.Set) then 
                        return
                    end 

                    local r, g, b = Library:ConvertFromHex(Text)

                    if r and g and b and Cfg.Set then 
                        Cfg.Set(Color3.new(r, g, b), Cfg.Alpha)
                    else 
                        Cfg.Set(Cfg.Color, Cfg.Alpha)
                    end 
                end})
            end 

            if Cfg.Type == "Animation" then 
                local Page = Colorpicker:CreateColorpickerPage({Name = "Settings"}); do 
                    local Section = Page.Items.Page:CreateElements({Size = UDim2.new(1, 0, 0, 0); Position = UDim2.new(0, 0, 0, -2)})
                    Section:AddDropdown({Name = "Mode", Options = {"Rainbow", "Fading", "Solid"}, Flag = Cfg.Flag.."_Animation", Default = "Solid"}) 

                    Section:AddColorPicker({Type = "Default", Flag = Cfg.Flag.."1", Default = Color3.fromRGB(255, 0, 0)})
                    Section:AddColorPicker({Type = "Default", Flag = Cfg.Flag.."2", Default = Color3.fromRGB(255, 255, 255)})

                    Section:AddSlider({Name = "Speed", Min = 0, Max = 100, Default = 50, Suffix = "%", Flag = Cfg.Flag.."_AnimationSpeed"})

                    table.insert(Section.DataElements, function()
                        if Page.Tweening or Page2.Tweening then
                            return true;  
                        end
                    end)

                    Items.Outline:OutsideClick(Cfg, Section.DataElements)
                end 

                local fps, acc = 60, 0
                Library:Connect(Services.RunService.RenderStepped, function(dt)
                    if Type == "Solid" then 
                        return 
                    end 

                    acc += dt 
                    if not (acc >= 1/fps) then 
                        return 
                    end 

                    acc -= dt           

                    local Type = Flags[Cfg.Flag.."_Animation"]

                    local Speed = math.abs(math.sin(tick() * (Flags[Cfg.Flag .. "_AnimationSpeed"] / 25)))

                    if Type == "Rainbow" then 
                        Cfg.Set(Color3.fromHSV(Speed, s, v), a)
                    elseif Type == "Fading" then 
                        local Color = Flags[Cfg.Flag.."1"].Color:Lerp(Flags[Cfg.Flag.."2"].Color, Speed)

                        Cfg.Set(
                            Color, 
                            Library:Lerp(
                                Flags[Cfg.Flag.."1"].Transparency, 
                                Flags[Cfg.Flag.."2"].Transparency, 
                                Speed
                            )
                        )
                    end 
                end)
            else 
                Items.Colorpicker:OutsideClick(Cfg)

                task.spawn(function()
                    repeat task.wait() until Cfg.OldTab 

                    Cfg.OldTab.Items.Right.Instance.Visible = false
                end)
            end 

            Cfg.SetVisible = function(Bool)
                if Cfg.Tweening then
                    return
                end

                Cfg.Open = Bool

                if (Cfg.Open == true) and Items.Outline.Instance.Visible then 
                    return
                end 

                local ColorpickerObject = Items.Object.Instance
                Items.Outline.Instance.Position = UDim2.new(0, ColorpickerObject.AbsolutePosition.X, 0, ColorpickerObject.AbsolutePosition.Y + (Cfg.Open and 64 or 79))
                Items.Outline:Tween({ Position = UDim2.new(0, ColorpickerObject.AbsolutePosition.X, 0, ColorpickerObject.AbsolutePosition.Y + (Cfg.Open and 79 or 64))})
                Items.Outline:TweenDescendants(Cfg.Open, Cfg)
                Items.Outline:ClampToScreen()
            end

            Cfg.UpdateColor = function()
                local Mouse = Services.UserInputService:GetMouseLocation()
                local Offset = Mouse - Services.GuiService:GetGuiInset()

                if DraggingSat then
                    s = math.clamp((Offset - Items.Saturation.Instance.AbsolutePosition).X / Items.Saturation.Instance.AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((Offset - Items.Saturation.Instance.AbsolutePosition).Y / Items.Saturation.Instance.AbsoluteSize.Y, 0, 1)
                elseif DraggingHue then
                    h = math.clamp((Offset - Items.Hue.Instance.AbsolutePosition).Y / Items.Hue.Instance.AbsoluteSize.Y, 0, 1)
                elseif DraggingAlpha then
                    a = 1 - math.clamp((Offset - Items.Alpha.Instance.AbsolutePosition).Y / Items.Alpha.Instance.AbsoluteSize.Y, 0, 1)
                end

                Cfg.Set()
            end

            Cfg.Set = function(Color, Alpha, Colors)
                if Color then
                    h, s, v = Color:ToHSV()
                end 

                if Alpha then
                    a = Alpha
                end

                local TweenInformation = TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                local Flag = Flags[Cfg.Flag]

                Items.Object.Instance.BackgroundColor3 = Color3.fromHSV(h, s, v)
                Items.ColorpickerBackground.Instance.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                Items.GradientHolder.Instance.BackgroundColor3 = Color3.fromHSV(h, 1, 1)

                Items.SatValPicker:Tween({ Position = UDim2.new(s, 0, 1 - v, 0) }, TweenInformation)
                Items.AlphaPicker:Tween({ Position = UDim2.new(0.5, 0, 1 - a, 0) }, TweenInformation)
                Items.HuePicker:Tween({ Position = UDim2.new(0.5, 0, h, 0) }, TweenInformation)

                Color = Items.Object.Instance.BackgroundColor3

                Items.RgbInput.Items.Input.Instance.Text = string.format("%s, %s, %s", Library:Round(Color.R * 255), Library:Round(Color.G * 255), Library:Round(Color.B * 255))
                Items.HexInput.Items.Input.Instance.Text = Library:ConvertToHex(Color)

                Cfg.Color = Color 
                Cfg.Alpha = a

                Flags[Cfg.Flag] = {
                    Color = Color,
                    Transparency = a,
                    Colors = Cfg.Colors
                }

                Cfg.Callback(Color, a)
            end

            Cfg.DisableDragging = function()
                DraggingSat = false
                DraggingHue = false
                DraggingAlpha = false
            end

            Cfg.IsHovering = function()
                return Items.Outline:Hovering()
            end

            Items.Alpha:OnDrag(Cfg.UpdateColor, function(Dragging)
                if Dragging then
                    DraggingAlpha = true
                else
                    Cfg.DisableDragging()
                end
            end)

            Items.Hue:OnDrag(Cfg.UpdateColor, function(Dragging)
                if Dragging then
                    DraggingHue = true
                else
                    Cfg.DisableDragging()
                end
            end)

            Items.Saturation:OnDrag(Cfg.UpdateColor, function(Dragging)
                if Dragging then
                    DraggingSat = true
                else
                    Cfg.DisableDragging()
                end
            end)

            Items.Object:OnClick(function()
                Cfg.Open = not Cfg.Open

                Cfg.SetVisible(Cfg.Open)
            end)

            Colorpicker:SetupElement(Cfg.Color, Cfg.Alpha)

            return setmetatable(Cfg, Library)
        end

        Library.CreateColorpickerPage = function(self, Data)
            Data = Data or {}

            self.PageCount += 1

            local Cfg = {
                Text = Data.Name or Data.Text or Data.Title or "Tab"; 
                Tweeming = false;
                Colorpicker = self;
                Items = {};
                PageCount = self.PageCount;
            }

            local Items = Cfg.Items; do 

                Items.Button = Library:Create("TextButton",{Active = false; Parent = self.Items.TabButtonHolder.Instance; BackgroundTransparency = 1; Selectable = false; TextTransparency = 1; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Text = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Button.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset.Accent}):Themify("Accent", "BackgroundColor3")
                Items.Stroke = Library:Create("UIStroke",{Transparency = 1; Parent = Items.Button.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Text.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Button.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Themes.Preset.SectionBackground)}})
                Items.Filler = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, 0, 0, 2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.SectionBackground})
                Items.Right = Library:Create("Frame",{Visible = false; Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(1, -1, 0, 0); Size = UDim2.new(0, 1, 1, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Left = Library:Create("Frame",{Visible = false; Parent = Items.Button.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 1, 1, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})

                Items.Page = Library:Create("Frame",{Visible = false; Parent = self.Items.Background.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 4, 0, 29); Size = UDim2.new(1, -8, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})

                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 4); Parent = Items.Page.Instance})

                Items.Text.Instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                    if self.OldTab == Cfg then 
                        Items.Text.Instance.TextColor3 = Themes.Preset.Accent
                    end 
                end)
            end 

            local Page = setmetatable(Cfg, Library)

            Items.Button:OnClick(function()
                Page:OpenColorpickerPage()
            end)

            if not self.OldTab then 
                Page:OpenColorpickerPage()
            end

            return Page
        end

        Library.OpenColorpickerPage = function(self, Data)
            if self.Tweening or self.Colorpicker.Tweening then 
                return 
            end 

            local OldTab = self.Colorpicker and self.Colorpicker.OldTab or nil

            local Items = self.Items

            if OldTab == self or (self.Tweening or (OldTab and OldTab.Tweening)) then
                return
            end

            if OldTab then
                local OldItems = OldTab.Items

                OldItems.Filler:Tween({BackgroundTransparency = 1})
                OldItems.Button:Tween({BackgroundTransparency = 1})
                OldItems.Left:Tween({BackgroundTransparency = 1})
                OldItems.Right:Tween({BackgroundTransparency = 1})
                OldItems.Stroke:Tween({Transparency = 1})
                OldItems.Text:Tween({TextColor3 = Themes.Preset.TextMain})

                OldItems.Page:TweenDescendants(false, OldTab)
            end

            Items.Button:Tween({BackgroundTransparency = 0})
            Items.Filler:Tween({BackgroundTransparency = 0})
            Items.Left:Tween({BackgroundTransparency = 0})
            Items.Right:Tween({BackgroundTransparency = 0})
            Items.Stroke:Tween({Transparency = 0})
            Items.Text:Tween({TextColor3 = Themes.Preset.Accent})

            Items.Page:TweenDescendants(true, self)

            local Order = self.PageCount 
            local Max = self.Colorpicker.PageCount 

            if Order == 1 then 
                Items.Left.Instance.Visible = false;
                Items.Right.Instance.Visible = true;       
            elseif Order == Max then 
                Items.Left.Instance.Visible = true;
                Items.Right.Instance.Visible = false;
            else 
                Items.Left.Instance.Visible = true;
                Items.Right.Instance.Visible = true;
            end 

            self.Colorpicker.OldTab = self
        end 

        Library.Tooltip = function(self, Data)
            Data = Data or {} 

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name; 
                MultiLine = Data.MultiLine or false;

                Items = {};
                Open = false;
            }

            local Items = Cfg.Items; do 
                Items.Outline = Library:Create("CanvasGroup",{GroupTransparency = 1; Parent = Library.Items.Instance; Size = UDim2.new(0, Data.MultiLine and 200 or 0, 0, 0); Position = UDim2.new(0, 30, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Background.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Text = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Background.Instance; Position = UDim2.new(0, 4, 0, 4); BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Text.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 3); PaddingTop = UDim.new(0, 1); PaddingRight = UDim.new(0, 7); Parent = Items.Text.Instance})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Outline.Instance})
            end 

            self.Items.Object.Instance.MouseEnter:Connect(function()
                Items.Outline:Tween({GroupTransparency = 0})
                Cfg.Open = true
            end)

            self.Items.Object.Instance.MouseLeave:Connect(function()
                Items.Outline:Tween({GroupTransparency = 1})
                Cfg.Open = false 
            end)

            Library:Connect(Services.UserInputService.InputChanged, function(Input, game_event)
                if Cfg.Open and Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    Items.Outline:Tween({Position = UDim2.fromOffset(Input.Position.X + 5, Input.Position.Y + 80)})
                end
            end)

            return setmetatable(Cfg, Library)
        end

        local Colors = {
            ["Neutral"] = Color3.fromRGB(171, 168, 168),
            ["Enemy"] = Color3.fromRGB(255, 0, 0),
            ["LocalPlayer"] = Themes.Preset.Accent
        }

        Library.AddPlayer = function(self, Player)
            local Cfg = {Items = {}, Player = Player}

            local Items = Cfg.Items; do 
                Items.Holder = Library:Create( "TextButton", {
                    Parent = self.Items.Holder.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                Items.Player = Library:Create( "TextLabel", {
                    Parent = Items.Holder.Instance;
                    TextColor3 = Themes.Preset.TextColor;
                    Text = string.format("%s (@%s)", Player.DisplayName, Player.Name);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    Size = UDim2.new(1, 0, 0, 0);
                    ClipsDescendants = true;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Themify("Accent", "TextColor3")

                table.insert(self.Labels, Items.Player)

                Items.Seperator = Library:Create( "Frame", {
                    Parent = Items.Holder.Instance;
                    Size = UDim2.new(0, 3, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                })

                Items.Priority = Library:Create( "TextLabel", {
                    TextColor3 = Color3.fromRGB(171, 168, 168);
                    Text = "Neutral";
                    Parent = Items.Holder.Instance;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    Size = UDim2.new(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Themify("Accent", "TextColor3")

                Library:Create( "UIPadding", {
                    PaddingRight = UDim.new(0, 8);
                    Parent = Items.Priority.Instance
                })

                Library:Create( "UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = Items.Holder.Instance;
                    Padding = UDim.new(0, 8);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })
            end 

            local PlayerData = setmetatable(Cfg, Library)

            self.Data[Player.Name] = PlayerData

            Items.Holder:OnClick(function()
                Cfg.Switch()
            end)

            Cfg.Filter = function(Text)
                if string.find(string.lower(Items.Player.Instance.Text .. " " .. Items.Priority.Instance.Text), string.lower(Text)) then 
                    Items.Holder.Instance.Visible = true 
                else 
                    Items.Holder.Instance.Visible = false
                end 
            end 

            Cfg.Switch = function()
                if self.Selected == PlayerData then 
                    return 
                end 

                if self.Selected then 
                    self.Selected.Items.Player.Instance.TextColor3 = Themes.Preset.TextColor
                end 

                self.ImageBox:SetImage(Services.Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48))
                self.Name.ChangeText("Name: "..Player.Name)
                self.DisplayName.ChangeText("DisplayName: "..Player.DisplayName)
                self.UserId.ChangeText("UserId: "..Player.UserId)
                Items.Player.Instance.TextColor3 = Themes.Preset.Accent

                self.Selected = PlayerData
            end 

            return PlayerData
        end 

        Library.RemovePlayer = function(self, Player)
            self.Data[Player.Name].Items.Holder.Instance:Destroy()
        end

        Library.GetPriority = function(self, Player)
            if not self.Data[Player.Name] then 
                return 
            end 

            return self.Data[Player.Name].Items.Priority.Instance.Text  
        end 

        Library.SetPriority = function(self, Priority)
            if self.Player.Name == Services.Players.LocalPlayer.Name then 
                self.Items.Priority.Instance.Text = "LocalPlayer"
                self.Items.Priority:Tween({TextColor3 = Themes.Preset.Accent})

                return
            end 

            self.Items.Priority.Instance.Text = Priority
            self.Items.Priority:Tween({TextColor3 = Colors[Priority]})
        end 

        do  
            local YOffset = 0 
            local BiggestX = 0 

            Library.Notify = function(self, Data)
                Data = Data or {} 

                local Cfg = {
                    Text = Data.Title or Data.Name or Data.Text or "Title";
                    Lifetime = Data.Lifetime or 5; 

                    Items = {};
                    Status = true;
                    Fade = 2;
                    Tick = tick();
                    Index = #self.Notifications + 1
                }

                local Items = Cfg.Items; do 
                    Items.Notification = Library:Create("CanvasGroup",{GroupTransparency = 1; Parent = Library.Items.Instance; Size = UDim2.new(0, 0, 0, 0); Position = UDim2.new(0, 30, 0, 435); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                    Items.Inline = Library:Create("Frame",{Parent = Items.Notification.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                    Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Background.Instance; Color = ColorSeq{ColorKey(0, Themes.Preset["High Contrast"]), ColorKey(1, Themes.Preset["Low Contrast"])}})
                    Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Background.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 4, 0, 4); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextColor3 = Themes.Preset.TextMain})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 3); PaddingRight = UDim.new(0, 7); Parent = Items.Title.Instance})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Notification.Instance})
                    Items.Accent = Library:Create("Frame",{Parent = Items.Notification.Instance; Position = UDim2.new(0, 2, 1, -1); Size = UDim2.new(0, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Accent"]}):Themify("Accent", "BackgroundColor3")
                end     

                self.Notifications[Cfg.Index] = Cfg 
                Items.Accent:Tween({Size = UDim2.new(0, Items.Notification.Instance.AbsoluteSize.X - 4, 0, 1)}, TweenInfo.new(Cfg.Lifetime, Library.EasingStyle, Library.EasingDirection, 0, false, 0))

                task.delay(Cfg.Lifetime + 1, function()
                    Items.Notification.Instance:Destroy() 
                    self.Notifications[Cfg.Index] = nil 
                end)

                return setmetatable(Cfg, Library)
            end 

            Library.LerpObjects = function(self)
                YOffset = 0
                BiggestX = 0

                local Tick = tick()
                for _,Object in self.Notifications do
                    Object.Fade = Library:Lerp(Object.Fade, Object.Status and 255 or 0, 0.02)

                    if Tick - Object.Tick >= Object.Lifetime then 
                        Object.Status = false 
                    end     

                    local Instance = Object.Items.Notification.Instance

                    local Offset = UDim2.new(0, 30, 0, 80) 
                    local Transparency = 1 - (1 * (Object.Fade / 255))

                    Instance.Position = Offset + UDim2.new(0, -(Instance.AbsoluteSize.X - (Instance.AbsoluteSize.X * (Object.Fade / 255))), 0, YOffset)
                    Object:SetTransparency(Transparency)

                    if Object.Status and BiggestX < Instance.AbsoluteSize.X then
                        BiggestX = math.max(BiggestX, Instance.AbsoluteSize.X)
                    end

                    YOffset += (Instance.AbsoluteSize.Y + 6) * (Object.Fade / 255)
                end     
            end

            Library.SetTransparency = function(self, Num) 
                self.Items.Notification.Instance.GroupTransparency = Num
            end 
        end 

        do  
            local YOffset = 0 
            local BiggestX = 0 
            local KeybindListTransparency = 0 

            Library.AddHotKey = function(self, Data)
                Data = Data or {} 

                local Cfg = {
                    Lifetime = Data.Lifetime or 5; 

                    Items = {};
                    Status = true;
                    Fade = 2;
                    Tick = tick();
                    Index = #self.Keybinds + 1
                }   

                local Items = Cfg.Items; do 
                    Items.Keybind = Library:Create("CanvasGroup",{Parent = self.Window.Items.Elements.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; Size = UDim2.fromOffset(0, 19); AutomaticSize = Enum.AutomaticSize.None; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text or ""; Parent = Items.Keybind.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; RichText = true; TextWrapped = false; TextTruncate = Enum.TextTruncate.None; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 3); PaddingBottom = UDim.new(0, 3); Parent = Items.Keybind.Instance})
                end

                local function syncKeybindSize()
                    local title = Items.Title.Instance
                    if not title.Parent then return end
                    local bounds = title.TextBounds
                    local textWidth = math.ceil(math.max(bounds.X, title.AbsoluteSize.X))
                    local textHeight = math.ceil(math.max(bounds.Y, title.TextSize))
                    Cfg.TextWidth = textWidth + 10
                    local size = UDim2.fromOffset(Cfg.TextWidth, textHeight + 6)
                    if Items.Keybind.Instance.Size ~= size then
                        Items.Keybind.Instance.Size = size
                    end
                end
                for _, property in {"TextBounds", "TextSize", "FontFace"} do
                    Library:Connect(Items.Title.Instance:GetPropertyChangedSignal(property), syncKeybindSize)
                end
                Library:RegisterMainTextLayout(syncKeybindSize)

                function Cfg:ChangeText(Key, Name, Mode)
                    Items.Title.Instance.Text = string.format("[%s] %s (%s)", Key, Name, Mode)
                    syncKeybindSize()
                end

                function Cfg:SetEnabled(Bool)
                    Cfg.Status = Bool
                end

                self.Keybinds[Cfg.Index] = Cfg 

                return setmetatable(Cfg, Library)
            end 

            Library.LerpKeybinds = function(self)
                YOffset = 0
                BiggestX = 0

                if not self.Window or not self.Window.KeybindListVisible then 
                    return 
                end 

                local Tick = tick()
                for _,Object in self.Keybinds do
                    Object.Fade = Library:Lerp(Object.Fade, Object.Status and 255 or 0, 0.02)  
                    local Instance = Object.Items.Keybind.Instance

                    local Offset = UDim2.new(0, 1, 0, 0)  
                    local Transparency = 1 - (1 * (Object.Fade / 255))

                    Instance.Position = Offset + UDim2.new(0, -(Instance.AbsoluteSize.X - (Instance.AbsoluteSize.X * (Object.Fade / 255))), 0, YOffset)
                    Object:SetKeypickerTransparency(Transparency)

                    if Object.Status or Object.Fade > 1 then
                        BiggestX = math.max(BiggestX, Object.TextWidth or Instance.AbsoluteSize.X)
                    end

                    YOffset += (Instance.AbsoluteSize.Y + 5) * (Object.Fade / 255)
                end     

                local KbList = self.Window.Items.KeybindList.Instance 
                local Shown = BiggestX == 0
                KeybindListTransparency = Library:Lerp(KeybindListTransparency, Shown and 255 or 0, 0.05)

                if not Shown then                    
                    self.Window.Items.Elements.Instance.Size = UDim2.new(1, -8, 0, YOffset)
                    self.Window.Items.KeybindList.Instance.Size = UDim2.fromOffset(math.ceil(BiggestX + 17), math.ceil(YOffset + 29))
                end

                KbList.GroupTransparency = KeybindListTransparency / 255
            end

            Library.SetKeypickerTransparency = function(self, Num) 
                self.Items.Keybind.Instance.GroupTransparency = Num
            end 
        end 
    end

    do

        do
            Library.ConvertToHex = function(self, Color)
                local r = math.floor(Color.R * 255)
                local g = math.floor(Color.G * 255)
                local b = math.floor(Color.B * 255)
                return string.format("#%02X%02X%02X", r, g, b)
            end 

            Library.ConvertFromHex = function(self, Color)
                Color = Color:gsub("#", "")
                local r = tonumber(Color:sub(1, 2), 16) / 255
                local g = tonumber(Color:sub(3, 4), 16) / 255
                local b = tonumber(Color:sub(5, 6), 16) / 255
                return r, g, b
            end

            Library.GroupRGB = function(self, String)
                local Values = {}

                for Value in string.gmatch(String, "[^,]+") do
                    table.insert(Values, tonumber(Value))
                end

                if #Values == 3 then
                    return unpack(Values)
                else
                    return
                end
            end

            Library.ConvertEnum = function(self, enum)
                local EnumParts = {}

                for _, part in string.gmatch(tostring(enum), "[%w_]+") do
                    table.insert(EnumParts, part)
                end

                local EnumTable = tostring(enum)

                for i = 2, #EnumParts do
                    local EnumItem = EnumTable[EnumParts[i]]

                    EnumTable = EnumItem
                end

                return EnumTable
            end

            Library.Lerp = function(self, start, finish, t)
                t = t or 1 / 8

                return start * (1 - t) + finish * t
            end

            Library.Round = function(self, num, float)
                local Multiplier = 1 / (float or 1)
                return math.floor(num * Multiplier + 0.5) / Multiplier
            end

            Library.IsDecimal = function(self, Num)
                return math.floor(Num) ~= Num
            end

            Library.GetCalculatePosition = function(self, Position, Normal, Origin, Direction)
                local n = Normal;
                local d = Direction;
                local v = Origin - Position;

                local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);  
                local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
                local a = -num / den;

                return Origin + (a * Direction);
            end
        end

        do
            Library.Create = function(self, Class, Options)
                local Info = {
                    Instance = Instance.new(Class),
                    Properties = Options,
                    Tweening = false,
                    Blur,
                }

                local Instance = Info.Instance
                local Mt = setmetatable(Info, Library)

                for Property, Value in Info.Properties do
                    if Property == "Parent" or Property == "ScrollingBarImageColor3" then
                        continue 
                    end 

                    Instance[Property] = Value
                end

                if Class == "TextButton" then
                    Instance.AutoButtonColor = false
                    Instance.Text = ""
                end

                if Class == "ScrollingFrame" then 
                    Instance.ScrollBarImageColor3 = Themes.Preset.Accent
                    Mt:Themify("Accent", "ScrollBarImageColor3")
                end 

                if Class == "TextLabel" or Class == "TextBox" or Class == "TextButton" then
                    Instance.FontFace = Info.Properties.FontFace or Fonts.Main
                    Instance.TextSize = Info.Properties.TextSize or 12

                    if (not Info.Properties["TextColor3"]) then 
                        Instance.TextColor3 = Themes.Preset.TextMain
                    end
                end

                if Class == "ScreenGui" then
                    table.insert(self.Guis, Instance)
                end

                if Class == "UIGradient" then 
                    local KeyPoints = Instance.Color.Keypoints

                    for _,KeyPoint in KeyPoints do 
                        local Color = Color3ToRGB(KeyPoint.Value)

                        if #KeyPoints > 2 then 
                            break
                        end 

                        for Name,Value in Themes.Preset do 
                            if Color3ToRGB(Value) == Color then 
                                if not table.find(Themes.GradientsThemes, Name) then 
                                    table.insert(Themes.GradientsThemes, Name)
                                end

                                Mt:Themify(Name, "Color")
                            end 
                        end
                    end 
                end 

                local ColorProperties = Library:GetColors(Instance)

                if ColorProperties then 
                    for _,Property in ColorProperties do 
                        local Color = Color3ToRGB(Instance[Property])

                        for Name,Value in Themes.Preset do 
                            if Color3ToRGB(Value) == Color then 
                                Mt:Themify(Name, Property)
                            end 
                        end
                    end 
                end 

                Instance.Name = "\0"
                -- Attach fully styled objects once, rather than invalidating a live
                -- layout for each property applied during construction.
                Instance.Parent = Info.Properties.Parent

                return Mt
            end

            Library.AddGlow = function(self, Options)
                Options = Options or {} 

                local Cfg = {
                    Amount = Options.Amount or 5;
                    DampingFactor = Options.DampingFactor or 0.4;
                    Parent = self.Instance;
                    Items = {};
                }   

                local Items = Cfg.Items; 

                for Outline = 0, Cfg.Amount do  
                    Items[tostring(Outline)] = Library:Create( "UIStroke", {
                        Parent = self.Instance;
                        Color = Color3.fromRGB(255, 255, 255);
                        LineJoinMode = Enum.LineJoinMode.Round;
                        BorderOffset = UDim.new(0, Outline);
                        Transparency = (Outline / (Cfg.Amount + Cfg.DampingFactor))
                    })

                    Library:Create( "UIGradient", {
                        Parent = Items[tostring(Outline)].Instance;
                        Transparency = NumberSequence.new{
                            NumberSequenceKeypoint.new(0, Cfg.DampingFactor),
                            NumberSequenceKeypoint.new(1, Cfg.DampingFactor)
                        }
                    })
                end

                table.insert(Library.Glows, Cfg)

                return self
            end

            Library.Resizify = function(self)
                local Instance = self.Instance

                local Resizing = Library:Create("TextButton", {
                    Position = UDim2.new(1, -10, 1, -10),
                    Size = UDim2.new(0, 10, 0, 10),
                    BorderSizePixel = 0,
                    Parent = Instance,
                    BackgroundTransparency = 1,
                    ZIndex = 9e9,
                    Text = ""
                })

                local IsResizing = false
                local Size;
                local InputLost;
                local ParentSize = Instance.Size

                Resizing.Instance.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        IsResizing = true
                        InputLost = Input.Position
                        Size = Instance.Size
                    end
                end)

                Resizing.Instance.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        IsResizing = false
                    end
                end)

                Library:Connect(Services.UserInputService.InputChanged, function(Input, game_event)
                    if IsResizing and Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                        self:Tween({
                            Size = UDim2.new(
                                Size.X.Scale,
                                math.clamp(Size.X.Offset + (Input.Position.X - InputLost.X), ParentSize.X.Offset,
                                    Camera.ViewportSize.X),
                                Size.Y.Scale,
                                math.clamp(Size.Y.Offset + (Input.Position.Y - InputLost.Y), ParentSize.Y.Offset,
                                    Camera.ViewportSize.Y)
                            )
                        }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                    end
                end)

                return self
            end

            Library.Hovering = function(self, point)
                if not (self and self.Instance) then return false end
                local ancestor = self.Instance
                while ancestor do
                    if ancestor:IsA("GuiObject") and not ancestor.Visible then return false end
                    if ancestor:IsA("ScreenGui") and not ancestor.Enabled then return false end
                    ancestor = ancestor.Parent
                end
                point = point or Services.UserInputService:GetMouseLocation()
                point -= Services.GuiService:GetGuiInset()
                local position, size = self.Instance.AbsolutePosition, self.Instance.AbsoluteSize
                return point.X >= position.X and point.X <= position.X + size.X
                    and point.Y >= position.Y and point.Y <= position.Y + size.Y
            end

            Library.CheckHoveredItems = function(self, Cfg, Items)
                local Connection = Library:Connect(Services.UserInputService.InputBegan, function(Input)
                    if self.Instance.Visible == false or Cfg.Open == false then
                        return
                    end

                    local InputType = Input.UserInputType

                    if not (InputType == Enum.UserInputType.MouseButton1 or InputType == Enum.UserInputType.Touch) then
                        return
                    end

                    local Objects = Library.Items.Instance:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y + GuiInset)

                    if not Items then
                        if not table.find(Objects, self.Instance) then
                            Cfg.SetVisible(false)
                        end
                    else
                        local Pass = true

                        for _, Item in Items do
                            if not table.find(Objects, Item.Instance) then
                                Pass = false
                            end
                        end
                    end

                    Cfg.SetVisible(Pass)
                end)

                return self
            end

            Library.LightweightWindowDrag = true
            Library.Draggify = function(self)
                local library = Library
                local instance = self.Instance
                local dragging = false
                local dragInput
                local startPointer
                local latestPointer
                local startPosition
                local lastPosition
                local preview
                local dragTarget
                local originalVisible
                local dragTask
                local destroyed = false

                local function clearPreview(commit)
                    if preview then
                        if commit and instance.Parent and dragTarget then
                            instance.Position = dragTarget
                        end
                        preview:Destroy()
                        preview = nil
                        dragTarget = nil
                        if instance.Parent and not destroyed and not library.Unloaded then
                            instance.Visible = originalVisible
                        end
                    end
                end

                local function stopDragging(commit)
                    if not dragging then return end
                    dragging = false
                    library.Dragging = false
                    dragInput = nil
                    dragTask:Stop()
                    clearPreview(commit ~= false)
                end

                library:Connect(instance.InputBegan, function(input)
                    local kind = input.UserInputType
                    if destroyed or library.Unloaded or library.Dragging or
                        (kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.Touch) then
                        return
                    end
                    dragging = true
                    library.Dragging = true
                    dragInput = input
                    startPointer = input.Position
                    latestPointer = startPointer
                    startPosition = instance.Position
                    lastPosition = startPosition
                    originalVisible = instance.Visible
                    if library.LightweightWindowDrag and instance.Name == "GamehaxxMainWindow" then
                        local ghost = Instance.new("Frame")
                        ghost.Name = "GamehaxxDragPreview"
                        ghost.Size = instance.Size
                        ghost.Position = instance.Position
                        ghost.BackgroundColor3 = Color3.fromRGB(19, 19, 27)
                        ghost.BackgroundTransparency = 0
                        ghost.BorderSizePixel = 0
                        ghost.ZIndex = 30
                        ghost.Active = false
                        local stroke = Instance.new("UIStroke")
                        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        stroke.Color = library.Themes.Preset.Accent
                        stroke.Thickness = 1
                        stroke.Parent = ghost
                        local label = Instance.new("TextLabel")
                        label.BackgroundTransparency = 1
                        label.Text = library.Window and library.Window.Title or "gamehaxx"
                        label.TextColor3 = Color3.fromRGB(225, 225, 235)
                        label.TextXAlignment = Enum.TextXAlignment.Left
                        label.Font = Enum.Font.Code
                        label.TextSize = 12
                        label.Size = UDim2.new(1, -12, 0, 19)
                        label.Position = UDim2.fromOffset(6, 1)
                        label.ZIndex = 31
                        label.Parent = ghost
                        local line = Instance.new("Frame")
                        line.Name = "DragPreviewTitleRule"
                        line.BorderSizePixel = 0
                        line.BackgroundColor3 = library.Themes.Preset.Accent
                        line.Position = UDim2.fromOffset(5, 21)
                        line.Size = UDim2.new(1, -10, 0, 1)
                        line.ZIndex = 31
                        line.Parent = ghost
                        ghost.Parent = instance.Parent
                        preview = ghost
                        dragTarget = instance.Position
                        instance.Visible = false
                        for owner, popup in library.PopupOwners or {} do
                            if popup.Visible then
                                popup.Visible = false
                                owner.Open = false
                            end
                        end
                    end
                    dragTask:Start()
                end)

                library:Connect(Services.UserInputService.InputChanged, function(input)
                    if not dragging then return end
                    if input.UserInputType == Enum.UserInputType.MouseMovement or input == dragInput then
                        latestPointer = input.Position
                    end
                end)

                local function move()
                    local delta = latestPointer - startPointer
                    local nextPosition = UDim2.new(
                        startPosition.X.Scale, startPosition.X.Offset + math.round(delta.X),
                        startPosition.Y.Scale, startPosition.Y.Offset + math.round(delta.Y)
                    )
                    if nextPosition ~= lastPosition then
                        if preview then
                            preview.Position = nextPosition
                            dragTarget = nextPosition
                        else
                            instance.Position = nextPosition
                        end
                        lastPosition = nextPosition
                    end
                end
                dragTask = library:CreateRenderTask(function()
                    if not dragging then dragTask:Stop(); return end
                    if destroyed or library.Unloaded or not instance.Parent then
                        stopDragging(false)
                        return
                    end
                    move()
                end, 1 / 60)
                -- Commit the newest cursor position even when release falls between frames.
                library:Connect(Services.UserInputService.InputEnded, function(input)
                    if dragging and (input == dragInput or
                        (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and
                        input.UserInputType == Enum.UserInputType.MouseButton1)) then
                        move()
                        stopDragging()
                    end
                end)
                library:Connect(Services.UserInputService.WindowFocusReleased, stopDragging)
                library:Connect(instance.Destroying, function()
                    destroyed = true
                    stopDragging(false)
                end)

                return self
            end

            Library.ClampToScreen = function(self)
                local Parent = self
                local Horizontal = Camera.ViewportSize.X
                local Vertical = Camera.ViewportSize.Y

                local ClampedPosition = UDim2.new(
                    0,
                    math.clamp(
                        Parent.Instance.Position.X.Offset,
                        0,
                        Horizontal - Parent.Instance.Size.X.Offset
                    ),
                    0,
                    math.clamp(
                        Parent.Instance.Position.Y.Offset,
                        0,
                        Vertical - Parent.Instance.Size.Y.Offset
                    )
                )

                if Parent.Instance.Position ~= ClampedPosition then
                    Parent:Tween({Position = ClampedPosition}, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                end
            end

            Library.OnClick = function(self, Callback)
                local Connection = Library:Connect(self.Instance.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        Callback()
                    end
                end)

                return Connection
            end

            Library.OnRightClick = function(self, Callback)
                local Connection = Library:Connect(self.Instance.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.Touch then
                        Callback()
                    end
                end)

                return self
            end

            Library.OnHover = function(self, Callback1, Callback2)
                Callback2 = Callback2 or function() end

                Library:Connect(self.Instance.MouseEnter, function()
                    Callback1()
                end)

                Library:Connect(self.Instance.MouseLeave, function()
                    Callback2()
                end)

                return self
            end

            Library.OnDrag = function(self, Callback1, Callback2)
                local Dragging = false
                Callback2 = Callback2 or function() end

                self.Instance.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        Callback2(Dragging)
                    end
                end)

                Library:Connect(Services.UserInputService.InputEnded, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                        Callback2(Dragging)
                    end
                end)

                Library:Connect(Services.UserInputService.InputChanged, function(Input)
                    if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                        Callback1(Input)
                    end
                end)

                return self
            end

            Library.Reparent = function(self, Parent)
                Parent = Parent or self.Instance.Parent

                local Connection = Library:Connect(self.Instance:GetPropertyChangedSignal("Visible"), function()
                    local object = self.Instance

                    if not object.Parent or not Library then return end
                    local destination = object.Visible and Parent or (Library.Other and Library.Other.Instance)
                    if destination and destination.Parent then object.Parent = destination end
                end)

                return self
            end

            Library.OutsideClick = function(self, Cfg, Functions)
                if Cfg and Cfg.Colorpickers and Cfg.Items and Cfg.Items.Outline then
                    return self
                end
                Library:Connect(Services.UserInputService.InputBegan, function(Input)
                    local InputType = Input.UserInputType
                    if not (InputType == Enum.UserInputType.MouseButton1 or InputType == Enum.UserInputType.Touch) then
                        return
                    end
                    local point = InputType == Enum.UserInputType.Touch
                        and Vector2.new(Input.Position.X, Input.Position.Y)
                        or Services.UserInputService:GetMouseLocation()

                    task.defer(function()
                        if not self.Instance.Parent or not self.Instance.Visible or not Cfg.Open then return end
                        if os.clock() - (Cfg.ReferenceOpenedAt or 0) < 0.08 then return end
                        if self:Hovering(point) then return end
                        local trigger = Cfg.Items and (Cfg.Items.Object or Cfg.Items.Value)
                        if trigger and trigger:Hovering(point) then return end
                        for _, isHovering in Functions or {} do
                            if isHovering() then return end
                        end
                        Cfg.SetVisible(false)
                    end)
                end)
                return self
            end

            Library.Blurify = function(self, Strength)
                Strength = Strength or 0.90

                local Instance = self.Instance
                self.Strength = Strength

                local Part = Library:Create("Part", {
                    Material = Enum.Material.Glass,
                    Transparency = Strength,
                    Reflectance = 1,
                    CastShadow = false,
                    Anchored = true,
                    CanCollide = false,
                    CanQuery = false,
                    CollisionGroup = " ",
                    Size = Vector3.new(1, 1, 1) * 0.01,
                    Color = Color3.fromRGB(0, 0, 0),
                    Parent = Camera,
                });

                local BlockMesh = Library:Create("BlockMesh", {
                    Parent = Part.Instance,
                })

                local DepthOfField = Library:Create("DepthOfFieldEffect", {
                    Parent = Services.Lighting,
                    Enabled = true,
                    FarIntensity = 0,
                    FocusDistance = 0,
                    InFocusRadius = 1000,
                    NearIntensity = 1,
                    Name = ""
                })

                Library:Connect(Services.RunService.RenderStepped, function()
                    if not self.Instance.Visible then 
                        Part.Transparency = 1
                        Part.Instance.CFrame = CFrame.new(0/0, 9e9, 9e9)
                        return 
                    end    

                    local Corner0 = Instance.AbsolutePosition;
                    local Corner1 = Corner0 + Instance.AbsoluteSize;

                    local Ray0 = Workspace.CurrentCamera.ScreenPointToRay(Workspace.CurrentCamera,Corner0.X, Corner0.Y, 1);
                    local Ray1 = Workspace.CurrentCamera.ScreenPointToRay(Workspace.CurrentCamera,Corner1.X, Corner1.Y, 1);

                    local Origin = Workspace.CurrentCamera.CFrame.Position + Workspace.CurrentCamera.CFrame.LookVector * (0.05 - Workspace.CurrentCamera.NearPlaneZ);

                    local Normal = Workspace.CurrentCamera.CFrame.LookVector;

                    local Pos0 = Library:GetCalculatePosition(Origin, Normal, Ray0.Origin, Ray0.Direction);
                    local Pos1 = Library:GetCalculatePosition(Origin, Normal, Ray1.Origin, Ray1.Direction);

                    Pos0 = Workspace.CurrentCamera.CFrame:PointToObjectSpace(Pos0);
                    Pos1 = Workspace.CurrentCamera.CFrame:PointToObjectSpace(Pos1);

                    local Size = Pos1 - Pos0;
                    local Center = (Pos0 + Pos1) / 2;

                    BlockMesh.Instance.Offset = Center
                    BlockMesh.Instance.Scale  = Size / 0.0101;

                    Part.Instance.CFrame = Workspace.CurrentCamera.CFrame;
                    Part.Instance.Transparency = self.Strength
                end)

                return self
            end
        end

        do
            Library.GetTransparency = function(self, obj)
                local Instance = obj

                if Instance:IsA("Frame") or Instance:IsA("CanvasGroup") then
                    return { "BackgroundTransparency" }
                elseif Instance:IsA("TextLabel") or Instance:IsA("TextButton") then
                    return { "TextTransparency", "BackgroundTransparency" }
                elseif Instance:IsA("ImageLabel") or Instance:IsA("ImageButton") then
                    return { "BackgroundTransparency", "ImageTransparency" }
                elseif Instance:IsA("ScrollingFrame") then
                    return { "BackgroundTransparency", "ScrollBarImageTransparency" }
                elseif Instance:IsA("TextBox") then
                    return { "TextTransparency", "BackgroundTransparency" }
                elseif Instance:IsA("UIStroke") then
                    return { "Transparency" }
                elseif Instance:IsA("BasePart") then
                    return { "Transparency" }
                end

                return nil
            end

            Library.GetColors = function(self, obj)
                local Instance = obj

                if Instance:IsA("Frame") or Instance:IsA("CanvasGroup") then
                    return { "BackgroundColor3" }
                elseif Instance:IsA("TextLabel") or Instance:IsA("TextButton") then
                    return { "TextColor3", "BackgroundColor3" }
                elseif Instance:IsA("ImageLabel") or Instance:IsA("ImageButton") then
                    return { "BackgroundColor3", "ImageColor3" }
                elseif Instance:IsA("ScrollingFrame") then
                    return { "BackgroundColor3", "ScrollBarImageColor3" }
                elseif Instance:IsA("TextBox") then
                    return { "TextColor3", "BackgroundColor3" }
                elseif Instance:IsA("UIStroke") then
                    return { "Color" }
                elseif Instance:IsA("BasePart") then
                    return { "Color" }
                end

                return nil
            end

            Library.Tween = function(self, Properties, Info, Obj)
                local Instance = self.Instance or Obj

                local Tween = Services.TweenService:Create(Instance,
                    Info or
                    TweenInfo.new(Library.TweeningSpeed, Library.EasingStyle, Enum.EasingDirection.Out, 0, false, 0),
                    Properties)
                Tween:Play()    

                if table.find(Properties, "TextColor3") then 
                    Tween.Completed:Connect(function()
                        print("Nigga")
                        self.Instance.TextColor3 = Properties.TextColor3
                    end)
                end

                return Tween
            end

            Library.Fade = function(self, obj, prop, vis)
                if not (prop and obj) then
                    return
                end

                local OldTransparency = obj[prop]
                obj[prop] = vis and 1 or OldTransparency

                local Animation = Library:Tween({ [prop] = vis and OldTransparency or 1 }, nil, obj)
                Library:Connect(Animation.Completed, function()
                    if not vis then
                        obj[prop] = OldTransparency
                    end
                end)

                return Animation
            end

            Library.TweenDescendants = function(self, Bool, Path)
                Path = Path or { Tweening = false }

                if Path.Tweening == true then
                    return
                end

                local Instance = self.Instance
                Path.Tweening = true

                if Bool then
                    if Instance:IsA("ScreenGui") then 
                        Instance.Enabled = true
                    else 
                        Instance.Visible = true
                    end 
                end

                local Children = Instance:GetDescendants()
                table.insert(Children, Instance)

                if self.Blur then
                    table.insert(Children, self.Blur)
                end

                local FadingAnimation;
                for _, obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then
                        continue
                    end

                    if type(Index) == "table" then
                        for _, prop in Index do
                            FadingAnimation = Library:Fade(obj, prop, Bool)
                        end
                    else
                        FadingAnimation = Library:Fade(obj, Index, Bool)
                    end
                end

                Library:Connect(FadingAnimation.Completed, function()
                    Path.Tweening = false
                    if Instance:IsA("ScreenGui") then 
                        Instance.Enabled = Bool
                    else 
                        Instance.Visible = Bool
                    end 
                end)
            end
        end

        do
            Library.CreateConfigButton = function(self, Data)
                Data = Data or {} 

                local Cfg = {
                    Name = Data.Name or Data.Text or "Config";
                    MakeConfig = Data.MakeConfig or true;
                    Selected = false;
                    Items = {};
                    Configs = self.Configs;
                } 

                local Items = Cfg.Items; do 
                    Items.NewConfig = Library:Create( "TextButton", {
                        TextColor3 = Color3.fromRGB(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        Parent = self.Items.Content.Instance;
                        Size = UDim2.new(1, 0, 0, 30);
                        BorderSizePixel = 0;
                        BackgroundColor3 = Themes.Preset["ElementBackground"]
                    }):Themify("ElementBackground", "BackgroundColor3")

                    Library:Create( "UICorner", {
                        Parent = Items.NewConfig.Instance
                    })

                    Items.Stroke = Library:Create( "UIStroke", {
                        Color = Themes.Preset.ConfigOutline;
                        Parent = Items.NewConfig.Instance;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):Themify("ConfigOutline", "Color"):Themify("Accent", "Color")

                    Items.LoadButton = Library:Create( "ImageButton", {
                      ImageColor3 = Color3.fromRGB(200, 200, 207);
                        Parent = Items.NewConfig.Instance;
                        AutoButtonColor = false;
                        AnchorPoint = Vector2.new(1, 0.5);
                        Image = "rbxassetid://126165013650337";
                        BackgroundTransparency = 1;
                        Position = UDim2.new(1, -8, 0.5, -1);
                        Size = UDim2.new(0, 20, 0, 20);
                        BorderSizePixel = 0;
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    Items.OverwriteButton = Library:Create( "ImageButton", {
                        ImageColor3 = Color3.fromRGB(200, 200, 207);
                        Parent = Items.NewConfig.Instance;
                        AutoButtonColor = false;
                        AnchorPoint = Vector2.new(1, 0.5);
                        Image = "rbxassetid://77237686348397";
                        BackgroundTransparency = 1;
                        Position = UDim2.new(1, -34, 0.5, -1);
                        Size = UDim2.new(0, 20, 0, 20);
                        BorderSizePixel = 0;
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    Items.DeleteIcon = Library:Create( "ImageButton", {
                        ImageColor3 = Color3.fromRGB(200, 200, 207);
                        Parent = Items.NewConfig.Instance;
                        AutoButtonColor = false;
                        AnchorPoint = Vector2.new(1, 0.5);
                        Image = "rbxassetid://106573800301941";
                        BackgroundTransparency = 1;
                        Position = UDim2.new(1, -59, 0.5, -1);
                        Size = UDim2.new(0, 18, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })

                    Items.ConfigName = Library:Create( "TextBox", {
                        Active = false;
                        Interactable = true;
                        AnchorPoint = Vector2.new(0, 0.5);
                        Size = UDim2.new(1, -90, 1, 0);
                        Parent = Items.NewConfig.Instance;
                        ClipsDescendants = true;
                        Text = Cfg.Name;
                        Selectable = true;
                        Position = UDim2.new(0, 10, 0.5, -1);
                        TextColor3 = Color3.fromRGB(200, 200, 207);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        ClearTextOnFocus = false;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    })
                end 

                local Button = setmetatable(Cfg, Library)

                function Cfg:SetVisible(Bool)
                    Items.NewConfig.Instance.Visible = Bool
                end 

                function Cfg:SetName(Text)
                    if Text == Cfg.Name then
                        return 
                    end 

                    local OldName = Cfg.Name

                    Cfg.Name = Text
                    Items.ConfigName.Instance.Text = Text

                    Library:ResaveConfig(Text, OldName);

                    Library:DeleteConfig(OldName)
                end

                Cfg.DestroyButton = function(Config) 
                    if Config then
                        Library:DeleteConfig(Cfg.Name)
                    end

                    Items.NewConfig.Instance:Destroy()

                    table.remove(Cfg.Configs, Cfg.Index)
                end

                Items.DeleteIcon:OnClick(function()
                    Cfg.DestroyButton(true)
                end)

                Items.LoadButton:OnClick(function()
                    if self.OldConfig then 
                        local OldItems = self.OldConfig.Items
                        OldItems.Stroke:Tween({Color = Themes.Preset.ConfigOutline})
                    end

                    Library:LoadConfig(Cfg.Name);
                    Items.Stroke:Tween({Color = Themes.Preset.Accent})

                    self.OldConfig = Button;
                end)

                Items.OverwriteButton:OnClick(function()
                    writefile(string.format("%s/%s/%s.Cfg", Library.Directory, "Configs", Cfg.Name), Returner or Library:GetConfig())
                end)

                Items.ConfigName.Instance.FocusLost:Connect(function()
                    Cfg:SetName(Items.ConfigName.Instance.Text)
                end)

                if Cfg.MakeConfig then 
                    Library:ResaveConfig(Cfg.Name, Cfg.Name);
                end 

                Cfg.Index = table.insert(self.Configs, Button)

                return Button
            end 

            Library.GetConfig = function(self)
                self:EnsureReferenceDeferredTabs()
                local Config = {}

                for Idx, Value in Flags do
                    if type(Value) == "table" and Value.Key then
                        Config[Idx] = {Active = Value.Active, Mode = Value.Mode, Key = tostring(Value.Key)}
                    elseif type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                        Config[Idx] = {Transparency = Value["Transparency"], Color = Value["Color"]:ToHex()}
                    else
                        Config[Idx] = Value
                    end
                end 

                return Services.HttpService:JSONEncode(Config)
            end

            Library.LoadConfig = function(self, JSON) 
                local Config = Services.HttpService:JSONDecode(JSON)
                self:EnsureReferenceDeferredTabs()

                for Idx, Value in Config do  
                    local Function = ConfigFlags[Idx]

                    if string.find(Idx, "_RGB") or string.find(Idx, "_ALPHA") then 
                        continue 
                    end 

                    if Function then 
                        if type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                            Function(Color3.fromHex(Value["Color"]), Value["Transparency"])
                        else 
                            Function(Value)
                        end
                    end 
                end 
            end 

            Library.DeleteConfig = function(self, Config)
                local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Configs", Config)
                if isfile(Path) then 
                    delfile(Path)
                end
            end

            Library.SaveConfig = function(self, Config)
                if Config == "" then 
                    return 
                end 

                local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Configs", Config)
                writefile(Path, self:GetConfig())
            end

            Library.AutoLoad = function(self)
                self.Window.Tweening = true 
                local Name = readfile(self.Directory.."/Autoload.txt")

                if Name ~= "" then 
                    for i = 1, 2 do 
                        self:LoadConfig(readfile(self.Directory .. "/Configs/" .. Name .. ".Cfg"))
                    end 
                end 
                self.Window.Tweening = false 
            end 

            Library.UpdateConfigList = function(self) 
                local List = {}

                for _, File in listfiles(Library.Directory .. "/Configs") do
                    local Name = File:gsub(Library.Directory .. "/Configs\\", ""):gsub(".Cfg", ""):gsub(Library.Directory .. "\\Configs\\", "")
                    List[#List + 1] = Name
                end

                self:RefreshList(List)
            end 

            Library.NextFlag = function(self)
                self.FlagCount += 1
                local String = "Flag "..tostring(self.FlagCount)

                return String
            end 
        end

        do
            Library.Thread = function(self, Function)
                local Thread = coroutine.create(Function)

                coroutine.wrap(function()
                    coroutine.resume(Thread)
                end)()

                table.insert(self.Threads, Thread)

                return Thread
            end

            Library.SafeCall = function(self, Function, ...)
                local Arguments = { ... }
                local Success, Result = pcall(Function, table.unpack(Arguments))

                if not Success then
                    warn(Result)
                    return false
                end

                return Success
            end

            Library.Connect = function(self, Signal, Callback)
                local ConnectionInfo = {
                    Event = Signal,
                    Callback = Callback,
                    Connection = Signal:Connect(Callback),
                }

                table.insert(self.Connections, ConnectionInfo)

                return ConnectionInfo
            end

            -- Animation work subscribes only while it is moving. Keep one tracked
            -- record across restarts instead of retaining a new connection each time.
            Library.CreateRenderTask = function(self, Callback, Interval)
                local Owner = self
                local Info = {Event = Services.RunService.RenderStepped, Callback = Callback,
                    Interval = Interval or 0, Elapsed = 0}
                table.insert(self.Connections, Info)
                function Info:Stop()
                    if self.Connection then self.Connection:Disconnect(); self.Connection = nil end
                    self.Elapsed = 0
                end
                function Info:Start()
                    if Owner.Unloaded or Owner.Unloading or self.Connection then return end
                    self.Connection = self.Event:Connect(function(dt)
                        if Owner.Unloaded or Owner.Unloading then self:Stop(); return end
                        self.Elapsed += dt
                        if self.Elapsed < self.Interval then return end
                        local elapsed = self.Elapsed
                        self.Elapsed = self.Interval > 0 and (self.Elapsed % self.Interval) or 0
                        Callback(elapsed)
                    end)
                end
                return Info
            end

            Library.Delay = function(self)
                task.spawn(function()
                    self.Tweening = true
                    task.wait()
                    self.Tweening = false
                end)

                return self
            end

            Library.Unload = function(self)
                if self.Unloaded or self.Unloading then return end
                self.Unloading = true
                repeat task.wait() until #self.Notifications == 0
                self.Unloaded = true

                for Index, Value in self.Connections do
                    if Value.Stop then
                        Value:Stop()
                    elseif Value.Connection then
                        Value.Connection:Disconnect()
                        Value.Connection = nil
                    end
                end

                for Index, Value in self.Threads do
                    if Value ~= coroutine.running() and coroutine.status(Value) ~= "dead" then
                        local cancelled = pcall(task.cancel, Value)
                        if not cancelled then pcall(coroutine.close, Value) end
                    end
                end

                for _, Item in self.Guis do
                    if Item then
                        Item:Destroy()
                        Item = nil
                    end
                end

                for _,Instance in self.Blurs do 
                    Instance:Destroy()
                end         

                Library = nil
                getgenv().Library = nil
            end
        end
    end

    do
        Library.Items = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true, DisplayOrder = 100});
        Library.HUD = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = true, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 1000001});
        Library.Other = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true});
        Library.Elements = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true, DisplayOrder = 101});

        Library.CreateWindow = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Prefix = Data.Prefix or "perona", 
                Suffix = Data.Suffix or "hax",
                Title = Data.Title or ((Data.Prefix or "perona") .. (Data.Suffix or "hax")),

                Size = Data.Size or UDim2.new(0, 506, 0, 661),

                TabInfo,

                Tweening = false,
                Open = true,
                KeybindListVisible = false,
                WatermarkVisible = Data.WatermarkVisible ~= false,

                Items = {},
                KeybindElements = {},

                Sections = {},
                PageCount = 0;
            }; Library.Window = setmetatable(Cfg, Library);

            local Items = Cfg.Items; do
                Items.Menu = Library:Create("Frame",{Visible = Data.StartHidden ~= true, AnchorPoint = Vector2.new(0.5, 0.5); Parent = Library.Items.Instance; Position = UDim2.fromScale(0.5, 0.5); Size = Cfg.Size; BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3"):Draggify():Resizify()
                Items.Menu.Instance.Position = UDim2.fromOffset(Items.Menu.Instance.AbsolutePosition.X, Items.Menu.Instance.AbsolutePosition.Y)
                Items.Menu.Instance.AnchorPoint = Vector2.new(0, 0)

                Items.Inline = Library:Create("Frame",{Parent = Items.Menu.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(29, 29, 29)})

                Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.Accent; Text = Cfg.Title; Parent = Items.Background.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 3, 0, 5); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "TextColor3")
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.PageHolderOutline = Library:Create("Frame",{Parent = Items.Background.Instance; Position = UDim2.new(0, 3, 0, 22); Size = UDim2.new(1, -6, 1, -25); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.PageHolderInline = Library:Create("Frame",{Parent = Items.PageHolderOutline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.BackgroundInner = Library:Create("Frame",{Parent = Items.PageHolderInline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageBackground"]}):Themify("PageBackground", "BackgroundColor3")

                Items.TabButtonOutline = Library:Create("Frame",{Parent = Items.BackgroundInner.Instance; ClipsDescendants = true; Size = UDim2.new(1, 0, 0, 25); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(17, 17, 17)})
                Items.InlineLine = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; Position = UDim2.new(0, 0, 1, -1); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.OutlineLine = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; Position = UDim2.new(0, 0, 1, -2); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.TabButtonHolder = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, -2); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.TabButtonHolder.Instance; Padding = UDim.new(0, 1); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})

                Items.KeybindList = Library:Create("CanvasGroup",{GroupTransparency = 1; Visible = true; Parent = Library.HUD.Instance; Size = UDim2.new(0, 200, 0, 100); Position = UDim2.new(0, 30, 0, 350); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3"):Draggify()
                Items.Inline = Library:Create("Frame",{Parent = Items.KeybindList.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["SectionBackground"]}):Themify("SectionBackground", "BackgroundColor3")
                Items.Topbar = Library:Create("Frame",{Parent = Items.Background.Instance; Size = UDim2.new(1, 0, 0, 21); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.KeybindListTitle = Library:Create("TextLabel",{TextColor3 = Themes.Preset["Accent"]; Text = 'key<font color = "rgb(255, 255, 255)">binds</font>'; Parent = Items.Topbar.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 4, 0, 4); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "TextColor3")
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.KeybindListTitle.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.Holder = Library:Create("Frame",{Parent = Items.Topbar.Instance; Position = UDim2.new(0, 1, 1, -1); Size = UDim2.new(1, -2, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Inline"]}):Themify("Inline", "BackgroundColor3")
                Items.UIGradient = Library:Create("UIGradient",{Parent = Items.Holder.Instance; Transparency = NumSeq{NumKey(0, 0), NumKey(0.25, 0.75), NumKey(0.5, 1), NumKey(0.75, 0.75), NumKey(1, 0)}})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Topbar.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Elements = Library:Create("Frame",{Parent = Items.Background.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 4, 0, 25); Size = UDim2.new(1, -8, 0, -10); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})

                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Elements.Instance})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.KeybindList.Instance})

                Items.Watermark = Library:Create("CanvasGroup",{Name = "ReferenceWatermark"; Visible = Data.StartHidden ~= true; GroupTransparency = Cfg.WatermarkVisible and 0 or 1; Parent = Library.HUD.Instance; Size = UDim2.fromOffset(186, 24); Position = Data.WatermarkPosition or UDim2.fromOffset(44, 44); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.None; BackgroundColor3 = Themes.Preset.Accent; ClipsDescendants = false; ZIndex = 2}):Themify("Accent", "BackgroundColor3"):Draggify()
                Items.WatermarkInline = Library:Create("Frame",{Parent = Items.Watermark.Instance; Position = UDim2.fromOffset(1, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(28, 27, 34)})
                Items.WatermarkBackground = Library:Create("Frame",{Parent = Items.WatermarkInline.Instance; Position = UDim2.fromOffset(1, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.new(1, 1, 1)})
                Items.WatermarkGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.WatermarkBackground.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(22, 21, 28)), ColorKey(1, Color3.fromRGB(18, 17, 24))}})
                Items.WatermarkTitle = Library:Create("TextLabel",{TextColor3 = Color3.fromRGB(235, 235, 250); Text = Cfg.Title .. " - 0 fps - 0 ping"; Parent = Items.WatermarkBackground.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.fromOffset(5, 2); Size = UDim2.new(1, -10, 1, -4); TextXAlignment = Enum.TextXAlignment.Left; TextYAlignment = Enum.TextYAlignment.Center; RichText = false; AutomaticSize = Enum.AutomaticSize.None; TextWrapped = false; TextTruncate = Enum.TextTruncate.None})
                Items.WatermarkStroke = Library:Create("UIStroke",{Parent = Items.WatermarkTitle.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Color = Color3.new(0, 0, 0); Thickness = 1})

                Items.WatermarkGlowHolder = Library:Create("CanvasGroup",{Parent = Library.HUD.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; Active = false; ZIndex = 1; ClipsDescendants = false; GroupTransparency = Items.Watermark.Instance.GroupTransparency})
                Items.WatermarkGlow = Library:Create("ImageLabel",{Parent = Items.WatermarkGlowHolder.Instance; Name = "WatermarkGlow"; BackgroundTransparency = 1; BorderSizePixel = 0; Active = false; Size = UDim2.fromScale(1, 1); Image = "rbxassetid://18245826428"; ImageColor3 = Themes.Preset.Accent; ImageTransparency = Data.WatermarkGlowTransparency or 0.8; ScaleType = Enum.ScaleType.Slice; SliceCenter = Rect.new(21, 21, 79, 79); SliceScale = 0.7; ZIndex = 1}):Themify("Accent", "ImageColor3")
                Library:RegisterGlow("Main", Items.WatermarkGlow, Data.WatermarkGlowTransparency)
                local function syncWatermarkGlow()
                    local root, holder = Items.Watermark.Instance, Items.WatermarkGlowHolder.Instance
                    local position = root.Position + UDim2.fromOffset(-14, -14)
                    local size = root.Size + UDim2.fromOffset(28, 28)
                    local visible = root.Visible and root.Parent ~= nil and root.GroupTransparency < 1
                    if holder.Position ~= position then holder.Position = position end
                    if holder.Size ~= size then holder.Size = size end
                    if holder.GroupTransparency ~= root.GroupTransparency then holder.GroupTransparency = root.GroupTransparency end
                    if holder.Visible ~= visible then holder.Visible = visible end
                    if root.Parent and holder.Parent ~= root.Parent then holder.Parent = root.Parent end
                end
                for _, property in {"Position", "Size", "Visible", "GroupTransparency", "Parent"} do
                    Library:Connect(Items.Watermark.Instance:GetPropertyChangedSignal(property), syncWatermarkGlow)
                end
                local measuredWatermarkBounds = {}
                local watermarkMeasurementKeys = {}
                local watermarkMeasurementCursor = 1
                local watermarkMeasurementRevision = 0
                local watermarkFitQueued = false
                local watermarkMeasuring = false
                local function watermarkMeasurementKey(label)
                    local face = label.FontFace
                    return label.Text .. "\0" .. tostring(label.TextSize) .. "\0" .. face.Family .. "\0" .. tostring(face.Weight) .. "\0" .. tostring(face.Style)
                end
                local function rememberWatermarkBounds(key, bounds)
                    if not measuredWatermarkBounds[key] then
                        local previous = watermarkMeasurementKeys[watermarkMeasurementCursor]
                        if previous then measuredWatermarkBounds[previous] = nil end
                        watermarkMeasurementKeys[watermarkMeasurementCursor] = key
                        watermarkMeasurementCursor = watermarkMeasurementCursor % 64 + 1
                    end
                    measuredWatermarkBounds[key] = bounds
                end
                local function applyWatermarkBounds(bounds)
                    if not Items.Watermark.Instance.Parent then return end
                    local label = Items.WatermarkTitle.Instance
                    local current = Items.Watermark.Instance.Size
                    -- The label starts seven pixels from the outer edge; leave the same on the right.
                    local width = math.max(14, math.ceil(bounds.X) + 14)
                    local height = math.max(24, label.TextSize + 12, math.ceil(bounds.Y) + 12)
                    if current.X.Offset ~= width or current.Y.Offset ~= height then
                        Items.Watermark.Instance.Size = UDim2.fromOffset(width, height)
                    end
                end
                local function fitWatermark()
                    local label = Items.WatermarkTitle.Instance
                    if not label.Parent or not Items.Watermark.Instance.Parent then return end
                    watermarkMeasurementRevision += 1
                    if watermarkFitQueued or watermarkMeasuring then return end
                    watermarkFitQueued = true
                    task.defer(function()
                        watermarkFitQueued = false
                        if not label.Parent or not Items.Watermark.Instance.Parent then return end
                        watermarkMeasuring = true
                        repeat
                            local revision = watermarkMeasurementRevision
                            local key = watermarkMeasurementKey(label)
                            local bounds = measuredWatermarkBounds[key]
                            if not bounds then
                                local parameters = Instance.new("GetTextBoundsParams")
                                parameters.Text, parameters.Font, parameters.Size = label.Text, label.FontFace, label.TextSize
                                parameters.Width, parameters.RichText = 100000, false
                                local ok, result = pcall(function()
                                    return Services.TextService:GetTextBoundsAsync(parameters)
                                end)
                                parameters:Destroy()
                                if ok then
                                    bounds = result
                                    rememberWatermarkBounds(key, bounds)
                                elseif revision == watermarkMeasurementRevision then
                                    bounds = label.TextBounds
                                end
                            end
                            if revision == watermarkMeasurementRevision then
                                if bounds then applyWatermarkBounds(bounds) end
                                break
                            end
                        until not label.Parent or not Items.Watermark.Instance.Parent
                        watermarkMeasuring = false
                    end)
                end
                for _, property in {"Text", "TextSize", "FontFace"} do
                    Library:Connect(Items.WatermarkTitle.Instance:GetPropertyChangedSignal(property), fitWatermark)
                end
                Library:Connect(Items.WatermarkTitle.Instance:GetPropertyChangedSignal("TextBounds"), function()
                    local label = Items.WatermarkTitle.Instance
                    local bounds = label.TextBounds
                    if bounds.X > 0 or label.Text == "" then
                        -- Roblox already measured this exact text; avoid a service request for FPS changes.
                        rememberWatermarkBounds(watermarkMeasurementKey(label), bounds)
                        applyWatermarkBounds(bounds)
                    end
                end)
                Library:RegisterMainTextLayout(fitWatermark)
                syncWatermarkGlow()
            end 

            function Cfg.SetKeybindListVisibility(Bool)
                Cfg.KeybindListVisible = Bool

                if not Bool then 
                    Items.KeybindList:Tween({GroupTransparency = 1})
                end
            end

            function Cfg.SetWatermarkVisibility(Bool)
                Cfg.WatermarkVisible = not not Bool
                Items.Watermark:Tween({GroupTransparency = Cfg.WatermarkVisible and 0 or 1})
            end

            local Frames = 0
            local FPS = 0
            local elapsedFrames = 0
            local watermarkRefreshRate = math.max(0.05, tonumber(Flags["Refresh Rate"]) or 0.1)
            local GameName = ""
            local requestedGameName = false
            local currentDate = os.date("%b %d, %Y")
            local dateRefreshTime = 1
            local titlePrefix, titleSuffix, titleColor, titleDate
            local defaultWatermarkOptions = {"Title", "Fps", "Ping"}

            Library:Connect(Services.RunService.RenderStepped, function(dt)
                Frames += 1
                elapsedFrames += dt
                if elapsedFrames < watermarkRefreshRate then return end

                local elapsed = elapsedFrames
                FPS = math.floor(Frames / math.max(elapsed, 0.001) + 0.5)
                Frames, elapsedFrames = 0, 0
                watermarkRefreshRate = math.max(0.05, tonumber(Flags["Refresh Rate"]) or 0.1)
                dateRefreshTime -= elapsed
                if dateRefreshTime <= 0 then
                    currentDate = os.date("%b %d, %Y")
                    dateRefreshTime = 1
                end

                local mainTitle = Items.Title.Instance
                local color = Themes.Preset.TextMain
                if mainTitle.Parent and (titlePrefix ~= Cfg.Prefix or titleSuffix ~= Cfg.Suffix or titleColor ~= color or titleDate ~= currentDate) then
                    titlePrefix, titleSuffix, titleColor, titleDate = Cfg.Prefix, Cfg.Suffix, color, currentDate
                    local text = string.format(
                        '%s<font color = "rgb(%s, %s, %s)">%s ~ %s</font>',
                        Cfg.Prefix,
                        math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255),
                        Cfg.Suffix, currentDate
                    )
                    if mainTitle.Text ~= text then mainTitle.Text = text end
                end

                local watermark = Items.Watermark.Instance
                if not watermark.Parent or not watermark.Visible or watermark.GroupTransparency >= 1 or not Library.HUD.Instance.Enabled then return end
                local Strings = Flags["WatermarkSettings"] or defaultWatermarkOptions

                local Parts = {}

                if table.find(Strings, "Title") then
                    table.insert(Parts, Cfg.Title)
                end

                if table.find(Strings, "Fps") then
                    table.insert(Parts, FPS .. " fps")
                end

                if table.find(Strings, "Ping") then
                    local pingOk, ping = pcall(function()
                        return Services.Stats.PerformanceStats.Ping:GetValue()
                    end)
                    table.insert(Parts, math.floor((pingOk and tonumber(ping) or 0) + 0.5) .. " ping")
                end

                if table.find(Strings, "Game Name") then
                    if not requestedGameName then
                        requestedGameName = true
                        task.spawn(function()
                            local ok, info = pcall(function()
                                return Services.MarketplaceService:GetProductInfo(game.PlaceId)
                            end)
                            if ok and info then GameName = info.Name or "" end
                        end)
                    end
                    table.insert(Parts, GameName)
                end

                if table.find(Strings, "User ID") then
                    table.insert(Parts, tostring(Services.Players.LocalPlayer.UserId))
                end

                if table.find(Strings, "LocalPlayer Name") then
                    table.insert(Parts, Services.Players.LocalPlayer.Name)
                end

                if table.find(Strings, "Date") then
                    table.insert(Parts, currentDate)
                end

                local text = table.concat(Parts, " - ")
                if Items.WatermarkTitle.Instance.Text ~= text then Items.WatermarkTitle.Instance.Text = text end
            end)

            return Library.Window
        end

        Library.AddTab = function(self, Data)
            self.PageCount += 1 
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Name or Data.Title or "Tab",
                Icon = Data.Icon or "rbxassetid://108020878442937",
                Columns = Data.Columns or 2,

                OldTab = {},
                Items = {},
                Pages = {},

                Tweening = false,
                Window = self,

                Buttons = self.Items.TabButtonHolder,
                SectionData = self.Sections,
                Parent,
                TabInfo,
                PageCount = self.PageCount;
            };  

            local Items = Cfg.Items; do

                Items.Button = Library:Create("TextButton",{Parent = self.Items.TabButtonHolder.Instance; Active = false; BackgroundTransparency = 1; Selectable = false; SizeConstraint = Enum.SizeConstraint.RelativeXX; TextTransparency = 1; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Title = Library:Create("TextLabel",{Text = Cfg.Text; Parent = Items.Button.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Button.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Filler = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, 0, 0, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(25, 25, 25)})
                Items.Left = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 1, 1, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Right = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(1, -1, 0, 0); Size = UDim2.new(0, 1, 1, 2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Stroke = Library:Create("UIStroke",{Transparency = 1; Parent = Items.Button.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border})

                Items.Title:ThemeListener("Accent", function() return self.TabInfo == Cfg end, "TextColor3", "BackgroundColor3")

                Items.Page = Library:Create("Frame",{ZIndex = 2; Visible = false; Parent = self.Items.BackgroundInner.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 4, 0, 29); Size = UDim2.new(1, -8, 1, -32); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Reparent(self.Items.BackgroundInner.Instance)
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.Page.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})

                for Index = 1, Cfg.Columns do
                    Items[tostring(Index)] = Library:Create("ScrollingFrame",{ZIndex = 2; ScrollBarImageColor3 = Themes.Preset["Outline"]; Active = true; AutomaticCanvasSize = Enum.AutomaticSize.Y; ScrollBarThickness = 0; Parent = Items.Page.Instance; BackgroundTransparency = 1; BackgroundColor3 = Color3.fromRGB(255, 255, 255); BorderSizePixel = 0; CanvasSize = UDim2.new(0, 0, 0, 0)}):Themify("Outline", "ScrollBarImageColor3")
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items[tostring(Index)].Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder; HorizontalFlex = Enum.UIFlexAlignment.Fill});
                end
            end

            local Tab = setmetatable(Cfg, Library)

            Items.Button:OnClick(function()
                if Cfg.Tweening then
                    return 
                end

                Tab:OpenPage()
            end)

            if not self.TabInfo then
                Tab:OpenPage()
            end 

            return Tab
        end

        Library.AddSection = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Title = Data.Title or Data.Text or Data.Name or "Title",
                Description = Data.Description,
                Icon = Data.Logo or Data.Icon or "rbxassetid://137452965100669",
                Side = Data.Side or 1,
                Accent = Data.Accent or false, 

                Items = {},
                Tweening = false,

                Elements = {},
                Names = {},
                DataElements = {},

                SeperatedElements = {},
            }

            local Parent = (self.Items and self.Items[tostring(Cfg.Side)] and self.Items[tostring(Cfg.Side)].Instance)
            local ElementsHolder; 

            local Items = Cfg.Items; do
                if Parent then

                    Items.Outline = Library:Create("Frame",{Parent = Parent; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                    Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.SectionBackground})
                    Items.TopBar = Library:Create("Frame",{AutomaticSize = Enum.AutomaticSize.Y; Parent = Items.Background.Instance; Size = UDim2.new(1, 0, 0, 21); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.TextLabel = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Title; Parent = Items.TopBar.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 3, 0, 4); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.TextLabel.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.Frame = Library:Create("Frame",{Parent = Items.TopBar.Instance; Position = UDim2.new(0, 1, 1, -1); Size = UDim2.new(1, -2, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.UIGradient = Library:Create("UIGradient",{Parent = Items.Frame.Instance; Transparency = NumSeq{NumKey(0, 0), NumKey(0.25, 0.75), NumKey(0.5, 1), NumKey(0.75, 0.75), NumKey(1, 0)}})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.TopBar.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Outline.Instance})

                    if Cfg.Description then 
                        Items.TextLabel = Library:Create("TextLabel",{RichText = true; Parent = Items.TopBar.Instance; TextColor3 = Color3.fromRGB(134, 134, 134); Text = Cfg.Description; Size = UDim2.new(1, 0, 0, 0); Position = UDim2.new(0, 5, 0, 21-6); BorderSizePixel = 0; TextWrapped = true; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})

                        ElementsHolder = Items.Background:CreateElements({
                            Position = UDim2.new(0, 4, 0, 19 + Items.TextLabel.Instance.AbsoluteSize.Y)
                        }) 

                        Items.UIStroke = Library:Create("UIStroke",{Parent = Items.TextLabel.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                        Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); PaddingRight = UDim.new(0, 4); Parent = Items.TextLabel.Instance})

                        Items.TextLabel.Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                            ElementsHolder.Items.Elements.Instance.Position = UDim2.new(0, 4, 0, 19 + Items.TextLabel.Instance.AbsoluteSize.Y)
                        end)
                    end

                    if not ElementsHolder then  
                        ElementsHolder = Items.Background:CreateElements({
                            Position = UDim2.new(0, 4, 0, 25)
                        })
                    end 

                    Items.Elements = ElementsHolder.Items.Elements
                    Cfg.SetVisible = ElementsHolder.SetVisible
                    Cfg.DataElements = ElementsHolder.DataElements
                end
            end

            return setmetatable(Cfg, Library)
        end

        Library.AddMultiSection = function(self, Data) 
            Data = Data or {}

            local Cfg = {
                Names = Data.Titles or Data.Texts or Data.Names or {"1", "2", "3"},
                Side = Data.Side or 1,
                Accent = Data.Accent or false, 

                Items = {},
                Tweening = false,

                Elements = {},
                DataElements = {},
                OldSection;
                Sections = {},
                SeperatedElements = {},
                Count = 0;
            }

            local Parent = (self.Items and self.Items[tostring(Cfg.Side)] and self.Items[tostring(Cfg.Side)].Instance)

            local Items = Cfg.Items; do     
                Items.Outline = Library:Create("Frame",{Parent = Parent; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Outline.Instance})
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Size = UDim2.new(1, -2, 1, 0); Position = UDim2.new(0, 1, 0, 1); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                Items.Holder = Library:Create("Frame",{Parent = Items.Inline.Instance; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Background = Library:Create("Frame",{Parent = Items.Holder.Instance; Size = UDim2.new(1, -2, 1, -2); Position = UDim2.new(0, 1, 0, 1); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset.SectionBackground})
                Items.TabButtonOutline = Library:Create("Frame",{ClipsDescendants = true; Parent = Items.Holder.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 0, 25); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(17, 17, 17)})
                Items.InlineLine = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; Position = UDim2.new(0, 0, 1, -1); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.OutlineLine = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; Position = UDim2.new(0, 0, 1, -2); Size = UDim2.new(1, 0, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.TabButtonHolder = Library:Create("Frame",{Parent = Items.TabButtonOutline.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, -2); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.TabButtonHolder.Instance; Padding = UDim.new(0, 1); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, -1); Parent = Items.Holder.Instance})
            end 

            local MultiSection = setmetatable(Cfg, Library)

            for _,Section in Cfg.Names do 
                Cfg.Sections[#Cfg.Sections + 1] = MultiSection:CreateMultiSection({Name = Section})
            end 

            Cfg.Sections[1].SetVisible(true)
            Cfg.OldSection = Cfg.Sections[1]

            return unpack(Cfg.Sections)
        end 

        Library.AddMultiPage = function(self, Data)
            self.PageCount += 1 
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Name or Data.Title or "Tab",

                OldTab = {},
                Items = {},
                Pages = {},

                Tweening = false,
                Window = self,

                Buttons = self.Items.TabButtonHolder,
                SectionData = self.Sections,
                Parent,
                TabInfo,
                PageCount = self.PageCount;
            };

            local Items = Cfg.Items; do 
                local Tab = self:AddTab({Text = Cfg.Text})
                Tab.Items.Page:Destroy() 

                Items.Page = Library:Create("Frame",{Parent = self.Items.BackgroundInner.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 4, 0, 29); Size = UDim2.new(1, -8, 1, -32); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.PageHolder = Library:Create("Frame",{Parent = Items.Page.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Page.Instance; PaddingTop = UDim.new(0, 45)})
                Items.OutlineHolder = Library:Create("Frame",{AnchorPoint = Vector2.new(0, 1); Parent = Items.Page.Instance; Position = UDim2.new(0, 0, 0, -4); Size = UDim2.new(1, 0, 0, 41); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.OutlineInner = Library:Create("Frame",{Parent = Items.OutlineHolder.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Background = Library:Create("Frame",{Parent = Items.OutlineInner.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.IconHolder = Library:Create("Frame",{Parent = Items.Background.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.IconHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 5); PaddingTop = UDim.new(0, 5); Parent = Items.IconHolder.Instance})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Background.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
            end 

            return setmetatable(Cfg, Library)
        end

        Library.AddToggle = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or "Toggle",

                Flag = Data.Flag or Data.Text or Library:NextFlag(),
                Enabled = Data.Default or false,
                Callback = Data.Callback or function() end,

                Items = {},

                Names = self.Names,

                Elements = self.Elements,
                DataElements = self.DataElements,
                SeperatedElements = self.SeperatedElements,
            }

            local Items = Cfg.Items; do
                Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Size = UDim2.new(0, 14, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Accent = Library:Create("Frame",{Parent = Items.Inline.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.Accent}):Themify("Accent", "BackgroundColor3")
                Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.TextLabel = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Object.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 18, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; TextXAlignment = Enum.TextXAlignment.Left; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.TextLabel.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.ComponentsHolder = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 0, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.ComponentsHolder.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder})
            end

            Cfg.Set = function(Bool)
                Items.Accent:Tween({ BackgroundTransparency = Bool and 0 or 1 })

                Flags[Cfg.Flag] = Bool
                Cfg.Callback(Bool)
            end

            Items.Object:OnClick(function()
                for _, component in Items.ComponentsHolder.Instance:GetChildren() do
                    if component:IsA("GuiObject") and Library.Hovering({Instance = component}) then return end
                end
                Cfg.Enabled = not Cfg.Enabled
                Cfg.Set(Cfg.Enabled)
            end)

            local Toggle = setmetatable(Cfg, Library)
            Toggle:SetupElement(Cfg.Enabled)

            return setmetatable(Cfg, Library)
        end

        Library.AddSlider = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name or "Text",
                Suffix = Data.Suffix or "",
                Flag = Data.Flag or Data.Text or Data.Title or Data.Name or Library:NextFlag(),
                Callback = Data.Callback or function() end,

                Min = Data.Min or 0,
                Max = Data.Max or 100,
                Intervals = Data.Decimal or Data.Rounding or 1,
                Value = Data.Default or 10,

                Dragging = false,
                Items = {},

                Names = self.Names,
                Elements = self.Elements,
                DataElements = self.DataElements,

                SeperatedElements = self.SeperatedElements,
                Type = Data.Type or "Animation",
            }

            local Slider = setmetatable(Cfg, Library)

            local Items = Cfg.Items; do
                Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 0, 0, 16); Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Holder = Library:Create("Frame",{Parent = Items.Gray.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Accent = Library:Create("Frame",{Parent = Items.Holder.Instance; Size = UDim2.new(1, 0, 1, 0); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.Accent}):Themify("Accent", "BackgroundColor3")
                Items.Value = Library:Create("TextBox",{Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), TextColor3 = Themes.Preset.TextMain; Text = "1000"; Parent = Items.Outline.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.Title = Library:Create("TextLabel",{TextXAlignment = Enum.TextXAlignment.Left; TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Object.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.ComponentsHolder = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(1, 0, 0, 17); Size = UDim2.new(0, 0, 0, 12); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.ComponentsHolder.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder})
                Items.Minus = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; TextTransparency = 1; Text = "-"; Parent = Items.ComponentsHolder.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 1, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.MinusStroke = Library:Create("UIStroke",{Parent = Items.Minus.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 1})
                Items.Plus = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; TextTransparency = 1; Text = "+"; Parent = Items.ComponentsHolder.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 1, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.PlusStroke = Library:Create("UIStroke",{Parent = Items.Plus.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 1})

                if Cfg.Type == "Animation" then
                    Items.Settings = Library:Create("Frame",{Visible = false, Parent = Library.Other.Instance; Size = UDim2.new(0, 250, 0, 0); Position = UDim2.new(0, 30, 0, 30); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3"):Reparent(Library.Elements.Instance)
                    Items.Inline = Library:Create("Frame",{Parent = Items.Settings.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.SectionBackground})
                    Items.Top = Library:Create("Frame",{Parent = Items.Background.Instance; Size = UDim2.new(1, 0, 0, 21); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = "Animations"; Parent = Items.Top.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 3, 0, 4); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.Gradient = Library:Create("Frame",{Parent = Items.Top.Instance; Position = UDim2.new(0, 1, 1, -1); Size = UDim2.new(1, -2, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.UIGradient = Library:Create("UIGradient",{Parent = Items.Gradient.Instance; Transparency = NumSeq{NumKey(0, 0), NumKey(0.25, 0.75), NumKey(0.5, 1), NumKey(0.75, 0.75), NumKey(1, 0)}})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Top.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Settings.Instance})

                    local Elements = Items.Background:CreateElements({Size = UDim2.new(1, -8, 0, 0), Position = UDim2.new(0, 4, 0, 25)})

                    Elements:AddToggle({Text = "Enabled", Flag = Cfg.Flag .. "_ENABLED"})
                    Elements:AddRangeSlider({Text = "Range", Min = Cfg.Min, Max = Cfg.Max, Rounding = Cfg.Intervals, Default = {Cfg.Min, Cfg.Max}, Suffix = Cfg.Suffix, Flag = Cfg.Flag.."_RANGE"})
                    Elements:AddSlider({Text = "Speed", Min = 0, Max = 100, Rounding = Cfg.Intervals, Default = 50, Suffix = "%", Flag = Cfg.Flag.."_SPEED", Type = "Normal"})
                    Elements:AddDropdown({Name = "Mode", Options = EasingStyleNames, Flag = Cfg.Flag.."_EASING_STYLE", Default = "Linear"}) 

                    Items.Settings:OutsideClick(Cfg, Elements.DataElements)

                    Cfg.SetVisible = function(Open, Debounce)
                        if Cfg.Tweening then
                            return
                        end

                        Cfg.Open = Open

                        Slider:UpdateSliderPosition(Cfg.Open, Debounce)

                        if Debounce and Cfg.Open then
                            return 
                        end

                        Items.Settings:TweenDescendants(Cfg.Open, Cfg)
                        Items.Settings:ClampToScreen()
                    end

                    Cfg.IsHovering = function()
                        return Items.Object:Hovering()
                    end

                    Items.Object:OnRightClick(function()
                        Cfg.Open = not Cfg.Open
                        Cfg.SetVisible(Cfg.Open)
                    end)

                    local fps, acc = 60, 0  
                    Library:Connect(Services.RunService.RenderStepped, function(dt)
                        if not Flags[Cfg.Flag .. "_ENABLED"] then 
                            return 
                        end 

                        acc += dt 
                        if not (acc >= 1/fps) then 
                            return 
                        end 

                        acc -= dt           

                        local Value = math.abs(math.sin(tick() * (Flags[Cfg.Flag .. "_SPEED"] / 25)))
                        local NewValue = EasingStyles[Enum.EasingStyle[Flags[Cfg.Flag.."_EASING_STYLE"]]][Enum.EasingDirection.InOut](Value)
                        local Minimum = Flags[Cfg.Flag.."_RANGE"][1]
                        local Maximum = Flags[Cfg.Flag.."_RANGE"][2]

                        Cfg.Set(Library:Lerp(Minimum, Maximum, NewValue))
                    end)
                end
            end

            Cfg.Set = function(Value)
                Cfg.Value = math.clamp(Library:Round(Value, Cfg.Intervals), Cfg.Min, Cfg.Max)

                Items.Value.Instance.Text = tostring(Cfg.Value) .. Cfg.Suffix
                Items.Accent:Tween({ Size = UDim2.new((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), 0, 1, 0) }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

                Flags[Cfg.Flag] = Cfg.Value
                Cfg.Callback(Flags[Cfg.Flag])
            end

            Cfg.OnHover = function()
                Items.ComponentsHolder:Tween({Position = UDim2.new(1, -1, 0, 0)})

                Items.Plus:Tween({TextTransparency = 0})
                Items.Minus:Tween({TextTransparency = 0})
                Items.PlusStroke:Tween({Transparency = 0}) 
                Items.MinusStroke:Tween({Transparency = 0})
            end

            Cfg.NoHover = function()    
                Items.ComponentsHolder:Tween({Position = UDim2.new(1, -1, 0, 16)})

                Items.Plus:Tween({TextTransparency = 1})
                Items.Minus:Tween({TextTransparency = 1})
                Items.PlusStroke:Tween({Transparency = 1}) 
                Items.MinusStroke:Tween({Transparency = 1})
            end

            Items.Plus:OnClick(function()
                if Items.Plus.Instance.TextTransparency ~= 0 then 
                    return 
                end 

                Cfg.Set(Cfg.Value + Cfg.Intervals)
            end)

            Items.Minus:OnClick(function()
                if Items.Minus.Instance.TextTransparency ~= 0 then 
                    return 
                end 

                Cfg.Set(Cfg.Value - Cfg.Intervals)
            end)

            Items.Object:OnHover(Cfg.OnHover, Cfg.NoHover)

            Items.Value.Instance.FocusLost:Connect(function()
                local OldValue = Cfg.Value

                local Succesful, Result = pcall(function()
                    Cfg.Set(Items.Value.Instance.Text)
                end)

                if not Succesful then
                    Cfg.Set(OldValue)
                end
            end)

            Slider:SetupElement(Cfg.Value)

            Items.Outline:OnDrag(function(Input)
                Slider:UpdateSlider(Input)
            end)

            return Slider
        end

        Library.AddRangeSlider = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name or "Text",
                Suffix = Data.Suffix or "",
                Flag = Data.Flag or Data.Text or Library:NextFlag(),
                Callback = Data.Callback or function() end,

                Min = Data.Min or 0,
                Max = Data.Max or 100,
                Intervals = Data.Decimal or Data.Rounding or 1,
                Value = Data.Default or {0, 100},

                Dragging = false,
                Items = {},

                Names = self.Names,
                Elements = self.Elements,
                DataElements = self.DataElements,

                SeperatedElements = self.SeperatedElements,
            }

            local Slider = setmetatable(Cfg, Library)

            local Items = Cfg.Items; do
                Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 0, 0, 16); Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Holder = Library:Create("Frame",{Parent = Items.Gray.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Accent = Library:Create("Frame",{Parent = Items.Holder.Instance; Size = UDim2.new(1, 0, 1, 0); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.Accent}):Themify("Accent", "BackgroundColor3")
                Items.Value = Library:Create("TextLabel",{Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), TextColor3 = Themes.Preset.TextMain; Text = "1000"; Parent = Items.Outline.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Object.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.ComponentsHolder = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(1, 0, 0, 17); Size = UDim2.new(0, 0, 0, 12); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.ComponentsHolder.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder})

                Items.Max = Library:Create("Frame",{BackgroundTransparency = 1; AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.Holder.Instance; Position = UDim2.fromScale(1, 0.5); Size = UDim2.new(0, 10, 0, 10); Active = true; ZIndex = 5; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Min = Library:Create("Frame",{BackgroundTransparency = 1; AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.Holder.Instance; Position = UDim2.fromScale(0, 0.5); Size = UDim2.new(0, 10, 0, 10); Active = true; ZIndex = 5; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
            end

            Cfg.Set = function(MinValue, MaxValue)
                if typeof(MinValue) == "table" then
                    MinValue, MaxValue = MinValue[1], MinValue[2]
                end

                MinValue = Library:Round(math.clamp(MinValue, Cfg.Min, Cfg.Max), Cfg.Intervals)
                MaxValue = Library:Round(math.clamp(MaxValue, Cfg.Min, Cfg.Max), Cfg.Intervals)

                if MinValue > MaxValue then
                    MinValue, MaxValue = MaxValue, MinValue
                end

                Cfg.Value = { MinValue, MaxValue }
                Flags[Cfg.Flag] = Cfg.Value

                local MinPCT = (MinValue - Cfg.Min) / (Cfg.Max - Cfg.Min)
                local MaxPCT = (MaxValue - Cfg.Min) / (Cfg.Max - Cfg.Min)

                Items.Accent:Tween({Position = UDim2.fromScale(MinPCT, 0), Size = UDim2.fromScale(MaxPCT - MinPCT, 1)}, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                Items.Value.Instance.Text = string.format("%s%s-%s%s", MinValue, Cfg.Suffix, MaxValue, Cfg.Suffix)

                Cfg.Callback(Cfg.Value)
            end

            Slider:SetupElement(Cfg.Value)

            return Slider
        end

        Library.AddDropdown = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name or nil,
                Flag = Data.Flag or Library:NextFlag(),
                Options = Data.Options or Data.Values or { "" },
                Callback = Data.Callback or function() end,
                Multi = Data.Multi or false,
                Search = Data.Search or false; 

                Open = true,
                OptionInstances = {},
                MultiItems = {},
                Items = {},
                Tweening = false,

                Names = self.Names,
                Elements = self.Elements,
                DataElements = self.DataElements,

                SeperatedElements = self.SeperatedElements
            }   
            Cfg.Default = Data.Default or Cfg.Options[1] or "";

            local Items = Cfg.Items; do
                do  
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 0, 0, 16); Size = UDim2.new(1, 0, 0, 20); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                    Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                    Items.Value = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = "Option1, Option2, Option3"; Parent = Items.Outline.Instance; Size = UDim2.new(1, -15, 1, 0); ClipsDescendants = true; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; RichText = true; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 6); Parent = Items.Value.Instance})
                    Items.Indicator = Library:Create("TextLabel",{Parent = Items.Outline.Instance; TextColor3 = Themes.Preset.TextMain; Text = "-"; Size = UDim2.new(0, 0, 1, 0); ClipsDescendants = true; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Right; RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255); Position = UDim2.new(1, 0, 0, 0); AnchorPoint = Vector2.new(1, 0)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Indicator.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingRight = UDim.new(0, 8); Parent = Items.Indicator.Instance})
                    Items.Title = Library:Create("TextLabel",{TextXAlignment = Enum.TextXAlignment.Left; TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Object.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                    Items.ComponentsHolder = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 0, 0, 12); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.ComponentsHolder.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder})
                end 

                do  
                    Items.DropdownHolder = Library:Create("Frame",{Parent = Library.Other.Instance; BackgroundTransparency = 1; Position = UDim2.new(0.7315288782119751, 0, 0.6228915452957153, 0); Size = UDim2.new(0, 200, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Reparent(Library.Elements.Instance)
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.DropdownHolder.Instance; Padding = UDim.new(0, 2); SortOrder = Enum.SortOrder.LayoutOrder})

                    Items.Holder = Library:Create("Frame",{Visible = true; Parent = Items.DropdownHolder.Instance; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                    Items.Inline = Library:Create("Frame",{Parent = Items.Holder.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); PaddingRight = UDim.new(0, 2); Parent = Items.Inline.Instance})
                    Items.OptionsHolder = Library:Create("ScrollingFrame",{AutomaticCanvasSize = Enum.AutomaticSize.Y; AutomaticSize = Enum.AutomaticSize.Y; CanvasSize = UDim2.new(0, 0, 0, 0); MidImage = "rbxassetid://118384633897629"; Parent = Items.Inline.Instance; ScrollBarThickness = 3; Size = UDim2.new(1, -2, 1, -2); Selectable = false; TopImage = "rbxassetid://118384633897629"; Position = UDim2.new(0, 1, 0, 1); BottomImage = "rbxassetid://118384633897629"; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.OptionsHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.OptionsHolder.Instance})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.OptionsHolder.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                end 
            end

            if Cfg.Search then 
                function Cfg:Filter(Text)
                    for _,Option in Cfg.OptionInstances do 
                        if string.find(string.lower(Option.Value.Instance.Text), string.lower(Text)) then 
                            Option.Value.Instance.Visible = true 
                        else
                            Option.Value.Instance.Visible = false 
                        end             
                    end 
                end

                local ElementsHolder = Library:CreateElements({
                    Parent = Items.DropdownHolder.Instance;
                    Size = UDim2.new(1, 0, 0, 0);
                    Position = UDim2.new(0, 0, 0, 0);
                }); ElementsHolder.Items.Elements.Instance.LayoutOrder = -1;

                Items.Textbox = ElementsHolder:AddInput({Placeholder = "Search...", Callback = function(Text)
                    Cfg:Filter(Text)
                end, FocusLost = false})
            end 

            local Dropdown = setmetatable(Cfg, Library)
            Items.DropdownHolder:OutsideClick(Cfg)    

            Cfg.SetVisible = function()
                if Cfg.Tweening then
                    return
                end

                Cfg.Open = not Cfg.Open

                Dropdown:UpdateDropdownPosition(Cfg.Open)
                Items.DropdownHolder:TweenDescendants(Cfg.Open, Cfg)

                if not Cfg.VariantDropdown then
                    Items.DropdownHolder:ClampToScreen()
                end
            end

            Cfg.Set = function(Value)
                local Selected = {}
                local IsTable = type(Value) == "table"

                for _, Option in Cfg.OptionInstances do
                    local Text = Option.Value.Instance.Text

                    if Text == Value or (IsTable and table.find(Value, Text)) then
                        table.insert(Selected, Text)
                        Cfg.MultiItems = Selected

                        Option.Value:Tween({TextColor3 = Themes.Preset.Accent})
                    else
                        Option.Value:Tween({TextColor3 = Themes.Preset.TextMisc})
                    end
                end

                Items.Value.Instance.Text = IsTable and table.concat(Selected, ", ") or Selected[1] or "Select"

                Flags[Cfg.Flag] = IsTable and Selected or Selected[1]
                Cfg.Callback(Flags[Cfg.Flag])
            end

            Cfg.IsHovering = function()
                return Items.DropdownHolder:Hovering()
            end

            Items.Outline:OnClick(function()
                Cfg.SetVisible()
            end)

            Dropdown:RefreshDropdown(Cfg.Options)
            Dropdown:SetupElement(Cfg.Default)

            return setmetatable(Cfg, Library)
        end

        Library.AddLabel = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name or nil,
                Items = {},

                Names = self.Names,
                Elements = self.Elements,
                DataElements = self.DataElements,
                SeperatedElements = self.SeperatedElements,

                Type = "Label",
            }

            local Items = Cfg.Items; do
                Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Label = Library:Create("TextLabel",{TextXAlignment = Enum.TextXAlignment.Left; TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Object.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Label.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.ComponentsHolder = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 0, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.ComponentsHolder.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder})

                Cfg.ChangeText = function(Text)
                    Items.Label.Instance.Text = Text
                end
            end

            local Label = setmetatable(Cfg, Library)
            Label:SetupElement()

            return Label
        end

        Library.AddKeyPicker = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Name or Data.Title or "Keybind",
                Flag = Data.Flag or Library:NextFlag(),
                Callback = Data.Callback or function() end,

                Key = Data.Key or Data.Default or nil,
                Mode = Data.Mode or "Toggle",
                Active = Data.Active or false,
                ShowInList = Data.ShowInList or false, 

                Open = false,
                Tweening = false,
                Binding,

                Items = {},
                Type = "KeybindPicker",

                Names = self.Names,
                Elements = self.Elements,
                DataElements = self.DataElements,
                SeperatedElements = self.SeperatedElements,

                Old;
            }

            Flags[Cfg.Flag] = {
                Mode = Cfg.Mode,
                Key = Cfg.Key,
                Active = Cfg.Active
            }

            local Keypicker = setmetatable(Cfg, Library)
            local KeybindListElement = Library:AddHotKey({})
            local Items = Cfg.Items; do

                Items.ComponentsHolder = self.Items.ComponentsHolder
                if not Items.ComponentsHolder then 
                    Items.ComponentsHolder = self:AddLabel({Name = Cfg.Text}).Items.ComponentsHolder
                end 

                Items.Value = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = "[V]"; Parent = Items.ComponentsHolder.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 18, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter})

                Items.Settings = Library:Create("Frame",{Visible = false, Parent = Library.Other.Instance; Size = UDim2.new(0, 200, 0, 0); Position = UDim2.new(0, 30, 0, 30); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3"):Reparent(Library.Elements.Instance)
                Items.Inline = Library:Create("Frame",{Parent = Items.Settings.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Background = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset.SectionBackground})
                Items.Top = Library:Create("Frame",{Parent = Items.Background.Instance; Size = UDim2.new(1, 0, 0, 21); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = "Settings"; Parent = Items.Top.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 3, 0, 4); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.Gradient = Library:Create("Frame",{Parent = Items.Top.Instance; Position = UDim2.new(0, 1, 1, -1); Size = UDim2.new(1, -2, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.UIGradient = Library:Create("UIGradient",{Parent = Items.Gradient.Instance; Transparency = NumSeq{NumKey(0, 0), NumKey(0.25, 0.75), NumKey(0.5, 1), NumKey(0.75, 0.75), NumKey(1, 0)}})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Top.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Inline.Instance})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 2); Parent = Items.Settings.Instance})
                local Elements = Items.Background:CreateElements({Size = UDim2.new(1, -8, 0, 0), Position = UDim2.new(0, 4, 0, 25)})
                Items.SettingsElements = Elements.Items.Elements
                Cfg.ShowInListControl = Elements:AddToggle({Text = "Show in list", Default = Cfg.ShowInList, Flag = Cfg.Flag .. "_SHOW_IN_LIST", Callback = function(Bool)
                    Cfg.ShowInList = Bool
                    if Bool then 
                        KeybindListElement:SetEnabled(Cfg.Active)
                    else 
                        KeybindListElement:SetEnabled(false)
                    end
                end})
                Cfg.ModeControl = Elements:AddDropdown({Text = "Mode", Options = {"Hold", "Toggle", "Always"}, Default = Cfg.Mode, Flag = Cfg.Flag .. "_MODE", Callback = function(Option)
                    if Cfg.Set and not Cfg.SyncingMode then 
                        Cfg.Set(Option)
                    end 
                end})

                Items.Settings:OutsideClick(Cfg, Elements.DataElements)
            end

            Cfg.Set = function(Input)
                if type(Input) == "boolean" then
                    Cfg.Active = Input

                    if Cfg.Mode == "Always" then
                        Cfg.Active = true
                    end
                elseif tostring(Input):find("Enum") then
                    Input = Input.Name == "Escape" and "None" or Input

                    Cfg.Key = Input or "None"
                elseif table.find({ "Toggle", "Hold", "Always" }, Input) then
                    if Input == "Always" then
                        Cfg.Active = true
                    end

                    Cfg.Mode = Input
                    Keypicker:SetMode(Cfg.Mode)
                elseif type(Input) == "table" then
                    Input.Key = type(Input.Key) == "string" and Input.Key ~= "None" and Library:ConvertEnum(Input.Key) or Input.Key
                    Input.Key = Input.Key == Enum.KeyCode.Escape and "None" or Input.Key

                    Cfg.Key = Input.Key or "None"
                    Cfg.Mode = Input.Mode or "Toggle"

                    if Input.Active ~= nil then
                        Cfg.Active = Input.Active == true
                    end

                    Keypicker:SetMode(Cfg.Mode)
                end

                Cfg.Callback(Cfg.Active)

                local text = (tostring(Cfg.Key) ~= "Enums" and (Keys[Cfg.Key] or tostring(Cfg.Key):gsub("Enum.", "")) or nil)
                local __text = text and tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", "") or ""

                Items.Value.Instance.Text = "["..__text.."]"

                if Cfg.ModeControl and Cfg.ModeControl.Value ~= Cfg.Mode then
                    Cfg.SyncingMode = true
                    Cfg.ModeControl.Set(Cfg.Mode)
                    Cfg.SyncingMode = false
                end

                KeybindListElement:ChangeText(__text, Cfg.Text, Cfg.Mode)

                if Flags[Cfg.Flag .. "_SHOW_IN_LIST"] then  
                    KeybindListElement:SetEnabled(Cfg.Active)
                end

                Flags[Cfg.Flag] = {
                    Mode = Cfg.Mode,
                    Key = Cfg.Key,
                    Active = Cfg.Active
                }
            end

            Cfg.SetVisible = function(Open, Debounce)
                if Cfg.Tweening then
                    return
                end

                Cfg.Open = Open

                Keypicker:UpdateKeyPickerPosition(Cfg.Open, Debounce)

                if Debounce and Cfg.Open then
                    return 
                end

                Items.Settings:TweenDescendants(Cfg.Open, Cfg)
                Items.Settings:ClampToScreen()
            end

            Cfg.IsHovering = function()
                return Items.Modepicker:Hovering()
            end

            Items.Value:OnClick(function()
                Keypicker:NewKey()
            end)

            Library:Connect(Services.UserInputService.InputBegan, function(Input, GameProcessedEvent)
                local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or
                Input.UserInputType

                if not Cfg.Binding and not GameProcessedEvent
                    and (SelectedKey == Cfg.Key or tostring(SelectedKey) == Cfg.Key) then
                    if Cfg.Mode == "Toggle" then
                        Cfg.Active = not Cfg.Active
                        Cfg.Set(Cfg.Active)
                    elseif Cfg.Mode == "Hold" then
                        Cfg.Set(true)
                    end
                end
            end)

            Items.Value:OnRightClick(function()
                Cfg.Open = not Cfg.Open
                Cfg.SetVisible(Cfg.Open)
            end)

            Library:Connect(Services.UserInputService.InputEnded, function(Input, GameProcessedEvent)
                local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or
                Input.UserInputType

                if SelectedKey == Cfg.Key then
                    if Cfg.Mode == "Hold" then
                        Cfg.Set(false)
                    end
                end
            end)

            Keypicker:SetupElement({ Mode = Cfg.Mode, Active = Cfg.Active, Key = Cfg.Key })

            Cfg.Old = Flags[Cfg.Flag]

            return Keypicker
        end

        Library.AddButton = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name or "Button",
                Callback = Data.Callback or function() end,
                Seperator = Data.Seperator,
                Confirmation = Data.Confirmation or false; 
                ConfirmationTimeout = math.clamp(tonumber(Data.ConfirmationTimeout) or 3, 0.1, 30),
                Confirming = false,

                Items = {}, 

                Elements = self.Elements,
                Names = self.Names,
                DataElements = self.DataElements,
            }

            local Items = Cfg.Items; do
                Items.Object = self.Items.Object

                if not Items.Object then
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 21); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.Object.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill}) 
                end

                Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Size = UDim2.new(1, 0, 0, 20); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Outline.Instance; Size = UDim2.new(1, 0, 1, 0); ClipsDescendants = true; BackgroundTransparency = 1; BorderSizePixel = 0; RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
            end

            local confirmationRevision = 0
            local confirmationDeadline = 0
            Cfg.CancelConfirmation = function()
                confirmationRevision += 1
                Cfg.Confirming = false
                if Items.Title.Instance.Parent then
                    Items.Title.Instance.Text = Cfg.Text
                    Items.Title.Instance.TextColor3 = Themes.Preset.TextMain
                end
            end
            Cfg.Set = function()
                if not Items.Title.Instance.Parent then return false end
                if not Cfg.Confirmation or (Cfg.Confirming and os.clock() < confirmationDeadline) then

                    Cfg.CancelConfirmation()
                    Cfg.Callback()
                    return true
                end
                confirmationRevision += 1
                local revision = confirmationRevision
                confirmationDeadline = os.clock() + Cfg.ConfirmationTimeout
                Cfg.Confirming = true
                Items.Title.Instance.TextColor3 = Themes.Preset.Accent
                Items.Title.Instance.Text = string.format("Confirm? (%ss)", Cfg.ConfirmationTimeout)
                task.spawn(function()
                    while revision == confirmationRevision and Cfg.Confirming do
                        if not Items.Title.Instance.Parent then return end
                        local remaining = confirmationDeadline - os.clock()
                        if remaining <= 0 then Cfg.CancelConfirmation(); return end
                        Items.Title.Instance.Text = string.format("Confirm? (%.1fs)", math.ceil(remaining * 10) / 10)
                        task.wait(0.1)
                    end
                end)
                return false
            end

            Items.Outline:OnClick(Cfg.Set)

            local Button = setmetatable(Cfg, Library)
            Button:SetupElement()

            return Button
        end

        Library.AddInput = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Title or Data.Name,
                Placeholder = Data.PlaceHolder or Data.TextColor or Data.Holder or Data.HolderText or "Input here...",
                Default = Data.Default or "",
                Flag = Data.Flag or Library:NextFlag(),
                Callback = Data.Callback or function() end,
                FocusLost = Data.FocusLost or false, 

                Items = {},
                Focused = false,

                Names = self.Names,
                Elements = self.Elements,
                DataElements = self.DataElements,
                SeperatedElements = self.SeperatedElements,
            }   

            local Items = Cfg.Items; do
                Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 0, 0, Cfg.Text and 16 or 0); Size = UDim2.new(1, 0, 0, 20); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Input = Library:Create("TextBox",{PlaceholderText = Cfg.Placeholder, ClearTextOnFocus = Data.ClearTextOnFocus or false; Active = false; Selectable = false; PlaceholderColor3 = Color3.fromRGB(134, 134, 134); Size = UDim2.new(1, -5, 1, 0); RichText = true; TextColor3 = Themes.Preset.TextMain; Text = ""; Parent = Items.Outline.Instance; CursorPosition = -1; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; ClipsDescendants = true; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Input.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 6); Parent = Items.Input.Instance})
                Items.ComponentsHolder = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 0, 0, 12); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.ComponentsHolder.Instance; Padding = UDim.new(0, 4); SortOrder = Enum.SortOrder.LayoutOrder})

                if Cfg.Text then 
                    Items.Title = Library:Create("TextLabel",{TextColor3 = Themes.Preset.TextMain; Text = Cfg.Text; Parent = Items.Object.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 1); RichText = true; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Title.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                end 
            end

            function Cfg.Set(Text)
                if type(Text) == "boolean" or Text == nil then 
                    return 
                end 

                Flags[Cfg.Flag] = Text

                Items.Input.Instance.Text = Text

                Cfg.Callback(Text)
            end

            Items.Input.Instance.Focused:Connect(function()
                Cfg.Focused = true;

                Items.Input:Tween({
                    TextColor3 = Themes.Preset.Accent;
                })
            end)

            Items.Input.Instance.FocusLost:Connect(function()
                Cfg.Focused = false;

                Items.Input:Tween({
                    TextColor3 = Themes.Preset.TextMain;
                })

                if Cfg.FocusLost then 
                    Cfg.Set(Items.Input.Instance.Text)
                end 
            end)

            if not Cfg.FocusLost then 
                Items.Input.Instance:GetPropertyChangedSignal("Text"):Connect(function()
                    Cfg.Set(Items.Input.Instance.Text)
                end)
            end

            local Input = setmetatable(Cfg, Library)
            Input:SetupElement(Cfg.Default)

            return Input
        end

        Library.AddColorPicker = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Text = Data.Text or Data.Name or Data.Title or "Color",
                Flag = Data.Flag or Data.Text or Data.Title or Library:NextFlag(),
                Callback = Data.Callback or function() end,

                Color = Data.Color or Data.Default or Color3.new(1, 1, 1),  
                Alpha = Data.Alpha or Data.Transparency or 1,
                Colors = Data.Colors or {},

                Open = false,
                Items = {},

                Names = self.Names, 
                DataElements = self.DataElements,
                Items = self.Items,
                Element = self,

                Type = Data.Type or "Animation",
                ExtraGradient = Data.ExtraGradient == true,
                MiscTab = Data.MiscTab == true,
                HistoryTab = Data.HistoryTab == true,
            }

            local Picker = self:Colorpicker(Cfg)
            Picker.Items.ComponentsHolder = self.Items.ComponentsHolder

            local Items = Picker.Items; do
                Cfg.Items = Items;
                Cfg.Set = Picker.Set;
                Cfg.SetDeleterVisible = Picker.SetDeleterVisible;
                Cfg.IsHovering = Picker.IsHovering;
            end

            return setmetatable(Cfg, Library)
        end

        Library.AddList = function(self, Data)  
            Data = Data or {}

            local Cfg = {
                Flag = Data.Flag or Library:NextFlag(),
                Options = Data.Options or { "Option 1", "Option 2", "Option 3", "Option 4" },
                Callback = Data.Callback or function() end,
                Multi = Data.Multi or false,

                Size = Data.Size or 100,
                Scrolling = Data.Scrolling or false, 

                Names = self.Names,
                Items = {},
                OptionInstances = {},
                MultiItems = {},
                DataElements = self.DataElements,
            }

            local Items = Cfg.Items; do
                Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 100); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Size = UDim2.new(1, 0, 0, 100); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                Items.Holder = Library:Create("ScrollingFrame",{AutomaticCanvasSize = Enum.AutomaticSize.Y; BorderSizePixel = 0; CanvasSize = UDim2.new(0, 0, 0, 0); ScrollBarImageColor3 = Color3.fromRGB(245, 20, 136); MidImage = "rbxassetid://118384633897629"; Parent = Items.Gray.Instance; ScrollBarThickness = 3; Size = UDim2.new(1, 0, 1, 0); ElasticBehavior = Enum.ElasticBehavior.Always; Selectable = false; TopImage = "rbxassetid://118384633897629"; BottomImage = "rbxassetid://118384633897629"; BackgroundTransparency = 1; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Holder.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
            end 

            Cfg.Set = function(Value)
                local Selected = {}
                local IsTable = type(Value) == "table"

                for _, Option in Cfg.OptionInstances do
                    local Text = Option.Value.Instance.Text

                    if Text == Value or (IsTable and table.find(Value, Text)) then
                        table.insert(Selected, Text)
                        Cfg.MultiItems = Selected

                        Option.Value:Tween({ TextColor3 = Themes.Preset.Accent })
                    else    
                        Option.Value:Tween({ TextColor3 = Themes.Preset.TextMisc })
                    end
                end

                Flags[Cfg.Flag] = IsTable and Selected or Selected[1]
                Cfg.Callback(Flags[Cfg.Flag])
            end

            local List = setmetatable(Cfg, Library)
            List:SetupElement(Cfg.Default)
            List:RefreshList(Cfg.Options)

            return setmetatable(Cfg, Library)
        end

        Library.ImageBox = function(self, Data)
            Data = Data or {}

            local Cfg = {
                Image = Data.Image or "rbxassetid://82574858136292",
                Items = {},
            }

            local Items = Cfg.Items; do 
                Items.Object = Library:Create( "Frame", {
                    Parent = self.Items.Elements.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, 72);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                Items.ImageHolder = Library:Create( "Frame", {
                    Parent = Items.Object.Instance;
                    Size = UDim2.new(0, 72, 0, 72);
                    BorderSizePixel = 0;
                    BackgroundColor3 = Themes.Preset["PageBackground"]
                }):Themify("PageBackground", "BackgroundColor3")

                Library:Create( "UIStroke", {
                    Parent = Items.ImageHolder.Instance;
                    BorderOffset = UDim.new(0, -1);
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                Library:Create( "UIStroke", {
                    Color = Color3.fromRGB(50, 50, 50);
                    BorderOffset = UDim.new(0, -2);
                    Parent = Items.ImageHolder.Instance;
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 2);
                    PaddingBottom = UDim.new(0, 2);
                    Parent = Items.ImageHolder.Instance;
                    PaddingRight = UDim.new(0, 2);
                    PaddingLeft = UDim.new(0, 2)
                })

                Library:Create( "UIListLayout", {
                    Parent = Items.ImageHolder.Instance;
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items.Image = Library:Create( "ImageLabel", {
                    Parent = Items.ImageHolder.Instance;
                    Image = "rbxassetid://82574858136292";
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                Cfg.RightElements = Library:CreateElements({
                    Position = UDim2.new(1, 0, 0, 0);
                    Size = UDim2.new(0, 160, 0, 0);
                    Parent = Items.Object.Instance
                }); Cfg.RightElements.Items.Elements.Instance.AnchorPoint = Vector2.new(1, 0);

                Cfg.LeftElements = Library:CreateElements({
                    Position = UDim2.new(0, 76, 0, 0);
                    Size = UDim2.new(0, 160, 0, 0);
                    Parent = Items.Object.Instance
                })
            end 

            function Cfg:SetImage(Image)
                Items.Image.Instance.Image = Image 
            end

            Cfg:SetImage(Cfg.Image)

            return setmetatable(Cfg, Library)
        end

        Library.AddPreview = function(self, Data) 
            Data = Data or {} 

            local Cfg = {
                Items = {};
                Height = Data.Height or 300;  

                EnableInputCamera = true,
                IsViewing = false,
                AutoRefresh = false,
                ZoomMultiplier = 2,
                AutoRotate = true,
                RotationSpeed = 0.01,
                RefreshRate = 30
            }

            local Model, ViewportCamera, OriginalModel

            local Items = Cfg.Items; do 
                Items.Object = Library:Create("TextButton",{ClipsDescendants = true; Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, Cfg.Height); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.ViewportFrame = Library:Create("ViewportFrame",{Position = UDim2.new(0.5, 0, 0.5, 0); AnchorPoint = Vector2.new(0.5, 0.5); BackgroundTransparency = 1; Parent = Items.Object.Instance; Size = UDim2.new(0, Cfg.Height, 0, Cfg.Height); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})

                Items.Main = Library:Create("Frame",{Visible = false; AnchorPoint = Vector2.new(0.5, 0); Parent = Items.Object.Instance; Size = UDim2.new(0, 150, 0, 250); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.BoxOutline = Library:Create("UIStroke",{Thickness = 3; LineJoinMode = Enum.LineJoinMode.Miter; Parent = Items.Main.Instance; BorderOffset = UDim.new(0, -1); Transparency = 0.5})
                Items.BoxAccent = Library:Create("UIStroke",{LineJoinMode = Enum.LineJoinMode.Miter; Color = Color3.fromRGB(255, 255, 255); ZIndex = 2; Parent = Items.Main.Instance})
                Items.BoxGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.BoxAccent.Instance})

                Items.Left = Library:Create("Frame",{Parent = Items.Main.Instance; Size = UDim2.new(0, 0, 1, 4); Position = UDim2.new(0, -4, 0, -2); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalAlignment = Enum.HorizontalAlignment.Right; Parent = Items.Left.Instance; Padding = UDim.new(0, 2); SortOrder = Enum.SortOrder.LayoutOrder})
                Items.TextHolder = Library:Create("Frame",{LayoutOrder = -1; Parent = Items.Left.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.TextHolder.Instance; Padding = UDim.new(0, 1); HorizontalAlignment = Enum.HorizontalAlignment.Right; SortOrder = Enum.SortOrder.LayoutOrder})
                Items.BarHolder = Library:Create("Frame",{Parent = Items.Left.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; VerticalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.BarHolder.Instance; Padding = UDim.new(0, 2); SortOrder = Enum.SortOrder.LayoutOrder})
                Items.TextHolder = Library:Create("Frame",{Parent = Items.BarHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.HealthText = Library:Create("TextLabel",{FontFace = Fonts.Preview; TextSize = 12; TextColor3 = Color3.fromRGB(0, 255, 0); Text = "100"; TextYAlignment = Enum.TextYAlignment.Bottom; Parent = Items.TextHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; Position = UDim2.new(0, 0, 1, 0); AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.HealthText.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 0.5})
                Items.UIPadding = Library:Create("UIPadding",{Parent = Items.HealthText.Instance; PaddingTop = UDim.new(0, -1)})
                Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.TextHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder; HorizontalAlignment = Enum.HorizontalAlignment.Right})
                Items.UIPadding = Library:Create("UIPadding",{PaddingRight = UDim.new(0, 1); Parent = Items.TextHolder.Instance})
                Items.Healthbar = Library:Create("Frame",{Parent = Items.BarHolder.Instance; BackgroundTransparency = 0.5; Size = UDim2.new(0, 4, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(0, 0, 0)});
                Items.HealthbarAccent = Library:Create("Frame",{ClipsDescendants = true, LayoutOrder = -1; Parent = Items.Healthbar.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.HealthbarFade = Library:Create("Frame",{ClipsDescendants = true, LayoutOrder = -1; Parent = Items.Healthbar.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(0, 0, 0)})
                Items.HealthbarGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.HealthbarAccent.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 255, 0)), ColorKey(0.5, Color3.fromRGB(255, 179, 0)), ColorKey(1, Color3.fromRGB(255, 0, 0))}})

                Items.Right = Library:Create("Frame",{Parent = Items.Main.Instance; Size = UDim2.new(0, 0, 1, 4); Position = UDim2.new(1, 4, 0, -2); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Right.Instance; Padding = UDim.new(0, 2); SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal})
                Items.TextHolder = Library:Create("Frame",{Parent = Items.Right.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Flags = Library:Create("TextLabel",{FontFace = Fonts.Preview; TextSize = 12;TextColor3 = Color3.fromRGB(255, 255, 255); Text = "Flags"; Parent = Items.TextHolder.Instance; Size = UDim2.new(1, 0, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Flags.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 0.5})
                Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Flags.Instance; PaddingTop = UDim.new(0, -1); PaddingLeft = UDim.new(0, 1)})
                Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.TextHolder.Instance; Padding = UDim.new(0, 1); HorizontalAlignment = Enum.HorizontalAlignment.Right; SortOrder = Enum.SortOrder.LayoutOrder})
                Items.UIPadding = Library:Create("UIPadding",{Parent = Items.TextHolder.Instance})

                Items.Top = Library:Create("Frame",{Parent = Items.Main.Instance; AnchorPoint = Vector2.new(0, 1); BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, -2, 0, -4); Size = UDim2.new(1, 4, 0, 0); ZIndex = 2; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Bottom; Padding = UDim.new(0, 2); Parent = Items.Top.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
                Items.Name = Library:Create("TextLabel",{FontFace = Fonts.Preview; TextSize = 12;TextColor3 = Color3.fromRGB(255, 255, 255); Text = "Player"; Parent = Items.Top.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Name.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 0.5})
                Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, -1); Parent = Items.Name.Instance})

                Items.Bottom = Library:Create("Frame",{Parent = Items.Main.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; Position = UDim2.new(0, -2, 1, 4); Size = UDim2.new(1, 4, 0, 0); ZIndex = 2; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.Distance = Library:Create("TextLabel",{FontFace = Fonts.Preview; TextSize = 12;TextColor3 = Color3.fromRGB(255, 255, 255); Text = "100st"; Parent = Items.Bottom.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Distance.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 0.5})
                Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Distance.Instance})
                Items.Weapon = Library:Create("TextLabel",{FontFace = Fonts.Preview; TextSize = 12;TextColor3 = Color3.fromRGB(255, 255, 255); Text = "none"; Parent = Items.Bottom.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Weapon.Instance; LineJoinMode = Enum.LineJoinMode.Miter; Transparency = 0.5})
                Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Weapon.Instance})
                Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Bottom; Padding = UDim.new(0, 1); Parent = Items.Bottom.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
            end

            do  
                Cfg.Update = function()
                    local Flags = Library.Flags 

                    Items.Main.Instance.Parent = Items.Object.Instance or Library.Other.Instance

                    Items.BoxOutline.Instance.Enabled = Flags["Boxes"]
                    Items.BoxAccent.Instance.Enabled = Flags["Boxes"]

                    Items.Healthbar.Instance.Visible = Flags["Healthbar"]
                    Items.HealthText.Instance.Visible = Flags["Manipulated"]

                    Items.Name.Instance.Visible = Flags["Names"]
                    Items.Distance.Instance.Visible = Flags["Distance"]
                    Items.Weapon.Instance.Visible = Flags["Weapon"]
                    Items.Flags.Instance.Visible = Flags["Flags"]

                    Items.Name.Instance.TextColor3 = Flags["Name_Color"].Color
                    Items.Distance.Instance.TextColor3 = Flags["Distance_Color"].Color
                    Items.Weapon.Instance.TextColor3 = Flags["Weapon_Color"].Color
                    Items.Flags.Instance.TextColor3 = Flags["Manipulated_Color2"].Color

                    Items.HealthbarGradient.Instance.Color = ColorSeq{ColorKey(0, Flags["Health_High"].Color),ColorKey(0.5, Flags["Health_Medium"].Color), ColorKey(1, Flags["Health_Low"].Color)}
                end
            end 

            Cfg.StopViewing = function(Refreshing)
                if Refreshing then 
                    Items.ViewportFrame.Instance:FindFirstChildOfClass("Model"):Destroy()
                else 
                    if ViewportCamera then ViewportCamera = nil end 
                    if Model then Model = nil end 

                    Items.ViewportFrame.Instance:ClearAllChildren()

                    Cfg.IsViewing = false 
                end 
            end 

            Cfg.ViewModel = function(Item, Updating)
                if not Item then return end 

                Cfg.StopViewing(Updating)

                if Item ~= Services.Workspace and not Item:IsA("Model") then 
                    Model = Instance.new("Model")
                    Model.Parent = Items.ViewportFrame.Instance

                    local Clone = Item:Clone()
                    Clone.Parent = Model
                    Model.PrimaryPart = Clone
                    Model:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
                elseif Item:IsA("Model") then 
                    Item.Archivable = true 

                    if #Item:GetChildren() == 0 then return end 

                    Model = Item:Clone() 
                    Model.Parent = Items.ViewportFrame.Instance

                    if not Model.PrimaryPart then
                        local Found = false
                        for _,Child in Model:GetDescendants() do
                            if Child:IsA("BasePart") then
                                Model.PrimaryPart = Child
                                Model:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
                                Found = true

                                break
                            end
                        end

                        if not Found then
                            Model:Destroy()
                            Model = nil
                            return
                        end
                    end
                else 
                    return 
                end 

                OriginalModel = Item 

                if Cfg.AutoRefresh and not Updating then 
                    task.spawn(function()
                        while Model and Cfg.AutoRefresh do

                            Cfg.ViewModel(OriginalModel, true)
                            task.wait(1 / Cfg.RefreshRate)
                        end
                    end)
                end 

                if not Updating then
                    ViewportCamera = Instance.new("Camera")
                    ViewportCamera.Parent = Items.ViewportFrame.Instance

                    Items.ViewportFrame.Instance.CurrentCamera = ViewportCamera
                    ViewportCamera.FieldOfView = 60

                    Cfg.IsViewing = true
                end
            end 

            Cfg.Init = function()
                local rotationX, rotationY = 0, 0
                local distance = 10
                local dragging = false
                local hovering = false
                local lastpos = Vector2.zero

                Library:Connect(Services.UserInputService.InputChanged, function(Input, GameEvent)
                    if not (Cfg.EnableInputCamera) then return end

                    if dragging and Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                        local delta = Input.Position - lastpos
                        lastpos = Input.Position

                        rotationY -= delta.X * 0.01
                        rotationX -= delta.Y * 0.01
                        rotationX = math.clamp(rotationX, -math.pi/2 + 0.1, math.pi/2 - 0.1)
                    end

                    if Input.UserInputType == Enum.UserInputType.MouseWheel and dragging then
                        distance = math.clamp(distance - (Input.Position.Z * Cfg.ZoomMultiplier), 0.1, math.huge)
                    end
                end)

                Items.ViewportFrame.Instance.InputBegan:Connect(function(Input)
                    if not Cfg.EnableInputCamera then return end

                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        lastpos = Input.Position
                    elseif Input.KeyCode == Enum.KeyCode.LeftShift then
                        Cfg.ZoomMultiplier = 10
                    end
                end)

                Items.ViewportFrame.Instance.InputEnded:Connect(function(Input)
                    if not Cfg.EnableInputCamera then return end

                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    elseif Input.KeyCode == Enum.KeyCode.LeftShift then
                        Cfg.ZoomMultiplier = 2
                    end
                end)

                Library:Connect(Services.RunService.RenderStepped, function()
                    if ViewportCamera and Model then
                        if not dragging and Cfg.AutoRotate then
                            rotationY += Cfg.RotationSpeed
                        end

                        local center = Model.PrimaryPart.Position
                        local offset = CFrame.new(0, 0, distance)
                        local rotation = CFrame.Angles(0, rotationY, 0) * CFrame.Angles(rotationX, 0, 0)

                        local camCF = CFrame.new(center) * rotation * offset

                        ViewportCamera.CFrame = CFrame.lookAt(camCF.Position, center + Vector3.new(0, -1, 0))
                    end
                end)
            end 

            Cfg.ChangeHealth = function()
                if not Library.Window.Open then 
                    return 
                end

                local Value = math.abs(math.sin(tick()))
                local NewValue = EasingStyles[Enum.EasingStyle.Exponential][Enum.EasingDirection.InOut](Value)

                Items.HealthbarFade.Instance.Size = UDim2.new(1, -2, 1 - NewValue, 0)
                Items.HealthText.Instance.Size = UDim2.new(0, 0, 1 - NewValue, Items.HealthText.Instance.TextBounds.Y - 3)

                local Color = Flags["Health_Low"].Color:Lerp(Flags["Health_Medium"].Color, NewValue)
                local Color2 = Color:Lerp(Flags["Health_High"].Color, NewValue)
                Items.HealthText.Instance.TextColor3 = Color2
                Items.HealthText.Instance.Text = Library:Round(NewValue * 100, 1)

            end

            Cfg.Vertices = {
                Vector3.new(-1, -1, -1),
                Vector3.new(-1, 1, -1),
                Vector3.new(-1, 1, 1),
                Vector3.new(-1, -1, 1),
                Vector3.new(1, -1, -1),
                Vector3.new(1, 1, -1),
                Vector3.new(1, 1, 1),
                Vector3.new(1, -1, 1)
            }

            function Cfg:WorldToScreen(WorldPosition)
                local ScreenPosition, OnScreen = ViewportCamera:WorldToScreenPoint(WorldPosition) 
                return Vector2.new(ScreenPosition.Z, ScreenPosition.X), OnScreen
            end

            function Cfg:BoundingBox(CFrame, Size)
                local Corners = table.create(#self.Vertices)
                for i = 1, #self.Vertices do
                    Corners[i] = self:WorldToScreen((CFrame + Size * 0.5 * self.Vertices[i]).Position)
                end

                local Min = Vector2.zero.Min(ViewportCamera.ViewportSize, unpack(Corners))
                local Max = Vector2.zero.Max(Vector2.zero, unpack(Corners))

                return {
                    ["Corners"] = Corners,
                    ["TopLeft"] = Vector2.new(math.floor(Min.X), math.floor(Min.Y)),
                    ["TopRight"] = Vector2.new(math.floor(Max.X), math.floor(Min.Y)),
                    ["BottomLeft"] = Vector2.new(math.floor(Min.X), math.floor(Max.Y)),
                    ["BottomRight"] = Vector2.new(math.floor(Max.X), math.floor(Max.Y))
                }
            end 

            function Cfg:BoxSolve(Path)
                if not Path then
                    return nil, nil, nil
                end 

                local TorsoCFrame = Path.CFrame.UpVector
                local TorsoPosition = Path.Position
                local CameraCFrameUp = ViewportCamera.CFrame

                local ViewportTop = TorsoPosition + (TorsoCFrame * 1.8) + CameraCFrameUp.UpVector
                local ViewportBottom = TorsoPosition - (TorsoCFrame * 2.5) - CameraCFrameUp.UpVector
                local Distance = (TorsoPosition - CameraCFrameUp.p).Magnitude

                local NewDistance = math.floor(Distance * 0.333)
                local HolderSize = Items.ViewportFrame.Instance.AbsoluteSize 

                local Top, TopIsRendered = ViewportCamera:WorldToScreenPoint(ViewportTop)
                Top = Vector2.new(Top.X * HolderSize.X, Top.Y * HolderSize.Y)

                local Bottom, BottomIsRendered = ViewportCamera:WorldToScreenPoint(ViewportBottom)
                Bottom = Vector2.new(Bottom.X * HolderSize.X, Bottom.Y * HolderSize.Y)

                local Width = math.max(math.floor(math.abs(Top.X - Bottom.X)), 9)
                local Height = math.max(math.floor(math.max(math.abs(Bottom.Y - Top.Y), Width / 2)), 12)
                local BoxSize = Vector2.new(math.floor(math.max(Height / 1.5, Width)), Height)
                local BoxPosition = Vector2.new(math.floor(Top.X * 0.5 + Bottom.X * 0.5 - BoxSize.X * 0.5), math.floor(math.min(Top.Y, Bottom.Y)))

                return BoxSize, BoxPosition, TopIsRendered, NewDistance
            end

            function Cfg:GetBoundingBox(Parts)
                local Min, Max
                for i = 1, #Parts do
                    local Part = Parts[i]
                    local CFrame, Size = Part.CFrame, Part.Size
                    Min = Vector3.zero.Min(Min or CFrame.Position, (CFrame - Size * 0.5).Position)
                    Max = Vector3.zero.Max(Max or CFrame.Position, (CFrame + Size * 0.5).Position)
                end

                local Center = (Min + Max) * 0.5
                local Front = Vector3.new(Center.X, Center.Y, Max.Z)
                return CFrame.new(Center, Front), Max - Min
            end

            Library:Connect(Services.RunService.RenderStepped, function()
                if not (ViewportCamera or Model) then 
                    return 
                end 

                local Size, Position, OnScreen, Distance = Cfg:BoxSolve(Model.HumanoidRootPart)

                local Holder = Items.Main.Instance
                Holder.Visible = true
                Holder.Position = UDim2.new(0.5, 0, 0, Position.Y)
                Holder.Size = UDim2.fromOffset(Size.X, Size.Y)

                Cfg.ChangeHealth() 
            end)

            Cfg.Init()
            Cfg.ViewModel(Services.Players.LocalPlayer.Character)

            return setmetatable(Cfg, Library)
        end

        Library.Playerlist = function(self, Data)
            Data = Data or {} 

            local Cfg = {
                Size = Data.Size or 239, 
                Items = {},
                Data = {},
                Labels = {},
                Selected;
            }

            local Items = Cfg.Items; do 
                Items.Object = Library:Create( "TextButton", {
                    Parent = self.Items.Elements.Instance;
                    BackgroundTransparency = 1;
                    Size = UDim2.new(1, 0, 0, Cfg.Size);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })

                Items.Holder = Library:Create( "ScrollingFrame", {
                    Selectable = false;
                    BorderSizePixel = 0;
                    CanvasSize = UDim2.new(0, 0, 0, 0);
                    MidImage = "rbxassetid://118384633897629";
                    ScrollBarThickness = 2;
                    Parent = Items.Object.Instance;
                    Size = UDim2.new(1, -4, 0, Cfg.Size - 2);
                    TopImage = "rbxassetid://118384633897629";
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    BottomImage = "rbxassetid://118384633897629";
                    Position = UDim2.new(0, 2, 0, 0);
                    BackgroundColor3 = Themes.Preset["PageBackground"]
                }):Themify("PageBackground", "BackgroundColor3")

                Items.Outline = Library:Create( "UIStroke", {
                    Parent = Items.Holder.Instance;
                    BorderOffset = UDim.new(0, 1);
                    LineJoinMode = Enum.LineJoinMode.Miter
                })

                Items.Inline = Library:Create( "UIStroke", {
                    Color = Color3.fromRGB(50, 50, 50);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = Items.Holder.Instance
                })

                Library:Create( "UIPadding", {
                    PaddingTop = UDim.new(0, 5);
                    PaddingBottom = UDim.new(0, 5);
                    Parent = Items.Holder.Instance;
                    PaddingRight = UDim.new(0, 5);
                    PaddingLeft = UDim.new(0, 5)
                })

                Library:Create( "UIListLayout", {
                    Parent = Items.Holder.Instance;
                    Padding = UDim.new(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            end 

            local Playerlist = setmetatable(Cfg, Library)

            Library:Connect(Services.Players.PlayerAdded, function(Player)
                Playerlist:AddPlayer(Player)
            end)    

            Library:Connect(Services.Players.PlayerRemoving, function(Player)
                Playerlist:RemovePlayer(Player)
            end) 

            for _,Player in Services.Players:GetPlayers() do 
                local PlayerData = Playerlist:AddPlayer(Player)

                if Services.Players.LocalPlayer.Name == Player.Name then 
                    PlayerData:SetPriority("LocalPlayer")
                end 
            end 

            self:AddInput({PlaceHolder = "Search here...", Callback = function(Text)
                for _,Player in Cfg.Data do 
                    Player.Filter(Text)
                end 
            end, FocusLost = false})    

            Cfg.ImageBox = self:ImageBox({})
            Cfg.Name = Cfg.ImageBox.LeftElements:AddLabel({Text = "Name: ??"})
            Cfg.DisplayName = Cfg.ImageBox.LeftElements:AddLabel({Text = "DisplayName: ??"})
            Cfg.UserId = Cfg.ImageBox.LeftElements:AddLabel({Text = "UserId: ??"})

            Cfg.ImageBox.RightElements:AddDropdown({ Text = "Priority", Values = { "Neutral", "Enemy" }, Default ="Option 1", Multi = false, Callback = function(Option) 
                if Cfg.Selected then 
                    Cfg.Selected:SetPriority(Option)
                end 
            end})   

            return Playerlist
        end 
    end

    do 
        Library.InitPanels = function(self)
            local Settings = self:AddTab({Title = "Settings", Columns = 2, Icon = "rbxassetid://75121128014531"});

            local Section = Settings:AddSection({Title = "Configuration", Side = 1, Icon = "rbxassetid://89805822444471"}) do 
                local ConfigText;
                local ConfigHolder = Section:AddList({Text = "Configs", Flag = "ConfigList", Callback = function(option) 
                    if Text and option then 
                        Text.Set(option, true) 
                    end 
                end})

                Text = Section:AddInput({Text = "Config Name:", Flag = "config_Name_text", PlaceHolder = "Type config name here...", Callback = function(text)
                    ConfigText = text
                end})

                Section:AddButton({Text = "Save", Confirmation = true, Callback = function() 
                    if not ConfigText then 
                        return 
                    end 

                    Library:SaveConfig(ConfigText)
                    ConfigHolder:UpdateConfigList()
                end})
                :AddButton({Text = "Load", Confirmation = true, Callback = function()
                    if not (ConfigText and isfile(Library.Directory .. "/Configs/" .. ConfigText .. ".cfg")) then 
                        return 
                    end 
                    self.Tweening = true
                    Library:LoadConfig(readfile(Library.Directory .. "/Configs/" .. ConfigText .. ".cfg"))
                    self.Tweening = false
                    ConfigHolder:UpdateConfigList()
                end})

                Section:AddButton({Text = "Delete", Confirmation = true, Callback = function() 
                    if not ConfigText then 
                        return 
                    end 

                    Library:DeleteConfig(ConfigText)
                    ConfigHolder:UpdateConfigList()
                end})
                :AddButton({Text = "Refresh", Confirmation = true, Callback = function() 
                    ConfigHolder:UpdateConfigList()
                end})

                Section:AddButton({Text = "Set As Auto Load", Confirmation = true, Callback = function() 
                    writefile(Library.Directory.."/Autoload.txt", ConfigText)
                    Label.ChangeText("Current Config: " .. readfile(Library.Directory.."/Autoload.txt"))
                end})   
                :AddButton({Text = "Remove Auto Load", Confirmation = true, Callback = function() 
                    writefile(Library.Directory.."/Autoload.txt", "")
                    Label.ChangeText("Current Config: "..readfile(Library.Directory.."/Autoload.txt"))
                end})

                Label = Section:AddLabel({Text = "Current Config: ".. readfile(Library.Directory.."/Autoload.txt")})

                ConfigHolder:UpdateConfigList()
            end

            local Section = Settings:AddSection({Title = "Menu", Side = 1}) do 
                Section:AddDropdown({Text = "Easing Style", Flag = "Easing Style", Options = {"Linear", "Cubic", "Quad", "Quart", "Quint", "Sine", "Exponential", "Back", "Bounce", "Elastic", "Circular"}, Default = tostring(Library.EasingStyle):match("%.([%w]+)$"), Callback = function(Option) Library.EasingStyle = Enum.EasingStyle[Option] end})
                Section:AddDropdown({Text = "Easing Direction", Flag = "Easing Direction", Options = {"In", "Out", "InOut"}, Default = tostring(Library.EasingDirection):match("%.([%w]+)$"), Callback = function(Option) Library.EasingDirection = Enum.EasingDirection[Option] end})
                Section:AddSlider({Text = "Tweening Speed", Flag = "Tweening Speed", Min = 0, Max = 2, Default = 0.3, Suffix = "s", Decimal = 0.01, Callback = function(Text) Library.TweeningSpeed = Text  end})
                Section:AddSlider({Text = "Dragging Speed", Flag = "Dragging Speed", Min = 0, Max = 2, Default = 0.05, Suffix = "s", Decimal = 0.01, Callback = function(Text) Library.DraggingSpeed = Text end})

                Section:AddInput({Text = "Prefix", Default = Library.Window.Prefix, Callback = function(Text)
                    Library.Window.Prefix = Text
                end, Flag = "Prefix"})
                Section:AddInput({Text = "Suffix", Default = Library.Window.Suffix, Callback = function(Text)
                    Library.Window.Suffix = Text
                end, Flag = "Suffix"})
            end

            local Section = Settings:AddSection({Title = "HUD", Side = 2}) do 
            Section:AddToggle({Text = "Watermark", Default = true, Callback = self.SetWatermarkVisibility})
            Section:AddDropdown({Text = "Options", Flag = "WatermarkSettings", Options = {"Title", "Fps", "Ping", "Game Name", "User ID", "LocalPlayer Name", "Date"}, Multi = true, Default = {"Title", "Fps", "Ping"}})
            Section:AddSlider({Text = "Refresh Rate", Flag = "Refresh Rate", Min = 0, Max = 2, Default = 0.1, Suffix = "s", Decimal = 0.01})
            Section:AddToggle({Text = "Keybind List", Default = true, Callback = self.SetKeybindListVisibility}) 
            Section:AddKeyPicker({Text = "Menu Bind", Key = Enum.KeyCode.RightShift, Mode = "Toggle", Active = false, Callback = function(bool) Library.SetMenuVisible(Library, bool) end})

            local Section = Settings:AddSection({Title = "Theming", Side = 2})
                for Name,Value in Themes.Preset do 
                    Section:AddColorPicker({Text = Name:gsub("(%l)(%u)", "%1 %2"), Default = Value, Flag = Name, NoCallback = true, Callback = function(Color)
                        Library:Refresh(Name, Color)
                    end})
                end 

                local Input;
                ThemeHolder = Section:AddDropdown({Text = "Themes", Callback = function(Option) if Input then Input.Set(Option) end end})
                Input = Section:AddInput({Text = "Config Name:", Flag = "Theming_Text_Name", PlaceHolder = "Theme name here..."})
                Section:AddButton({Text = "Save", Callback = function() 
                    Library:SaveTheme(Flags["Theming_Text_Name"])
                    ThemeHolder:UpdateThemingList()
                end})
                :AddButton({Text = "Load", Callback = function()
                    if not Flags["Theming_Text_Name"] then 
                        return 
                    end 

                    if not isfile(Library.Directory .. "/Themes/" .. Flags["Theming_Text_Name"] .. ".Cfg") then 
                        return 
                    end 

                    Library:LoadConfig(readfile(Library.Directory .. "/Themes/" .. Flags["Theming_Text_Name"] .. ".Cfg"))
                    ThemeHolder:UpdateThemingList()
                end})

                Section:AddButton({Text = "Delete", Callback = function() 
                    if not Flags["Theming_Text_Name"] then 
                        return 
                    end 

                    Library:DeleteTheme(Flags["Theming_Text_Name"])
                    ThemeHolder:UpdateThemingList()
                end})
                :AddButton({Text = "Refresh", Callback = function() 
                    ThemeHolder:UpdateThemingList()
                end})

                ThemeHolder:UpdateThemingList()
            end 
        end
    end 

    do
        local palette = {
            Accent = Color3.fromRGB(185, 185, 218),
            Border = Color3.fromRGB(28, 27, 34),
            OuterOutline = Color3.fromRGB(173, 170, 189),
            Window = Color3.fromRGB(22, 21, 28),
            Outer = Color3.fromRGB(16, 15, 22),
            Section = Color3.fromRGB(18, 17, 24),
            Control = Color3.fromRGB(31, 31, 41),
            Text = Color3.fromRGB(200, 200, 200),
            White = Color3.fromRGB(255, 255, 255),
            Inactive = Color3.fromRGB(185, 185, 188),
        }
        Library.MainStylePalette = palette

        Library.MainTextSize = 12
        local mainTextObjects = {}
        local mainTextLayouts = {}
        function Library:RegisterMainTextLayout(callback)
            table.insert(mainTextLayouts, callback)
            callback(self.MainTextSize)
        end
        local theme = {
            ["High Contrast"] = Color3.fromRGB(33, 33, 44),
            ["Low Contrast"] = Color3.fromRGB(28, 28, 38),
            TabButtonUnselected = palette.Outer,
            Outline = palette.Border, Inline = palette.Border,
            MenuBackground = palette.Window, PageBackground = palette.Window,
            SectionBackground = palette.Section,
            TextMisc = palette.Text, TextMain = palette.White, Accent = palette.Accent,
        }
        for name, color in theme do Themes.Preset[name] = color end

        Library.AssetDirectories = {"gamehaxvx/assets", "gamehaxx/assets"}
        Library.ResolveAsset = function(self, candidates)
            if type(candidates) == "string" then candidates = {candidates} end
            for _, filename in candidates do
                if isfile(filename) then return filename end
                for _, directory in self.AssetDirectories do
                    local path = directory .. "/" .. filename
                    if isfile(path) then return path end
                end
            end
            return nil
        end
        local function localFont(name, candidates, weight, fallback)
            local file = Library:ResolveAsset(candidates)
            if not file then
                warn("[UI Library] Font asset missing: " .. tostring(candidates[1]))
                return fallback
            end
            local manifest = Library.Directory .. "/Fonts/" .. name .. ".font"
            writefile(manifest, Services.HttpService:JSONEncode({name = name, faces = {
                {name = "Regular", weight = weight, style = "normal", assetId = getcustomasset(file)},
            }}))
            return Font.new(getcustomasset(manifest), weight == 700 and Enum.FontWeight.Bold or Enum.FontWeight.Regular)
        end
        Fonts.Main = localFont("MainVerdana", {"main-verdana.ttf", "main-verdana.otf"}, 400, Font.fromEnum(Enum.Font.Arial))

        Fonts.MainBold = localFont("Tahoma8ptBoldWindowsXP", {
            "tahoma-8pt-bold-windows-xp.ttf", "tahoma-8pt-bold-windows-xp.otf",
            "tahoma-8pt-bold-windows-xp", "main-verdana-bold.ttf",
        }, 700, Font.fromEnum(Enum.Font.ArialBold))
        local referenceFonts = {Regular = Fonts.Main, Bold = Fonts.MainBold}
        local changingFont = false
        Library.MainFontName = "Reference default"
        Library.FontCatalog = {
            {Name = "Comfortaa", File = "Comfortaa-Regular.ttf"},
            {Name = "Hanken Grotesk SemiBold", File = "HankenGrotesk-SemiBold.ttf"},
            {Name = "Inter Medium", File = "Inter_28pt-Medium.ttf", BoldFile = "Inter_28pt-SemiBold.ttf"},
            {Name = "Inter SemiBold", File = "Inter_28pt-SemiBold.ttf"},
            {Name = "Light Modern", File = "Light Modern.ttf", BoldFile = "HankenGrotesk-SemiBold.ttf"},
            {Name = "Minecraftia", File = "Minecraftia-Regular.ttf"},
            {Name = "ProggyClean", File = "ProggyClean.ttf"},
            {Name = "ProggyTiny", File = "ProggyTiny.ttf"},
            {Name = "Rubik", File = "Rubik-Regular.ttf"},
            {Name = "Tahoma Modern Bold", File = "Tahoma-Modern-Bold.ttf"},
            {Name = "Tahoma Modern", File = "Tahoma-Modern.ttf", BoldFile = "Tahoma-Modern-Bold.ttf"},
            {Name = "Verdana", File = "Verdana-Font.ttf"},
            {Name = "fs Tahoma 8px", File = "fs-tahoma-8px.ttf"},
            {Name = "OpenSansPX", File = "open-sans-px.ttf"},
            {Name = "Smallest Pixel-7", File = "smallest_pixel-7.ttf"},
            {Name = "Tahoma XP Bold", File = "tahoma_bold.ttf"},
        }
        Library.FontOptions = {"Reference default"}
        local fontCache = {}
        for _, entry in Library.FontCatalog do table.insert(Library.FontOptions, entry.Name) end
        local function collectionAsset(filename)
            local candidates = {}
            for _, directory in Library.AssetDirectories do table.insert(candidates, directory .. "/font-collection/" .. filename) end
            local file = Library:ResolveAsset(candidates)
            if not file then
                local directory = "gamehaxx/assets/font-collection"
                for _, path in {"gamehaxx", "gamehaxx/assets", directory} do if not isfolder(path) then makefolder(path) end end
                local data = game:HttpGet("https://raw.githubusercontent.com/i77lhm/storage/main/fonts/" .. Services.HttpService:UrlEncode(filename))
                assert(data:sub(1, 4) == "\0\1\0\0" or data:sub(1, 4) == "OTTO", "Invalid font download: " .. filename)
                file = directory .. "/" .. filename
                writefile(file, data)
            end
            return getcustomasset(file)
        end
        Library.SetMainFont = function(self, name)
            local faces = referenceFonts
            if name ~= "Reference default" then
                local selected
                for _, entry in self.FontCatalog do if entry.Name == name then selected = entry; break end end
                assert(selected, "Unknown UI font: " .. tostring(name))
                faces = fontCache[name]
                if not faces then
                    local regularAsset = collectionAsset(selected.File)
                    local boldAsset = selected.BoldFile and collectionAsset(selected.BoldFile) or regularAsset
                    local manifest = self.Directory .. "/Fonts/Collection-" .. selected.File:gsub("[^%w%-]", "_") .. ".font"
                    writefile(manifest, Services.HttpService:JSONEncode({name = selected.Name, faces = {
                        {name = "Regular", weight = 400, style = "normal", assetId = regularAsset},
                        {name = "Bold", weight = 700, style = "normal", assetId = boldAsset},
                    }}))
                    local family = getcustomasset(manifest)
                    faces = {Regular = Font.new(family, Enum.FontWeight.Regular), Bold = Font.new(family, Enum.FontWeight.Bold)}
                    fontCache[name] = faces
                end
            end
            for _, object in mainTextObjects do
                if object.Parent then
                    if object.FontFace == Fonts.MainBold then object:SetAttribute("MainFontRole", "Bold")
                    elseif object.FontFace == Fonts.Main then object:SetAttribute("MainFontRole", "Regular") end
                end
            end
            changingFont = true
            Fonts.Main, Fonts.MainBold = faces.Regular, faces.Bold
            self.MainFontName = name
            for _, object in mainTextObjects do
                if object.Parent then object.FontFace = object:GetAttribute("MainFontRole") == "Bold" and Fonts.MainBold or Fonts.Main end
            end
            changingFont = false
            for _, callback in mainTextLayouts do callback(self.MainTextSize) end
            return faces.Regular
        end
        local originalCreate = Library.Create
        Library.Create = function(self, class, properties)
            properties = properties or {}
            if class == "TextLabel" or class == "TextBox" or class == "TextButton" then
                if properties.TextSize == nil then properties.TextSize = Library.MainTextSize end
                if properties.TextScaled == nil then properties.TextScaled = false end
            end
            local object = originalCreate(self, class, properties)
            if class == "TextLabel" or class == "TextBox" or class == "TextButton" then
                if properties.FontFace == nil or properties.FontFace == Fonts.Main or properties.FontFace == Fonts.MainBold then
                    table.insert(mainTextObjects, object.Instance)
                    object.Instance:SetAttribute("MainFontRole", properties.FontFace == Fonts.MainBold and "Bold" or "Regular")
                    Library:Connect(object.Instance:GetPropertyChangedSignal("FontFace"), function()
                        if changingFont or not object.Instance.Parent then return end
                        if object.Instance.FontFace == Fonts.MainBold then object.Instance:SetAttribute("MainFontRole", "Bold")
                        elseif object.Instance.FontFace == Fonts.Main then object.Instance:SetAttribute("MainFontRole", "Regular") end
                    end)
                end
            end
            return object
        end
        Library.SetMainTextSize = function(self, value)
            local size = math.clamp(math.round(tonumber(value) or self.MainTextSize), 6, 48)
            self.MainTextSize = size

            for _, object in mainTextObjects do
                if object.Parent then
                    object.TextSize = size
                    object.TextScaled = false
                end
            end
            for _, callback in mainTextLayouts do callback(size) end
            return size
        end

        local fontReady, fontError = pcall(function()
            Library:SetMainFont("Inter Medium")
        end)
        if not fontReady then
            warn("[UI Library] Inter Medium could not be loaded; using the fallback font: " .. tostring(fontError))
        end

        Library.GlowStrength = {Main = 20, Colorpicker = 6}
        local glowInstances = {
            Main = setmetatable({}, {__mode = "k"}),
            Colorpicker = setmetatable({}, {__mode = "k"}),
        }
        Library.RegisterGlow = function(self, kind, glow, initialTransparency)
            local registry = assert(glowInstances[kind], "Unknown glow kind: " .. tostring(kind))
            local object = glow and (glow.Instance or glow)
            if not (object and object:IsA("ImageLabel")) then return end
            registry[object] = true
            if initialTransparency ~= nil then

                object.ImageTransparency = math.clamp(tonumber(initialTransparency) or 0.7, 0, 1)
            else
                object.ImageTransparency = 1 - self.GlowStrength[kind] / 100
            end
            return object
        end
        Library.SetGlowStrength = function(self, kind, strength)
            local registry = assert(glowInstances[kind], "Unknown glow kind: " .. tostring(kind))
            local value = math.clamp(tonumber(strength) or self.GlowStrength[kind], 0, 100)
            self.GlowStrength[kind] = value
            for object in registry do
                if object.Parent then
                    object.ImageTransparency = 1 - value / 100
                end
            end
            return value
        end
        Library.SetMainGlowStrength = function(self, strength)
            return self:SetGlowStrength("Main", strength)
        end
        Library.SetColorpickerGlowStrength = function(self, strength)
            return self:SetGlowStrength("Colorpicker", strength)
        end

        local function frame(parent, position, size, color, z)
            return Library:Create("Frame", {Parent = parent, Position = position, Size = size,
                BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = z or 2})
        end
        local function labelStyle(object, bold)
            object.FontFace = bold and Fonts.MainBold or Fonts.Main
            object.TextSize = Library.MainTextSize
            object.TextScaled = false
            object.TextWrapped = false
            object.RichText = false
            object.TextTruncate = Enum.TextTruncate.None
            object.ClipsDescendants = false
            object.TextStrokeTransparency = 1
            object.TextColor3 = palette.White
            for _, child in object:GetChildren() do
                if child:IsA("UIStroke") then
                    child.Transparency = 0
                    child.Thickness = 1
                    child.Color = Color3.new(0, 0, 0)
                    child.LineJoinMode = Enum.LineJoinMode.Miter
                end
            end
        end
        local originalWindow = Library.CreateWindow
        Library.CreateWindow = function(self, data)
            data = table.clone(data or {})
            data.Size = data.Size or UDim2.fromOffset(452, 603)
            local window = originalWindow(self, data)
            window.ReferenceWindow = true
            window.ReferenceTabs = {}
            window.Title = data.Title or ((data.Prefix or "gamehaxx ") .. (data.Suffix or "remake"))
            local items = window.Items
            local root = items.Menu.Instance

            local background = items.Title.Instance.Parent
            local inline = background.Parent
            items.MainBackground = {Instance = background}
            items.MainInline = {Instance = inline}
            root.Name = "GamehaxxMainWindow"
            root.BackgroundColor3 = palette.OuterOutline
            root.BorderSizePixel = 0
            root.ClipsDescendants = false
            root.ZIndex = 2
            items.Menu:Themify("Accent", "BackgroundColor3")
            inline.Position = UDim2.fromOffset(1, 1)
            inline.Size = UDim2.new(1, -2, 1, -2)
            inline.BackgroundColor3 = palette.Border
            background.Position = UDim2.fromOffset(1, 1)
            background.Size = UDim2.new(1, -2, 1, -2)
            background.BackgroundColor3 = palette.Window
            local title = items.Title.Instance
            labelStyle(title, false)
            title.Position = UDim2.fromOffset(5, 1)
            title.Size = UDim2.new(1, -14, 0, 16)
            title.AutomaticSize = Enum.AutomaticSize.None
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextYAlignment = Enum.TextYAlignment.Top
            title.Text = window.Title
            Library:Connect(title:GetPropertyChangedSignal("Text"), function()
                if title.Text ~= window.Title then title.Text = window.Title end
            end)
            local panel = items.PageHolderOutline.Instance
            panel.Position = UDim2.fromOffset(5, 16)
            panel.Size = UDim2.new(1, -10, 1, -24)
            panel.BackgroundColor3 = palette.Border
            items.PageHolderInline.Instance.BackgroundColor3 = palette.Outer
            items.BackgroundInner.Instance.Position = UDim2.fromOffset(0, 0)
            items.BackgroundInner.Instance.Size = UDim2.fromScale(1, 1)
            items.BackgroundInner.Instance.BackgroundColor3 = palette.Outer
            local strip = items.TabButtonOutline.Instance

            strip.Position = UDim2.fromOffset(4, 5)
            strip.Size = UDim2.new(1, -8, 0, 14)
            strip.BackgroundTransparency = 1
            strip.ClipsDescendants = false
            items.InlineLine.Instance.Visible = false
            items.OutlineLine.Instance.Visible = false
            local oldHolder = items.TabButtonHolder.Instance
            local tabLayout = oldHolder:FindFirstChildOfClass("UIListLayout")
            items.TabButtonHolder = Library:Create("ScrollingFrame", {Parent = strip,
                Name = "MainTabStrip", BackgroundTransparency = 1, BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.fromOffset(0, 14),
                AutomaticCanvasSize = Enum.AutomaticSize.None, ScrollingDirection = Enum.ScrollingDirection.X,
                ScrollingEnabled = false, ScrollBarThickness = 0, ClipsDescendants = true,
                ElasticBehavior = Enum.ElasticBehavior.Never,
                ScrollBarImageColor3 = palette.Accent, ZIndex = 2})
            local tabHolder = items.TabButtonHolder.Instance
            tabLayout.Parent = tabHolder
            oldHolder:Destroy()
            tabLayout.Padding = UDim.new(0, 0)
            tabLayout.HorizontalFlex = Enum.UIFlexAlignment.None
            tabLayout.VerticalFlex = Enum.UIFlexAlignment.None
            tabLayout.VerticalAlignment = Enum.VerticalAlignment.Top
            local glow = Library:Create("ImageLabel", {Parent = root.Parent, Name = "MainWindowGlow",
                Image = "rbxassetid://18245826428", ImageColor3 = Themes.Preset.Accent,
                ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(21, 21, 79, 79),
                ImageTransparency = data.GlowTransparency or 0.7, BackgroundTransparency = 1,
                BorderSizePixel = 0, Active = false, ZIndex = 1}):Themify("Accent", "ImageColor3")
            items.MainGlow = glow
            Library:RegisterGlow("Main", glow, data.GlowTransparency)

            items.MainContour = {
                frame(root, UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 1), palette.OuterOutline, 6),
                frame(root, UDim2.new(0, 0, 1, -1), UDim2.new(1, 0, 0, 1), palette.OuterOutline, 6),
                frame(root, UDim2.fromOffset(0, 1), UDim2.new(0, 1, 1, -2), palette.OuterOutline, 6),
                frame(root, UDim2.new(1, -1, 0, 1), UDim2.new(0, 1, 1, -2), palette.OuterOutline, 6),
            }
            for _, contour in items.MainContour do contour:Themify("Accent", "BackgroundColor3") end
            local snapping = false
            local function alignPixels()
                if snapping then return end
                snapping = true
                local position, size = root.Position, root.Size
                local snappedPosition = UDim2.fromOffset(math.round(position.X.Offset), math.round(position.Y.Offset))
                local snappedSize = UDim2.fromOffset(math.round(size.X.Offset), math.round(size.Y.Offset))
                if position ~= snappedPosition then root.Position = snappedPosition end
                if size ~= snappedSize then root.Size = snappedSize end
                local glowPosition = snappedPosition + UDim2.fromOffset(-14, -14)
                local glowSize = snappedSize + UDim2.fromOffset(28, 28)
                if glow.Instance.Position ~= glowPosition then glow.Instance.Position = glowPosition end
                if glow.Instance.Size ~= glowSize then glow.Instance.Size = glowSize end
                if glow.Instance.Visible ~= root.Visible then glow.Instance.Visible = root.Visible end
                snapping = false
            end
            Library:Connect(root:GetPropertyChangedSignal("Position"), alignPixels)
            Library:Connect(root:GetPropertyChangedSignal("Size"), alignPixels)
            Library:Connect(root:GetPropertyChangedSignal("Visible"), alignPixels)
            alignPixels()
            local layingOut = false
            local function fitWindowChrome()
                if layingOut or not root.Parent then return end
                layingOut = true
                local native = Library.MainFontName == "Reference default" and Library.MainTextSize == 10
                local titleHeight = native and 16 or math.max(16, Library.MainTextSize + 6, math.ceil(title.TextBounds.Y) + 4)
                title.TextWrapped = not native
                title.Size = UDim2.new(1, -14, 0, titleHeight)
                panel.Position = UDim2.fromOffset(5, titleHeight)
                panel.Size = UDim2.new(1, -10, 1, -titleHeight - 8)
                local tabHeight, totalWidth = 14, 0
                for _, tab in window.ReferenceTabs do
                    local tabTitle = tab.Items.Title.Instance
                    local width = native and math.max(36, #tab.Text * 5 + 10)
                        or math.max(36, math.ceil(tabTitle.TextBounds.X) + 10, #tab.Text * Library.MainTextSize * 0.45 + 10)
                    width = math.max(width, tab.ReferenceRequestedWidth or 0)
                    local height = native and 14 or math.max(14, Library.MainTextSize + 4, math.ceil(tabTitle.TextBounds.Y) + 4)
                    tab.Items.Button.Instance.Size = UDim2.fromOffset(math.ceil(width), height)
                    tabHeight = math.max(tabHeight, height)
                    totalWidth += math.ceil(width)
                end
                local overflow = totalWidth > strip.AbsoluteSize.X
                local extra = overflow and 3 or 0
                strip.Size = UDim2.new(1, -8, 0, tabHeight + extra)
                tabHolder.ScrollBarThickness = overflow and 2 or 0
                tabHolder.ScrollingEnabled = overflow
                tabHolder.CanvasSize = UDim2.fromOffset(totalWidth, tabHeight)
                if not overflow then tabHolder.CanvasPosition = Vector2.zero end
                window.ReferenceTabHeight = tabHeight
                window.ReferencePageTop = 5 + tabHeight + extra + 1
                for _, tab in window.ReferenceTabs do
                    tab.Items.Button.Instance.Size = UDim2.fromOffset(tab.Items.Button.Instance.Size.X.Offset, tabHeight)
                    if tab.ReferenceRelayout then tab.ReferenceRelayout() end
                end
                if window.TabInfo and window.TabInfo.ReferenceTab and window.ReferenceScrollToTab then
                    window.ReferenceScrollToTab(window.TabInfo)
                end
                layingOut = false
            end
            window.ReferenceChromeLayout = fitWindowChrome
            window.ReferenceScrollToTab = function(tab)
                local left = 0
                for _, previous in window.ReferenceTabs do
                    if previous == tab then break end
                    left += previous.Items.Button.Instance.Size.X.Offset
                end
                local right = left + tab.Items.Button.Instance.Size.X.Offset
                local scroll = tabHolder.CanvasPosition.X
                if left < scroll then scroll = left
                elseif right > scroll + strip.AbsoluteSize.X then scroll = right - strip.AbsoluteSize.X end
                tabHolder.CanvasPosition = Vector2.new(math.max(0, scroll), 0)
            end
            Library:Connect(tabHolder:GetPropertyChangedSignal("CanvasPosition"), function()
                for _, tab in window.ReferenceTabs do if tab.ReferenceRelayout then tab.ReferenceRelayout() end end
            end)
            Library:Connect(title:GetPropertyChangedSignal("TextBounds"), fitWindowChrome)
            Library:Connect(strip:GetPropertyChangedSignal("AbsoluteSize"), fitWindowChrome)
            Library:RegisterMainTextLayout(fitWindowChrome)
            return window
        end

        local originalOpenPage = Library.OpenPage
        Library.OpenPage = function(self)
            local window = self.Window
            if not window or not window.ReferenceWindow then return originalOpenPage(self) end
            local function selectTab(tab, selected)
                local items = tab.Items
                local page = items.Page.Instance
                page.Parent = window.Items.BackgroundInner.Instance
                page.Visible = selected and not tab.ReferenceBuilding
                if items.PageBorder then items.PageBorder.Instance.Visible = selected end
                if selected and tab.ReferenceRelayout then tab.ReferenceRelayout() end
                local button = items.Button.Instance
                button.BackgroundTransparency = selected and 0 or 1
                button.BackgroundColor3 = Color3.new(1, 1, 1)
                items.Title.Instance.TextColor3 = selected and palette.White or palette.Inactive
                items.Title.Instance.FontFace = selected and Fonts.MainBold or Fonts.Main

                items.Left.Instance.Visible = false
                items.Right.Instance.Visible = false
                items.Filler.Instance.Visible = false
                items.Stroke.Instance.Enabled = false
                items.Stroke.Instance.Transparency = 1
                if items.ReferenceLine then items.ReferenceLine.Instance.Visible = selected end
                if items.ReferenceLeftEdge then items.ReferenceLeftEdge.Instance.Visible = selected end
                if items.ReferenceRightEdge then items.ReferenceRightEdge.Instance.Visible = selected end
                tab.Tweening = false
            end
            for _, tab in window.ReferenceTabs do selectTab(tab, tab == self) end

            if not self.ReferenceTab then selectTab(self, true) end
            for owner, popup in Library.PopupOwners or {} do
                local trigger = owner.Items and owner.Items.Object and owner.Items.Object.Instance
                if trigger and popup.Visible and trigger:IsDescendantOf(window.Items.Menu.Instance) then
                    local ancestor, hidden = trigger, false
                    while ancestor do
                        if ancestor:IsA("GuiObject") and not ancestor.Visible then hidden = true; break end
                        ancestor = ancestor.Parent
                    end
                    if hidden and owner.SetVisible then owner.SetVisible(false, true) end
                end
            end
            window.TabInfo = self
            if self.ReferenceDeferredBuild then Library:StartReferenceDeferredTab(self) end
            if self.ReferenceTab and window.ReferenceScrollToTab then window.ReferenceScrollToTab(self) end
        end

        Library.ReferenceTabWidth = 36
        local originalTab = Library.AddTab
        Library.AddTab = function(self, data)
            data = data or {}
            local tab = originalTab(self, data)
            if not self.ReferenceWindow then return tab end
            local items = tab.Items
            tab.ReferenceTab = true
            tab.ReferenceRequestedWidth = data.Width
            tab.ReferenceSections = {}
            table.insert(self.ReferenceTabs, tab)
            local button = items.Button.Instance
            button.SizeConstraint = Enum.SizeConstraint.RelativeXY
            button.Size = UDim2.fromOffset(data.Width or math.max(36, #tab.Text * 5 + 10), 14)
            button.AutomaticSize = Enum.AutomaticSize.None
            items.Title.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Title.Instance.Size = UDim2.fromScale(1, 1)
            items.Title.Instance.TextXAlignment = Enum.TextXAlignment.Center
            items.Title.Instance.TextYAlignment = Enum.TextYAlignment.Center
            labelStyle(items.Title.Instance, false)

            if not Library.ReferenceTabGradient then
                Library.ReferenceTabGradient = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 66, 84)),
                    ColorSequenceKeypoint.new(1 / 19, Color3.fromRGB(49, 50, 64)),
                    ColorSequenceKeypoint.new(2 / 19, Color3.fromRGB(36, 37, 48)),
                    ColorSequenceKeypoint.new(3 / 19, Color3.fromRGB(26, 26, 34)),
                    ColorSequenceKeypoint.new(4 / 19, palette.Window),
                    ColorSequenceKeypoint.new(1, palette.Window),
                })
            end
            items.UIGradient.Instance.Color = Library.ReferenceTabGradient
            items.UIGradient.Instance.Rotation = 90

            items.Left.Instance.Visible = false
            items.Right.Instance.Visible = false
            items.Left.Instance.BackgroundTransparency = 1
            items.Right.Instance.BackgroundTransparency = 1
            items.Stroke.Instance.Enabled = false
            items.Stroke.Instance.Transparency = 1

            items.ReferenceLine = frame(button, UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 1), Themes.Preset.Accent, 3):Themify("Accent", "BackgroundColor3")
            items.ReferenceLeftEdge = frame(button, UDim2.fromOffset(0, 1),
                UDim2.new(0, 1, 1, -1), palette.Border, 4)
            items.ReferenceRightEdge = frame(button, UDim2.new(1, -1, 0, 1),
                UDim2.new(0, 1, 1, -1), palette.Border, 4)

            for _, contour in {items.ReferenceLine, items.ReferenceLeftEdge,
                items.ReferenceRightEdge} do
                contour.Instance.Visible = false
            end
            local page = items.Page.Instance
            page.Position = UDim2.fromOffset(5, 20)
            page.Size = UDim2.new(1, -10, 1, -25)
            page.BackgroundTransparency = 0
            page.BackgroundColor3 = palette.Window

            page.ClipsDescendants = true

            local pageBorder = frame(self.Items.BackgroundInner.Instance, UDim2.fromOffset(4, 19),
                UDim2.new(1, -8, 1, -23), palette.Window, 1)
            items.PageBorder = pageBorder
            local borderParent = pageBorder.Instance
            local tabWidth = button.Size.X.Offset
            local gapStart = 0
            for _, earlier in self.ReferenceTabs do
                if earlier == tab then break end
                gapStart += earlier.Items.Button.Instance.Size.X.Offset
            end
            local gapEnd = gapStart + tabWidth
            items.ReferencePageTopBefore = frame(borderParent, UDim2.fromOffset(0, 0),
                UDim2.fromOffset(gapStart, 1), palette.Border, 2)
            items.ReferencePageTopAfter = frame(borderParent, UDim2.fromOffset(gapEnd, 0),
                UDim2.new(1, -gapEnd, 0, 1), palette.Border, 2)
            items.ReferencePageLeft = frame(borderParent, UDim2.fromOffset(0, 0),
                UDim2.new(0, 1, 1, 0), palette.Border, 2)
            items.ReferencePageRight = frame(borderParent, UDim2.new(1, -1, 0, 0),
                UDim2.new(0, 1, 1, 0), palette.Border, 2)
            items.ReferencePageBottom = frame(borderParent, UDim2.new(0, 0, 1, -1),
                UDim2.new(1, 0, 0, 1), palette.Border, 2)
            Library:Connect(page:GetPropertyChangedSignal("Visible"), function()
                items.PageBorder.Instance.Visible = page.Visible
            end)
            local pageLayout = page:FindFirstChildOfClass("UIListLayout")
            pageLayout.Padding = UDim.new(0, 4)
            pageLayout.HorizontalFlex = Enum.UIFlexAlignment.None
            pageLayout.VerticalFlex = Enum.UIFlexAlignment.None
            pageLayout.VerticalAlignment = Enum.VerticalAlignment.Top
            local pagePadding = Library:Create("UIPadding", {Parent = page, PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 4)})
            local function sizeColumns()
                local pageTop = self.ReferencePageTop or 20
                page.Position = UDim2.fromOffset(5, pageTop)
                page.Size = UDim2.new(1, -10, 1, -pageTop - 5)
                borderParent.Position = UDim2.fromOffset(4, pageTop - 1)
                borderParent.Size = UDim2.new(1, -8, 1, -pageTop - 3)
                local topPadding = 8
                for _, section in tab.ReferenceSections do
                    topPadding = math.max(topPadding, 8 + math.ceil(((section.ReferenceHeaderHeight or 14) - 14) / 2))
                end
                pagePadding.Instance.PaddingTop = UDim.new(0, topPadding)
                local start = -self.Items.TabButtonHolder.Instance.CanvasPosition.X
                for _, earlier in self.ReferenceTabs do
                    if earlier == tab then break end
                    start += earlier.Items.Button.Instance.Size.X.Offset
                end
                local edge = math.max(0, borderParent.AbsoluteSize.X)
                local before = math.clamp(start, 0, edge)
                local after = math.clamp(start + button.Size.X.Offset, 0, edge)
                items.ReferencePageTopBefore.Instance.Size = UDim2.fromOffset(before, 1)
                items.ReferencePageTopAfter.Instance.Position = UDim2.fromOffset(after, 0)
                items.ReferencePageTopAfter.Instance.Size = UDim2.new(1, -after, 0, 1)
                local width = page.AbsoluteSize.X
                local available = math.max(tab.Columns, width - 8 - 4 * (tab.Columns - 1))
                for index = 1, tab.Columns do
                    local column = items[tostring(index)].Instance
                    local left = math.floor(available * (index - 1) / tab.Columns)
                    local right = math.floor(available * index / tab.Columns)

                    column.AutomaticSize = Enum.AutomaticSize.None
                    column.Size = UDim2.new(0, right - left, 1, -topPadding - 5)
                    column:FindFirstChildOfClass("UIListLayout").Padding = UDim.new(0, 6 + topPadding - 8)
                end
            end
            for index = 1, tab.Columns do
                local column = items[tostring(index)].Instance
                column.ClipsDescendants = false
                column.ScrollingDirection = Enum.ScrollingDirection.Y
                column.AutomaticCanvasSize = Enum.AutomaticSize.Y
                column.CanvasSize = UDim2.fromOffset(0, 0)
                column.LayoutOrder = index
                local layout = column:FindFirstChildOfClass("UIListLayout")
                layout.Padding = UDim.new(0, 6)
                layout.HorizontalFlex = Enum.UIFlexAlignment.None
                layout.VerticalFlex = Enum.UIFlexAlignment.None
            end
            tab.ReferenceRelayout = sizeColumns
            Library:Connect(page:GetPropertyChangedSignal("AbsoluteSize"), sizeColumns)
            Library:Connect(items.Title.Instance:GetPropertyChangedSignal("TextBounds"), self.ReferenceChromeLayout)
            sizeColumns()
            self.ReferenceChromeLayout()
            self.TabInfo:OpenPage()
            return tab
        end

        local originalElements = Library.CreateElements
        Library.CreateElements = function(self, data)
            local elements = originalElements(self, data)
            local layout = elements.Items.Elements.Instance:FindFirstChildOfClass("UIListLayout")
            layout.Padding = UDim.new(0, 0)
            return elements
        end
        local originalSection = Library.AddSection
        Library.AddSection = function(self, data)
            local section = originalSection(self, data)
            local items = section.Items
            if not items.Outline then return section end
            local outline, inline, background = items.Outline.Instance, items.Inline.Instance, items.Background.Instance
            outline.AutomaticSize = Enum.AutomaticSize.None
            outline.Size = UDim2.new(1, 0, 0, 15)
            outline.BackgroundColor3 = palette.Border
            outline.ClipsDescendants = false
            for _, object in {outline, inline} do
                local padding = object:FindFirstChildOfClass("UIPadding")
                if padding then padding:Destroy() end
            end
            inline.AutomaticSize = Enum.AutomaticSize.None
            inline.Position = UDim2.fromOffset(1, 1)
            inline.Size = UDim2.new(1, -2, 1, -2)
            inline.BackgroundColor3 = palette.Section
            background.AutomaticSize = Enum.AutomaticSize.None
            background.Position = UDim2.fromOffset(0, 0)
            background.Size = UDim2.fromScale(1, 1)
            background.BackgroundColor3 = palette.Section
            items.TopBar.Instance.Visible = false
            items.AccentLine = frame(outline, UDim2.fromOffset(1, 0), UDim2.new(1, -2, 0, 2), Themes.Preset.Accent, 3):Themify("Accent", "BackgroundColor3")
            Library:Create("UIGradient", {Parent = items.AccentLine.Instance, Rotation = 90,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(160, 160, 160))})

            items.TitleTopMask = frame(outline, UDim2.fromOffset(5, -7),
                UDim2.fromOffset(0, 7), palette.Window, 4)
            items.TitleBottomMask = frame(outline, UDim2.fromOffset(5, 0),
                UDim2.fromOffset(0, 7), palette.Section, 4)
            items.MainTitle = Library:Create("TextLabel", {Parent = outline, Text = section.Title,
                Position = UDim2.fromOffset(5, -7), Size = UDim2.fromOffset(0, 14), AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1, BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 5})
            labelStyle(items.MainTitle.Instance, true)
            Library:Create("UIStroke", {Parent = items.MainTitle.Instance, Color = Color3.new(0, 0, 0),
                Thickness = 1, LineJoinMode = Enum.LineJoinMode.Miter})
            Library:Create("UIPadding", {Parent = items.MainTitle.Instance, PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3)})
            local elements = items.Elements.Instance
            elements.Position = UDim2.fromOffset(4, 8)
            elements.Size = UDim2.new(1, -8, 0, 0)
            elements.ClipsDescendants = false
            local layout = elements:FindFirstChildOfClass("UIListLayout")
            layout.Padding = UDim.new(0, 0)
            local elementsTop = 8
            local function fitSection()
                outline.Size = UDim2.new(1, 0, 0, math.round(layout.AbsoluteContentSize.Y) + elementsTop + 3)
            end
            Library:Connect(layout:GetPropertyChangedSignal("AbsoluteContentSize"), fitSection)
            fitSection()

            local headingMeasure = Library:Create("TextLabel", {Parent = outline, Visible = false,
                Text = section.Title, TextSize = Library.MainTextSize, FontFace = Fonts.MainBold,
                Size = UDim2.fromOffset(191, 10000), TextWrapped = true, BackgroundTransparency = 1,
                BorderSizePixel = 0, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top})
            if self.ReferenceSections then table.insert(self.ReferenceSections, section) end
            local fittingHeading = false
            local function fitHeading()
                if fittingHeading or not outline.Parent then return end
                fittingHeading = true
                local native = Library.MainFontName == "Reference default" and Library.MainTextSize == 10
                local available = math.max(6, outline.AbsoluteSize.X - 10)
                headingMeasure.Instance.Size = UDim2.fromOffset(math.max(1, available - 6), 10000)
                local height = native and 14 or math.max(14, Library.MainTextSize + 4, math.ceil(headingMeasure.Instance.TextBounds.Y) + 4)
                section.ReferenceHeaderHeight = height
                items.MainTitle.Instance.AutomaticSize = native and Enum.AutomaticSize.X or Enum.AutomaticSize.None
                items.MainTitle.Instance.TextWrapped = not native
                local titleTop = math.ceil(height / 2)
                local titleWidth = math.min(available, math.ceil(headingMeasure.Instance.TextBounds.X) + 6)
                items.MainTitle.Instance.Position = UDim2.fromOffset(5, -titleTop)
                items.MainTitle.Instance.Size = UDim2.fromOffset(native and 0 or titleWidth, height)

                items.TitleTopMask.Instance.Position = UDim2.fromOffset(5, -titleTop)
                items.TitleTopMask.Instance.Size = UDim2.fromOffset(titleWidth, titleTop)
                items.TitleBottomMask.Instance.Position = UDim2.fromOffset(5, 0)
                items.TitleBottomMask.Instance.Size = UDim2.fromOffset(titleWidth, height - titleTop)
                elementsTop = 8 + math.ceil((height - 14) / 2)
                elements.Position = UDim2.fromOffset(4, elementsTop)
                fitSection()
                if self.ReferenceRelayout then self.ReferenceRelayout() end
                fittingHeading = false
            end
            Library:Connect(headingMeasure.Instance:GetPropertyChangedSignal("TextBounds"), fitHeading)
            Library:Connect(outline:GetPropertyChangedSignal("AbsoluteSize"), fitHeading)
            Library:RegisterMainTextLayout(fitHeading)
            fitHeading()  
            if section.Description then

                local description = Library:Create("TextLabel", {Parent = elements, LayoutOrder = -1,
                    Text = section.Description, Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1,
                    TextColor3 = palette.Text, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0, TextSize = Library.MainTextSize, FontFace = Fonts.Main})
                local function fitDescription()
                    description.Instance.Size = UDim2.new(1, 0, 0, math.max(28, math.ceil(description.Instance.TextBounds.Y) + 5))
                end
                Library:Connect(description.Instance:GetPropertyChangedSignal("TextBounds"), fitDescription)

                Library:Connect(elements:GetPropertyChangedSignal("Position"), function()
                    if elements.Position ~= UDim2.fromOffset(4, elementsTop) then elements.Position = UDim2.fromOffset(4, elementsTop) end
                end)
            end
            return section
        end
        local originalMenuVisible = Library.SetMenuVisible
        Library.SetMenuVisible = function(self, visible)
            if not self.ReferenceWindow then return originalMenuVisible(self, visible) end
            self.Open = visible
            self.Items.Menu.Instance.Visible = visible
            Library.Elements.Instance.Enabled = visible
            if not visible then
                for owner, popup in self.PopupOwners or Library.PopupOwners or {} do
                    owner.Open, owner.Tweening = false, false
                    if popup.Parent then popup.Visible = false end
                end
                for _, gui in Library.Elements.Instance:GetChildren() do
                    if gui:IsA("GuiObject") then gui.Visible = false end
                end
            end
        end
    end

    do
        local controlFill = Color3.fromRGB(31, 31, 41)
        local uncheckedFill = Color3.fromRGB(31, 31, 41)
        local outlineFill = Color3.fromRGB(30, 30, 39)
        local function instance(item)
            return item and item.Instance
        end
        local function textStyle(object, outline)
            if not object then return end
            object.FontFace = Fonts.Main
            object.TextSize = Library.MainTextSize or 11
            object.TextScaled = false
            object.TextWrapped = false
            object.TextTruncate = Enum.TextTruncate.None
            object.RichText = false
            object.BackgroundTransparency = 1
            object.BorderSizePixel = 0
            object.ClipsDescendants = false
            for _, child in object:GetChildren() do
                if child:IsA("UIStroke") then
                    child.Transparency = object:IsA("TextBox") and object.Text == "" and 1 or 0
                    child.Thickness = 1
                    child.Color = Color3.new(0, 0, 0)
                end
            end
        end
        local function fixRowText(row)
            for _, object in row:GetDescendants() do
                if object:IsA("TextLabel") or object:IsA("TextBox") or object:IsA("TextButton") then
                    textStyle(object, false)
                end
            end
        end
        local function rowStyle(control, height)
            local row = instance(control.Items.Object)
            row.AutomaticSize = Enum.AutomaticSize.None
            row.Size = UDim2.new(1, 0, 0, height)
            row.BackgroundTransparency = 1
            row.BorderSizePixel = 0
            row.ClipsDescendants = false
            fixRowText(row)
            return row
        end
        local function rowTitle(row)
            for _, child in row:GetChildren() do
                if child:IsA("TextLabel") then return child end
            end
        end
        local function caption(object, y, x)
            if not object then return end
            textStyle(object, false)
            object.AutomaticSize = Enum.AutomaticSize.None
            object.Position = UDim2.fromOffset(x or 0, y or 2)
            object.Size = UDim2.new(1, -(x or 0), 0, 16)
            object.TextXAlignment = Enum.TextXAlignment.Left
            object.TextYAlignment = Enum.TextYAlignment.Center
        end
        local function flatten(outer, color, slider)
            outer.BackgroundColor3 = color or Themes.Preset.Outline
            outer.BackgroundTransparency = 0
            outer.BorderSizePixel = 0

            for _, child in outer:GetChildren() do
                if child:IsA("Frame") then
                    child.Position = UDim2.fromOffset(slider and 0 or 1, slider and 0 or 1)
                    child.Size = UDim2.new(1, slider and 0 or -2, 1, slider and 0 or -2)
                    child.BackgroundTransparency = 1
                    child.BorderSizePixel = 0
                    for _, grandchild in child:GetChildren() do
                        if grandchild:IsA("Frame") then
                            grandchild.Position = UDim2.fromOffset(0, 0)
                            grandchild.Size = UDim2.fromScale(1, 1)
                            grandchild.BackgroundColor3 = Color3.new(1, 1, 1)
                            grandchild.BackgroundTransparency = 0
                            grandchild.BorderSizePixel = 0
                            for _, gradient in grandchild:GetChildren() do
                                if gradient:IsA("UIGradient") then gradient.Enabled = false end
                            end
                            Library:Create("UIGradient", {Parent = grandchild; Rotation = 90;
                                Color = ColorSequence.new(Color3.fromRGB(33, 33, 44), Color3.fromRGB(28, 28, 38))})
                        end
                    end
                end
            end
            if slider then
                Library:Create("UIStroke", {Parent = outer; Color = Themes.Preset.Outline;
                    Thickness = 1; Transparency = 0; ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    LineJoinMode = Enum.LineJoinMode.Miter})
            end
        end
        local function hostStyle(holder, height)
            if not holder then return end
            local object = holder.Instance
            object.AnchorPoint = Vector2.new(0, 0)
            object.Position = UDim2.new(1, 0, 0, 0)
            object.Size = UDim2.new(0, 0, 0, height or 20)
            object.BackgroundTransparency = 1
            object.ClipsDescendants = false
            local layout = object:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout.FillDirection = Enum.FillDirection.Horizontal
                layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                layout.VerticalAlignment = Enum.VerticalAlignment.Center
                layout.Padding = UDim.new(0, 7)
            end
        end
        local function pinnedTween(item, properties)
            if not item then return end
            item.FontPinnedProperties = properties
            local originalTween = item.Tween
            item.Tween = function(wrapper, data, ...)
                local updated = table.clone(data)
                for key, value in properties do updated[key] = value end
                return originalTween(wrapper, updated, ...)
            end
        end
        local function syncPopup(control, frame)
            if not frame then return end
            Library.PopupOwners = Library.PopupOwners or setmetatable({}, {__mode = "k"})
            Library.PopupOwners[control] = frame
            control.ReferencePopup = frame
            Library:Connect(frame:GetPropertyChangedSignal("Visible"), function()
                if not frame.Visible then control.Open = false end
            end)
        end
        local function integerWidths(holder, objects, gap, height, inset)
            local layout = holder:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout.Padding = UDim.new(0, gap)
                layout.HorizontalFlex = Enum.UIFlexAlignment.None
                layout.VerticalFlex = Enum.UIFlexAlignment.None
                layout.VerticalAlignment = Enum.VerticalAlignment.Top
            end
            local function update()
                local count = #objects
                if count == 0 then return end

                local width = math.max(0, math.round(holder.AbsoluteSize.X) -
                    2 * (inset or 0) - gap * (count - 1))
                for index, object in objects do
                    local left = math.ceil(width * (index - 1) / count)
                    local right = math.ceil(width * index / count)
                    object.Size = UDim2.fromOffset(right - left, holder:GetAttribute("FontButtonHeight") or height)
                end
            end
            update()
            Library:Connect(holder:GetPropertyChangedSignal("AbsoluteSize"), update)
            return update
        end

        local function fontRowLayout(control, kind)
            local items, row = control.Items, instance(control.Items.Object)
            if not row or (kind == "button" and row:GetAttribute("FontButtonLayout")) then return end
            if kind == "button" then row:SetAttribute("FontButtonLayout", true) end
            local base, working
            local function update(size)
                if working or not row.Parent then return end
                local ancestor = row
                while ancestor do
                    if ancestor.Name == "ReferenceColorpicker" then return end
                    ancestor = ancestor.Parent
                end
                local heading = instance(items.TextLabel or items.Label or items.Title)
                local measured = heading and math.ceil(heading.TextBounds.Y) or size
                local extra = math.max(0, size - 10, measured - 12)
                if extra == 0 and not base then return end
                if not base then
                    base = {Height = row.Size.Y.Offset}
                    for _, key in {"Outline", "TextLabel", "Label", "Title", "Value", "Minus", "Plus"} do
                        local object = instance(items[key])
                        if object and object:IsA("GuiObject") then
                            base[key] = {Position = object.Position, Size = object.Size}
                        end
                    end
                end
                working = true
                local paired = kind == "slider" or ((kind == "dropdown" or kind == "input") and control.Text ~= nil)
                row.Size = UDim2.new(1, 0, 0, base.Height + extra * (paired and 2 or 1))
                for _, key in {"TextLabel", "Label", "Title"} do
                    local object, original = instance(items[key]), base[key]
                    if object and original and original.Size.Y.Scale == 0 and original.Size.Y.Offset > 0 then
                        object.Size = UDim2.new(original.Size.X.Scale, original.Size.X.Offset, 0, original.Size.Y.Offset + extra)
                    end
                end
                local bar, original = instance(items.Outline), base.Outline
                if bar and original then
                    local position, dimensions = original.Position, original.Size
                    if kind == "slider" then
                        bar.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset + extra)
                    elseif kind == "dropdown" or kind == "input" then
                        bar.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset + (paired and extra or 0))
                        bar.Size = UDim2.new(dimensions.X.Scale, dimensions.X.Offset, 0, dimensions.Y.Offset + extra)
                        if items.Indicator then items.Indicator.Instance.Size = UDim2.new(0, 13, 1, 0) end
                    elseif kind == "toggle" then
                        bar.Position = UDim2.new(position.X.Scale, position.X.Offset, 0, position.Y.Offset + math.floor(extra / 2))
                    elseif kind == "button" then
                        row:SetAttribute("FontButtonHeight", original.Size.Y.Offset + extra)
                        items.Object.ReferenceButtonLayout()
                    end
                end
                if kind == "slider" then
                    if items.Value and base.Value then
                        local dimensions = base.Value.Size
                        items.Value.Instance.Size = UDim2.new(dimensions.X.Scale, dimensions.X.Offset, 0, dimensions.Y.Offset + extra)
                    end
                    for _, key in {"Minus", "Plus"} do
                        if items[key] and base[key] then
                            local originalSymbol = base[key]
                            local position = originalSymbol.Position + UDim2.fromOffset(0, extra)
                            items[key].Instance.Position = position
                            items[key].Instance.Size = UDim2.new(originalSymbol.Size.X.Scale, originalSymbol.Size.X.Offset, 0, originalSymbol.Size.Y.Offset + extra)
                            if items[key].FontPinnedProperties then items[key].FontPinnedProperties.Position = position end
                        end
                    end
                end
                if items.ComponentsHolder then
                    local holder = items.ComponentsHolder.Instance
                    holder.Size = UDim2.new(holder.Size.X.Scale, holder.Size.X.Offset, 0, row.Size.Y.Offset)
                end
                working = false
            end
            local initial = true
            Library:RegisterMainTextLayout(function(size)
                if initial then initial = false; task.defer(function() update(Library.MainTextSize) end)
                else update(size) end
            end)
            local heading = instance(items.TextLabel or items.Label or items.Title)
            if heading then
                Library:Connect(heading:GetPropertyChangedSignal("TextBounds"), function() update(Library.MainTextSize) end)
            end
        end

        local originalToggle = Library.AddToggle
        Library.AddToggle = function(self, data)
            data = data or {}
            local toggle = originalToggle(self, data)
            local items = toggle.Items
            local row = rowStyle(toggle, data.RowHeight or 15)
            local box = items.Outline.Instance
            box.Position = UDim2.fromOffset(0, 0)
            box.Size = UDim2.fromOffset(11, 11)
            box.BackgroundColor3 = uncheckedFill
            items.Inline.Instance.Position = UDim2.fromOffset(0, 0)
            items.Inline.Instance.Size = UDim2.fromScale(1, 1)
            items.Inline.Instance.BackgroundTransparency = 1
            items.Gray.Instance.Position = UDim2.fromOffset(0, 0)
            items.Gray.Instance.Size = UDim2.fromScale(1, 1)
            items.Gray.Instance.BackgroundTransparency = 0
            items.Gray.Instance.BackgroundColor3 = uncheckedFill
            items.UIGradient.Instance.Enabled = false
            items.Accent.Instance.Position = UDim2.fromOffset(0, 0)
            items.Accent.Instance.Size = UDim2.fromScale(1, 1)
            Library:Create("UIGradient", {Parent = items.Accent.Instance; Rotation = 90;
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(170, 170, 170))})
            caption(items.TextLabel.Instance, -2, 15)
            items.TextLabel.Instance.Size = UDim2.new(1, -15, 0, 14)
            hostStyle(items.ComponentsHolder, row.Size.Y.Offset)
            local originalSet = toggle.Set
            toggle.Set = function(enabled)
                toggle.Enabled = not not enabled
                return originalSet(toggle.Enabled)
            end
            Library.ConfigFlags[toggle.Flag] = toggle.Set
            fontRowLayout(toggle, "toggle")
            return toggle
        end

        local function sliderStyle(slider, data, range)
            local items = slider.Items
            local height = data.RowHeight or 30
            local offset = data.BarOffset or 13
            local row = rowStyle(slider, height)
            caption(rowTitle(row), (data.LabelY or 0) - 3)
            local bar = items.Outline.Instance
            local barInset = data.BarInset or 8
            bar.Position = UDim2.fromOffset(barInset, offset)
            bar.Size = UDim2.new(1, -(barInset + 12), 0, data.BarHeight or 9)
            flatten(bar, nil, true)
            items.Accent.Instance.BackgroundColor3 = Color3.new(1, 1, 1)
            Library:Create("UIGradient", {Parent = items.Accent.Instance; Rotation = 0;
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Themes.Preset.Accent),
                    ColorSequenceKeypoint.new(0.15, Color3.fromRGB(190, 196, 250)),
                    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(167, 173, 220)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(181, 187, 238)),
                })})
            textStyle(items.Value.Instance, true)
            items.Value.Instance.AutomaticSize = Enum.AutomaticSize.X
            items.Value.Instance.AnchorPoint = Vector2.new(0.5, 0)
            items.Value.Instance.Position = UDim2.fromOffset(0, 0)
            items.Value.Instance.Size = UDim2.new(0, 0, 0, 16)
            items.Value.Instance.ZIndex = 4
            items.Value.Instance.TextXAlignment = Enum.TextXAlignment.Center
            items.Value.Instance.TextYAlignment = Enum.TextYAlignment.Center
            local function placeValue()
                local fill = items.Accent.Instance
                local position = fill.Position.X.Scale * items.Holder.Instance.AbsoluteSize.X + fill.Position.X.Offset
                local width = fill.Size.X.Scale * items.Holder.Instance.AbsoluteSize.X + fill.Size.X.Offset
                local edge = range and (position + width / 2) or (position + width)
                local trackWidth = items.Holder.Instance.AbsoluteSize.X
                local halfText = math.min(items.Value.Instance.AbsoluteSize.X / 2, trackWidth / 2)
                items.Value.Instance.Position = UDim2.fromOffset(
                    math.round(math.clamp(edge, halfText, math.max(halfText, trackWidth - halfText))), 0)
            end
            Library:Connect(bar:GetPropertyChangedSignal("AbsoluteSize"), placeValue)
            Library:Connect(items.Value.Instance:GetPropertyChangedSignal("AbsoluteSize"), placeValue)
            Library:Connect(items.Accent.Instance:GetPropertyChangedSignal("Position"), placeValue)
            Library:Connect(items.Accent.Instance:GetPropertyChangedSignal("Size"), placeValue)
            placeValue()
            if items.Value.Instance:IsA("TextBox") then
                items.Value.Instance.ClearTextOnFocus = false
            end
            local minus = items.Minus
            local plus = items.Plus
            if range then
                minus = Library:Create("TextLabel", {Parent = row; Text = "-"; Active = true;
                    BackgroundTransparency = 1; BorderSizePixel = 0})
                plus = Library:Create("TextLabel", {Parent = row; Text = "+"; Active = true;
                    BackgroundTransparency = 1; BorderSizePixel = 0})
                items.Minus, items.Plus = minus, plus
                minus:OnClick(function()
                    slider.Set(slider.Value[1] - slider.Intervals, slider.Value[2] - slider.Intervals)
                end)
                plus:OnClick(function()
                    slider.Set(slider.Value[1] + slider.Intervals, slider.Value[2] + slider.Intervals)
                end)
            else
                minus.Instance.Parent = row
                plus.Instance.Parent = row
                pinnedTween(items.PlusStroke, {Transparency = 0})
                pinnedTween(items.MinusStroke, {Transparency = 0})
            end
            for _, symbol in {minus, plus} do
                textStyle(symbol.Instance, false)
                symbol.Instance.AutomaticSize = Enum.AutomaticSize.None
                symbol.Instance.Size = UDim2.fromOffset(symbol == minus and 8 or 12, 14)
                symbol.Instance.TextTransparency = 0
                symbol.Instance.Active = true
                symbol.Instance.TextXAlignment = Enum.TextXAlignment.Center
                symbol.Instance.TextYAlignment = Enum.TextYAlignment.Center
                pinnedTween(symbol, {TextTransparency = 0})
            end
            minus.Instance.Position = UDim2.fromOffset(-1, offset - 2)
            plus.Instance.Position = UDim2.new(1, -12, 0, offset - 2)

            pinnedTween(minus, {Position = minus.Instance.Position})
            pinnedTween(plus, {Position = plus.Instance.Position})
            hostStyle(items.ComponentsHolder, 14)
            syncPopup(slider, instance(items.Settings))
            fontRowLayout(slider, "slider")
            if range then
                items.Min.Instance.Size = UDim2.fromOffset(10, 10)
                items.Max.Instance.Size = UDim2.fromOffset(10, 10)
                items.Min.Instance.Active = true
                items.Max.Instance.Active = true
            end
            return slider
        end
        local originalSlider = Library.AddSlider
        Library.AddSlider = function(self, data)
            data = data or {}
            return sliderStyle(originalSlider(self, data), data, false)
        end
        local originalRange = Library.AddRangeSlider
        Library.AddRangeSlider = function(self, data)
            data = data or {}
            return sliderStyle(originalRange(self, data), data, true)
        end

        local function optionStyle(option)
            local object = option.Value.Instance
            textStyle(object, false)
            object.AutomaticSize = Enum.AutomaticSize.None
            object.Size = UDim2.new(1, 0, 0, 20)
            local padding = object:FindFirstChildOfClass("UIPadding")
            if padding then
                padding.PaddingTop = UDim.new(0, 0)
                padding.PaddingBottom = UDim.new(0, 0)
                padding.PaddingLeft = UDim.new(0, 5)
            end
            return option
        end
        local originalDropdownOption = Library.RenderDropdownOption
        Library.RenderDropdownOption = function(self, ...)
            return optionStyle(originalDropdownOption(self, ...))
        end
        local originalListOption = Library.RenderListOption
        Library.RenderListOption = function(self, ...)
            return optionStyle(originalListOption(self, ...))
        end
        local originalDropdown = Library.AddDropdown
        local dropdownDotsAsset = getcustomasset("gamehaxx/assets/dropdown-dots.png")
        Library.AddDropdown = function(self, data)
            data = data or {}
            local dropdown = originalDropdown(self, data)
            local items = dropdown.Items
            local row = rowStyle(dropdown, data.RowHeight or (dropdown.Text and 32 or 19))
            local captionObject = rowTitle(row)
            caption(captionObject, -2)
            if not dropdown.Text and captionObject then captionObject.Visible = false end
            local bar = items.Outline.Instance
            bar.Position = UDim2.fromOffset(0, dropdown.Text and 14 or 0)
            bar.Size = UDim2.new(1, 0, 0, 15)
            flatten(bar)
            items.Value.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Value.Instance.TextTruncate = Enum.TextTruncate.AtEnd
            items.Value.Instance.TextWrapped = false
            items.Value.Instance.Position = UDim2.fromOffset(5, 0)
            items.Value.Instance.Size = UDim2.new(1, -32, 1, 0)
            local valuePadding = items.Value.Instance:FindFirstChildOfClass("UIPadding")
            if valuePadding then valuePadding.PaddingLeft = UDim.new(0, 0) end
            items.Indicator.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Indicator.Instance.AnchorPoint = Vector2.new(1, 0)
            items.Indicator.Instance.Position = UDim2.new(1, -5, 0, 0)
            items.Indicator.Instance.Size = UDim2.fromOffset(13, 15)
            items.Indicator.Instance.Text = ""
            items.Indicator.Instance.TextColor3 = Themes.Preset.Accent
            local indicatorPadding = items.Indicator.Instance:FindFirstChildOfClass("UIPadding")
            if indicatorPadding then indicatorPadding.PaddingRight = UDim.new(0, 0) end
            items.DotsIcon = Library:Create("ImageLabel", {Parent = items.Indicator.Instance, Name = "DropdownDots",
                Image = dropdownDotsAsset, ImageColor3 = Themes.Preset.Accent, BackgroundTransparency = 1,
                BorderSizePixel = 0, Active = false, Size = UDim2.fromOffset(11, 4),
                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                ResampleMode = Enum.ResamplerMode.Pixelated, ZIndex = items.Indicator.Instance.ZIndex + 1}):Themify("Accent", "ImageColor3")
            hostStyle(items.ComponentsHolder, 14)
            items.Holder.Instance.BackgroundColor3 = outlineFill
            items.OptionsHolder.Instance.BackgroundColor3 = controlFill
            local gradient = items.OptionsHolder.Instance:FindFirstChildOfClass("UIGradient")
            if gradient then gradient.Enabled = false end

            dropdown.Open = false
            items.DropdownHolder.Instance.Visible = false
            syncPopup(dropdown, items.DropdownHolder.Instance)
            fontRowLayout(dropdown, "dropdown")
            return dropdown
        end

        local originalLabel = Library.AddLabel
        Library.AddLabel = function(self, data)
            data = data or {}
            local label = originalLabel(self, data)
            local row = rowStyle(label, data.RowHeight or 18)
            caption(label.Items.Label.Instance, -2)
            label.Items.Label.Instance.Size = UDim2.new(1, 0, 0, 16)
            hostStyle(label.Items.ComponentsHolder, row.Size.Y.Offset)
            fontRowLayout(label, "label")
            return label
        end
        local originalButton = Library.AddButton
        Library.AddButton = function(self, data)
            data = data or {}
            local button = originalButton(self, data)
            local items = button.Items

            local row = rowStyle(button, data.RowHeight or 20)
            local buttonHeight, buttonGap, horizontalInset = 16, 4, 0
            local layout = row:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout.Padding = UDim.new(0, buttonGap)
                layout.HorizontalFlex = Enum.UIFlexAlignment.None
                layout.VerticalFlex = Enum.UIFlexAlignment.None
                layout.VerticalAlignment = Enum.VerticalAlignment.Top
            end
            local padding = row:FindFirstChildOfClass("UIPadding")
            if not padding then
                padding = Library:Create("UIPadding", {Parent = row,
                    PaddingLeft = UDim.new(0, horizontalInset),
                    PaddingRight = UDim.new(0, horizontalInset),
                    PaddingTop = UDim.new(0, 2),
                    PaddingBottom = UDim.new(0, 4)}).Instance
            end
            padding.PaddingLeft = UDim.new(0, horizontalInset)
            padding.PaddingRight = UDim.new(0, horizontalInset)
            padding.PaddingTop = UDim.new(0, 2)
            padding.PaddingBottom = UDim.new(0, 4)

            local outline = items.Outline.Instance
            outline.Position = UDim2.fromOffset(0, 2)
            outline.BackgroundColor3 = Themes.Preset.Outline
            outline.BackgroundTransparency = 0
            outline.BorderSizePixel = 0
            items.Inline.Instance.Position = UDim2.fromOffset(1, 1)
            items.Inline.Instance.Size = UDim2.new(1, -2, 1, -2)
            items.Inline.Instance.BackgroundColor3 = Color3.fromRGB(23, 23, 31)
            items.Inline.Instance.BackgroundTransparency = 0
            items.Gray.Instance.Position = UDim2.fromOffset(0, 0)
            items.Gray.Instance.Size = UDim2.fromScale(1, 1)
            items.Gray.Instance.BackgroundColor3 = Color3.new(1, 1, 1)
            items.Gray.Instance.BackgroundTransparency = 0
            items.UIGradient.Instance.Enabled = true
            items.UIGradient.Instance.Color = ColorSequence.new(
                Color3.fromRGB(25, 25, 33), Color3.fromRGB(20, 20, 27))
            items.Title.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Title.Instance.Position = UDim2.fromOffset(0, 0)
            items.Title.Instance.Size = UDim2.fromScale(1, 1)
            items.Title.Instance.TextXAlignment = Enum.TextXAlignment.Center
            items.Title.Instance.TextYAlignment = Enum.TextYAlignment.Center
            items.Object.ReferenceButtons = items.Object.ReferenceButtons or {}
            table.insert(items.Object.ReferenceButtons, outline)
            if not items.Object.ReferenceButtonLayout then
                items.Object.ReferenceButtonLayout = integerWidths(row,
                    items.Object.ReferenceButtons, buttonGap, buttonHeight, horizontalInset)
            else
                items.Object.ReferenceButtonLayout()
            end
            fontRowLayout(button, "button")
            return button
        end
        local originalInput = Library.AddInput
        Library.AddInput = function(self, data)
            data = data or {}
            local input = originalInput(self, data)
            local items = input.Items
            local row = rowStyle(input, data.RowHeight or (input.Text and 36 or 23))
            caption(rowTitle(row), -2)
            items.Outline.Instance.Position = UDim2.fromOffset(0, input.Text and 16 or 0)
            items.Outline.Instance.Size = UDim2.new(1, 0, 0, 20)
            flatten(items.Outline.Instance)
            items.Input.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Input.Instance.Position = UDim2.fromOffset(5, 0)
            items.Input.Instance.Size = UDim2.new(1, -10, 1, 0)
            items.Input.Instance.RichText = false
            items.Input.Instance.Active = true
            local padding = items.Input.Instance:FindFirstChildOfClass("UIPadding")
            if padding then padding.PaddingLeft = UDim.new(0, 0) end
            if data.Placeholder ~= nil then items.Input.Instance.PlaceholderText = data.Placeholder end
            hostStyle(items.ComponentsHolder, 14)
            fontRowLayout(input, "input")
            return input
        end
        local originalList = Library.AddList
        Library.AddList = function(self, data)
            data = data or {}
            local list = originalList(self, data)
            rowStyle(list, data.Size or 100)
            list.Items.Outline.Instance.Size = UDim2.new(1, 0, 1, 0)
            flatten(list.Items.Outline.Instance)
            list.Items.Holder.Instance.ScrollBarImageColor3 = Themes.Preset.Accent
            return list
        end

        local keyPopups = setmetatable({}, {__mode = "k"})
        local function keySourceVisible(value)
            local object = value
            while object do
                if object:IsA("GuiObject") and not object.Visible then return false end
                if object:IsA("ScreenGui") then return object.Enabled end
                object = object.Parent
            end
            return false
        end
        local function keyPopupPosition(key)
            local value, popup = key.Items.Value.Instance, key.Items.Settings.Instance
            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
            local offset = key.PopupOffset
            local origin = Library.Elements.Instance.AbsolutePosition
            local x = math.round(value.AbsolutePosition.X + offset.X - origin.X)
            local y = math.round(value.AbsolutePosition.Y + offset.Y - origin.Y)
            x = math.clamp(x, 4, math.max(4, viewport.X - popup.AbsoluteSize.X - 4))
            y = math.clamp(y, 4, math.max(4, viewport.Y - popup.AbsoluteSize.Y - 4))
            return UDim2.fromOffset(x, y)
        end
        local originalKeyPosition = Library.UpdateKeyPickerPosition
        Library.UpdateKeyPickerPosition = function(self, open, debounce)
            if not self.ReferenceKeyMenu then return originalKeyPosition(self, open, debounce) end
            self.Items.Settings.Instance.Position = keyPopupPosition(self)
        end
        local keyPopupTask
        keyPopupTask = Library:CreateRenderTask(function()
            for key in keyPopups do
                local popup, value = key.Items.Settings.Instance, key.Items.Value.Instance
                if not value.Parent then keyPopups[key] = nil; continue end
                if key.Open and not keySourceVisible(value) then
                    key.SetVisible(false, true)
                    continue
                end
                if key.Open and popup.Visible and not key.OpeningMenu then
                    local position = keyPopupPosition(key)
                    if popup.Position ~= position then popup.Position = position end
                end
            end
            if next(keyPopups) == nil then keyPopupTask:Stop() end
        end)
        local originalKey = Library.AddKeyPicker
        Library.AddKeyPicker = function(self, data)
            data = data or {}
            local key = originalKey(self, data)
            local value = key.Items.Value.Instance
            textStyle(value, false)
            value.AutomaticSize = Enum.AutomaticSize.X
            value.Size = UDim2.new(0, 0, 0, 16)
            value.Position = UDim2.fromOffset(0, 0)
            local updating = false
            local function compactKey()
                if updating then return end
                local replacement = value.Text:gsub("^%[(.*)%]$", "<%1>")
                if value.Text == "Selecting" then replacement = "..." end
                if replacement ~= value.Text then
                    updating = true
                    value.Text = replacement
                    updating = false
                end
            end
            compactKey()
            Library:Connect(value:GetPropertyChangedSignal("Text"), compactKey)
            hostStyle(key.Items.ComponentsHolder, 20)
            local oldHover = key.IsHovering
            key.IsHovering = function()
                return key.Items.Settings:Hovering() or key.Items.Value:Hovering()
            end
            if key.DataElements then
                for index, handler in key.DataElements do
                    if handler == oldHover then key.DataElements[index] = key.IsHovering end
                end
            end
            local items = key.Items
            local popup = items.Settings.Instance
            key.ReferenceKeyMenu = true
            key.PopupOffset = data.PopupOffset or Vector2.new(-4, 40)
            popup.Name = "KeybindSettings"
            popup.AutomaticSize = Enum.AutomaticSize.None
            popup.Size = UDim2.fromOffset(180, 63)
            popup.BackgroundColor3 = Themes.Preset.Outline
            popup.BackgroundTransparency = 0
            popup.BorderSizePixel = 0
            popup.ClipsDescendants = false
            popup.ZIndex = 45
            local popupStroke = Instance.new("UIStroke")
            popupStroke.Name = "KeybindOutline"
            popupStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            popupStroke.LineJoinMode = Enum.LineJoinMode.Miter
            popupStroke.Color = Library.MainStylePalette and Library.MainStylePalette.Border or Color3.fromRGB(76, 76, 96)
            popupStroke.Thickness = 1
            popupStroke.Transparency = 0
            popupStroke.Parent = popup
            local popupGlow = Instance.new("ImageLabel")
            popupGlow.Name = "KeybindGlow"
            popupGlow.Image = "rbxassetid://18245826428"
            popupGlow.ScaleType = Enum.ScaleType.Slice
            popupGlow.SliceCenter = Rect.new(21, 21, 79, 79)
            popupGlow.ImageColor3 = Themes.Preset.Accent
            popupGlow.ImageTransparency = 0.89
            popupGlow.BackgroundTransparency = 1
            popupGlow.BorderSizePixel = 0
            popupGlow.Active = false
            popupGlow.ZIndex = 39
            popupGlow.Visible = false
            popupGlow.Parent = Library.Elements.Instance
            local function placePopupGlow()
                popupGlow.Position = popup.Position + UDim2.fromOffset(-12, -12)
                popupGlow.Size = popup.Size + UDim2.fromOffset(24, 24)
                popupGlow.Visible = popup.Visible and popup.Parent ~= nil
            end
            Library:Connect(popup:GetPropertyChangedSignal("Position"), placePopupGlow)
            Library:Connect(popup:GetPropertyChangedSignal("Size"), placePopupGlow)
            Library:Connect(popup:GetPropertyChangedSignal("Visible"), placePopupGlow)
            placePopupGlow()
            items.Top.Instance.Visible = false
            items.Inline.Instance.Position = UDim2.fromOffset(1, 1)
            items.Inline.Instance.Size = UDim2.new(1, -2, 1, -2)
            items.Inline.Instance.BackgroundColor3 = Themes.Preset.SectionBackground
            items.Background.Instance.Position = UDim2.fromOffset(0, 0)
            items.Background.Instance.Size = UDim2.fromScale(1, 1)
            items.Background.Instance.BackgroundColor3 = Themes.Preset.SectionBackground
            for _, object in {popup, items.Inline.Instance, items.Background.Instance} do
                for _, child in object:GetChildren() do
                    if child:IsA("UIPadding") then
                        child.PaddingLeft, child.PaddingRight = UDim.new(0, 0), UDim.new(0, 0)
                        child.PaddingTop, child.PaddingBottom = UDim.new(0, 0), UDim.new(0, 0)
                    end
                end
            end
            local elements = items.SettingsElements.Instance
            elements.AutomaticSize = Enum.AutomaticSize.None
            elements.Position = UDim2.fromOffset(4, 4)
            elements.Size = UDim2.new(1, -8, 1, -8)
            elements.ClipsDescendants = false
            local layout = elements:FindFirstChildOfClass("UIListLayout")
            if layout then layout.Padding = UDim.new(0, 0) end
            local show = key.ShowInListControl
            show.Items.Object.Instance.Size = UDim2.new(1, 0, 0, 16)
            show.Items.Outline.Instance.Position = UDim2.fromOffset(0, 1)
            show.Items.Outline.Instance.Size = UDim2.fromOffset(10, 10)
            show.Items.TextLabel.Instance.Position = UDim2.fromOffset(14, -2)
            show.Items.TextLabel.Instance.Size = UDim2.new(1, -14, 0, 16)
            local mode = key.ModeControl
            mode.Items.Object.Instance.Size = UDim2.new(1, 0, 0, 30)
            local modeTitle = rowTitle(mode.Items.Object.Instance)
            caption(modeTitle, -4, 0)
            mode.Items.Outline.Instance.Position = UDim2.fromOffset(0, 12)
            mode.Items.Outline.Instance.Size = UDim2.new(1, 0, 0, 16)
            mode.OptionHeight = 18
            mode.PopupGap = 3
            local modePopup = mode.Items.DropdownHolder.Instance
            modePopup.ZIndex = 70
            modePopup.BackgroundTransparency = 0
            for _, child in ipairs(modePopup:GetDescendants()) do
                if child:IsA("GuiObject") then
                    child.ZIndex = math.max(child.ZIndex, 71)
                end
            end

            local revision = 0
            key.SetVisible = function(open, debounce)
                key.Open, key.Tweening = open == true, false
                if not key.Open then
                    revision += 1
                    key.OpeningMenu = false
                    keyPopups[key] = nil
                    if next(keyPopups) == nil then keyPopupTask:Stop() end
                    mode.SetVisible(false, true)
                    popup.Visible = false
                    return
                end
                keyPopups[key] = true
                keyPopupTask:Start()
                popup.Visible = true
                local target = keyPopupPosition(key)
                if debounce or key.OpeningMenu then
                    popup.Position = target
                    return
                end
                revision += 1
                local token = revision
                key.OpeningMenu = true
                popup.Position = target + UDim2.fromOffset(0, 4)
                items.Settings:Tween({Position = target}, TweenInfo.new(0.12,
                    Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
                task.delay(0.12, function()
                    if token == revision then key.OpeningMenu = false end
                end)
            end
            syncPopup(key, key.Items.Settings.Instance)
            return key
        end
        local pickerBySwatch = {}
        local originalPicker = Library.Colorpicker
        Library.Colorpicker = function(self, data)
            local picker = originalPicker(self, data)
            pickerBySwatch[picker.Items.Object.Instance] = picker
            syncPopup(picker, picker.Items.Outline.Instance)
            return picker
        end
        local originalColor = Library.AddColorPicker
        Library.AddColorPicker = function(self, data)
            local color = originalColor(self, data)
            local swatch = color.Items.Object.Instance
            local outer = swatch.Parent
            outer.Size = UDim2.fromOffset(24, 11)
            outer.BackgroundColor3 = outlineFill
            swatch.Position = UDim2.fromOffset(1, 1)
            swatch.Size = UDim2.new(1, -2, 1, -2)
            local gradient = swatch:FindFirstChildOfClass("UIGradient")
            if gradient then
                gradient.Rotation = 0
                gradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(110, 110, 110))
            end

            if not color.Items.ComponentsHolder then
                color.Items.ComponentsHolder = {Instance = outer.Parent}
            end
            hostStyle(color.Items.ComponentsHolder, 14)
            color.Items.ComponentsHolder.Instance.Position = UDim2.new(1, 0, 0, 0)
            local layout = color.Items.ComponentsHolder.Instance:FindFirstChildOfClass("UIListLayout")
            if layout then
                layout.VerticalAlignment = Enum.VerticalAlignment.Top
                layout.Padding = UDim.new(0, 4)
            end
            color.ReferencePicker = pickerBySwatch[swatch]
            return color
        end

        local originalMultiChild = Library.CreateMultiSection
        Library.CreateMultiSection = function(self, data)
            local child = originalMultiChild(self, data)
            local items = child.Items
            local elements = items.Elements.Instance
            elements.Position = UDim2.fromOffset(6, 28)
            elements.Size = UDim2.new(1, -12, 0, 0)
            elements.ClipsDescendants = false
            local list = elements:FindFirstChildOfClass("UIListLayout")
            if list then list.Padding = UDim.new(0, 0) end
            textStyle(items.Text.Instance, false)
            items.Text.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Text.Instance.Size = UDim2.fromScale(1, 1)
            items.Text.Instance.TextXAlignment = Enum.TextXAlignment.Center
            items.Text.Instance.TextYAlignment = Enum.TextYAlignment.Center
            items.UIGradient.Instance.Color = ColorSequence.new(Themes.Preset.Outline, Themes.Preset.SectionBackground)
            items.Filler.Instance.Visible = false
            items.Left.Instance.BackgroundColor3 = Themes.Preset.Outline
            items.Right.Instance.BackgroundColor3 = Themes.Preset.Outline
            items.Left.Instance.Size = UDim2.new(0, 1, 1, 0)
            items.Right.Instance.Size = UDim2.new(0, 1, 1, 0)
            items.Stroke.Instance.Transparency = 1
            pinnedTween(items.Stroke, {Transparency = 1})
            local originalVisible = child.SetVisible
            child.SetVisible = function(visible)
                originalVisible(visible)
                items.Text.Instance.FontFace = visible and Fonts.MainBold or Fonts.Main
                items.Filler.Instance.Visible = false
            end
            return child
        end
        local originalMulti = Library.AddMultiSection
        Library.AddMultiSection = function(self, data)
            local children = {originalMulti(self, data)}
            local container = children[1] and children[1].Old
            if not container then return table.unpack(children) end
            local items = container.Items
            local outline = items.Outline.Instance
            for _, object in {outline, items.Inline.Instance, items.Holder.Instance, items.Background.Instance} do
                object.AutomaticSize = Enum.AutomaticSize.None
                object.BorderSizePixel = 0
                object.ClipsDescendants = false
                for _, padding in object:GetChildren() do
                    if padding:IsA("UIPadding") then padding:Destroy() end
                end
            end
            outline.BackgroundColor3 = Themes.Preset.Outline
            items.Inline.Instance.Position = UDim2.fromOffset(1, 1)
            items.Inline.Instance.Size = UDim2.new(1, -2, 1, -2)
            items.Inline.Instance.BackgroundColor3 = Themes.Preset.SectionBackground
            items.Holder.Instance.Position = UDim2.fromOffset(0, 0)
            items.Holder.Instance.Size = UDim2.fromScale(1, 1)
            items.Holder.Instance.BackgroundColor3 = Themes.Preset.SectionBackground
            items.Background.Instance.Position = UDim2.fromOffset(0, 0)
            items.Background.Instance.Size = UDim2.fromScale(1, 1)
            items.Background.Instance.BackgroundColor3 = Themes.Preset.SectionBackground
            items.TabButtonOutline.Instance.Position = UDim2.fromOffset(0, 0)
            items.TabButtonOutline.Instance.Size = UDim2.new(1, 0, 0, 22)
            items.TabButtonOutline.Instance.BackgroundColor3 = Themes.Preset.SectionBackground
            items.TabButtonOutline.Instance.ClipsDescendants = false
            items.InlineLine.Instance.Visible = false
            items.OutlineLine.Instance.BackgroundColor3 = Themes.Preset.Outline
            items.TabButtonHolder.Instance.Size = UDim2.new(1, 0, 0, 20)
            local buttons = {}
            for _, child in children do table.insert(buttons, child.Items.Button.Instance) end
            integerWidths(items.TabButtonHolder.Instance, buttons, 1, 20)
            local function fit()
                local height = 0
                for _, child in children do
                    local elements = child.Items.Elements.Instance
                    if elements.Visible then
                        local list = elements:FindFirstChildOfClass("UIListLayout")
                        if list then height = math.max(height, math.round(list.AbsoluteContentSize.Y)) end
                    end
                end
                outline.Size = UDim2.new(1, 0, 0, height + 33)
            end
            for index, child in children do
                local elements = child.Items.Elements.Instance
                local list = elements:FindFirstChildOfClass("UIListLayout")
                if list then Library:Connect(list:GetPropertyChangedSignal("AbsoluteContentSize"), fit) end
                Library:Connect(elements:GetPropertyChangedSignal("Visible"), fit)
                child.Items.Text.Instance.FontFace = index == 1 and Fonts.MainBold or Fonts.Main
            end
            fit()
            return table.unpack(children)
        end
    end

    do
        local function finite(value)
            return type(value) == "number" and value == value and math.abs(value) < math.huge
        end
        local function number(value, fallback)
            local parsed = tonumber(value)
            return finite(parsed) and parsed or fallback
        end
        local function placesForStep(step)
            for places = 0, 8 do
                local scaled = step * 10 ^ places
                if math.abs(scaled - math.round(scaled)) < 0.0000001 then return places end
            end
            return 8
        end
        local function specFor(data, range)
            local valueType = tostring(data.ValueType or ""):lower()
            local legacyType = tostring(data.Type or ""):lower()
            if valueType == "" and table.find({"integer", "float", "decimal", "string"}, legacyType) then
                valueType = legacyType
            end
            if valueType == "" then valueType = "normal" end
            assert(not range or valueType ~= "string", "A range slider requires numeric values")
            assert(table.find({"normal", "integer", "float", "decimal", "string"}, valueType), "Unknown slider ValueType")
            local choices = data.Values or data.Options
            if valueType == "string" and not choices and data.Min == nil and data.Max == nil then
                choices = {"Low", "Medium", "High"}
            end
            local values = valueType == "string" and choices and table.clone(choices) or nil
            if values then assert(#values > 0, "A string slider requires at least one value") end
            local minimum = values and 1 or number(data.Min, 0)
            local maximum = values and #values or number(data.Max, 100)
            if valueType == "integer" then minimum, maximum = math.ceil(minimum), math.floor(maximum) end
            assert(maximum >= minimum, "Slider Max must be greater than or equal to Min")
            local defaultStep = ((valueType == "float" or (valueType == "string" and not values)) and 0.1)
                or (valueType == "decimal" and 0.01) or 1
            local step = (values or valueType == "integer") and 1 or number(data.Step or data.Decimal or data.Rounding, defaultStep)
            assert(step > 0, "Slider Step must be positive")
            local places = math.clamp(math.round(number(data.DecimalPlaces, placesForStep(step))), 0, 8)
            local suffix = tostring(data.Suffix or "")
            local function normalize(value)
                local parsed = number(value, nil)
                if not parsed then return nil end
                parsed = math.clamp(parsed, minimum, maximum)
                parsed = minimum + math.round((parsed - minimum) / step) * step
                parsed = math.clamp(parsed, minimum, maximum)

                return tonumber(string.format("%.10f", parsed))
            end
            local function display(value)
                local label = values and tostring(values[value]) or nil
                if type(data.Format) == "function" then
                    local ok, formatted = pcall(data.Format, label or value, value)
                    if ok and formatted ~= nil then return tostring(formatted) .. suffix end
                elseif type(data.Format) == "string" then
                    local ok, formatted = pcall(string.format, data.Format, label or value)
                    if ok then return formatted .. suffix end
                end
                return (label or string.format("%." .. places .. "f", value)) .. suffix
            end
            local function parse(value)
                if type(value) == "string" and suffix ~= "" and value:sub(-#suffix) == suffix then
                    value = value:sub(1, -#suffix - 1)
                end
                if values and type(value) ~= "number" then
                    for index, label in values do
                        if value == label or tostring(value) == tostring(label) then return index end
                    end
                    return nil
                end
                return normalize(value)
            end
            return {Kind = valueType, Values = values, Min = minimum, Max = maximum,
                Step = step, Places = places, Normalize = normalize, Parse = parse, Display = display}
        end

        local visuals = setmetatable({}, {__mode = "k"})
        local visualTask
        local function drawVisual(slider, visual, settled)
            local fill = slider.Items.Accent.Instance
            local width = visual.Width or 0
            local left, right = visual.Start * width, visual.End * width
            if settled and not slider.Dragging and not slider.SlidingHandle then
                left, right = math.round(left), math.round(right)
            end
            local position = UDim2.fromOffset(left, 0)
            local size = UDim2.new(0, math.max(0, right - left), 1, 0)
            if fill.Position ~= position then fill.Position = position end
            if fill.Size ~= size then fill.Size = size end
        end
        visualTask = Library:CreateRenderTask(function(dt)
            for slider, visual in visuals do
                local fill = slider.Items.Accent.Instance
                if not fill.Parent then visuals[slider] = nil; continue end
                local alpha = slider.SmoothTime == 0 and 1 or (1 - math.exp(-dt / slider.SmoothTime))
                visual.Start += (visual.TargetStart - visual.Start) * alpha
                visual.End += (visual.TargetEnd - visual.End) * alpha
                local settled = math.max(math.abs(visual.TargetStart - visual.Start), math.abs(visual.TargetEnd - visual.End)) * math.max(1, visual.Width) < 0.05
                if settled then visual.Start, visual.End = visual.TargetStart, visual.TargetEnd end
                drawVisual(slider, visual, settled)
                if settled then visuals[slider] = nil end
            end
            if next(visuals) == nil then visualTask:Stop() end
        end)
        local function installVisual(slider, data)
            local fill = slider.Items.Accent.Instance
            Services.TweenService:Create(fill, TweenInfo.new(0), {Size = fill.Size, Position = fill.Position}):Play()
            slider.SmoothTime = data.Smooth == false and 0 or math.clamp(number(data.SmoothTime, 0.06), 0.01, 0.5)
            local holder = slider.Items.Holder.Instance
            local visual = {Start = 0, End = 0, TargetStart = 0, TargetEnd = 0, Width = math.max(0, holder.AbsoluteSize.X)}
            slider.VisualState = visual
            local function target(first, last, immediate)
                visual.TargetStart, visual.TargetEnd = first, last
                if immediate or slider.SmoothTime == 0 then
                    visual.Start, visual.End = first, last
                    visuals[slider] = nil
                    drawVisual(slider, visual, true)
                else
                    visuals[slider] = visual
                    visualTask:Start()
                end
            end
            visual.SetTarget = target
            Library:Connect(holder:GetPropertyChangedSignal("AbsoluteSize"), function()
                visual.Width = math.max(0, holder.AbsoluteSize.X)
                drawVisual(slider, visual, visuals[slider] == nil)
            end)
            local bar = slider.Items.Outline.Instance
            Library:Connect(bar.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then slider.Dragging = true end
            end)
            Library:Connect(Services.UserInputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local wasDragging = slider.Dragging or slider.SlidingHandle ~= nil
                    if not wasDragging then return end
                    slider.Dragging = false
                    slider.SlidingHandle = nil
                    local span = slider.Max - slider.Min
                    if type(slider.Value) == "table" then
                        target(span == 0 and 0 or (slider.Value[1] - slider.Min) / span,
                            span == 0 and 0 or (slider.Value[2] - slider.Min) / span)
                    else
                        target(0, span == 0 and 0 or (slider.Value - slider.Min) / span)
                    end
                end
            end)
            return target
        end

        Library.OnDrag = function(self, moved, changed)
            local dragging = false
            changed = changed or function() end
            Library:Connect(self.Instance.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    changed(true)
                    moved(input)
                end
            end)
            Library:Connect(Services.UserInputService.InputEnded, function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    dragging = false
                    changed(false)
                end
            end)
            Library:Connect(Services.UserInputService.InputChanged, function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then moved(input) end
            end)
            return self
        end

        local originalSlider = Library.AddSlider
        Library.AddSlider = function(self, data)
            data = data or {}
            local spec, prepared = specFor(data, false), table.clone(data)
            local requested = data.Default
            if requested == nil then requested = spec.Values and spec.Values[1] or math.clamp(10, spec.Min, spec.Max) end
            local initial = spec.Parse(requested) or spec.Min
            prepared.Min, prepared.Max = spec.Min, math.max(spec.Min + spec.Step, spec.Max)
            prepared.Default, prepared.Decimal, prepared.Callback = initial, spec.Step, function() end
            if prepared.Type and table.find({"integer", "float", "decimal", "string"}, tostring(prepared.Type):lower()) then prepared.Type = "Normal" end
            if spec.Values then prepared.Type = "Normal" end
            local slider = originalSlider(self, prepared)
            slider.Min, slider.Max, slider.Intervals = spec.Min, spec.Max, spec.Step
            slider.ValueType, slider.Values, slider.DecimalPlaces = spec.Kind, spec.Values, spec.Places
            slider.Callback = data.Callback or function() end
            local target = installVisual(slider, data)
            local initialSet = true
            slider.Set = function(value)
                local parsed = spec.Parse(value)
                if parsed == nil then
                    slider.Items.Value.Instance.Text = spec.Display(slider.Value)
                    return false
                end
                slider.Value = parsed
                slider.Index = spec.Values and parsed or nil
                slider.SelectedValue = spec.Values and spec.Values[parsed] or parsed
                slider.Items.Value.Instance.Text = spec.Display(parsed)
                local ratio = spec.Max == spec.Min and 0 or (parsed - spec.Min) / (spec.Max - spec.Min)
                target(0, ratio, initialSet)
                Flags[slider.Flag] = slider.SelectedValue
                slider.Callback(slider.SelectedValue)
                return true
            end
            Library.ConfigFlags[slider.Flag] = slider.Set
            slider.Set(spec.Values and spec.Values[initial] or initial)
            initialSet = false
            return slider
        end
        local originalRange = Library.AddRangeSlider
        Library.AddRangeSlider = function(self, data)
            data = data or {}
            local spec, prepared = specFor(data, true), table.clone(data)
            prepared.Min, prepared.Max = spec.Min, math.max(spec.Min + spec.Step, spec.Max)
            prepared.Default = data.Default or {spec.Min, spec.Max}
            prepared.Decimal, prepared.Callback = spec.Step, function() end
            local slider = originalRange(self, prepared)
            slider.Min, slider.Max, slider.Intervals = spec.Min, spec.Max, spec.Step
            slider.ValueType, slider.DecimalPlaces = spec.Kind, spec.Places
            slider.Callback = data.Callback or function() end

            local rangeVisualOptions = table.clone(data)
            rangeVisualOptions.Smooth = false
            local target = installVisual(slider, rangeVisualOptions)
            local initialSet = true
            slider.Set = function(first, last)
                if type(first) == "table" then first, last = first[1], first[2] end
                first, last = spec.Parse(first), spec.Parse(last)
                if first == nil or last == nil then return false end
                if first > last then first, last = last, first end
                slider.Value = {first, last}
                Flags[slider.Flag] = slider.Value
                local divisor = spec.Max - spec.Min
                local startAlpha = divisor == 0 and 0 or (first - spec.Min) / divisor
                local endAlpha = divisor == 0 and 0 or (last - spec.Min) / divisor
                target(startAlpha, endAlpha, initialSet)

                slider.Items.Min.Instance.Position = UDim2.fromScale(startAlpha, 0.5)
                slider.Items.Max.Instance.Position = UDim2.fromScale(endAlpha, 0.5)
                slider.Items.Value.Instance.Text = spec.Display(first) .. "-" .. spec.Display(last)
                slider.Callback(slider.Value)
                return true
            end
            Library.ConfigFlags[slider.Flag] = slider.Set
            slider.Set(prepared.Default)
            initialSet = false

            local inputService = Services.UserInputService
            local holder = slider.Items.Holder.Instance
            local minHandle = slider.Items.Min.Instance
            local maxHandle = slider.Items.Max.Instance
            local gesture
            local function valueAt(x)
                local width = math.max(1, holder.AbsoluteSize.X)
                local ratio = math.clamp((x - holder.AbsolutePosition.X) / width, 0, 1)
                return spec.Normalize(slider.Min + (slider.Max - slider.Min) * ratio)
            end
            local function dragTo(x)
                if not gesture then return end
                local value = valueAt(x)
                if gesture.Side == "min" then
                    slider.Set(math.min(value, gesture.Opposite), gesture.Opposite)
                else
                    slider.Set(gesture.Opposite, math.max(value, gesture.Opposite))
                end
            end
            local function beginDrag(input)
                if gesture then return end
                local kind = input.UserInputType
                if kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.Touch then return end
                local value = valueAt(input.Position.X)
                local leftDistance = math.abs(value - slider.Value[1])
                local rightDistance = math.abs(value - slider.Value[2])
                local side = leftDistance <= rightDistance and "min" or "max"
                gesture = {
                    Side = side,
                    Opposite = side == "min" and slider.Value[2] or slider.Value[1],
                    TouchInput = kind == Enum.UserInputType.Touch and input or nil,
                }
                slider.Dragging = true
                slider.SlidingHandle = side == "min" and slider.Items.Min or slider.Items.Max
                dragTo(input.Position.X)
            end

            slider.Items.Outline.Instance.Active = true
            holder.Active = true
            slider.Items.Accent.Instance.Active = true
            slider.Items.Gray.Instance.Active = true
            minHandle.Active = true
            maxHandle.Active = true
            for _, part in {slider.Items.Outline.Instance, holder,
                slider.Items.Gray.Instance, slider.Items.Accent.Instance, minHandle, maxHandle} do
                Library:Connect(part.InputBegan, beginDrag)
            end
            Library:Connect(inputService.InputChanged, function(input)
                if not gesture then return end
                if gesture.TouchInput then
                    if input ~= gesture.TouchInput then return end
                elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                dragTo(input.Position.X)
            end)
            Library:Connect(inputService.InputEnded, function(input)
                if not gesture then return end
                if gesture.TouchInput then
                    if input ~= gesture.TouchInput then return end
                elseif input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end
                gesture = nil
                slider.Dragging = false
                slider.SlidingHandle = nil
                slider.RangeDragAnchor = nil
            end)
            return slider
        end

        Library.UpdateSlider = function(self, input)
            self.Dragging = true
            local holder = self.Items.Holder.Instance
            local width = math.max(1, holder.AbsoluteSize.X)
            local ratio = math.clamp((input.Position.X - holder.AbsolutePosition.X) / width, 0, 1)
            self.Set(self.Min + (self.Max - self.Min) * ratio)
            local visual = self.VisualState
            if visual then
                visual.SetTarget(0, ratio)
            end
        end
        Library.UpdateRangeSlider = function(self, input)
            local handle = self.SlidingHandle
            local isMin = handle == self.Items.Min
            local isMax = handle == self.Items.Max
            if not (isMin or isMax) then return end

            local anchor = self.RangeDragAnchor
            if not anchor or anchor.Handle ~= handle then
                anchor = {
                    Handle = handle,
                    OtherValue = isMin and self.Value[2] or self.Value[1],
                }
                self.RangeDragAnchor = anchor
            end

            self.Dragging = true
            local holder = self.Items.Holder.Instance
            local width = math.max(1, holder.AbsoluteSize.X)
            local ratio = math.clamp((input.Position.X - holder.AbsolutePosition.X) / width, 0, 1)
            local span = self.Max - self.Min
            local value = self.Min + span * ratio
            if isMin then
                self.Set(math.min(value, anchor.OtherValue), anchor.OtherValue)
            else
                self.Set(anchor.OtherValue, math.max(value, anchor.OtherValue))
            end

            local visual = self.VisualState
            if visual then
                local startAlpha = span == 0 and 0 or (self.Value[1] - self.Min) / span
                local endAlpha = span == 0 and 0 or (self.Value[2] - self.Min) / span
                visual.SetTarget(startAlpha, endAlpha, true)
            end
        end

        local dropdownVariants = setmetatable({}, {__mode = "k"})

        Library.DropdownYOffset = math.clamp(math.round(number(Library.DropdownYOffset, 0)), -250, 250)
        local function popupOffset(dropdown)
            return dropdown.PopupYOffset ~= nil and dropdown.PopupYOffset or Library.DropdownYOffset
        end
        local function popupPosition(dropdown)
            local bar, popup = dropdown.Items.Outline.Instance, dropdown.Items.DropdownHolder.Instance
            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
            local width = math.round(bar.AbsoluteSize.X)
            local origin = Library.Elements.Instance.AbsolutePosition
            local x = math.clamp(math.round(bar.AbsolutePosition.X - origin.X), 0, math.max(0, viewport.X - width))

            local y = math.round(bar.AbsolutePosition.Y - origin.Y + bar.AbsoluteSize.Y + dropdown.PopupGap
                + popupOffset(dropdown))
            return UDim2.fromOffset(x, y), width
        end
        local function keepDropdownPlaced(dropdown)
            if not dropdown.Open then return end
            local position, width = popupPosition(dropdown)
            local popup = dropdown.Items.DropdownHolder.Instance
            local size = UDim2.fromOffset(width, popup.Size.Y.Offset)
            if popup.Size ~= size then popup.Size = size end
            if popup.Position ~= position then popup.Position = position end
        end
        local function fitDropdown(dropdown, placementOnly)
            if not dropdown.VariantDropdown then return end
            if placementOnly and not dropdown.Open then return end
            local extra = math.max(0, Library.MainTextSize - 10)
            dropdown.OptionHeight = (dropdown.BaseOptionHeight or dropdown.OptionHeight) + extra
            dropdown.SearchRowHeight = (dropdown.BaseSearchRowHeight or dropdown.SearchRowHeight) + extra
            if dropdown.Search and dropdown.Items.SearchHost then
                local input = dropdown.Items.Textbox.Items
                dropdown.Items.SearchHost.Instance.Size = UDim2.new(1, 0, 0, dropdown.SearchRowHeight)
                input.Object.Instance.Size = UDim2.new(1, 0, 0, dropdown.SearchRowHeight)
                input.Outline.Instance.Size = UDim2.new(1, 0, 0, dropdown.SearchRowHeight)
            end
            local visible = dropdown.VisibleOptionCount or 0
            if not placementOnly then
            visible = 0
            for _, option in dropdown.OptionInstances do
                option.Value.Instance.AutomaticSize = Enum.AutomaticSize.None
                option.Value.Instance.Size = UDim2.new(1, 0, 0, dropdown.OptionHeight)
                local padding = option.Value.Instance:FindFirstChildOfClass("UIPadding")
                if padding then
                    padding.PaddingLeft, padding.PaddingRight = UDim.new(0, 4), UDim.new(0, 4)
                    padding.PaddingTop, padding.PaddingBottom = UDim.new(0, 0), UDim.new(0, 0)
                end
                if option.Value.Instance.Visible then visible += 1 end
            end
            dropdown.VisibleOptionCount = visible
            end
            local items = dropdown.Items
            local bar = items.Outline.Instance
            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
            local searchHeight = dropdown.Search and dropdown.SearchRowHeight or 0
            local desiredHeight = math.max(dropdown.OptionHeight, math.min(visible, dropdown.MaxVisibleOptions) * dropdown.OptionHeight)

            local available = math.floor(viewport.Y - (bar.AbsolutePosition.Y - Library.Elements.Instance.AbsolutePosition.Y + bar.AbsoluteSize.Y
                + dropdown.PopupGap + popupOffset(dropdown)) - searchHeight - 4)
            local height = math.min(desiredHeight, math.max(dropdown.OptionHeight, available))
            items.Holder.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.Holder.Instance.Size = UDim2.new(1, 0, 0, height)
            items.Inline.Instance.Position = UDim2.fromOffset(0, 0)
            items.Inline.Instance.Size = UDim2.fromScale(1, 1)
            for _, padding in items.Inline.Instance:GetChildren() do
                if padding:IsA("UIPadding") then
                    padding.PaddingLeft, padding.PaddingRight = UDim.new(0, 0), UDim.new(0, 0)
                    padding.PaddingTop, padding.PaddingBottom = UDim.new(0, 0), UDim.new(0, 0)
                end
            end
            items.OptionsHolder.Instance.AutomaticSize = Enum.AutomaticSize.None
            items.OptionsHolder.Instance.Position = UDim2.fromOffset(0, 0)
            items.OptionsHolder.Instance.Size = UDim2.fromScale(1, 1)
            items.OptionsHolder.Instance.ClipsDescendants = true
            for _, padding in items.OptionsHolder.Instance:GetChildren() do
                if padding:IsA("UIPadding") then
                    padding.PaddingLeft, padding.PaddingRight = UDim.new(0, 0), UDim.new(0, 0)
                    padding.PaddingTop, padding.PaddingBottom = UDim.new(0, 0), UDim.new(0, 0)
                end
            end
            items.OptionsHolder.Instance.ScrollBarThickness = visible * dropdown.OptionHeight > height and 3 or 0
            local popup = items.DropdownHolder.Instance
            popup.AutomaticSize = Enum.AutomaticSize.None
            popup.Size = UDim2.fromOffset(math.round(items.Outline.Instance.AbsoluteSize.X), height + 2 + searchHeight)
            keepDropdownPlaced(dropdown)
        end

        function Library:SetDropdownYOffset(value)
            self.DropdownYOffset = math.clamp(math.round(number(value, 0)), -250, 250)
            for dropdown in dropdownVariants do
                if dropdown.Items and dropdown.Items.DropdownHolder
                    and dropdown.Items.DropdownHolder.Instance then
                    fitDropdown(dropdown)
                    if dropdown.Open then
                        local popup = dropdown.Items.DropdownHolder.Instance
                        local position, width = popupPosition(dropdown)
                        popup.Size = UDim2.fromOffset(width, popup.Size.Y.Offset)
                        popup.Position = position
                    end
                end
            end
            return self.DropdownYOffset
        end
        local originalRefresh = Library.RefreshDropdown
        Library.RefreshDropdown = function(self, options)
            self.Options = table.clone(options)
            originalRefresh(self, options)

            for index, option in self.OptionInstances do
                option.Value.Instance.LayoutOrder = index
            end
            if self.VariantDropdown then
                if self.Search and self.Filter then
                    local text = self.Items.Textbox.Items.Input.Instance.Text
                    self:Filter(text)
                else fitDropdown(self) end
                self.Set(Flags[self.Flag])
            end
        end
        local originalDropdown = Library.AddDropdown
        Library.AddDropdown = function(self, data)
            data = data or {}
            local prepared = table.clone(data)
            prepared.Callback = function() end
            prepared.Search = data.Search or data.Searchable or false
            local dropdown = originalDropdown(self, prepared)
            dropdown.VariantDropdown = true
            dropdownVariants[dropdown] = true

            for index, option in dropdown.OptionInstances do
                option.Value.Instance.LayoutOrder = index
            end
            local barHeight = math.max(8, math.round(number(data.BarHeight, 15)))
            dropdown.Items.Outline.Instance.Position = UDim2.fromOffset(0, number(data.BarOffset, dropdown.Text and 14 or 0))
            dropdown.Items.Outline.Instance.Size = UDim2.new(1, 0, 0, barHeight)
            dropdown.Items.Indicator.Instance.Size = UDim2.fromOffset(13, barHeight)
            if data.LabelY ~= nil and dropdown.Items.Title then
                dropdown.Items.Title.Instance.Position = UDim2.fromOffset(0, number(data.LabelY, -2))
            end
            dropdown.MaxVisibleOptions = math.clamp(math.round(number(data.MaxVisibleOptions, 8)), 1, 20)
            dropdown.OptionHeight = math.clamp(math.round(number(data.OptionHeight, 18)), 14, 32)
            dropdown.SearchRowHeight = math.clamp(math.round(number(data.SearchRowHeight, 16)), 14, 26)
            dropdown.BaseOptionHeight, dropdown.BaseSearchRowHeight = dropdown.OptionHeight, dropdown.SearchRowHeight
            dropdown.PopupGap = math.clamp(math.round(number(data.PopupGap, 2)), 0, 12)
            dropdown.PopupYOffset = data.PopupYOffset ~= nil and math.clamp(math.round(number(data.PopupYOffset, 0)), -250, 250) or nil

            local popupItems = dropdown.Items
            local popupBorder = Library.MainStylePalette.Border
            local popupRoot = popupItems.DropdownHolder.Instance
            popupRoot.BackgroundColor3 = popupBorder
            popupRoot.BackgroundTransparency = 0
            popupRoot.BorderSizePixel = 0
            popupRoot.ZIndex = math.max(30, number(data.PopupZIndex, 30))
            local rootPadding = popupRoot:FindFirstChildOfClass("UIPadding")
            if not rootPadding then rootPadding = Library:Create("UIPadding", {Parent = popupRoot}).Instance end
            rootPadding.PaddingLeft, rootPadding.PaddingRight = UDim.new(0, 1), UDim.new(0, 1)
            rootPadding.PaddingTop, rootPadding.PaddingBottom = UDim.new(0, 1), UDim.new(0, 1)
            local rootLayout = popupRoot:FindFirstChildOfClass("UIListLayout")
            if rootLayout then rootLayout.Padding = UDim.new(0, 0) end
            popupItems.Holder.Instance.BackgroundColor3 = Library.MainStylePalette.Section
            popupItems.Holder.Instance.BorderSizePixel = 0
            popupItems.Inline.Instance.BackgroundColor3 = Library.MainStylePalette.Section
            popupItems.Inline.Instance.BorderSizePixel = 0
            popupItems.OptionsHolder.Instance.BackgroundColor3 = Library.MainStylePalette.Section
            popupItems.OptionsHolder.Instance.BorderSizePixel = 0
            local oldGradient = popupItems.OptionsHolder.Instance:FindFirstChildOfClass("UIGradient")
            if oldGradient then oldGradient.Enabled = false end
            for _, child in popupItems.Holder.Instance:GetChildren() do
                if child:IsA("UIStroke") then child.Color = popupBorder end
            end
            dropdown.NoDefault = data.NoDefault == true or data.Default == false
            dropdown.Placeholder = data.Placeholder or "Select"
            dropdown.Callback = data.Callback or function() end
            dropdown.Set = function(value)
                local selected = {}
                local multiple = dropdown.Multi
                local source = type(value) == "table" and value or (value ~= nil and value ~= false and {value} or {})
                for _, option in dropdown.OptionInstances do
                    local text = option.Value.Instance.Text
                    local active = table.find(source, text) ~= nil and (multiple or #selected == 0)
                    if active then table.insert(selected, text) end
                    option.Value.Instance.FontFace = active and Fonts.MainBold or Fonts.Main
                    option.Value:Tween({TextColor3 = active and Themes.Preset.Accent or Themes.Preset.TextMisc})
                end
                dropdown.MultiItems = selected
                dropdown.Value = multiple and selected or selected[1]
                dropdown.Items.Value.Instance.Text = #selected == 0 and dropdown.Placeholder or (multiple and table.concat(selected, ", ") or selected[1])
                dropdown.Items.Value.Instance.TextTruncate = Enum.TextTruncate.AtEnd
                dropdown.Items.Value.Instance.TextWrapped = false
                dropdown.Items.Value.Instance.AutomaticSize = Enum.AutomaticSize.None
                dropdown.Items.Value.Instance.Size = UDim2.new(1, -32, 1, 0)
                Flags[dropdown.Flag] = dropdown.Value
                dropdown.Callback(dropdown.Value)
            end
            if dropdown.Search then
                local input = dropdown.Items.Textbox.Items
                local searchHost = input.Object.Instance.Parent
                searchHost.AutomaticSize = Enum.AutomaticSize.None
                searchHost.Size = UDim2.new(1, 0, 0, dropdown.SearchRowHeight)
                searchHost.Position = UDim2.fromOffset(0, 0)
                searchHost.LayoutOrder = -1
                input.Object.Instance.AutomaticSize = Enum.AutomaticSize.None
                input.Object.Instance.Size = UDim2.new(1, 0, 0, dropdown.SearchRowHeight)
                input.Outline.Instance.Position = UDim2.fromOffset(0, 0)
                input.Outline.Instance.Size = UDim2.new(1, 0, 0, dropdown.SearchRowHeight)
                input.Input.Instance.Position = UDim2.fromOffset(4, 0)
                input.Input.Instance.Size = UDim2.new(1, -8, 1, 0)
                input.Input.Instance.PlaceholderText = ""
                input.Input.Instance.ClearTextOnFocus = false
                for _, object in {searchHost, input.Object.Instance} do
                    for _, child in object:GetChildren() do
                        if child:IsA("UIPadding") then
                            child.PaddingLeft, child.PaddingRight = UDim.new(0, 0), UDim.new(0, 0)
                            child.PaddingTop, child.PaddingBottom = UDim.new(0, 0), UDim.new(0, 0)
                        elseif child:IsA("UIListLayout") then child.Padding = UDim.new(0, 0) end
                    end
                end
                input.Outline.Instance.BackgroundColor3 = popupBorder
                local searchInline = input.Outline.Instance:FindFirstChildWhichIsA("Frame")
                if searchInline then
                    searchInline.Position = UDim2.fromOffset(1, 1)
                    searchInline.Size = UDim2.new(1, -2, 1, -2)
                    searchInline.BackgroundTransparency = 1
                    for _, fill in searchInline:GetChildren() do
                        if fill:IsA("Frame") then
                            fill.Position = UDim2.fromOffset(0, 0)
                            fill.Size = UDim2.fromScale(1, 1)
                            fill.BackgroundColor3 = Library.MainStylePalette.Section
                            fill.BackgroundTransparency = 0
                            for _, gradient in fill:GetChildren() do
                                if gradient:IsA("UIGradient") then gradient.Enabled = false end
                            end
                        end
                    end
                end
                dropdown.Items.SearchHost = {Instance = searchHost}
                dropdown.Filter = function(_, text)
                    local query = tostring(text or ""):lower()
                    for _, option in dropdown.OptionInstances do
                        option.Value.Instance.Visible = option.Value.Instance.Text:lower():find(query, 1, true) ~= nil
                    end
                    dropdown.Items.OptionsHolder.Instance.CanvasPosition = Vector2.new(0, 0)
                    fitDropdown(dropdown)
                end
            end
            Library.ConfigFlags[dropdown.Flag] = dropdown.Set
            fitDropdown(dropdown)
            dropdown.SetVisible = function(visible)
                if visible == nil then visible = not dropdown.Open end
                visible = visible == true
                dropdown.Open, dropdown.Tweening = visible, false
                local popup = dropdown.Items.DropdownHolder.Instance
                if visible then
                    dropdown.ReferenceOpenedAt = os.clock()
                    popup.Parent = Library.Elements.Instance
                    fitDropdown(dropdown)
                    popup.Visible = true
                else
                    popup.Visible = false
                    popup.Parent = Library.Other.Instance
                end
            end
            Library:Connect(dropdown.Items.Outline.Instance:GetPropertyChangedSignal("AbsolutePosition"), function() fitDropdown(dropdown, true) end)
            Library:Connect(dropdown.Items.Outline.Instance:GetPropertyChangedSignal("AbsoluteSize"), function() fitDropdown(dropdown, true) end)
            Library:RegisterMainTextLayout(function()
                if dropdown.Items.DropdownHolder.Instance.Parent then fitDropdown(dropdown) end
            end)
            local default = data.Default
            if dropdown.NoDefault then default = nil
            elseif default == nil then default = dropdown.Multi and {dropdown.Options[1]} or dropdown.Options[1] end
            dropdown.Default = default
            dropdown.Set(default)
            return dropdown
        end

        local originalGetConfig = Library.GetConfig
        Library.GetConfig = function(self)
            local config = Services.HttpService:JSONDecode(originalGetConfig(self))
            for dropdown in dropdownVariants do
                if dropdown.Value == nil then config[dropdown.Flag] = false end
            end
            return Services.HttpService:JSONEncode(config)
        end
        local originalPosition = Library.UpdateDropdownPosition
        Library.UpdateDropdownPosition = function(self, open, debounce)
            if not self.VariantDropdown then return originalPosition(self, open, debounce) end
            if open then fitDropdown(self) end  
            local popup = self.Items.DropdownHolder
            local position, width = popupPosition(self)
            popup.Instance.Size = UDim2.fromOffset(width, popup.Instance.Size.Y.Offset)

            popup.Instance.Position = position
        end
    end

    do
        local constructing
        local border = Library.MainStylePalette.Border
        local panelFill = Library.MainStylePalette.Section
        local function widgetFont(object, bold)
            object.FontFace = bold and Fonts.MainBold or Fonts.Main
            object.TextSize = Library.MainTextSize or 12
            object.TextScaled = false
            object.TextWrapped = false
            object.RichText = false
            object.ClipsDescendants = false
            object.TextColor3 = Themes.Preset.TextMain
            for _, child in object:GetChildren() do
                if child:IsA("UIStroke") then
                    child.Color = Color3.new(0, 0, 0)
                    child.Thickness = 1
                    child.Transparency = 0
                end
            end
        end
        local function caption(object)
            widgetFont(object, false)
            object.AutomaticSize = Enum.AutomaticSize.None
            object.Position = UDim2.fromOffset(0, -3)
            object.Size = UDim2.new(1, 0, 0, 16)
            object.TextXAlignment = Enum.TextXAlignment.Left
            object.TextColor3 = Themes.Preset.TextMisc
        end
        local function firstFrame(parent)
            for _, object in parent:GetChildren() do
                if object:IsA("Frame") then return object end
            end
        end
        local function oneBorder(outer)
            outer.BackgroundColor3 = border
            outer.BorderSizePixel = 0
            local inline = firstFrame(outer)
            if inline then
                inline.AnchorPoint = Vector2.new(0, 0)
                inline.Position = UDim2.fromOffset(1, 1)
                inline.Size = UDim2.new(1, -2, 1, -2)
                inline.BackgroundTransparency = 1
                local inner = firstFrame(inline)
                if inner then
                    inner.Position = UDim2.fromOffset(0, 0)
                    inner.Size = UDim2.fromScale(1, 1)
                    inner.BackgroundTransparency = 0
                end
            end
        end
        local function fitInput(control, y, page, height)
            height = height or 14
            local row = control.Items.Object.Instance
            local host = row.Parent
            host.Parent = page
            host.AnchorPoint = Vector2.new(0, 0)
            host.Position = UDim2.fromOffset(0, y)
            host.Size = UDim2.new(1, 0, 0, height)
            host.AutomaticSize = Enum.AutomaticSize.None
            row.Size = UDim2.new(1, 0, 0, height)
            row.AutomaticSize = Enum.AutomaticSize.None
            control.Items.Outline.Instance.Position = UDim2.fromOffset(0, 0)
            control.Items.Outline.Instance.Size = UDim2.new(1, 0, 0, height)
            control.Items.Outline.Instance.BackgroundColor3 = Color3.fromRGB(28, 27, 34)
            local inline = firstFrame(control.Items.Outline.Instance)
            local fill = inline and firstFrame(inline)
            if fill then
                fill.BackgroundColor3 = panelFill
                for _, gradient in fill:GetChildren() do
                    if gradient:IsA("UIGradient") then gradient.Enabled = false end
                end
            end
            widgetFont(control.Items.Input.Instance, false)
            control.Items.Input.Instance.Position = UDim2.fromOffset(4, 0)
            control.Items.Input.Instance.Size = UDim2.new(1, -8, 1, 0)
            local textPadding = control.Items.Input.Instance:FindFirstChildOfClass("UIPadding")
            if textPadding then textPadding.PaddingLeft = UDim.new(0, 0) end
        end

        local previousSlider = Library.AddSlider
        Library.AddSlider = function(self, data)
            local owner = constructing
            if owner and data and data.Flag == owner.Flag .. "_AnimationSpeed" then
                data = table.clone(data)
                data.Type = "Normal"
                local slider = previousSlider(self, data)
                owner.Speed = slider
                return slider
            end
            return previousSlider(self, data)
        end
        local previousDropdown = Library.AddDropdown
        Library.AddDropdown = function(self, data)

            if constructing and constructing.ExtraGradient and data
                    and data.Flag == constructing.Flag .. "_Animation" then
                data = table.clone(data)
                data.Options = {"Solid", "Fading", "Rainbow", "Gradient"}
            end
            local dropdown = previousDropdown(self, data)
            if constructing and data and data.Flag == constructing.Flag .. "_Animation" then
                constructing.Mode = dropdown
            end
            return dropdown
        end
        local previousAddColor = Library.AddColorPicker
        Library.AddColorPicker = function(self, data)
            local owner = constructing
            local color = previousAddColor(self, data)
            if owner and data then
                if data.Flag == owner.Flag .. "1" then owner.First = color end
                if data.Flag == owner.Flag .. "2" then owner.Second = color end
            end
            return color
        end
        local previousConnect = Library.Connect
        Library.Connect = function(self, signal, callback)
            if constructing and constructing.Animation and signal == Services.RunService.RenderStepped then

                return {Event = signal, Callback = callback, Connection = nil}
            end
            return previousConnect(self, signal, callback)
        end

        local previousPage = Library.CreateColorpickerPage
        Library.CreateColorpickerPage = function(self, data)
            local page = previousPage(self, data)
            self.ReferenceColorPages = self.ReferenceColorPages or {}
            table.insert(self.ReferenceColorPages, page)
            return page
        end
        local previousOpen = Library.OpenColorpickerPage
        Library.OpenColorpickerPage = function(self, data)
            local picker = self.Colorpicker
            if not picker then return previousOpen(self, data) end
            if not picker.ReferenceColorStyle then
                if not constructing then return previousOpen(self, data) end

                if picker.OldTab then picker.OldTab.Items.Page.Instance.Visible = false end
                self.Items.Page.Instance.Visible = true
                picker.OldTab = self
                return
            end
            if picker.OldTab == self then return end
            local mode = picker.ReferenceColorControls and picker.ReferenceColorControls.Mode
            if mode and mode.Open then
                mode.Open, mode.Tweening = false, false
                mode.Items.DropdownHolder.Instance.Visible = false
            end
            for _, page in picker.ReferenceColorPages do
                local selected = page == self
                local items = page.Items
                page.Tweening = false
                items.Page.Instance.Visible = selected
                items.Button.Instance.BackgroundTransparency = selected and 0 or 1
                items.Text.Instance.FontFace = selected and Fonts.MainBold or Fonts.Main

                items.Text.Instance.TextColor3 = selected
                    and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(185, 185, 188)
                if items.ReferenceLine then
                    items.ReferenceLine.Instance.Visible = selected
                end

                items.Left.Instance.Visible = false
                items.Right.Instance.Visible = false
                items.Filler.Instance.Visible = false

                items.Stroke.Instance.Enabled = false
                items.Stroke.Instance.Transparency = 1
                if items.ReferenceLeftEdge then items.ReferenceLeftEdge.Instance.Visible = selected end
                if items.ReferenceRightEdge then items.ReferenceRightEdge.Instance.Visible = selected end
                if items.ReferenceSeam then items.ReferenceSeam.Instance.Visible = selected end
            end
            picker.OldTab = self
        end

        local previousPicker = Library.Colorpicker
        Library.Colorpicker = function(self, properties)
            properties = table.clone(properties or {})

            if properties.Type == nil or properties.Type == "Normal" then properties.Type = "Animation" end
            local owner = {Flag = properties.Flag or properties.Name or properties.Title or properties.Text,
                Animation = properties.Type == "Animation",
                ExtraGradient = properties.ExtraGradient == true}
            if not owner.Flag then
                owner.Flag = Library:NextFlag()
                properties.Flag = owner.Flag
            end
            local parentConstruction = constructing
            constructing = owner
            local success, picker = pcall(previousPicker, self, properties)
            constructing = parentConstruction
            if not success then error(picker, 0) end
            picker.ReferenceColorStyle = true
            picker.ReferenceColorControls = owner
            Library.ActiveColorpickers = Library.ActiveColorpickers or {}
            Library.AllColorpickers = Library.AllColorpickers or {}
            table.insert(Library.AllColorpickers, picker)
            if properties.MiscTab then
                picker.ReferenceMiscPage = picker:CreateColorpickerPage({Name = "Misc"})
            end
            if properties.HistoryTab then
                picker.ReferenceHistoryPage = picker:CreateColorpickerPage({Name = "History"})
            end
            local items = picker.Items
            local root = items.Outline.Instance
            root.Name = "ReferenceColorpicker"
            root.AutomaticSize = Enum.AutomaticSize.None
            root.Size = UDim2.fromOffset(214, 236)
            root.BackgroundColor3 = Library.MainStylePalette.OuterOutline
            root.BorderSizePixel = 0
            root.ClipsDescendants = false

            root.ZIndex = 20
            local glow = Library:Create("ImageLabel", {
                Parent = Library.Other.Instance, Name = "ColorpickerGlow",
                Image = "rbxassetid://18245826428", ImageColor3 = Themes.Preset.Accent,
                ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(21, 21, 79, 79),
                ImageTransparency = properties.GlowTransparency or (1 - Library.GlowStrength.Colorpicker / 100),
                BackgroundTransparency = 1, BorderSizePixel = 0,
                Active = false, Visible = false, ZIndex = 19, SliceScale = 0.7,
            }):Themify("Accent", "ImageColor3")
            items.ReferenceGlow = glow
            Library:RegisterGlow("Colorpicker", glow, properties.GlowTransparency)

            local closingGlow = false
            local function updateGlow()
                local active = not closingGlow and root.Visible and root.Parent == Library.Elements.Instance
                glow.Instance.Parent = active and Library.Elements.Instance or Library.Other.Instance
                glow.Instance.Visible = active
                if active then

                    glow.Instance.Position = root.Position + UDim2.fromOffset(-14, -14)
                    glow.Instance.Size = root.Size + UDim2.fromOffset(28, 28)
                end
            end
            Library:Connect(root:GetPropertyChangedSignal("Position"), updateGlow)
            Library:Connect(root:GetPropertyChangedSignal("Size"), updateGlow)
            Library:Connect(root:GetPropertyChangedSignal("Visible"), updateGlow)
            Library:Connect(root:GetPropertyChangedSignal("Parent"), updateGlow)
            updateGlow()

            Library.PopupOwners = Library.PopupOwners or setmetatable({}, {__mode = "k"})
            Library.PopupOwners[picker] = root
            local function removeFromStack()
                local stack = Library.ActiveColorpickers
                for index = #stack, 1, -1 do
                    if stack[index] == picker then table.remove(stack, index) end
                end
            end
            picker.SetVisible = function(visible)
                visible = visible == true
                if picker.Open == visible and root.Visible == visible then return end
                picker.Open, picker.Tweening = visible, false
                closingGlow = not visible
                if not visible then
                    removeFromStack()
                    root.Visible = false
                    local mode = owner.Mode
                    if mode then
                        mode.Open, mode.Tweening = false, false
                        mode.Items.DropdownHolder.Instance.Visible = false
                    end
                    picker.DisableDragging()
                    root.Parent = Library.Other.Instance
                    updateGlow()
                    return
                end
                picker.ReferenceOpenedAt = os.clock()
                local trigger = items.Object.Instance
                local viewport = workspace.CurrentCamera.ViewportSize
                local origin = Library.Elements.Instance.AbsolutePosition
                local x = math.clamp(math.round(trigger.AbsolutePosition.X - origin.X - 12), 0,
                    math.max(0, viewport.X - root.Size.X.Offset))
                local y = math.round(trigger.AbsolutePosition.Y - origin.Y + trigger.AbsoluteSize.Y + 4)
                if y + root.Size.Y.Offset > viewport.Y then y = trigger.AbsolutePosition.Y - origin.Y - root.Size.Y.Offset - 4 end
                y = math.clamp(y, 0, math.max(0, viewport.Y - root.Size.Y.Offset))
                removeFromStack()
                local earlier = Library.ActiveColorpickers[#Library.ActiveColorpickers]
                if earlier and earlier.Items and earlier.Items.Outline then
                    local other = earlier.Items.Outline.Instance
                    if other.Visible and earlier.Open then
                        local beside = other.Position.X.Offset + other.Size.X.Offset + 5
                        local before = other.Position.X.Offset - root.Size.X.Offset - 5
                        if beside + root.Size.X.Offset <= viewport.X then
                            x = beside
                            y = other.Position.Y.Offset
                        elseif before >= 0 then
                            x = before
                            y = other.Position.Y.Offset
                        end
                    end
                end
                table.insert(Library.ActiveColorpickers, picker)
                root.Parent = Library.Elements.Instance
                root.Position = UDim2.fromOffset(x, y - 4)
                root.Visible = true
                items.Outline:Tween({Position = UDim2.fromOffset(x, y)},
                    TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
                updateGlow()
            end
            for _, object in root:GetChildren() do
                if object:IsA("UIPadding") then object:Destroy() end
                if object:IsA("Frame") and object ~= items.Colorpicker.Instance then object.Visible = false end
            end
            local chrome = Library.MainStylePalette
            local shell = items.Colorpicker.Instance

            shell.Position = UDim2.fromOffset(1, 1)
            shell.Size = UDim2.new(1, -2, 1, -2)
            shell.AutomaticSize = Enum.AutomaticSize.None
            shell.BackgroundTransparency = 0
            shell.BackgroundColor3 = chrome.Border
            shell.BorderSizePixel = 0
            shell.ClipsDescendants = false
            for _, object in shell:GetChildren() do
                if object:IsA("UIPadding") then object:Destroy() end
            end
            local windowBackground = Library:Create("Frame", {Parent = shell,
                Name = "PickerWindowBackground", Position = UDim2.fromOffset(1, 1),
                Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = chrome.Window,
                BorderSizePixel = 0, ClipsDescendants = false, ZIndex = 2})
            items.ReferenceWindowBackground = windowBackground
            items.ReferenceTitle = Library:Create("TextLabel", {Parent = windowBackground.Instance,
                Text = "Colorpicker", Position = UDim2.fromOffset(4, 2),
                Size = UDim2.new(1, -8, 0, 14), BackgroundTransparency = 1,
                BorderSizePixel = 0, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4})
            widgetFont(items.ReferenceTitle.Instance, false)
            Library:Create("UIStroke", {Parent = items.ReferenceTitle.Instance,
                Color = Color3.new(0, 0, 0), Thickness = 1,
                LineJoinMode = Enum.LineJoinMode.Miter})

            local panelOutline = Library:Create("Frame", {Parent = windowBackground.Instance,
                Name = "PickerPageHolderOutline", Position = UDim2.fromOffset(5, 14),
                Size = UDim2.new(1, -10, 1, -20), BackgroundColor3 = chrome.Border,
                BorderSizePixel = 0, ClipsDescendants = false, ZIndex = 2})
            local panelInline = Library:Create("Frame", {Parent = panelOutline.Instance,
                Name = "PickerPageHolderInline", Position = UDim2.fromOffset(1, 1),
                Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = chrome.Outer,
                BorderSizePixel = 0, ClipsDescendants = false, ZIndex = 2})
            items.ReferencePageHolderOutline = panelOutline
            items.ReferencePageHolderInline = panelInline
            local body = items.Background.Instance
            body.Parent = panelInline.Instance
            body.Position = UDim2.fromOffset(0, 0)
            body.Size = UDim2.fromScale(1, 1)
            body.AutomaticSize = Enum.AutomaticSize.None
            body.BackgroundColor3 = chrome.Outer
            body.BorderSizePixel = 0
            body.ClipsDescendants = false
            for _, child in body:GetChildren() do
                if child:IsA("UIPadding") then child:Destroy() end
            end

            local pickerTabHeight = 16
            local pickerTabWidths = {Color = 38, Settings = 56, Misc = 38, History = 54}
            local pickerTabTop = 4
            local pickerBorderTop = pickerTabTop + pickerTabHeight
            local pageOutline = Library:Create("Frame", {Parent = body,
                Name = "PickerPageBorder", Position = UDim2.fromOffset(3, pickerBorderTop),
                Size = UDim2.new(1, -6, 1, -(pickerBorderTop + 3)), BackgroundColor3 = chrome.Border,
                BorderSizePixel = 0, ClipsDescendants = false, ZIndex = 2})
            local pageInterior = Library:Create("Frame", {Parent = pageOutline.Instance,
                Name = "PickerPageBackground", Position = UDim2.fromOffset(1, 1),
                Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = chrome.Window,
                BorderSizePixel = 0, ClipsDescendants = false, ZIndex = 2})
            items.ReferencePageBorder = pageOutline
            items.ReferencePageBackground = pageInterior
            local strip = items.TabButtonOutline.Instance
            strip.Parent = body

            strip.Position = UDim2.fromOffset(3, pickerTabTop)
            strip.Size = UDim2.new(1, -6, 0, pickerTabHeight)
            strip.BackgroundTransparency = 1
            strip.ClipsDescendants = false
            items.InlineLine.Instance.Visible = false
            items.OutlineLine.Instance.Visible = false
            items.TabButtonHolder.Instance.Size = UDim2.fromScale(1, 1)
            local layout = items.TabButtonHolder.Instance:FindFirstChildOfClass("UIListLayout")
            layout.Padding = UDim.new(0, 0)
            layout.HorizontalFlex = Enum.UIFlexAlignment.None
            layout.VerticalFlex = Enum.UIFlexAlignment.None
            layout.VerticalAlignment = Enum.VerticalAlignment.Top
            local colorPage
            local settingsPage
            for _, page in picker.ReferenceColorPages do
                local p = page.Items
                if page.Text == "Color" then colorPage = page end
                if page.Text == "Settings" then settingsPage = page end

                p.Button.Instance.Size = UDim2.fromOffset(
                    pickerTabWidths[page.Text] or 46, pickerTabHeight)
                p.Button.Instance.AutomaticSize = Enum.AutomaticSize.None
                p.Button.Instance.BackgroundColor3 = Color3.new(1, 1, 1)

                p.UIGradient.Instance.Color = Library.ReferenceTabGradient
                p.UIGradient.Instance.Rotation = 90
                widgetFont(p.Text.Instance, false)
                p.Text.Instance.AutomaticSize = Enum.AutomaticSize.None
                p.Text.Instance.Size = UDim2.fromScale(1, 1)
                p.Text.Instance.TextXAlignment = Enum.TextXAlignment.Center
                p.Text.Instance.TextYAlignment = Enum.TextYAlignment.Center
                p.ReferenceLine = Library:Create("Frame", {
                    Parent = p.Button.Instance, Position = UDim2.fromOffset(0, 0),
                    Size = UDim2.new(1, 0, 0, 1), Visible = false,
                    BorderSizePixel = 0, BackgroundColor3 = Themes.Preset.Accent,
                    ZIndex = 3,
                }):Themify("Accent", "BackgroundColor3")

                p.Left.Instance.Visible = false
                p.Right.Instance.Visible = false
                p.Left.Instance.BackgroundTransparency = 1
                p.Right.Instance.BackgroundTransparency = 1
                p.Stroke.Instance.Enabled = false
                p.Stroke.Instance.Transparency = 1
                p.Filler.Instance.Visible = false

                local edge = chrome.Border
                p.ReferenceLeftEdge = Library:Create("Frame", {
                    Name = "PickerTabLeftEdge", Parent = p.Button.Instance,
                    Position = UDim2.fromOffset(0, 1), Size = UDim2.new(0, 1, 1, -1),
                    BackgroundColor3 = edge, BorderSizePixel = 0,
                    Visible = false, ZIndex = 4,
                })
                p.ReferenceRightEdge = Library:Create("Frame", {
                    Name = "PickerTabRightEdge", Parent = p.Button.Instance,
                    Position = UDim2.new(1, -1, 0, 1), Size = UDim2.new(0, 1, 1, -1),
                    BackgroundColor3 = edge, BorderSizePixel = 0,
                    Visible = false, ZIndex = 4,
                })

                p.ReferenceSeam = Library:Create("Frame", {
                    Name = "PickerTabSeamCover", Parent = p.Button.Instance,
                    Position = UDim2.new(0, 1, 1, 0), Size = UDim2.new(1, -2, 0, 1),
                    BackgroundColor3 = chrome.Window, BorderSizePixel = 0,
                    Visible = false, ZIndex = 5,
                })
                p.Page.Instance.Parent = pageInterior.Instance
                p.Page.Instance.AutomaticSize = Enum.AutomaticSize.None

                p.Page.Instance.Position = UDim2.fromOffset(4, 5)
                p.Page.Instance.Size = UDim2.new(1, -8, 1, -9)
                p.Page.Instance.BackgroundTransparency = 1
                p.Page.Instance.ClipsDescendants = false
                for _, padding in p.Page.Instance:GetChildren() do
                    if padding:IsA("UIPadding") then padding:Destroy() end
                end
            end
            local page = colorPage.Items.Page.Instance
            local sat = items.SatValBackground.Instance
            sat.AnchorPoint = Vector2.new(0, 0)
            sat.Position = UDim2.fromOffset(0, 0)
            sat.Size = UDim2.new(1, -34, 0, 138)
            oneBorder(sat)
            items.ColorpickerBackground.Instance.Position = UDim2.fromOffset(0, 0)
            items.ColorpickerBackground.Instance.Size = UDim2.fromScale(1, 1)
            items.SatValPickerHolder.Instance.Position = UDim2.fromOffset(0, 0)
            items.SatValPickerHolder.Instance.Size = UDim2.fromScale(1, 1)
            items.Alpha.Instance.AnchorPoint = Vector2.new(0, 0)
            items.Alpha.Instance.Position = UDim2.new(1, -31, 0, 0)
            items.Alpha.Instance.Size = UDim2.fromOffset(13, 138)
            items.Hue.Instance.AnchorPoint = Vector2.new(0, 0)
            items.Hue.Instance.Position = UDim2.new(1, -15, 0, 0)
            items.Hue.Instance.Size = UDim2.fromOffset(14, 138)
            oneBorder(items.Alpha.Instance)
            oneBorder(items.Hue.Instance)
            fitInput(items.RgbInput, 142, page)
            fitInput(items.HexInput, 160, page)
            local saturation, value = select(2, picker.Color:ToHSV())
            local animating = false
            local originalSet = picker.Set
            picker.Set = function(color, alpha, colors)
                if color and not animating then
                    local _, s, v = color:ToHSV()
                    saturation, value = s, v
                end
                if colors ~= nil then picker.Colors = colors end
                originalSet(color, alpha, colors)
                if not animating then
                    local _, s, v = picker.Color:ToHSV()
                    saturation, value = s, v
                end

                items.GradientHolder.Instance.BackgroundColor3 = picker.Color
            end
            Library.ConfigFlags[picker.Flag] = picker.Set
            picker.Set(picker.Color, picker.Alpha)
            if settingsPage and owner.Mode then
                local mode = owner.Mode
                local row = mode.Items.Object.Instance
                local elements = row.Parent
                elements.Position = UDim2.fromOffset(0, 0)
                elements.Size = UDim2.new(1, 0, 0, 0)
                row.Size = UDim2.new(1, 0, 0, 29)
                caption(mode.Items.Title.Instance)
                mode.Items.Outline.Instance.Position = UDim2.fromOffset(0, 12)
                mode.Items.Outline.Instance.Size = UDim2.new(1, 0, 0, 14)
                mode.Items.Outline.Instance.BackgroundColor3 = chrome.Border
                widgetFont(mode.Items.Value.Instance, false)
                widgetFont(mode.Items.Indicator.Instance, false)
                mode.Items.Indicator.Instance.Size = UDim2.fromOffset(13, 14)
                for _, endpoint in {owner.First, owner.Second} do
                    local swatch = endpoint.Items.Object.Instance
                    local host = swatch.Parent.Parent
                    local endpointRow = host.Parent
                    endpointRow.Size = UDim2.new(1, 0, 0, 14)
                    host.Position = UDim2.new(1, 0, 0, 0)
                    host.Size = UDim2.fromOffset(0, 12)
                    swatch.Parent.Size = UDim2.fromOffset(24, 11)
                    local label = endpointRow:FindFirstChildOfClass("TextLabel")
                    if label then caption(label) end
                end
                local speed = owner.Speed
                speed.Items.Object.Instance.Size = UDim2.new(1, 0, 0, 28)
                caption(speed.Items.Title.Instance)
                speed.Items.Outline.Instance.Position = UDim2.fromOffset(7, 12)
                speed.Items.Outline.Instance.Size = UDim2.new(1, -18, 0, 7)
                widgetFont(speed.Items.Value.Instance, false)
                speed.Items.Minus.Instance.Position = UDim2.fromOffset(0, 8)
                speed.Items.Plus.Instance.Position = UDim2.new(1, -10, 0, 8)
                speed.Items.Minus.Instance.Size = UDim2.fromOffset(10, 14)
                speed.Items.Plus.Instance.Size = UDim2.fromOffset(10, 14)
                widgetFont(speed.Items.Minus.Instance, false)
                widgetFont(speed.Items.Plus.Instance, false)
                for _, symbol in {speed.Items.Minus, speed.Items.Plus} do
                    local position = symbol.Instance.Position
                    symbol.Tween = function(wrapper, data, ...)
                        local updated = table.clone(data)
                        updated.Position = wrapper.Instance.Position
                        updated.TextTransparency = 0
                        return Library.Tween(wrapper, updated, ...)
                    end
                end
                local animationTask, animationDestroyed
                animationTask = Library:CreateRenderTask(function()
                    local selected = Flags[picker.Flag .. "_Animation"] or "Solid"
                    if selected ~= "Rainbow" and selected ~= "Fading" then animationTask:Stop(); return end
                    local rate = tonumber(Flags[picker.Flag .. "_AnimationSpeed"]) or 50
                    local phase = math.abs(math.sin(tick() * rate / 25))
                    animating = true
                    if selected == "Rainbow" then
                        picker.Set(Color3.fromHSV(phase, saturation == 0 and 1 or saturation, value), picker.Alpha)
                    elseif selected == "Fading" then
                        local first = Flags[picker.Flag .. "1"]
                        local second = Flags[picker.Flag .. "2"]
                        if first and second then
                            picker.Set(first.Color:Lerp(second.Color, phase),
                                Library:Lerp(first.Transparency, second.Transparency, phase))
                        end
                    end
                    animating = false
                end, 1 / 60)
                local function syncAnimation()
                    local selected = Flags[picker.Flag .. "_Animation"]
                    if not animationDestroyed and (selected == "Rainbow" or selected == "Fading") then animationTask:Start()
                    else animationTask:Stop() end
                end
                local previousModeCallback = mode.Callback
                mode.Callback = function(...)
                    syncAnimation()
                    return previousModeCallback(...)
                end
                picker.AnimationTask = animationTask
                Library:Connect(root.Destroying, function() animationDestroyed = true; animationTask:Stop() end)
                syncAnimation()
            end
            Library:RegisterMainTextLayout(function(size)
                if not root.Parent then return end
                local extra = math.max(0, size - 10)
                local fieldHeight = 14 + extra
                root.Size = UDim2.fromOffset(214, 236 + extra * 3)
                items.ReferenceTitle.Instance.Size = UDim2.new(1, -8, 0, fieldHeight)
                panelOutline.Instance.Position = UDim2.fromOffset(5, 14 + extra)
                panelOutline.Instance.Size = UDim2.new(1, -10, 1, -(20 + extra))
                strip.Size = UDim2.new(1, -6, 0, pickerTabHeight + extra)
                pageOutline.Instance.Position = UDim2.fromOffset(3, pickerBorderTop + extra)
                pageOutline.Instance.Size = UDim2.new(1, -6, 1, -(pickerBorderTop + extra + 3))
                for _, pickerPage in picker.ReferenceColorPages do
                    local button = pickerPage.Items.Button.Instance
                    button.Size = UDim2.fromOffset((pickerTabWidths[pickerPage.Text] or 46) + extra * 3,
                        pickerTabHeight + extra)
                end
                fitInput(items.RgbInput, 142, page, fieldHeight)
                fitInput(items.HexInput, 160 + extra, page, fieldHeight)
                if settingsPage and owner.Mode then
                    local mode = owner.Mode
                    mode.Items.Object.Instance.Size = UDim2.new(1, 0, 0, 29 + extra * 2)
                    mode.Items.Title.Instance.Size = UDim2.new(1, 0, 0, 16 + extra)
                    mode.Items.Outline.Instance.Position = UDim2.fromOffset(0, 12 + extra)
                    mode.Items.Outline.Instance.Size = UDim2.new(1, 0, 0, fieldHeight)
                    mode.Items.Indicator.Instance.Size = UDim2.fromOffset(13, fieldHeight)
                    for _, endpoint in {owner.First, owner.Second} do
                        local swatch = endpoint.Items.Object.Instance
                        local host = swatch.Parent.Parent
                        local endpointRow = host.Parent
                        endpointRow.Size = UDim2.new(1, 0, 0, fieldHeight)
                        host.Position = UDim2.new(1, 0, 0, math.floor(extra / 2))
                        local title = endpointRow:FindFirstChildOfClass("TextLabel")
                        if title then title.Size = UDim2.new(1, -30, 0, 16 + extra) end
                    end
                    local speed = owner.Speed
                    speed.Items.Object.Instance.Size = UDim2.new(1, 0, 0, 28 + extra * 2)
                    speed.Items.Title.Instance.Size = UDim2.new(1, 0, 0, 16 + extra)
                    speed.Items.Outline.Instance.Position = UDim2.fromOffset(8, 12 + extra)
                    speed.Items.Outline.Instance.Size = UDim2.new(1, -20, 0, 7)
                    speed.Items.Value.Instance.Size = UDim2.new(0, 0, 0, 16 + extra)
                    speed.Items.Minus.Instance.Position = UDim2.fromOffset(0, 8 + extra)
                    speed.Items.Plus.Instance.Position = UDim2.new(1, -10, 0, 8 + extra)
                end
            end)
            picker.OldTab = nil
            colorPage:OpenColorpickerPage()
            return picker
        end
        local function inside(point, object)
            if not object or not object.Parent or not object.Visible then return false end
            local at, size = object.AbsolutePosition, object.AbsoluteSize
            return point.X >= at.X and point.X <= at.X + size.X
                and point.Y >= at.Y and point.Y <= at.Y + size.Y
        end
        local function visibleThroughParents(object)
            while object do
                if object:IsA("GuiObject") and not object.Visible then return false end
                object = object.Parent
            end
            return true
        end
        Library:Connect(Services.UserInputService.InputBegan, function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then return end
            local stack = Library.ActiveColorpickers
            if not stack or #stack == 0 then return end
            local point = input.UserInputType == Enum.UserInputType.Touch
                and Vector2.new(input.Position.X, input.Position.Y)
                or Services.UserInputService:GetMouseLocation()
            local current = stack[#stack]
            task.defer(function()
                if not current or not current.Open then return end
                for _, picker in ipairs(stack) do
                    if picker.Open and inside(point, picker.Items.Outline.Instance) then return end
                end
                for _, picker in ipairs(Library.AllColorpickers or {}) do
                    local trigger = picker.Items.Object.Instance
                    if visibleThroughParents(trigger) and inside(point, trigger) then return end
                end
                if current.Open then current.SetVisible(false) end
            end)
        end)
    end

    do
        local inputService = Services.UserInputService
        local function isPointerPress(input)
            return input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch
        end
        local function installRepeat(symbol, step)
            if not (symbol and symbol.Instance) then return end
            local button = symbol.Instance
            button.Active = true
            local heldInput
            local heldSerial = 0
            local function stop()
                heldInput = nil
                heldSerial += 1
            end
            Library:Connect(button.InputBegan, function(input)
                if not isPointerPress(input) then return end
                stop()
                heldInput = input
                local thisPress = heldSerial
                task.spawn(function()
                    task.wait(0.32)
                    while heldInput and heldSerial == thisPress and button.Parent do
                        step()
                        task.wait(0.065)
                    end
                end)
            end)
            Library:Connect(inputService.InputEnded, function(input)
                if heldInput and (input == heldInput or
                    (heldInput.UserInputType == Enum.UserInputType.MouseButton1 and
                     input.UserInputType == Enum.UserInputType.MouseButton1)) then
                    stop()
                end
            end)
            Library:Connect(button.MouseLeave, stop)
            Library:Connect(button.Destroying, stop)
        end
        local oldSlider = Library.AddSlider
        Library.AddSlider = function(self, data)
            local slider = oldSlider(self, data)
            local items = slider.Items
            installRepeat(items.Minus, function()
                if slider.Value > slider.Min then slider.Set(slider.Value - slider.Intervals) end
            end)
            installRepeat(items.Plus, function()
                if slider.Value < slider.Max then slider.Set(slider.Value + slider.Intervals) end
            end)
            return slider
        end
        local oldRange = Library.AddRangeSlider
        Library.AddRangeSlider = function(self, data)
            local slider = oldRange(self, data)
            local items = slider.Items
            installRepeat(items.Minus, function()
                if slider.Value[1] > slider.Min then
                    slider.Set(slider.Value[1] - slider.Intervals, slider.Value[2] - slider.Intervals)
                end
            end)
            installRepeat(items.Plus, function()
                if slider.Value[2] < slider.Max then
                    slider.Set(slider.Value[1] + slider.Intervals, slider.Value[2] + slider.Intervals)
                end
            end)
            return slider
        end
    end

    do
        local activeTooltip
        local function guiVisible(object)
            local cursor = object
            while cursor do
                if cursor:IsA("GuiObject") and not cursor.Visible then return false end
                if cursor:IsA("ScreenGui") then return cursor.Enabled end
                cursor = cursor.Parent
            end
            return false
        end
        Library.Tooltip = function(self, data)
            if type(data) == "string" then data = {Text = data} end
            data = data or {}
            local owner = assert(self.Items and self.Items.Object and self.Items.Object.Instance,
                "Tooltip requires a control with Items.Object")
            if self.TooltipInfo then self.TooltipInfo:Destroy() end
            local config = {Items = {}, Open = false, Destroyed = false,
                Text = data.Text or data.Description or data.Name or "",
                Title = data.Title or "", Hovered = false,
                Delay = math.max(0, tonumber(data.Delay) or 0.08),
                SmoothTime = math.max(0.01, tonumber(data.SmoothTime) or 0.06),
                Offset = data.Offset or Vector2.new(12, 16),
                MaxWidth = math.max(80, tonumber(data.MaxWidth) or 260)}
            setmetatable(config, Library)
            self.TooltipInfo = config
            local items = config.Items
            items.Outline = Library:Create("CanvasGroup", {Parent = Library.Elements.Instance,
                Name = "ControlTooltip", Visible = false, GroupTransparency = 1,
                Size = UDim2.fromOffset(122, 46), BorderSizePixel = 0, Active = false,
                BackgroundColor3 = Themes.Preset.Outline, ZIndex = 100}):Themify("Outline", "BackgroundColor3")
            items.Background = Library:Create("Frame", {Parent = items.Outline.Instance,
                Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2),
                BorderSizePixel = 0, Active = false, BackgroundColor3 = Themes.Preset.SectionBackground,
                ZIndex = 100}):Themify("SectionBackground", "BackgroundColor3")
            items.Title = Library:Create("TextLabel", {Parent = items.Background.Instance,
                Text = config.Title, FontFace = Fonts.MainBold, TextSize = Library.MainTextSize,
                Position = UDim2.fromOffset(6, 2), Size = UDim2.fromOffset(0, 16),
                AutomaticSize = Enum.AutomaticSize.X, BorderSizePixel = 0,
                BackgroundTransparency = 1, TextColor3 = Themes.Preset.Accent,
                TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
                TextWrapped = false, TextScaled = false, RichText = false, ZIndex = 101}):Themify("Accent", "TextColor3")
            items.Text = Library:Create("TextLabel", {Parent = items.Background.Instance,
                Text = config.Text, FontFace = Fonts.Main, TextSize = Library.MainTextSize,
                Position = UDim2.fromOffset(6, 18), Size = UDim2.fromOffset(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY, BorderSizePixel = 0,
                BackgroundTransparency = 1, TextColor3 = Themes.Preset.TextMain,
                TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = false, TextScaled = false, RichText = data.RichText == true,
                TextTruncate = Enum.TextTruncate.None, ZIndex = 101}):Themify("TextMain", "TextColor3")
            for _, label in {items.Title, items.Text} do
                Library:Create("UIStroke", {Parent = label.Instance, Color = Color3.new(0, 0, 0),
                    Thickness = 1, LineJoinMode = Enum.LineJoinMode.Miter})
            end
            local fitting = false
            local wrapped = false
            local function fit()
                if fitting or config.Destroyed then return end
                fitting = true
                local hasTitle = config.Title ~= ""
                items.Title.Instance.Visible = hasTitle

                local lineHeight = math.max(16, items.Text.Instance.TextSize + 4)
                items.Title.Instance.Size = UDim2.fromOffset(0, lineHeight)
                local top = hasTitle and lineHeight + 2 or 4
                items.Text.Instance.Position = UDim2.fromOffset(6, top)
                if not wrapped and items.Text.Instance.TextBounds.X > config.MaxWidth - 14 then
                    wrapped = true
                    items.Text.Instance.AutomaticSize = Enum.AutomaticSize.Y
                    items.Text.Instance.TextWrapped = true
                    items.Text.Instance.Size = UDim2.fromOffset(config.MaxWidth - 14, 0)
                end
                local width = math.clamp(math.ceil(math.max(items.Title.Instance.TextBounds.X,
                    wrapped and config.MaxWidth - 14 or items.Text.Instance.TextBounds.X)) + 14, 48, config.MaxWidth)
                local height = top + math.max(lineHeight, math.ceil(items.Text.Instance.TextBounds.Y)) + 5
                items.Outline.Instance.Size = UDim2.fromOffset(width, height)
                fitting = false
            end
            Library:Connect(items.Title.Instance:GetPropertyChangedSignal("TextBounds"), fit)
            Library:Connect(items.Text.Instance:GetPropertyChangedSignal("TextBounds"), fit)
            Library:Connect(items.Text.Instance:GetPropertyChangedSignal("TextSize"), function()

                wrapped = false
                items.Text.Instance.TextWrapped = false
                items.Text.Instance.AutomaticSize = Enum.AutomaticSize.XY
                items.Text.Instance.Size = UDim2.fromOffset(0, 0)
                task.defer(fit)
            end)
            fit()
            local current = Vector2.zero
            local pointerOverride
            local alpha = 1
            local enteredAt = 0
            local stepTask
            local function target()
                local pointer = pointerOverride or Services.UserInputService:GetMouseLocation()
                local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
                local size = items.Outline.Instance.AbsoluteSize
                local x, y = pointer.X + config.Offset.X, pointer.Y + config.Offset.Y
                if x + size.X > viewport.X - 4 then x = pointer.X - size.X - config.Offset.X end
                if y + size.Y > viewport.Y - 4 then y = pointer.Y - size.Y - config.Offset.Y end
                return Vector2.new(math.clamp(x, 4, math.max(4, viewport.X - size.X - 4)),
                    math.clamp(y, 4, math.max(4, viewport.Y - size.Y - 4)))
            end
            function config:Show(pointer)
                if self.Destroyed or not guiVisible(owner) then return end
                if activeTooltip and activeTooltip ~= self then activeTooltip:Hide() end
                activeTooltip = self
                pointerOverride = pointer
                local destination = target()
                if not items.Outline.Instance.Visible then
                    current = destination + Vector2.new(-8, 6)
                    alpha = 1
                    items.Outline.Instance.Position = UDim2.fromOffset(math.round(current.X), math.round(current.Y))
                end
                self.Open = true
                items.Outline.Instance.Visible = true
                if stepTask then stepTask:Start() end
            end
            function config:Hide()
                self.Open = false
                self.Hovered = false
            end
            function config:SetText(text, title)
                self.Text = tostring(text or "")
                if title ~= nil then self.Title = tostring(title) end
                wrapped = false
                items.Text.Instance.TextWrapped = false
                items.Text.Instance.AutomaticSize = Enum.AutomaticSize.XY
                items.Text.Instance.Size = UDim2.fromOffset(0, 0)
                items.Title.Instance.Text = self.Title
                items.Text.Instance.Text = self.Text
                task.defer(fit)
            end
            local stepConnection
            function config:Destroy()
                if self.Destroyed then return end
                self.Destroyed, self.Open, self.Hovered = true, false, false
                if activeTooltip == self then activeTooltip = nil end
                if stepTask then stepTask:Stop() end
                items.Outline.Instance:Destroy()
                if owner.Parent and self == self.Owner.TooltipInfo then self.Owner.TooltipInfo = nil end
            end
            config.Owner = self
            Library:Connect(owner.MouseEnter, function()
                config.Hovered = true
                enteredAt = os.clock()
                pointerOverride = nil
                stepTask:Start()
            end)
            Library:Connect(owner.MouseLeave, function() config:Hide() end)
            Library:Connect(owner.Destroying, function() config:Destroy() end)
            Library:Connect(items.Outline.Instance:GetPropertyChangedSignal("Visible"), function()
                if not items.Outline.Instance.Visible then config.Open = false end
            end)
            stepTask = Library:CreateRenderTask(function(dt)
                if config.Destroyed then return end
                if config.Hovered and not config.Open and os.clock() - enteredAt >= config.Delay then config:Show() end
                if not guiVisible(owner) or not Library.Elements.Instance.Enabled then config:Hide() end
                if not items.Outline.Instance.Visible then
                    if not config.Hovered then stepTask:Stop() end
                    return
                end
                local follow = 1 - math.exp(-dt / config.SmoothTime)
                local destination = target() + (config.Open and Vector2.zero or Vector2.new(0, -4))
                current = current:Lerp(destination, follow)
                alpha += ((config.Open and 0 or 1) - alpha) * (1 - math.exp(-dt / 0.075))
                items.Outline.Instance.Position = UDim2.fromOffset(math.round(current.X), math.round(current.Y))
                items.Outline.Instance.GroupTransparency = math.clamp(alpha, 0, 1)
                if not config.Open and alpha >= 0.995 then
                    items.Outline.Instance.Visible = false
                    items.Outline.Instance.GroupTransparency = 1
                    if activeTooltip == config then activeTooltip = nil end
                    stepTask:Stop()
                end
            end)
            return config
        end
    end

    do

Library.SupportsDeferredControlGallery = true
Library.BuildControlGallery = function(Library, window, existingTab)
    if window.ControlGallery then return window.ControlGallery end
    local tab = existingTab or window:AddTab({Text = "Controls", Columns = 2})
    local state = {}
    local gallery = {Tab = tab, State = state, Sliders = {}, Dropdowns = {}}
    window.ControlGallery = gallery
    if window.ReferenceControls then window.ReferenceControls.Tabs.Controls = tab end
    local function remember(key)
        return function(value, extra)
            state[key] = value
            if extra ~= nil then state[key .. "Alpha"] = extra end
        end
    end
    local sliders = tab:AddSection({Title = "Sliders", Side = 1})
    gallery.TooltipToggle = sliders:AddToggle({Text = "Hover for tooltip", Flag = "Gallery_TooltipToggle", Default = false})
    gallery.TooltipToggle:Tooltip({Title = "Titleee", Text = "This is a tooltip!!!\nAlso goes multi line!!"})
    gallery.Sliders.Normal = sliders:AddSlider({Text = "Slider (Normal)", Flag = "Gallery_SliderNormal", Type = "Normal", Min = 0, Max = 100, Default = 50, Callback = remember("Normal")})
    gallery.Sliders.Integer = sliders:AddSlider({Text = "Slider (Integer)", Flag = "Gallery_SliderInteger", Type = "Normal", ValueType = "Integer", Min = -10, Max = 10, Default = 5, Callback = remember("Integer")})
    gallery.Sliders.Float = sliders:AddSlider({Text = "Slider (Float)", Flag = "Gallery_SliderFloat", Type = "Normal", ValueType = "Float", Min = 0, Max = 10, Default = 2.5, Callback = remember("Float")})
    gallery.Sliders.Decimal = sliders:AddSlider({Text = "Slider (Decimal)", Flag = "Gallery_SliderDecimal", Type = "Normal", ValueType = "Decimal", Min = 0, Max = 1, Default = 0.25, DecimalPlaces = 2, Callback = remember("Decimal")})
    gallery.Sliders.String = sliders:AddSlider({Text = "Slider (String)", Flag = "Gallery_SliderString", Type = "Normal", ValueType = "String", Min = -200, Max = 200, Step = 0.1, Suffix = "m/s", Default = 35.4, Callback = remember("String")})
    gallery.Sliders.Range = sliders:AddRangeSlider({Text = "Slider (Range)", Flag = "Gallery_SliderRange", Min = 0, Max = 100, Default = {20, 80}, Callback = remember("Range")})
    local label = sliders:AddLabel({Text = "Animated color"})
    gallery.Color = label:AddColorPicker({Text = "Animated color", Flag = "Gallery_AnimatedColor", Type = "Animation", Default = Color3.fromRGB(255, 64, 64), Callback = remember("Color")})

    local dropdowns = tab:AddSection({Title = "Dropdowns", Side = 2})
    local options = {"option1", "option2", "option3"}
    local function compact(data)
        data.RowHeight, data.BarHeight, data.BarOffset, data.LabelY = 32, 15, 14, 0
        data.OptionHeight, data.SearchRowHeight, data.PopupGap = 18, 16, 2
        return dropdowns:AddDropdown(data)
    end
    gallery.Dropdowns.Single = compact({Text = "Dropdown (Single)", Flag = "Gallery_DropdownSingle", Options = options, Default = "option1", Callback = remember("Single")})
    gallery.Dropdowns.Multi = compact({Text = "Dropdown (Multi)", Flag = "Gallery_DropdownMulti", Options = options, Multi = true, Default = {"option1"}, Callback = remember("Multi")})
    gallery.Dropdowns.Searchable = compact({Text = "Dropdown (Searchable)", Flag = "Gallery_DropdownSearchable", Options = options, Search = true, Default = "option1", Callback = remember("Searchable")})
    gallery.Dropdowns.Normal = compact({Text = "Dropdown", Flag = "Gallery_DropdownNormal", Options = options, Callback = remember("Dropdown")})
    gallery.Dropdowns.NoDefault = compact({Text = "Dropdown (No Default)", Flag = "Gallery_DropdownNoDefault", Options = options, NoDefault = true, Callback = remember("NoDefault")})
    local largeOptions = {}
    for index = 1, 50 do largeOptions[index] = "option" .. index end
    gallery.Dropdowns.Large = compact({Text = "Dropdown (Large Option Set)", Flag = "Gallery_DropdownLarge", Options = largeOptions, MaxVisibleOptions = 8, Default = "option1", Callback = remember("Large")})
    local buttons = tab:AddSection({Title = "Buttons", Side = 1})
    gallery.ConfirmButton = buttons:AddButton({Text = "Double click to confirm", Confirmation = true,
        Callback = function()
            state.Confirmations = (state.Confirmations or 0) + 1
            gallery.ConfirmationResult.Items.Label.Instance.Text = "Confirmed: " .. state.Confirmations
        end})
    gallery.ConfirmationResult = buttons:AddLabel({Text = "Confirmed: 0"})
    return gallery
end

    end

    do
        local function box(parent, name, position, size, color, z)
            return Library:Create("Frame", {Parent = parent, Name = name, Position = position,
                Size = size, BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = z or 1})
        end
        local function text(parent, value, position, size, bold, centered)
            local label = Library:Create("TextLabel", {Parent = parent, Text = value,
                Position = position, Size = size, BackgroundTransparency = 1, BorderSizePixel = 0,
                FontFace = bold and Fonts.MainBold or Fonts.Main, TextSize = Library.MainTextSize,
                TextColor3 = Themes.Preset.TextMain, TextXAlignment = centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd,
                TextWrapped = false, ZIndex = 3})
            Library:Create("UIStroke", {Parent = label.Instance, Color = Color3.new(0, 0, 0),
                Thickness = 1, LineJoinMode = Enum.LineJoinMode.Miter})
            return label
        end
        local function dragPanel(handle, root)
            local held, startInput, startPosition, target, current
            local dragTask
            local function stopDrag()
                held, target = nil, nil
                dragTask:Stop()
            end
            dragTask = Library:CreateRenderTask(function(dt)
                if not target or not root.Instance.Parent or not root.Instance.Visible then stopDrag(); return end
                current = current:Lerp(target, 1 - math.exp(-dt / 0.055))
                local settled = (current - target).Magnitude < 0.05
                if settled then current = target end
                local position = UDim2.fromOffset(math.round(current.X), math.round(current.Y))
                if root.Instance.Position ~= position then root.Instance.Position = position end
                if settled then target = nil; dragTask:Stop() end
            end)
            Library:Connect(handle.Instance.InputBegan, function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1
                    and input.UserInputType ~= Enum.UserInputType.Touch then return end
                held, startInput = input, input.Position
                startPosition = Vector2.new(root.Instance.Position.X.Offset, root.Instance.Position.Y.Offset)
                target, current = nil, startPosition
            end)
            Library:Connect(Services.UserInputService.InputChanged, function(input)
                if not held or (input.UserInputType ~= Enum.UserInputType.MouseMovement and input ~= held) then return end
                local delta = input.Position - startInput
                local camera = workspace.CurrentCamera
                local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
                target = Vector2.new(math.clamp(startPosition.X + delta.X, 0, math.max(0, viewport.X - root.Instance.AbsoluteSize.X)),
                    math.clamp(startPosition.Y + delta.Y, 0, math.max(0, viewport.Y - root.Instance.AbsoluteSize.Y)))
                dragTask:Start()
            end)
            Library:Connect(Services.UserInputService.InputEnded, function(input)
                if held and (input == held or input.UserInputType == held.UserInputType) then held = nil end
            end)
            Library:Connect(Services.UserInputService.WindowFocusReleased, function() held = nil end)
            Library:Connect(root.Instance:GetPropertyChangedSignal("Visible"), function()
                if not root.Instance.Visible then stopDrag() end
            end)
            Library:Connect(root.Instance.Destroying, stopDrag)
        end
        local function panel(title, size, position)
            local palette = Library.MainStylePalette
            local root = box(Library.Items.Instance, "Reference" .. title:gsub(" ", ""), position,
                UDim2.fromOffset(size.X, size.Y), palette.OuterOutline, 40)
            root.Instance.Visible = false
            local glow = Library:Create("ImageLabel", {Parent = Library.Items.Instance,
                Image = "rbxassetid://18245826428", ImageColor3 = Themes.Preset.Accent,
                ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(21, 21, 79, 79), SliceScale = 0.7,
                ImageTransparency = 0.9, BackgroundTransparency = 1, BorderSizePixel = 0,
                Visible = false, ZIndex = 39})
            glow:Themify("Accent", "ImageColor3")
            Library:RegisterGlow("Main", glow)
            local inline = box(root.Instance, "Inline", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Border)
            local background = box(inline.Instance, "Background", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Window)
            local heading = box(root.Instance, "DragHandle", UDim2.fromOffset(2, 2), UDim2.new(1, -4, 0, 15), palette.Window, 4)
            heading.Instance.Active = true
            local caption = text(heading.Instance, title, UDim2.fromOffset(5, 0), UDim2.new(1, -10, 1, 0), true)
            local body = box(root.Instance, "BodyBorder", UDim2.fromOffset(8, 19), UDim2.new(1, -16, 1, -29), palette.Border, 2)
            local bodyInline = box(body.Instance, "BodyInline", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Outer)
            local bodyBackground = box(bodyInline.Instance, "BodyBackground", UDim2.fromOffset(4, 4), UDim2.new(1, -8, 1, -8), palette.Window)
            local cfg = {Open = false, Items = {Root = root, Header = heading, Title = caption, Body = body,
                BodyBackground = bodyBackground, Glow = glow}}
            local function syncGlow()
                glow.Instance.Position = root.Instance.Position + UDim2.fromOffset(-14, -14)
                glow.Instance.Size = root.Instance.Size + UDim2.fromOffset(28, 28)
                glow.Instance.Visible = root.Instance.Visible
            end
            Library:Connect(root.Instance:GetPropertyChangedSignal("Position"), syncGlow)
            Library:Connect(root.Instance:GetPropertyChangedSignal("Size"), syncGlow)
            Library:Connect(root.Instance:GetPropertyChangedSignal("Visible"), syncGlow)
            function cfg:SetVisible(visible)
                self.Open = visible == true
                root.Instance.Visible = self.Open
                syncGlow()
                if not self.Open and self.Priority then self.Priority.SetVisible(false) end
                if self.Dashboard then self.Dashboard:Sync() end
            end
            function cfg:Toggle() self:SetVisible(not self.Open) end
            dragPanel(heading, root)
            syncGlow()
            return cfg
        end

        Library.BuildReferencePreviewModel = function(self, directory)
            directory = tostring(directory or "gamehaxx/models"):gsub("\\", "/"):gsub("/+$", "")
            local workspaceRelative = directory:match("/[Ww][Oo][Rr][Kk][Ss][Pp][Aa][Cc][Ee]/(.+)$")
            if workspaceRelative then directory = workspaceRelative end

            local model = Instance.new("Model")
            model.Name = "DestinyPreview"
            local metadata = {Meshes = {}, Parts = 0, Faces = 0, Directory = directory}
            local destroyConnection
            local released = false
            local function releaseMeshes()
                if released then return end
                released = true
                for _, mesh in metadata.Meshes do pcall(function() mesh:Destroy() end) end
                table.clear(metadata.Meshes)
            end
            metadata.Destroy = function()
                if destroyConnection then destroyConnection:Disconnect(); destroyConnection = nil end
                pcall(function() model:Destroy() end)
                releaseMeshes()
            end

            local success, failure = pcall(function()
                local positions, uvs, normals, groups, materials = {}, {}, {}, {}, {}
                local currentGroup
                local minimum = Vector3.new(math.huge, math.huge, math.huge)
                local maximum = Vector3.new(-math.huge, -math.huge, -math.huge)
                local function numbers(value)
                    local result = {}
                    for number in value:gmatch("%S+") do result[#result + 1] = tonumber(number) end
                    return result
                end
                local function newGroup(name, material)
                    local group = {Name = name or "Mesh", Material = material, Faces = {}}
                    groups[#groups + 1] = group
                    currentGroup = group
                    return group
                end
                local function index(value, count)
                    local parsed = tonumber(value)
                    if not parsed or parsed == 0 then return nil end
                    return parsed < 0 and (count + parsed + 1) or parsed
                end
                for line in readfile(directory .. "/destiny.obj"):gmatch("[^\r\n]+") do
                    local command, value = line:match("^%s*(%S+)%s+(.+)$")
                    if command == "v" then
                        local values = numbers(value)
                        local position = Vector3.new(values[1], values[2], values[3])
                        positions[#positions + 1] = position
                        minimum = Vector3.new(math.min(minimum.X, position.X), math.min(minimum.Y, position.Y), math.min(minimum.Z, position.Z))
                        maximum = Vector3.new(math.max(maximum.X, position.X), math.max(maximum.Y, position.Y), math.max(maximum.Z, position.Z))
                    elseif command == "vt" then
                        local values = numbers(value)

                        uvs[#uvs + 1] = Vector2.new(values[1], 1 - values[2])
                    elseif command == "vn" then
                        local values = numbers(value)
                        normals[#normals + 1] = Vector3.new(values[1], values[2], values[3])
                    elseif command == "g" or command == "o" then
                        newGroup(value:match("^%S+"))
                    elseif command == "usemtl" then
                        if not currentGroup then newGroup("Mesh", value)
                        elseif #currentGroup.Faces > 0 and currentGroup.Material ~= value then
                            newGroup(currentGroup.Name, value)
                        else currentGroup.Material = value end
                    elseif command == "f" then
                        if not currentGroup then newGroup() end
                        local corners = {}
                        for token in value:gmatch("%S+") do
                            local vertex, uv, normal = token:match("^([^/]+)/?([^/]*)/?([^/]*)$")
                            local vertexIndex = index(vertex, #positions)
                            assert(vertexIndex and positions[vertexIndex], "Invalid vertex in preview OBJ")
                            corners[#corners + 1] = {vertexIndex, index(uv, #uvs), index(normal, #normals)}
                        end
                        for triangle = 2, #corners - 1 do
                            currentGroup.Faces[#currentGroup.Faces + 1] = {corners[1], corners[triangle], corners[triangle + 1]}
                        end
                    elseif command == "mtllib" then
                        local material
                        for materialLine in readfile(directory .. "/" .. value:gsub("%s+$", "")):gmatch("[^\r\n]+") do
                            local materialCommand, materialValue = materialLine:match("^%s*(%S+)%s+(.+)$")
                            if materialCommand == "newmtl" then
                                material = {}
                                materials[materialValue:gsub("%s+$", "")] = material
                            elseif materialCommand == "map_Kd" and material then
                                material.Texture = materialValue:gsub("%s+$", "")
                            end
                        end
                    end
                end
                assert(#positions > 0, "Preview OBJ contains no vertices")
                metadata.Center = (minimum + maximum) * 0.5
                metadata.Size = maximum - minimum
                metadata.Bounds = {Minimum = minimum, Maximum = maximum}
                metadata.FrontDirection = Vector3.new(0, 0, -1)
                local assetService = Services.AssetService
                for _, group in groups do
                    if #group.Faces == 0 then continue end
                    local groupMinimum = Vector3.new(math.huge, math.huge, math.huge)
                    local groupMaximum = Vector3.new(-math.huge, -math.huge, -math.huge)
                    for _, face in group.Faces do
                        for _, corner in face do
                            local position = positions[corner[1]]
                            groupMinimum = Vector3.new(math.min(groupMinimum.X, position.X), math.min(groupMinimum.Y, position.Y), math.min(groupMinimum.Z, position.Z))
                            groupMaximum = Vector3.new(math.max(groupMaximum.X, position.X), math.max(groupMaximum.Y, position.Y), math.max(groupMaximum.Z, position.Z))
                        end
                    end
                    local groupCenter = (groupMinimum + groupMaximum) * 0.5
                    local mesh = assert(assetService:CreateEditableMesh(), "EditableMesh memory limit reached")
                    metadata.Meshes[#metadata.Meshes + 1] = mesh
                    local vertexIds, uvIds, normalIds = {}, {}, {}
                    for _, face in group.Faces do
                        local vertices, textureCoordinates, surfaceNormals = {}, {}, {}
                        for cornerIndex, corner in face do
                            local vertexIndex, uvIndex, normalIndex = corner[1], corner[2] or 0, corner[3] or 0
                            if not vertexIds[vertexIndex] then vertexIds[vertexIndex] = mesh:AddVertex(positions[vertexIndex] - groupCenter) end
                            if not uvIds[uvIndex] then uvIds[uvIndex] = mesh:AddUV(uvs[uvIndex] or Vector2.zero) end
                            if not normalIds[normalIndex] then normalIds[normalIndex] = mesh:AddNormal(normals[normalIndex]) end
                            vertices[cornerIndex], textureCoordinates[cornerIndex], surfaceNormals[cornerIndex] = vertexIds[vertexIndex], uvIds[uvIndex], normalIds[normalIndex]
                        end
                        local faceId = mesh:AddTriangle(vertices[1], vertices[2], vertices[3])
                        mesh:SetFaceUVs(faceId, textureCoordinates)
                        mesh:SetFaceNormals(faceId, surfaceNormals)
                    end
                    local part = assetService:CreateMeshPartAsync(Content.fromObject(mesh), {CollisionFidelity = Enum.CollisionFidelity.Box})
                    part.Name = group.Name
                    part.Anchored = true
                    part.CanCollide, part.CanTouch, part.CanQuery, part.CastShadow = false, false, false, false
                    part.Material = Enum.Material.SmoothPlastic
                    part.Color = Color3.new(1, 1, 1)
                    part.DoubleSided = true
                    part.CFrame = CFrame.new(groupCenter - metadata.Center)
                    local material = materials[group.Material]
                    if material and material.Texture then part.TextureID = getcustomasset(directory .. "/" .. material.Texture) end
                    part.Parent = model
                    metadata.Parts += 1
                    metadata.Faces += #group.Faces
                end
                assert(metadata.Parts > 0, "Preview OBJ contains no faces")
                model.WorldPivot = CFrame.new()
                pcall(function() Services.ContentProvider:PreloadAsync(model:GetChildren()) end)
                destroyConnection = model.Destroying:Connect(releaseMeshes)
            end)
            if not success then
                metadata.Destroy()
                return nil, tostring(failure)
            end
            return model, metadata
        end

        Library.BuildLocalReferencePreviewModel = function(self)
            local player = Services.Players.LocalPlayer
            local character = player and player.Character
            if not character or not character:IsA("Model") then return nil, "Local character is not available yet." end
            local archivable = character.Archivable
            character.Archivable = true
            local cloned, model = pcall(function() return character:Clone() end)
            character.Archivable = archivable
            if not cloned or not model then return nil, "Could not clone the local character." end
            local metadata = {Meshes = {}, Parts = 0, VisibleParts = 0, Source = "Local"}
            metadata.Destroy = function() pcall(function() model:Destroy() end) end
            local success, failure = pcall(function()
                model.Name = "LocalCharacterPreview"

                for _, descendant in model:GetDescendants() do
                    if descendant:IsA("LuaSourceContainer") then descendant:Destroy() end
                end
                local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                local sourcePivot = root and root:IsA("BasePart") and root.CFrame or model:GetPivot()
                metadata.OriginalPivot = sourcePivot
                local normalize = sourcePivot:Inverse()
                local parts, visibleParts = {}, {}
                for _, descendant in model:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Anchored = true
                        descendant.CanCollide, descendant.CanTouch, descendant.CanQuery, descendant.CastShadow = false, false, false, false

                        descendant.LocalTransparencyModifier = 0
                        descendant.CFrame = normalize * descendant.CFrame
                        parts[#parts + 1] = descendant
                        if descendant.Transparency < 1 then visibleParts[#visibleParts + 1] = descendant end
                    end
                end
                assert(#visibleParts > 0, "Local character has no visible body parts.")
                local minimum = Vector3.new(math.huge, math.huge, math.huge)
                local maximum = Vector3.new(-math.huge, -math.huge, -math.huge)

                for _, part in visibleParts do
                    local half = part.Size * 0.5
                    for x = -1, 1, 2 do for y = -1, 1, 2 do for z = -1, 1, 2 do
                        local corner = part.CFrame:PointToWorldSpace(Vector3.new(half.X * x, half.Y * y, half.Z * z))
                        minimum = Vector3.new(math.min(minimum.X, corner.X), math.min(minimum.Y, corner.Y), math.min(minimum.Z, corner.Z))
                        maximum = Vector3.new(math.max(maximum.X, corner.X), math.max(maximum.Y, corner.Y), math.max(maximum.Z, corner.Z))
                    end end end
                end
                metadata.Center = (minimum + maximum) * 0.5
                metadata.Size = maximum - minimum
                metadata.Bounds = {Minimum = minimum, Maximum = maximum}
                metadata.FrontDirection = Vector3.new(0, 0, -1)
                metadata.Parts, metadata.VisibleParts = #parts, #visibleParts
                for _, part in parts do part.CFrame = part.CFrame - metadata.Center end
                model.PrimaryPart = nil
                model.WorldPivot = CFrame.new()
                local humanoid = model:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
                pcall(function() Services.ContentProvider:PreloadAsync(visibleParts) end)
            end)
            if not success then metadata.Destroy(); return nil, tostring(failure) end
            return model, metadata
        end

        Library.CreateReferencePlayerlist = function(self, data)
            data = data or {}
            local palette = self.MainStylePalette
            local cfg = panel("Playerlist", data.Size or Vector2.new(400, 400), data.Position or UDim2.fromOffset(20, 100))
            cfg.Rows, cfg.Priorities = {}, {}
            local root = cfg.Items.Root.Instance
            local section = box(root, "PlayersBorder", UDim2.fromOffset(17, 32), UDim2.new(1, -34, 1, -48), palette.Border, 3)
            local inside = box(section.Instance, "PlayersBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Section)
            local accent = box(section.Instance, "Accent", UDim2.fromOffset(1, 0), UDim2.new(1, -2, 0, 2), Themes.Preset.Accent, 3)
            self:Create("UIGradient", {Parent = accent.Instance, Rotation = 90,
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(160, 160, 160))})
            local sectionName = text(section.Instance, "Players", UDim2.fromOffset(5, -7), UDim2.fromOffset(44, 14), false)
            sectionName.Instance.BackgroundTransparency = 1
            sectionName.Instance.AutomaticSize = Enum.AutomaticSize.X
            sectionName.Instance.TextTruncate = Enum.TextTruncate.None
            sectionName.Instance.ZIndex = 5
            local titleTop = box(section.Instance, "PlayersTitleTop", UDim2.fromOffset(3, -7), UDim2.fromOffset(44, 7), palette.Window, 4)
            local titleBottom = box(section.Instance, "PlayersTitleBottom", UDim2.fromOffset(3, 0), UDim2.fromOffset(44, 7), palette.Section, 4)
            local function fitPlayerTitle()
                if not sectionName.Instance.Parent then return end
                local height = math.max(14, self.MainTextSize + 4, math.ceil(sectionName.Instance.TextBounds.Y) + 2)
                local top = math.ceil(height / 2)
                local width = math.ceil(sectionName.Instance.TextBounds.X) + 4
                sectionName.Instance.Position = UDim2.fromOffset(5, -top)
                sectionName.Instance.Size = UDim2.fromOffset(0, height)
                titleTop.Instance.Position = UDim2.fromOffset(3, -top)
                titleTop.Instance.Size = UDim2.fromOffset(width, top)
                titleBottom.Instance.Size = UDim2.fromOffset(width, height - top)
            end
            self:Connect(sectionName.Instance:GetPropertyChangedSignal("TextBounds"), fitPlayerTitle)
            self:RegisterMainTextLayout(fitPlayerTitle)
            cfg.Items.SectionTitle, cfg.Items.SectionTitleTop, cfg.Items.SectionTitleBottom = sectionName, titleTop, titleBottom
            local searchBorder = box(root, "PlayerSearchBorder", UDim2.fromOffset(22, 41), UDim2.new(1, -44, 0, 16), palette.Border, 4)
            local searchFill = box(searchBorder.Instance, "SearchBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Section)
            local search = self:Create("TextBox", {Parent = searchFill.Instance, Text = "", PlaceholderText = "Search...",
                Position = UDim2.fromOffset(3, 0), Size = UDim2.new(1, -6, 1, 0), BackgroundTransparency = 1,
                BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Fonts.Main, TextSize = self.MainTextSize,
                TextColor3 = Themes.Preset.TextMain, PlaceholderColor3 = palette.Inactive,
                TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center})
            local header = box(root, "ColumnHeader", UDim2.fromOffset(22, 61), UDim2.new(1, -44, 0, 17), palette.Border, 4)
            box(header.Instance, "HeaderBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Section)
            for index, name in {"Name", "Team", "Priority"} do
                text(header.Instance, name, UDim2.new((index - 1) / 3, 0, 0, 0), UDim2.new(1 / 3, 0, 1, 0), false, true)
            end
            local list = self:Create("ScrollingFrame", {Parent = root, Name = "PlayerRows", Position = UDim2.fromOffset(23, 78),
                Size = UDim2.new(1, -46, 1, -170), CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = palette.Section, BorderSizePixel = 0, ScrollBarThickness = 2,
                ScrollBarImageColor3 = Themes.Preset.Accent, ScrollingDirection = Enum.ScrollingDirection.Y,
                ClipsDescendants = true, ZIndex = 4})
            self:Create("UIStroke", {Parent = list.Instance, Color = palette.Border, Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter})
            self:Create("UIListLayout", {Parent = list.Instance, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0)})
            local footer = box(root, "SelectedPlayerBorder", UDim2.new(0, 22, 1, -87), UDim2.new(1, -44, 0, 65), palette.Border, 4)
            box(footer.Instance, "SelectedPlayerBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Section)
            local image = self:Create("ImageLabel", {Parent = footer.Instance, Position = UDim2.fromOffset(8, 11),
                Size = UDim2.fromOffset(48, 48), BackgroundColor3 = palette.Outer, BorderSizePixel = 0, Image = "", ZIndex = 3})
            local details = {}
            for i, caption in {"Name: None", "Priority: Neutral", "Team: None"} do
                details[i] = text(footer.Instance, caption, UDim2.fromOffset(63, 8 + (i - 1) * 12),
                    UDim2.new(1, -169, 0, 12), false)
            end
            local actionHost = box(footer.Instance, "PlayerActions", UDim2.new(1, -104, 0, 9), UDim2.fromOffset(96, 48), palette.Section, 3)
            actionHost.Instance.BackgroundTransparency = 1
            self:Create("UIListLayout", {Parent = actionHost.Instance, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0)})
            local context = setmetatable({Items = {Elements = actionHost}, Elements = {}, Names = {}, DataElements = {}}, self)
            local syncingPriority = false
            cfg.Priority = context:AddDropdown({Text = "Priority", Flag = "Reference_PlayerPriority_" .. self:NextFlag(),
                Options = {"Client", "Neutral", "Enemy"}, Default = "Neutral", RowHeight = 30, BarOffset = 13,
                BarHeight = 15, PopupGap = 2, OptionHeight = 16, Callback = function(value)
                    if syncingPriority or not cfg.Selected then return end
                    cfg:SetPriority(cfg.Selected, value)
                end})
            cfg.ExampleButton = context:AddButton({Text = "Example Button!", RowHeight = 18,
                Callback = function() if data.OnPlayerAction and cfg.Selected then data.OnPlayerAction(cfg.Selected, cfg:GetPriority(cfg.Selected)) end end})
            cfg.Items.Section, cfg.Items.Search, cfg.Items.List = section, search, list
            cfg.Items.Footer, cfg.Items.Avatar, cfg.Items.Details = footer, image, details
            cfg.Items.Header, cfg.Items.SearchBorder = header, searchBorder
            local selectionRevision = 0
            function cfg:GetPriority(player)
                return player == Services.Players.LocalPlayer and "Client" or self.Priorities[player.UserId] or "Neutral"
            end
            function cfg:UpdateRow(player)
                local row = self.Rows[player.UserId]
                if not row then return end
                row.Team.Instance.Text = player.Team and player.Team.Name or "None"
                row.Priority.Instance.Text = self:GetPriority(player)
                row.Priority.Instance.TextColor3 = self:GetPriority(player) == "Client" and Themes.Preset.Accent
                    or self:GetPriority(player) == "Enemy" and Color3.fromRGB(235, 80, 80) or Themes.Preset.TextMain
                row.Name.Instance.FontFace = self.Selected == player and Fonts.MainBold or Fonts.Main
                row.Name.Instance.TextColor3 = self.Selected == player and Themes.Preset.Accent or Themes.Preset.TextMain
                row.Button.Instance.BackgroundTransparency = self.Selected == player and 0 or 1
            end
            function cfg:SetPriority(player, value)
                if not table.find({"Client", "Neutral", "Enemy"}, value) then return end
                self.Priorities[player.UserId] = player == Services.Players.LocalPlayer and "Client" or value
                self:UpdateRow(player)
                if self.Selected == player then self:UpdateDetails() end
                if data.OnPriorityChanged then data.OnPriorityChanged(player, self:GetPriority(player)) end
            end
            function cfg:UpdateDetails()
                local player = self.Selected
                if not player then
                    details[1].Instance.Text, details[2].Instance.Text, details[3].Instance.Text = "Name: None", "Priority: Neutral", "Team: None"
                    image.Instance.Image = ""
                    return
                end
                details[1].Instance.Text = "Name: " .. player.Name .. " (" .. player.DisplayName .. ")"
                details[2].Instance.Text = "Priority: " .. self:GetPriority(player)
                details[3].Instance.Text = "Team: " .. (player.Team and player.Team.Name or "None")
                syncingPriority = true
                self.Priority.Set(self:GetPriority(player))
                syncingPriority = false
            end
            function cfg:Select(player)
                if not player or not self.Rows[player.UserId] then return false end
                self.Selected = player
                for _, row in self.Rows do self:UpdateRow(row.Player) end
                self:UpdateDetails()
                selectionRevision += 1
                local revision = selectionRevision
                task.spawn(function()
                    local ok, thumbnail = pcall(function()
                        return Services.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                    end)
                    if revision == selectionRevision and image.Instance.Parent then
                        image.Instance.Image = ok and thumbnail or "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=48&h=48"
                    end
                end)
                if data.OnSelect then data.OnSelect(player) end
                return true
            end
            function cfg:Filter(query)
                query = tostring(query or ""):lower()
                for _, row in self.Rows do
                    local value = (row.Player.Name .. " " .. row.Player.DisplayName .. " " .. row.Team.Instance.Text .. " " .. row.Priority.Instance.Text):lower()
                    row.Button.Instance.Visible = value:find(query, 1, true) ~= nil
                end
                list.Instance.CanvasPosition = Vector2.zero
            end
            function cfg:AddPlayer(player)
                if self.Rows[player.UserId] then return self.Rows[player.UserId] end
                local button = Library:Create("TextButton", {Parent = list.Instance, Text = "", Size = UDim2.new(1, 0, 0, 16 + math.max(0, Library.MainTextSize - 10)),
                    BackgroundColor3 = palette.Control, BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false,
                    LayoutOrder = player == Services.Players.LocalPlayer and -1 or player.UserId})
                local row = {Player = player, Button = button}
                row.Name = text(button.Instance, player.Name, UDim2.fromScale(0, 0), UDim2.new(1 / 3, -4, 1, 0), false, true)
                row.Team = text(button.Instance, "None", UDim2.new(1 / 3, 0, 0, 0), UDim2.new(1 / 3, 0, 1, 0), false, true)
                row.Priority = text(button.Instance, "Neutral", UDim2.new(2 / 3, 0, 0, 0), UDim2.new(1 / 3, 0, 1, 0), false, true)
                for column = 1, 2 do
                    box(button.Instance, "ColumnSeparator", UDim2.new(column / 3, -1, 0, 4), UDim2.new(0, 1, 1, -8), palette.Inactive, 2)
                end
                self.Rows[player.UserId] = row
                Library:Connect(button.Instance.Activated, function() cfg:Select(player) end)
                Library:Connect(player:GetPropertyChangedSignal("Team"), function() cfg:UpdateRow(player); if cfg.Selected == player then cfg:UpdateDetails() end end)
                Library:Connect(player:GetPropertyChangedSignal("DisplayName"), function() if cfg.Selected == player then cfg:UpdateDetails() end; cfg:Filter(search.Instance.Text) end)
                self:UpdateRow(player)
                self:Filter(search.Instance.Text)
                return row
            end
            function cfg:RemovePlayer(player)
                local row = self.Rows[player.UserId]
                if not row then return end
                row.Button.Instance:Destroy()
                self.Rows[player.UserId], self.Priorities[player.UserId] = nil, nil
                if self.Selected == player then
                    selectionRevision += 1
                    self.Selected = nil
                    local _, nextRow = next(self.Rows)
                    if nextRow then self:Select(nextRow.Player) else self:UpdateDetails() end
                end
            end
            self:Connect(search.Instance:GetPropertyChangedSignal("Text"), function() cfg:Filter(search.Instance.Text) end)
            self:Connect(Services.Players.PlayerAdded, function(player) cfg:AddPlayer(player) end)
            self:Connect(Services.Players.PlayerRemoving, function(player) cfg:RemovePlayer(player) end)
            for _, player in Services.Players:GetPlayers() do cfg:AddPlayer(player) end
            if cfg.Rows[Services.Players.LocalPlayer.UserId] then cfg:Select(Services.Players.LocalPlayer) end
            self:RegisterMainTextLayout(function(size)
                if not root.Parent then return end
                local extra = math.max(0, size - 10)
                local footerHeight = 65 + extra * 3
                searchBorder.Instance.Position = UDim2.fromOffset(22, 41)
                searchBorder.Instance.Size = UDim2.new(1, -44, 0, 16 + extra)
                header.Instance.Position = UDim2.fromOffset(22, 61 + extra)
                header.Instance.Size = UDim2.new(1, -44, 0, 17 + extra)
                list.Instance.Position = UDim2.fromOffset(23, 78 + extra * 2)
                list.Instance.Size = UDim2.new(1, -46, 1, -(170 + extra * 5))
                footer.Instance.Position = UDim2.new(0, 22, 1, -(87 + extra * 3))
                footer.Instance.Size = UDim2.new(1, -44, 0, footerHeight)
                for i, label in details do
                    label.Instance.Position = UDim2.fromOffset(63, 8 + (i - 1) * (12 + extra))
                    label.Instance.Size = UDim2.new(1, -169, 0, 12 + extra)
                end
                for _, row in cfg.Rows do row.Button.Instance.Size = UDim2.new(1, 0, 0, 16 + extra) end
            end)
            return cfg
        end

        Library.CreateReferenceSkinChanger = function(self, data)
            data = data or {}
            local palette = self.MainStylePalette
            local cfg = panel("Skin Changer", data.Size or Vector2.new(440, 340), data.Position or UDim2.fromOffset(20, 508))
            cfg.Skins = {}

            local gridOutline = box(cfg.Items.BodyBackground.Instance, "SkinsGridOutline",
                UDim2.fromOffset(2, 2), UDim2.new(1, -4, 1, -4), palette.Window)
            local gridBackground = box(gridOutline.Instance, "SkinsGridBackground",
                UDim2.fromOffset(0, 0), UDim2.fromScale(1, 1), palette.Window)
            self:Create("UIStroke", {Parent = gridBackground.Instance,
                Color = palette.Border, Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter})
            local grid = self:Create("ScrollingFrame", {Parent = gridBackground.Instance,
                Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = Themes.Preset.Accent,
                CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y})
            self:Create("UIGridLayout", {Parent = grid.Instance, CellSize = UDim2.fromOffset(80, 80),
                CellPadding = UDim2.fromOffset(6, 6), SortOrder = Enum.SortOrder.LayoutOrder})

            local addCell = self:Create("Frame", {Parent = grid.Instance, Name = "AddSkinCell",
                BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = -1,
                Size = UDim2.fromOffset(80, 80)})
            local add = self:Create("TextButton", {Parent = addCell.Instance, Text = "", BackgroundColor3 = palette.Border,
                Position = UDim2.fromOffset(2, 2), BorderSizePixel = 0, AutoButtonColor = false,
                Size = UDim2.fromOffset(80, 80)})
            box(add.Instance, "CardBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Section)
            local circle = box(add.Instance, "AddCircle", UDim2.fromOffset(31, 24), UDim2.fromOffset(18, 18), Color3.new(1, 1, 1), 3)
            self:Create("UICorner", {Parent = circle.Instance, CornerRadius = UDim.new(0.5, 0)})
            box(circle.Instance, "PlusHorizontal", UDim2.fromOffset(4, 8), UDim2.fromOffset(10, 2), palette.Section, 2)
            box(circle.Instance, "PlusVertical", UDim2.fromOffset(8, 4), UDim2.fromOffset(2, 10), palette.Section, 2)
            text(add.Instance, "Add", UDim2.fromOffset(0, 51), UDim2.new(1, 0, 0, 14), false, true)
            cfg.Items.Grid, cfg.Items.Add = grid, add
            self:Connect(add.Instance.Activated, function() if data.OnAdd then data.OnAdd(cfg) end end)
            function cfg:AddSkin(skin)
                skin = skin or {}
                local card = Library:Create("TextButton", {Parent = grid.Instance, Text = "", BackgroundColor3 = palette.Border,
                    BorderSizePixel = 0, AutoButtonColor = false, LayoutOrder = #self.Skins + 1, Size = UDim2.fromOffset(80, 80)})
                box(card.Instance, "CardBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Section)
                Library:Create("ImageLabel", {Parent = card.Instance, Position = UDim2.fromOffset(8, 6), Size = UDim2.fromOffset(64, 46),
                    BackgroundTransparency = 1, BorderSizePixel = 0, Image = skin.Image or "", ScaleType = Enum.ScaleType.Fit, ZIndex = 3})
                text(card.Instance, skin.Name or "Skin", UDim2.fromOffset(3, 54), UDim2.new(1, -6, 0, 16), false, true)
                local entry = {Data = skin, Button = card}
                table.insert(self.Skins, entry)
                Library:Connect(card.Instance.Activated, function()
                    self.Selected = entry
                    for _, other in self.Skins do other.Button.Instance.BackgroundColor3 = other == entry and Themes.Preset.Accent or palette.Border end
                    if skin.Callback then skin.Callback(skin) end
                    if data.OnSelect then data.OnSelect(skin) end
                end)
                return entry
            end
            return cfg
        end

        local referencePreviews = {}
        Library.CreateReferencePreview = function(self, data)
            data = data or {}
            local owner = self
            local cfg = panel("Preview", data.Size or Vector2.new(250, 309), data.Position or UDim2.fromOffset(20, 100))
            local root = cfg.Items.Root.Instance
            root.BackgroundColor3 = Themes.Preset.Accent
            cfg.Items.Root:Themify("Accent", "BackgroundColor3")
            cfg.ModelDirectory = data.ModelDirectory or "gamehaxx/models"
            cfg.LoadRevision = 0
            cfg.ModelSource = data.ModelSource == "Local" and "Local" or "Destiny"
            cfg.ModelFraction = math.clamp(tonumber(data.ModelFraction) or 0.65, 0.2, 0.9)
            cfg.AutoRotate = data.AutoRotate ~= false
            cfg.RotationSpeed = math.rad(tonumber(data.RotationSpeed) or 25)
            cfg.RotationSensitivity = math.rad(tonumber(data.RotationSensitivity) or 0.7)
            cfg.RotationYaw, cfg.TargetYaw, cfg.DraggingRotation = 0, 0, false
            local viewport = self:Create("ViewportFrame", {Parent = cfg.Items.BodyBackground.Instance,
                Name = "CharacterPreview", Size = UDim2.new(1, 0, 1, -19), BackgroundTransparency = 1,
                BorderSizePixel = 0, Active = true, Ambient = Color3.fromRGB(170, 170, 170), LightColor = Color3.new(1, 1, 1),
                LightDirection = Vector3.new(-1, -1, -1), ZIndex = 2})
            local world = self:Create("WorldModel", {Parent = viewport.Instance, Name = "PreviewWorld"})
            local camera = self:Create("Camera", {Parent = viewport.Instance, Name = "PreviewCamera", FieldOfView = 30})
            viewport.Instance.CurrentCamera = camera.Instance
            local status = text(cfg.Items.BodyBackground.Instance, "Loading...", UDim2.fromOffset(8, 0),
                UDim2.new(1, -16, 1, -19), false, true)
            cfg.Items.Viewport, cfg.Items.World, cfg.Items.Camera, cfg.Items.Status = viewport, world, camera, status
            local rotationConnections = {}
            local rotationTask
            local function connectRotation(signal, callback)
                local connection = owner:Connect(signal, callback).Connection
                rotationConnections[#rotationConnections + 1] = connection
            end
            local function disconnectRotation()
                if rotationTask then rotationTask:Stop() end
                for _, connection in rotationConnections do connection:Disconnect() end
                table.clear(rotationConnections)
            end
            local function closeModelDropdown()
                if cfg.SourceDropdown and cfg.SourceDropdown.Open then cfg.SourceDropdown.SetVisible(false) end
            end
            local function destroyModelDropdown()
                closeModelDropdown()
                if cfg.SourceDropdown then cfg.SourceDropdown.Items.DropdownHolder.Instance:Destroy() end
            end
            local function syncRotation()
                local moving = (cfg.AutoRotate and cfg.RotationSpeed ~= 0 and not cfg.DraggingRotation)
                    or math.abs(cfg.TargetYaw - cfg.RotationYaw) > 0.00001
                if not cfg.Destroyed and cfg.Open and root.Visible and owner.Items.Instance.Enabled
                    and cfg.Model and cfg.Model.Parent and moving then rotationTask:Start()
                else rotationTask:Stop() end
            end
            rotationTask = owner:CreateRenderTask(function(dt) cfg:StepRotation(dt) end, 1 / 60)
            function cfg:SetAutoRotate(enabled)
                self.AutoRotate = enabled == true
                syncRotation()
            end
            function cfg:BeginRotation(x)
                if self.Destroyed or not self.Open or not self.Model then return false end
                self.DraggingRotation = true
                self.TargetYaw = self.RotationYaw
                self.DragStartX, self.DragStartYaw = x, self.RotationYaw
                syncRotation()
                return true
            end
            function cfg:DragRotation(x)
                if not self.DraggingRotation or self.Destroyed then return end
                self.TargetYaw = self.DragStartYaw + (x - self.DragStartX) * self.RotationSensitivity
                syncRotation()
            end
            function cfg:EndRotation()
                self.DraggingRotation = false
                self.DragStartX, self.DragStartYaw = nil, nil
                syncRotation()
            end
            local previousPreviewVisible = cfg.SetVisible
            function cfg:SetVisible(visible)
                if visible ~= true then self:EndRotation(); self.TargetYaw = self.RotationYaw; closeModelDropdown() end
                previousPreviewVisible(self, visible)
                syncRotation()
            end
            function cfg:StepRotation(dt)
                if self.Destroyed or not self.Open or not root.Visible or not owner.Items.Instance.Enabled
                    or not self.Model or not self.Model.Parent then rotationTask:Stop(); return end
                dt = math.clamp(dt, 0, 0.1)
                if self.AutoRotate and not self.DraggingRotation then self.TargetYaw += self.RotationSpeed * dt end
                self.RotationYaw += (self.TargetYaw - self.RotationYaw) * (1 - math.exp(-dt / 0.06))
                if not (self.AutoRotate and self.RotationSpeed ~= 0 and not self.DraggingRotation)
                    and math.abs(self.TargetYaw - self.RotationYaw) <= 0.00001 then
                    self.RotationYaw = self.TargetYaw
                    rotationTask:Stop()
                end
                self.Model:PivotTo(CFrame.Angles(0, self.RotationYaw, 0))
            end
            connectRotation(viewport.Instance.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton3 then cfg:BeginRotation(input.Position.X) end
            end)
            connectRotation(Services.UserInputService.InputChanged, function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then cfg:DragRotation(input.Position.X) end
            end)

            connectRotation(Services.UserInputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton3 then cfg:EndRotation() end
            end)
            connectRotation(Services.UserInputService.WindowFocusReleased, function() cfg:EndRotation() end)
            connectRotation(root:GetPropertyChangedSignal("Visible"), function()
                if not root.Visible then cfg:EndRotation(); cfg.TargetYaw = cfg.RotationYaw; closeModelDropdown() end
                syncRotation()
            end)
            connectRotation(owner.Items.Instance:GetPropertyChangedSignal("Enabled"), syncRotation)
            function cfg:UpdateCamera()
                if not self.ModelInfo or not viewport.Instance.Parent then return end
                local size = self.ModelInfo.Size
                local frameSize = viewport.Instance.AbsoluteSize
                local aspect = frameSize.X / math.max(1, frameSize.Y)
                local halfFov = math.tan(math.rad(camera.Instance.FieldOfView) * 0.5)

                local fraction = self.ModelFraction
                local distance = math.max(size.Y / (2 * halfFov * fraction),
                    size.X / (2 * halfFov * math.max(0.1, aspect) * fraction))
                local target = Vector3.new(0, -size.Y * 0.08, 0)
                local yaw = math.rad(tonumber(data.Yaw) or 12)
                local direction = Vector3.new(math.sin(yaw), 0, -math.cos(yaw))
                camera.Instance.CFrame = CFrame.lookAt(target + direction * distance, target)
                camera.Instance.Focus = CFrame.new(target)
            end
            function cfg:LoadModel(directory, source)
                if self.Destroyed then return end
                local selected = source or self.ModelSource
                if selected ~= "Destiny" and selected ~= "Local" then return end
                self:EndRotation()
                self.TargetYaw = self.RotationYaw
                if selected ~= self.ModelSource and self.ModelInfo then
                    self.ModelInfo.Destroy()
                    self.ModelInfo, self.Model, self.CurrentModelSource = nil, nil, nil
                end
                self.ModelSource = selected
                self.LoadRevision += 1
                local revision = self.LoadRevision
                self.ModelDirectory = directory or self.ModelDirectory
                self.Loading, self.LoadError = true, nil
                status.Instance.Text, status.Instance.Visible = "Loading...", true
                local path = self.ModelDirectory
                task.spawn(function()
                    local ok, model, info
                    if selected == "Local" then
                        ok, model, info = pcall(owner.BuildLocalReferencePreviewModel, owner)
                    else
                        ok, model, info = pcall(owner.BuildReferencePreviewModel, owner, path)
                    end
                    if self.Destroyed or revision ~= self.LoadRevision or not root.Parent then
                        if ok and model and info then info.Destroy() end
                        return
                    end
                    self.Loading = false
                    if not ok or not model then
                        self.LoadError = tostring(ok and info or model)
                        status.Instance.Text = selected == "Local" and "Waiting for character..." or "Could not load preview model."
                        warn("[Preview] " .. self.LoadError)
                        return
                    end
                    if self.ModelInfo then self.ModelInfo.Destroy() end
                    model:PivotTo(CFrame.Angles(0, self.RotationYaw, 0))
                    model.Parent = world.Instance
                    self.Model, self.ModelInfo = model, info
                    self.CurrentModelSource = selected
                    status.Instance.Visible = false
                    self:UpdateCamera()
                    syncRotation()
                end)
            end
            function cfg:Destroy()
                if self.Destroyed then return end
                self.Destroyed, self.Loading = true, false
                self.LoadRevision += 1
                self:EndRotation()
                disconnectRotation()
                destroyModelDropdown()
                if self.ModelInfo then self.ModelInfo.Destroy(); self.ModelInfo, self.Model, self.CurrentModelSource = nil, nil, nil end
                root:Destroy()
                self.Items.Glow.Instance:Destroy()
            end
            self:Connect(viewport.Instance:GetPropertyChangedSignal("AbsoluteSize"), function() cfg:UpdateCamera() end)
            self:Connect(root.Destroying, function()
                cfg.Destroyed, cfg.Loading = true, false
                cfg.LoadRevision += 1
                cfg:EndRotation()
                disconnectRotation()
                destroyModelDropdown()
                if cfg.ModelInfo then cfg.ModelInfo.Destroy(); cfg.ModelInfo, cfg.Model, cfg.CurrentModelSource = nil, nil, nil end
                cfg.Items.Glow.Instance:Destroy()
            end)
            local selectorHost = self:Create("Frame", {Parent = cfg.Items.BodyBackground.Instance,
                Name = "PreviewModelSelector", Position = UDim2.new(0, 2, 1, -17), Size = UDim2.new(1, -4, 0, 15),
                BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 4})
            local selectorContext = setmetatable({Items = {Elements = selectorHost}, Elements = {}, Names = {}, DataElements = {}}, owner)
            cfg.SourceDropdown = selectorContext:AddDropdown({Options = {"Destiny", "Local"}, Multi = false,
                Default = cfg.ModelSource, Flag = "Reference_PreviewModel_" .. self:NextFlag(),
                RowHeight = 15, BarHeight = 15, BarOffset = 0, OptionHeight = 16, PopupGap = 2,
                MaxVisibleOptions = 2, Callback = function(value) if value then cfg:LoadModel(nil, value) end end})
            cfg.Items.SelectorHost = selectorHost
            local function fitModelSelector()
                if not selectorHost.Instance.Parent then return end
                local height = cfg.SourceDropdown.Items.Outline.Instance.Size.Y.Offset
                selectorHost.Instance.Position = UDim2.new(0, 2, 1, -(height + 2))
                selectorHost.Instance.Size = UDim2.new(1, -4, 0, height)
                viewport.Instance.Size = UDim2.new(1, 0, 1, -(height + 4))
                status.Instance.Size = UDim2.new(1, -16, 1, -(height + 4))
                cfg:UpdateCamera()
            end
            connectRotation(cfg.SourceDropdown.Items.Outline.Instance:GetPropertyChangedSignal("Size"), fitModelSelector)
            fitModelSelector()
            connectRotation(Services.Players.LocalPlayer.CharacterAdded, function(character)
                task.defer(function()
                    if not cfg.Destroyed and cfg.ModelSource == "Local" and Services.Players.LocalPlayer.Character == character then
                        cfg:LoadModel(nil, "Local")
                    end
                end)
            end)
            connectRotation(Services.Players.LocalPlayer.CharacterAppearanceLoaded, function(character)
                if not cfg.Destroyed and cfg.ModelSource == "Local" and Services.Players.LocalPlayer.Character == character then
                    cfg:LoadModel(nil, "Local")
                end
            end)
            connectRotation(Services.Players.LocalPlayer.CharacterRemoving, function()
                if cfg.Destroyed or cfg.ModelSource ~= "Local" then return end
                cfg.LoadRevision += 1
                cfg.Loading, cfg.LoadError = true, nil
                cfg:EndRotation()
                if cfg.ModelInfo then cfg.ModelInfo.Destroy(); cfg.ModelInfo, cfg.Model, cfg.CurrentModelSource = nil, nil, nil end
                status.Instance.Text, status.Instance.Visible = "Waiting for character...", true
            end)
            referencePreviews[#referencePreviews + 1] = cfg
            if not cfg.Loading and not cfg.Model then cfg:LoadModel() end
            cfg:SetVisible(data.Visible ~= false)
            return cfg
        end
        local previousPreviewUnload = Library.Unload
        Library.Unload = function(self)
            for _, preview in referencePreviews do preview:Destroy() end
            table.clear(referencePreviews)
            previousPreviewUnload(self)
        end

        Library.CreateReferenceDashboard = function(self, window, data)
            data = data or {}
            if rawget(window, "ReferenceDashboard") then return window.ReferenceDashboard end
            local palette, viewport = self.MainStylePalette, workspace.CurrentCamera.ViewportSize
            local menu = window.Items.Menu.Instance
            local mainPosition = menu.AbsolutePosition - self.Items.Instance.AbsolutePosition
            local rightX = math.clamp(mainPosition.X + menu.AbsoluteSize.X + 8, 0, math.max(0, viewport.X - 440))
            local topY = math.clamp(mainPosition.Y, 60, math.max(60, viewport.Y - 748))
            local dashboard = {Window = window, Buttons = {}}
            window.ReferenceDashboard, self.ReferenceDashboard = dashboard, dashboard
            dashboard.Playerlist = self:CreateReferencePlayerlist({Position = UDim2.fromOffset(rightX, topY),
                OnPlayerAction = data.OnPlayerAction, OnPriorityChanged = data.OnPriorityChanged})
            if data.StartHidden then task.wait() end
            dashboard.SkinChanger = self:CreateReferenceSkinChanger({Position = UDim2.fromOffset(rightX, topY + 408),
                OnAdd = data.OnAddSkin, OnSelect = data.OnSkinSelected})
            if data.StartHidden then task.wait() end
            local previewSize = data.PreviewSize or Vector2.new(250, 309)
            local previewX = mainPosition.X - previewSize.X - 8
            if previewX < 0 and mainPosition.X + menu.AbsoluteSize.X + previewSize.X + 8 <= viewport.X then
                previewX = mainPosition.X + menu.AbsoluteSize.X + 8
            end
            dashboard.Preview = self:CreateReferencePreview({Size = previewSize,
                Position = data.PreviewPosition or UDim2.fromOffset(math.round(math.clamp(previewX, 0, math.max(0, viewport.X - previewSize.X))),
                    math.round(math.clamp(mainPosition.Y, 20, math.max(20, viewport.Y - previewSize.Y)))),
                ModelDirectory = data.ModelDirectory or "gamehaxx/models",
                Visible = data.StartHidden ~= true and data.PreviewVisible ~= false})
            dashboard.Playerlist.Dashboard, dashboard.SkinChanger.Dashboard, dashboard.Preview.Dashboard = dashboard, dashboard, dashboard

            local bar = box(self.HUD.Instance, "ReferenceNavigation", UDim2.new(0.5, -59, 0, data.TopOffset or 36),
                UDim2.fromOffset(118, 39), Themes.Preset.Accent, 10):Themify("Accent", "BackgroundColor3")

            bar.Instance.Visible = data.StartHidden ~= true
            local inline = box(bar.Instance, "NavigationInline", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Border)
            local fill = box(inline.Instance, "NavigationBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), Color3.new(1, 1, 1))
            self:Create("UIGradient", {Parent = fill.Instance, Rotation = 90,
                Color = ColorSequence.new(palette.Window, palette.Section)})
            local glow = self:Create("ImageLabel", {Parent = self.HUD.Instance, Name = "NavigationGlow",
                Image = "rbxassetid://18245826428", ImageColor3 = Themes.Preset.Accent,
                ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(21, 21, 79, 79), SliceScale = 0.7,
                BackgroundTransparency = 1, BorderSizePixel = 0, Active = false, ZIndex = 9}):Themify("Accent", "ImageColor3")
            self:RegisterGlow("Main", glow, data.GlowTransparency)
            local function syncNavigationGlow()
                local root = bar.Instance
                glow.Instance.Position = root.Position + UDim2.fromOffset(-14, -14)
                glow.Instance.Size = root.Size + UDim2.fromOffset(28, 28)
                glow.Instance.Visible = root.Visible and root.Parent ~= nil
            end
            for _, property in {"Position", "Size", "Visible"} do
                self:Connect(bar.Instance:GetPropertyChangedSignal(property), syncNavigationGlow)
            end
            dashboard.Items = {Toolbar = bar, Inline = inline, Background = fill, Glow = glow}
            syncNavigationGlow()
            local iconImages = {
                Home = "rbxassetid://98823308062942",
                Players = "rbxassetid://107070078834415",
                Preview = "rbxassetid://77684377836328",
            }
            local callbacks = {
                Home = function() window:SetMenuVisible(not window.Open) end,
                Players = function() dashboard.Playerlist:Toggle() end,
                Skin = function() dashboard.SkinChanger:Toggle() end,
                Preview = function() dashboard.Preview:Toggle() end,
            }
            for index, name in {"Home", "Players", "Skin", "Preview"} do
                local callback = callbacks[name]
                local button = self:Create("TextButton", {Parent = fill.Instance, Name = name,
                    Position = UDim2.fromOffset(4 + (index - 1) * 27, 6), Size = UDim2.fromOffset(25, 25),
                    BackgroundColor3 = palette.Border, BorderSizePixel = 0, ZIndex = 3, Text = "", AutoButtonColor = false})
                local buttonInline = box(button.Instance, "ButtonInline", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), palette.Outer)
                local buttonFill = box(buttonInline.Instance, "ButtonBackground", UDim2.fromOffset(1, 1), UDim2.new(1, -2, 1, -2), Color3.new(1, 1, 1))
                self:Create("UIGradient", {Parent = buttonFill.Instance, Rotation = 90,
                    Color = ColorSequence.new(palette.Control, palette.Window)})
                local icon = box(buttonFill.Instance, "Icon", UDim2.fromOffset(4, 4), UDim2.fromOffset(13, 13), palette.Window, 3)
                icon.Instance.BackgroundTransparency = 1
                local image
                if name == "Skin" then

                    icon.Instance.BackgroundColor3, icon.Instance.BackgroundTransparency = Themes.Preset.Accent, 0
                    self:Create("UICorner", {Parent = icon.Instance, CornerRadius = UDim.new(0.5, 0)})
                    box(icon.Instance, "PlusHorizontal", UDim2.fromOffset(3, 6), UDim2.fromOffset(7, 1), palette.Window, 4)
                    box(icon.Instance, "PlusVertical", UDim2.fromOffset(6, 3), UDim2.fromOffset(1, 7), palette.Window, 4)
                else
                    image = self:Create("ImageLabel", {Parent = icon.Instance, Image = iconImages[name],
                        ImageColor3 = Themes.Preset.Accent, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                        BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, ZIndex = 2}).Instance
                end
                local entry = {Button = button, Image = image, Icon = icon, Callback = callback,
                    Inline = buttonInline, Background = buttonFill}
                dashboard.Buttons[name] = entry
                self:Connect(button.Instance.Activated, callback)
            end
            function dashboard:Sync()
                local active = {Home = self.Window.Open, Players = self.Playerlist.Open, Skin = self.SkinChanger.Open, Preview = self.Preview.Open}
                for name, entry in self.Buttons do
                    if entry.Image then
                        entry.Image.ImageColor3 = Themes.Preset.Accent
                        entry.Image.ImageTransparency = active[name] and 0 or 0.25
                    else
                        entry.Icon.Instance.BackgroundColor3 = Themes.Preset.Accent
                        entry.Icon.Instance.BackgroundTransparency = active[name] and 0 or 0.25
                    end
                end
                Library.Elements.Instance.Enabled = self.Window.Open or self.Playerlist.Open or self.SkinChanger.Open or self.Preview.Open
            end

            function dashboard:SetVisible(visible)
                if visible then
                    local opened = self.SavedVisibility or {Home = true, Players = false, Skin = false, Preview = false}
                    self.SavedVisibility = nil
                    self.Items.Toolbar.Instance.Visible = true
                    self.Window:SetMenuVisible(opened.Home)
                    self.Playerlist:SetVisible(opened.Players)
                    self.SkinChanger:SetVisible(opened.Skin)
                    self.Preview:SetVisible(opened.Preview)
                else
                    if not self.SavedVisibility then
                        self.SavedVisibility = {Home = self.Window.Open, Players = self.Playerlist.Open, Skin = self.SkinChanger.Open, Preview = self.Preview.Open}
                    end
                    self.Window:SetMenuVisible(false)
                    self.Playerlist:SetVisible(false)
                    self.SkinChanger:SetVisible(false)
                    self.Preview:SetVisible(false)
                    self.Items.Toolbar.Instance.Visible = false
                end
                self:Sync()
            end
            function dashboard:ToggleVisibility()
                if self.SavedVisibility then
                    self:SetVisible(true)
                elseif self.Window.Open or self.Playerlist.Open or self.SkinChanger.Open or self.Preview.Open then
                    self:SetVisible(false)
                else
                    self:SetVisible(true)
                end
            end
            self:Connect(bar.Instance:GetPropertyChangedSignal("BackgroundColor3"), function() dashboard:Sync() end)
            self:Connect(menu:GetPropertyChangedSignal("Visible"), function() dashboard:Sync() end)
            dashboard:Sync()
            return dashboard
        end
        local previousMenuVisible = Library.SetMenuVisible
        Library.SetMenuVisible = function(self, visible)
            previousMenuVisible(self, visible)
            if self.ReferenceDashboard then self.ReferenceDashboard:Sync() end
        end
        Library.ToggleDashboardVisibility = function(self)
            local dashboard = rawget(self, "ReferenceDashboard")
            if dashboard then
                dashboard:ToggleVisibility()
            else
                self:SetMenuVisible(not self.Open)
            end
        end
    end

    Library.LoaderTheme = {
        Background = Color3.fromRGB(22, 21, 28),
        Panel = Color3.fromRGB(19, 18, 25),
        Outline = Color3.fromRGB(173, 170, 189),
        Border = Color3.fromRGB(28, 27, 34),
        Inset = Color3.fromRGB(16, 16, 23),
        Blackline = Color3.fromRGB(5, 4, 12),
        Text = Color3.fromRGB(219, 219, 224),
        Muted = Color3.fromRGB(173, 173, 181),
        Selected = Color3.fromRGB(224, 223, 255),
        Rule = Color3.fromRGB(228, 227, 240),
        Ready = Color3.fromRGB(90, 220, 90),
        Error = Color3.fromRGB(255, 131, 131),
    }

    Library.CreateLoader = function(self, Data)
        Data = Data or {}
        local Theme = Data.Theme or self.LoaderTheme
        local Scale = math.clamp(tonumber(Data.Scale) or 0.9, 0.5, 1.5)
        local TextSize = math.floor((tonumber(Data.TextSize) or 11) + 0.5)
        local LayoutObjects = {}
        local TextObjects, Contours = {}, {}
        local Root
        local function pixel(value) return math.floor(value * Scale + 0.5) end
        local RequestedWidth = tonumber(Data.Width) and math.max(320, math.floor(tonumber(Data.Width) + 0.5)) or nil
        local WidthExtra = RequestedWidth and RequestedWidth - pixel(402) or 0

        local HeightExtra = math.max(0, math.floor((tonumber(Data.Height) or 232) + 0.5) - 232)
        local function applyLayout(instance, layout)
            local position = layout.Position or UDim2.fromOffset(0, 0)
            if layout.Position then
                instance.Position = UDim2.new(position.X.Scale, pixel(position.X.Offset) + (layout.DockRight and WidthExtra or 0), position.Y.Scale, pixel(position.Y.Offset))
            end
            if layout.Size then
                local size = layout.Size

                instance.Size = UDim2.new(size.X.Scale, pixel(position.X.Offset + size.X.Offset) - pixel(position.X.Offset) + (layout.StretchX and WidthExtra or 0),
                    size.Y.Scale, pixel(position.Y.Offset + size.Y.Offset) - pixel(position.Y.Offset))
            end
            if layout.CanvasSize then
                local size = layout.CanvasSize
                instance.CanvasSize = UDim2.new(size.X.Scale, pixel(size.X.Offset), size.Y.Scale, pixel(size.Y.Offset))
            end
        end

        if not Fonts.Loader then
            local file = self:ResolveAsset({"loader-pixel-tahoma.ttf", "loader-pixel-tahoma.otf"})
            if file then
                local manifest = self.Directory .. "/Fonts/LoaderPixelTahoma.font"
                writefile(manifest, Services.HttpService:JSONEncode({name = "Loader Pixel Tahoma", faces = {
                    {name = "Regular", weight = 400, style = "normal", assetId = getcustomasset(file)},
                }}))
                Fonts.Loader = Font.new(getcustomasset(manifest), Enum.FontWeight.Regular)
            else
                Fonts.Loader = Fonts.Main
            end
            Fonts.LoaderBold = Fonts.Loader
        end
        local LoaderFont = Data.FontFace or Fonts.Loader
        local NamePrefix = Data.NameLabel or "Name: "
        local DetailPrefix = Data.DetailLabel or "Last Updated: "
        local Cfg = {Library = self, Items = {}, Entries = {}, Selected = nil,
            Busy = false, Closed = false, Templates = Data.Items or {}, Scale = Scale}
        local function create(class, properties)
            local stretchX, dockRight = properties.LoaderStretchX, properties.LoaderDockRight
            properties.LoaderStretchX, properties.LoaderDockRight = nil, nil
            if class == "TextLabel" or class == "TextBox" or class == "TextButton" then
                properties.FontFace = LoaderFont
                properties.TextSize = TextSize
                properties.TextScaled = false
                properties.TextWrapped = false
                properties.TextStrokeTransparency = 1
                properties.ClipsDescendants = false
                properties.TextTruncate = Enum.TextTruncate.None
                properties.TextYAlignment = properties.TextYAlignment or Enum.TextYAlignment.Top
            elseif class == "UIStroke" then
                properties.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            end
            local object = self:Create(class, properties)
            local layout = {Position = properties.Position, Size = properties.Size, CanvasSize = properties.CanvasSize,
                StretchX = stretchX, DockRight = dockRight}
            if layout.Position or layout.Size or layout.CanvasSize then
                table.insert(LayoutObjects, {Instance = object.Instance, Layout = layout})
                applyLayout(object.Instance, layout)
            end
            if class == "TextLabel" or class == "TextBox" then
                local instance = object.Instance

                if instance.Size.Y.Scale == 0 then
                    local height = math.max(14, instance.Size.Y.Offset)
                    instance.Size = UDim2.new(instance.Size.X.Scale, instance.Size.X.Offset, 0, height)
                end
                table.insert(TextObjects, instance)
            end
            return object
        end
        local function frame(parent, x, y, width, height, color, z, stretchX)
            return create("Frame", {Parent = parent, Position = UDim2.fromOffset(x, y),
                Size = UDim2.fromOffset(width, height), BackgroundColor3 = color,
                BorderSizePixel = 0, ZIndex = z or 2, LoaderStretchX = stretchX})
        end
        local function outline(parent, color, front)

            if front then
                local source = parent
                local overlay = self:Create("Frame", {Parent = Root.Instance,
                    Position = source.Position, Size = source.Size, BackgroundTransparency = 1,
                    BorderSizePixel = 0, ZIndex = 6, Active = false})
                overlay.Instance.Name = "SectionOutline"
                table.insert(Contours, {Source = source, Overlay = overlay.Instance})
                parent = overlay.Instance
            end
            local edges = {
                {"Top", UDim2.fromOffset(0, 0), UDim2.new(1, 0, 0, 1)},
                {"Bottom", UDim2.new(0, 0, 1, -1), UDim2.new(1, 0, 0, 1)},
                {"Left", UDim2.fromOffset(0, 0), UDim2.new(0, 1, 1, 0)},
                {"Right", UDim2.new(1, -1, 0, 0), UDim2.new(0, 1, 1, 0)},
            }
            for _, edge in ipairs(edges) do
                local strip = self:Create("Frame", {Parent = parent, Position = edge[2], Size = edge[3],
                    BackgroundColor3 = color, BorderSizePixel = 0, ZIndex = parent.ZIndex + 1})
                strip.Instance.Name = "PixelBorder" .. edge[1]
            end
        end
        local function text(parent, value, x, y, width, height, color, z, stretchX)
            return create("TextLabel", {Parent = parent, Text = value,
                Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(width, height),
                BackgroundTransparency = 1, BorderSizePixel = 0,
                TextColor3 = color or Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center, ZIndex = z or 5, LoaderStretchX = stretchX})
        end
        Root = frame(self.Items.Instance, 0, 0, 402, 232 + HeightExtra, Theme.Background, 1, true)
        Root.Instance.Name = "PeronaLoader"

        Root.Instance.Visible = Data.StartHidden ~= true
        Root.Instance.AnchorPoint = Vector2.zero
        local function centerRoot()
            local viewport = Services.Workspace.CurrentCamera.ViewportSize
            local size = Root.Instance.Size
            Root.Instance.Position = UDim2.fromOffset(math.floor((viewport.X - size.X.Offset) / 2),
                math.floor((viewport.Y - size.Y.Offset) / 2))
        end
        centerRoot()

        local UIScale = create("UIScale", {Parent = Root.Instance, Scale = 1})
        local Glow = self:Create("ImageLabel", {
            Parent = self.Items.Instance, Name = "LoaderGlow", Active = false,
            ImageColor3 = Data.GlowColor or self.Themes.Preset.Accent,
            ScaleType = Enum.ScaleType.Slice, ImageTransparency = Data.GlowTransparency or 0.9,
            Image = "rbxassetid://18245826428", BackgroundTransparency = 1,
            ZIndex = 0, BorderSizePixel = 0, SliceCenter = Rect.new(21, 21, 79, 79),
        })
        if not Data.GlowColor then Glow:Themify("Accent", "ImageColor3") end
        local function updateGlow()
            local position, size = Root.Instance.Position, Root.Instance.Size
            Glow.Instance.Position = position + UDim2.fromOffset(-20, -20)
            Glow.Instance.Size = size + UDim2.fromOffset(40, 40)
            Glow.Instance.Visible = Root.Instance.Visible
        end
        self:Connect(Root.Instance:GetPropertyChangedSignal("Position"), updateGlow)
        self:Connect(Root.Instance:GetPropertyChangedSignal("Size"), updateGlow)
        self:Connect(Root.Instance:GetPropertyChangedSignal("Visible"), updateGlow)
        updateGlow()
        outline(Root.Instance, Theme.Outline)
        local Blackline = frame(Root.Instance, 1, 1, 400, 230 + HeightExtra, Theme.Blackline or Color3.fromRGB(5, 4, 12), 2, true)
        local Inner = frame(Root.Instance, 2, 2, 398, 228 + HeightExtra, Theme.Background, 2, true)

        local Drag = create("TextButton", {Parent = Root.Instance,
            Position = UDim2.fromOffset(3, 2), Size = UDim2.fromOffset(396, 18),
            BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 8, LoaderStretchX = true})
        text(Drag.Instance, Data.Title or "Loader", 3, 0, 390, 16, Theme.Text, 9, true)
        local dragging, startPointer, startPosition
        self:Connect(Drag.Instance.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging, startPointer, startPosition = true, input.Position, Root.Instance.Position
            end
        end)
        self:Connect(Services.UserInputService.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
        self:Connect(Services.UserInputService.InputChanged, function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - startPointer
                Root.Instance.Position = startPosition + UDim2.fromOffset(math.floor(delta.X + 0.5), math.floor(delta.Y + 0.5))
            end
        end)

        local Inset = frame(Root.Instance, 7, 19, 388, 203 + HeightExtra, Theme.Inset, 3, true)
        outline(Inset.Instance, Theme.Border, true)
        local Body = frame(Root.Instance, 12, 24, 378, 193 + HeightExtra, Theme.Background, 4, true)
        outline(Body.Instance, Theme.Border, true)
        local Content = frame(Root.Instance, 18, 30, 366, 181 + HeightExtra, Theme.Panel, 4, true)
        outline(Content.Instance, Theme.Border, true)
        local HeadingRule = frame(Root.Instance, 19, 31, 364, 2, self.Themes.Preset.Accent, 5, true):Themify("Accent", "BackgroundColor3")
        create("UIGradient", {Parent = HeadingRule.Instance, Rotation = 0,
            Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(160, 160, 175))})
        local headingText = Data.Heading or "Products"
        local HeadingMask = frame(Root.Instance, 22, 23, 66, 15, Theme.Panel, 7)
        local Heading = text(Root.Instance, headingText, 25, 23, 60, 15, Theme.Text, 8)

        local searchPalette = self.MainStylePalette or {}
        local SearchBorder = frame(Root.Instance, 21, 40, 359, 19,
            searchPalette.Border or Theme.Border, 5, true)
        local SearchFill = create("Frame", {Parent = SearchBorder.Instance,
            Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2),
            BackgroundColor3 = searchPalette.Section or Theme.Panel,
            BorderSizePixel = 0, ZIndex = 6})
        local Search = create("TextBox", {Parent = SearchFill.Instance, Text = "",
            PlaceholderText = Data.PlaceHolder or "Search games...", ClearTextOnFocus = false,
            Position = UDim2.fromOffset(3, 0), Size = UDim2.new(1, -6, 1, 0),
            BackgroundTransparency = 1, BorderSizePixel = 0,
            TextColor3 = Color3.new(1, 1, 1), PlaceholderColor3 = Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 7})
        local List = create("ScrollingFrame", {Parent = Root.Instance,

            Position = UDim2.fromOffset(21, 63), Size = UDim2.fromOffset(359, 78 + HeightExtra),
            BackgroundColor3 = Theme.Panel, BorderSizePixel = 0,
            CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.None,
            ScrollBarThickness = 2, ZIndex = 5, LoaderStretchX = true})
        List.Instance.ScrollBarImageColor3 = Theme.Muted
        outline(List.Instance, Theme.Border)
        local Empty = text(List.Instance, "No templates", 4, 2, 330, 16, Theme.Muted)
        local Footer = frame(Root.Instance, 21, 143 + HeightExtra, 359, 64, Theme.Panel, 5, true)
        outline(Footer.Instance, Theme.Border)
        local LogoBox = frame(Footer.Instance, 9, 7, 47, 47, Theme.Panel, 6)
        outline(LogoBox.Instance, Theme.Border)

        if Data.Icon then
            create("ImageLabel", {Parent = LogoBox.Instance, Image = Data.Icon,
                Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 7})
        else
            local logoFile = self:ResolveAsset("loader-reference.png")
            if logoFile then
                create("ImageLabel", {Parent = LogoBox.Instance,
                    Image = getcustomasset(logoFile),
                    ImageRectOffset = Vector2.new(68, 193), ImageRectSize = Vector2.new(45, 45),
                    Position = UDim2.fromOffset(1, 1), Size = UDim2.fromOffset(45, 45),
                    BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 7})
            end
        end
        local Name = text(Footer.Instance, NamePrefix .. "None", 64, 5, 180, 12, Theme.Text, 7)
        local Version = text(Footer.Instance, DetailPrefix .. "N/A", 64, 17, 180, 12, Theme.Text, 7)
        local StatusCaption = text(Footer.Instance, "Status:", 64, 29, 36, 12, Theme.Text, 7)
        local State = text(Footer.Instance, "Ready", 100, 29, 144, 12, Theme.Ready, 7)
        local function alignText()
            for _, contour in ipairs(Contours) do
                contour.Overlay.Position = contour.Source.Position
                contour.Overlay.Size = contour.Source.Size
            end
            for _, instance in ipairs(TextObjects) do
                if instance.Parent and instance.Size.Y.Scale == 0 then
                    local size = instance.Size
                    instance.Size = UDim2.new(size.X.Scale, size.X.Offset, 0, math.max(14, size.Y.Offset))
                end
            end
            HeadingRule.Instance.Size = UDim2.fromOffset(HeadingRule.Instance.Size.X.Offset, 2)
            local iconSize = pixel(47)
            LogoBox.Instance.Size = UDim2.fromOffset(iconSize, iconSize)
            LogoBox.Instance.Position = UDim2.fromOffset(pixel(9), math.floor((Footer.Instance.Size.Y.Offset - iconSize) / 2))
            local headingWidth = math.ceil(Heading.Instance.TextBounds.X)
            if headingWidth > 0 then
                Heading.Instance.Size = UDim2.fromOffset(headingWidth + 2, math.max(14, pixel(15)))
                HeadingMask.Instance.Position = UDim2.fromOffset(Heading.Instance.Position.X.Offset - 3, Heading.Instance.Position.Y.Offset)
                HeadingMask.Instance.Size = UDim2.fromOffset(headingWidth + 6, math.max(14, pixel(15)))
            end
            local statusWidth = math.ceil(StatusCaption.Instance.TextBounds.X)
            if statusWidth > 0 then
                local x = StatusCaption.Instance.Position.X.Offset
                StatusCaption.Instance.Size = UDim2.fromOffset(statusWidth + 2, 14)
                State.Instance.Position = UDim2.fromOffset(x + statusWidth + 4, StatusCaption.Instance.Position.Y.Offset)
                State.Instance.Size = UDim2.fromOffset(math.max(0, pixel(244) - x - statusWidth - 4), 14)
            end
        end
        self:Connect(Heading.Instance:GetPropertyChangedSignal("TextBounds"), alignText)
        self:Connect(StatusCaption.Instance:GetPropertyChangedSignal("TextBounds"), alignText)
        alignText()
        local function button(value, y)
            local item = create("TextButton", {Parent = Footer.Instance,
                Position = UDim2.fromOffset(254, y), Size = UDim2.fromOffset(97, 15),
                BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, ZIndex = 7, LoaderDockRight = true})
            outline(item.Instance, Theme.Border)
            local label = text(item.Instance, value, 0, 0, 97, 15, Theme.Text, 8)
            label.Instance.TextXAlignment = Enum.TextXAlignment.Center
            self:Connect(item.Instance.MouseEnter, function() item.Instance.BackgroundColor3 = Theme.Border end)
            self:Connect(item.Instance.MouseLeave, function() item.Instance.BackgroundColor3 = Theme.Panel end)
            return item, label
        end
        local Execute, ExecuteText = button(Data.ExecuteText or "Execute", 8)

        local Exit = button(Data.ExitText or "Exit", 29)
        Cfg.Items = {Root = Root, Search = Search, SearchBorder = SearchBorder,
            SearchFill = SearchFill, List = List, Name = Name,
            Version = Version, Status = State, Execute = Execute, Exit = Exit,
            Footer = Footer, Logo = LogoBox, UIScale = UIScale, Heading = Heading, HeadingMask = HeadingMask, HeadingRule = HeadingRule,
            Glow = Glow, Inset = Inset, Body = Body, Content = Content, Blackline = Blackline,
            Inner = Inner, StatusCaption = StatusCaption, Contours = Contours}
        function Cfg:SetScale(value)
            self.Scale = math.clamp(tonumber(value) or 0.9, 0.5, 1.5)
            Scale = self.Scale
            WidthExtra = RequestedWidth and RequestedWidth - pixel(402) or 0
            for _, object in ipairs(LayoutObjects) do
                if object.Instance.Parent then applyLayout(object.Instance, object.Layout) end
            end
            centerRoot()
            self:Filter(Search.Instance.Text)
            alignText()
            updateGlow()
        end
        function Cfg:SetStatus(value, isError)
            State.Instance.Text = tostring(value)
            State.Instance.TextColor3 = isError and Theme.Error or Theme.Ready
        end
        local rowTweenInfo = TweenInfo.new(0.20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local selectTweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        function Cfg:Select(index)
            local item = self.Templates[index]
            if not item then return false end
            self.Selected = index
            self.SelectedGame = item.Name
            Name.Instance.Text = NamePrefix .. tostring(item.Name or "Untitled")
            Version.Instance.Text = DetailPrefix .. tostring(item.LastUpdated or "N/A")
            self:SetStatus(item.Status or "Ready")
            for _, row in ipairs(self.Entries) do
                local selected = row.Index == index
                if row.StyleTween then row.StyleTween:Cancel() end
                if row.LabelTween then row.LabelTween:Cancel() end
                row.Button.Instance.BackgroundColor3 = Themes.Preset.Accent
                row.Label.Instance.FontFace = selected and (Data.SelectedFontFace or Fonts.LoaderBold) or LoaderFont
                row.StyleTween = Services.TweenService:Create(row.Button.Instance, selectTweenInfo,
                    {BackgroundTransparency = selected and 0.84 or 1})
                row.LabelTween = Services.TweenService:Create(row.Label.Instance, selectTweenInfo,
                    {TextColor3 = selected and Themes.Preset.Accent or Color3.new(1, 1, 1)})
                row.StyleTween:Play()
                row.LabelTween:Play()
            end
            return true
        end
        function Cfg:Filter(query, instant)
            query = string.lower(tostring(query or ""))
            local visible = 0
            for _, row in ipairs(self.Entries) do
                local item = self.Templates[row.Index]
                local matches = string.find(string.lower(tostring(item.Name or "Untitled")), query, 1, true) ~= nil
                if row.MoveTween then row.MoveTween:Cancel() end
                if matches then
                    local target = UDim2.fromOffset(0, pixel(2 + visible * 16))

                    row.Button.Instance.Visible = true
                    if instant then
                        row.Button.Instance.Position = target
                    elseif row.Button.Instance.Position ~= target then
                        row.MoveTween = Services.TweenService:Create(row.Button.Instance, rowTweenInfo,
                            {Position = target})
                        row.MoveTween:Play()
                    end
                    visible = visible + 1
                else
                    row.Button.Instance.Visible = false
                end
            end
            Empty.Instance.Visible = visible == 0
            Empty.Instance.Text = #self.Templates == 0 and "No games" or "No results"
            List.Instance.CanvasSize = UDim2.fromOffset(0, pixel(4 + visible * 16))
        end
        function Cfg:SetItems(items)
            for _, row in ipairs(self.Entries) do
                if row.MoveTween then row.MoveTween:Cancel() end
                if row.StyleTween then row.StyleTween:Cancel() end
                if row.LabelTween then row.LabelTween:Cancel() end
                row.Button.Instance:Destroy()
            end
            self.Entries, self.Templates, self.Selected, self.SelectedGame = {}, items or {}, nil, nil
            for index, item in ipairs(self.Templates) do
                local rowIndex = index
                local rowButton = create("TextButton", {Parent = List.Instance,
                    Position = UDim2.fromOffset(0, 2 + (index - 1) * 16),
                    Size = UDim2.new(1, -4, 0, 16),
                    BackgroundColor3 = Themes.Preset.Accent,
                    BackgroundTransparency = 1, Text = "", TextTransparency = 1,
                    BorderSizePixel = 0, ZIndex = 6})
                local label = create("TextLabel", {Parent = rowButton.Instance,
                    Text = tostring(item.Name or "Untitled"),
                    Position = UDim2.fromOffset(5, 0), Size = UDim2.new(1, -10, 1, 0),
                    BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 7,
                    TextColor3 = Color3.new(1, 1, 1),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center})
                table.insert(self.Entries, {Index = rowIndex, Button = rowButton, Label = label})
                Cfg.Library:Connect(rowButton.Instance.Activated, function() Cfg:Select(rowIndex) end)
            end
            Name.Instance.Text, Version.Instance.Text = NamePrefix .. "None", DetailPrefix .. "N/A"
            self:SetStatus(Data.EmptySelectionStatus or "Ready")
            if #self.Templates > 0 and Data.AutoSelect ~= false then self:Select(1) end
            self:Filter(Search.Instance.Text, true)
        end
        function Cfg:SetVisible(visible)
            if not self.Closed then Root.Instance.Visible = visible end
        end
        function Cfg:Close()
            if self.Closed then return end
            self.Closed = true
            self.Library:Unload()
            if Data.OnClose then Data.OnClose() end
        end
        function Cfg:Execute()
            if self.Busy or self.Closed then return false end
            local item = self.Templates[self.Selected]
            if not item or type(item.Callback) ~= "function" then
                self:SetStatus("Choose a game", true)
                return false
            end
            self.Busy = true
            ExecuteText.Instance.Text = "Loading..."
            self:SetStatus("Loading...")
            local ok, result = pcall(item.Callback, self.Library, self, item)
            self.Busy = false
            if self.Closed then return ok, result end
            ExecuteText.Instance.Text = Data.ExecuteText or "Execute"
            if ok then
                self:SetStatus("Loaded")
                if Data.HideOnExecute ~= false then self:SetVisible(false) end
            else
                self:SetStatus("Load failed", true)
                warn("[Loader] " .. tostring(result))
            end
            return ok, result
        end
        self:Connect(Search.Instance:GetPropertyChangedSignal("Text"), function() Cfg:Filter(Search.Instance.Text) end)
        self:Connect(Execute.Instance.Activated, function() Cfg:Execute() end)
        self:Connect(Exit.Instance.Activated, function() Cfg:Close() end)
        Cfg:SetItems(Cfg.Templates)
        return Cfg
    end

    Library:Connect(Services.RunService.Heartbeat, function()
        if not Library or not Library.LerpObjects then 
            return 
        end     

        Library:LerpObjects()
        Library:LerpKeybinds()
    end)
end

Library.StartReferenceDeferredTab = function(self, tab)
    if self.Unloaded or self.Unloading then return false, "UI has been unloaded" end
    if not tab or not tab.ReferenceDeferredBuild then return true end
    if tab.ReferenceDeferredStarted then
        return tab.ReferenceDeferredError == nil, tab.ReferenceDeferredError
    end
    local page = tab.Items and tab.Items.Page and tab.Items.Page.Instance
    if not page or not page.Parent then return false, "Tab page is unavailable" end
    tab.ReferenceDeferredStarted = true
    tab.ReferenceBuilding = true
    page.Visible = false
    local owner = self
    local thread = coroutine.create(function()
        if owner.Unloaded or owner.Unloading then
            tab.ReferenceBuilding = false
            tab.ReferenceDeferredError = "UI has been unloaded"
            return
        end
        local ok, result = pcall(tab.ReferenceDeferredBuild)
        if owner.Unloaded or owner.Unloading then
            ok, result = false, "UI has been unloaded"
        end
        tab.ReferenceDeferredReady = ok
        tab.ReferenceBuilding = false
        if not ok then
            tab.ReferenceDeferredError = tostring(result)
            warn("[UI] Could not build " .. tostring(tab.Text) .. ": " .. tostring(result))
        end
        if ok and page.Parent and tab.Window and tab.Window.TabInfo == tab then
            page.Visible = true
            if tab.ReferenceRelayout then tab.ReferenceRelayout() end
        end
    end)
    tab.ReferenceDeferredThread = thread
    table.insert(owner.Threads, thread)
    task.spawn(thread)
    return tab.ReferenceDeferredError == nil, tab.ReferenceDeferredError
end

-- Explicit config operations need every control registered, including unopened tabs.
-- Ordinary startup and tab switching keep their deferred construction behavior.
Library.EnsureReferenceDeferredTabs = function(self)
    if self.Unloaded or self.Unloading then error("[Config] UI has been unloaded", 2) end
    local window = self.ExampleWindow or self.Window
    for _, tab in window and window.ReferenceTabs or {} do
        if tab.ReferenceDeferredBuild then
            local ok, err = self:StartReferenceDeferredTab(tab)
            if not ok then
                error("[Config] Could not build " .. tostring(tab.Text) .. ": " .. tostring(err), 2)
            end
        end
    end
    for _, tab in window and window.ReferenceTabs or {} do
        if tab.ReferenceDeferredBuild then
            if tab.ReferenceBuilding and coroutine.running() == tab.ReferenceDeferredThread then
                error("[Config] Cannot save or load while constructing " .. tostring(tab.Text), 2)
            end
            while tab.ReferenceBuilding do
                if self.Unloaded or self.Unloading then error("[Config] UI has been unloaded", 2) end
                task.wait()
            end
            if self.Unloaded or self.Unloading then error("[Config] UI has been unloaded", 2) end
            if not tab.ReferenceDeferredReady then
                error("[Config] Could not build " .. tostring(tab.Text) .. ": " .. tostring(tab.ReferenceDeferredError or "construction did not complete"), 2)
            end
        end
    end
end

return Library
