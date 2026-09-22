local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer

local Library = {
    Name = "Blade",
    Title = "Evenesce",
    Theme = "Blade",
    AnimationsEnabled = true,
    AnimationSpeed = 1,
    Windows = {},
    Options = {},
    Toggles = {},
    Connections = {},
    Themes = {},
    ThemeNames = {},
    Unloaded = false,
}

local function rgb(r,g,b)
    return Color3.fromRGB(r,g,b)
end

local function clamp(v,a,b)
    return math.clamp(v,a,b)
end

local function tween(obj, info, props)
    if not Library.AnimationsEnabled or info.Time <= 0 then
        for k,v in pairs(props) do obj[k] = v end
        return
    end
    TweenService:Create(obj, info, props):Play()
end

local MOTION = {
    Hover = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Press = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Release = TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Toggle = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    ToggleSlide = TweenInfo.new(0.20, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    DropdownIn = TweenInfo.new(0.17, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    DropdownOut = TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    FadeIn = TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    FadeOut = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
}

local DEFAULT = {
    Window = rgb(23,24,31),
    Rail = rgb(28,30,36),
    SubPanel = rgb(28,30,36),
    Panel = rgb(28,30,39),
    Field = rgb(39,40,51),
    TabFill = rgb(40,41,52),
    TabFillHover = rgb(46,47,60),
    Accent = rgb(117,105,225),
    Knob = rgb(120,101,255),
    Swatch = rgb(99,107,255),
    Text = rgb(255,255,255),
    Muted = rgb(109,117,141),
    MutedHover = rgb(137,147,177),
    TabHover = rgb(142,153,184),
    GroupTitle = rgb(211,211,211),
    TrackOn = rgb(35,37,47),
    TrackOff = rgb(35,37,48),
    TrackOffHover = rgb(36,39,50),
    KnobOff = rgb(51,51,68),
    KnobOffHover = rgb(64,64,86),
    KnobStroke = rgb(29,29,29),
    SliderStroke = rgb(28,30,39),
    TableHeader = rgb(21,22,29),
    TableStroke = rgb(34,36,47),
    TableText = rgb(128,134,176),
    SliderValue = rgb(195,195,195),
    SliderValueHover = rgb(213,213,213),
    Divider = rgb(41,44,57),
    Dots = rgb(167,167,167),
    DotsHover = rgb(211,211,211),
    Arrow = rgb(189,189,189),
    ArrowHover = rgb(223,223,223),
    Pen = rgb(177,177,177),
    PenHover = rgb(223,223,223),
    ButtonFill = rgb(39,40,51),
    ButtonFillHover = rgb(45,46,59),
    Popup = rgb(31,32,39),
    PopupTitle = rgb(234,234,234),
    HexBg = rgb(41,42,56),
    HexText = rgb(221,221,221),
    Danger = rgb(255,97,100),
    ScrollBar = rgb(23,24,31),
    NotifyBar = rgb(41,43,55),
    NotifyDesc = rgb(130,137,168),
    NotifyClose = rgb(128,134,172),
    NotifyWarn = rgb(254,154,126),
    NotifyError = rgb(255,132,132),
}

local function copy(t)
    local n = {}
    for k,v in pairs(t) do n[k] = v end
    return n
end

Library.Themes.Blade = copy(DEFAULT)
Library.Themes.Darker = {
    Window=rgb(13,13,18), Panel=rgb(17,18,23), Field=rgb(25,26,34),
    Divider=rgb(30,31,40), Accent=rgb(117,105,225),
    Text=rgb(240,240,246), Muted=rgb(120,124,146)
}
Library.Themes.White = {
    Window=rgb(235,237,243), Panel=rgb(224,227,236), Field=rgb(252,252,255),
    Divider=rgb(205,208,222), Accent=rgb(117,105,225),
    Text=rgb(30,32,40), Muted=rgb(120,124,142)
}
Library.Themes.Nexonix = {
    Window=rgb(24,25,30), Panel=rgb(29,30,37), Field=rgb(39,40,51),
    Divider=rgb(35,36,46), Accent=rgb(81,95,255),
    Text=rgb(255,255,255), Muted=rgb(150,150,150)
}
Library.Themes.Obsidian = {
    Window=rgb(16,16,19), Panel=rgb(22,22,26), Field=rgb(31,31,37),
    Divider=rgb(28,28,34), Accent=rgb(96,110,240),
    Text=rgb(255,255,255), Muted=rgb(146,146,156)
}
Library.Themes.Carbon = {
    Window=rgb(20,20,20), Panel=rgb(26,26,26), Field=rgb(36,36,36),
    Divider=rgb(33,33,33), Accent=rgb(240,138,66),
    Text=rgb(250,250,250), Muted=rgb(148,148,148)
}
Library.Themes.Slate = {
    Window=rgb(21,26,33), Panel=rgb(27,33,42), Field=rgb(38,46,58),
    Divider=rgb(34,41,52), Accent=rgb(86,180,222),
    Text=rgb(238,243,248), Muted=rgb(140,152,166)
}
Library.Themes.Abyss = {
    Window=rgb(13,20,33), Panel=rgb(18,27,43), Field=rgb(27,39,60),
    Divider=rgb(24,35,54), Accent=rgb(0,190,190),
    Text=rgb(232,240,250), Muted=rgb(126,142,164)
}
Library.Themes.Nord = {
    Window=rgb(38,42,53), Panel=rgb(46,52,64), Field=rgb(59,66,82),
    Divider=rgb(53,60,74), Accent=rgb(136,192,208),
    Text=rgb(236,239,244), Muted=rgb(150,160,176)
}
Library.Themes.Dracula = {
    Window=rgb(30,31,42), Panel=rgb(40,42,54), Field=rgb(54,57,74),
    Divider=rgb(48,50,66), Accent=rgb(189,147,249),
    Text=rgb(248,248,242), Muted=rgb(150,153,175)
}
Library.Themes.Gruvbox = {
    Window=rgb(29,32,33), Panel=rgb(40,40,40), Field=rgb(60,56,54),
    Divider=rgb(50,48,47), Accent=rgb(215,153,33),
    Text=rgb(235,219,178), Muted=rgb(146,131,116)
}
Library.Themes["Tokyo Night"] = {
    Window=rgb(26,27,38), Panel=rgb(31,35,53), Field=rgb(41,46,66),
    Divider=rgb(37,41,59), Accent=rgb(122,162,247),
    Text=rgb(192,202,245), Muted=rgb(122,131,166)
}
Library.Themes.Mocha = {
    Window=rgb(30,30,46), Panel=rgb(36,36,54), Field=rgb(49,50,68),
    Divider=rgb(44,44,62), Accent=rgb(203,166,247),
    Text=rgb(205,214,244), Muted=rgb(147,153,178)
}
Library.Themes["Rose Pine"] = {
    Window=rgb(25,23,36), Panel=rgb(31,29,46), Field=rgb(42,39,61),
    Divider=rgb(38,35,58), Accent=rgb(235,188,186),
    Text=rgb(224,222,244), Muted=rgb(144,140,170)
}
Library.Themes.Everforest = {
    Window=rgb(39,46,51), Panel=rgb(45,53,59), Field=rgb(58,68,74),
    Divider=rgb(52,61,67), Accent=rgb(167,192,128),
    Text=rgb(211,198,170), Muted=rgb(133,146,137)
}
Library.Themes.Crimson = {
    Window=rgb(24,16,18), Panel=rgb(32,21,24), Field=rgb(46,30,34),
    Divider=rgb(41,27,31), Accent=rgb(230,72,84),
    Text=rgb(250,240,241), Muted=rgb(158,138,141)
}
Library.Themes.Emerald = {
    Window=rgb(14,25,21), Panel=rgb(19,33,28), Field=rgb(28,47,40),
    Divider=rgb(25,42,36), Accent=rgb(52,211,153),
    Text=rgb(232,245,240), Muted=rgb(130,155,146)
}
Library.Themes.Amethyst = {
    Window=rgb(24,18,33), Panel=rgb(31,24,43), Field=rgb(44,34,60),
    Divider=rgb(39,30,54), Accent=rgb(167,110,248),
    Text=rgb(242,236,250), Muted=rgb(152,140,168)
}
Library.Themes.Ocean = {
    Window=rgb(15,23,42), Panel=rgb(20,31,56), Field=rgb(30,44,76),
    Divider=rgb(27,39,68), Accent=rgb(56,152,255),
    Text=rgb(235,242,252), Muted=rgb(133,150,176)
}
Library.Themes.Cyberpunk = {
    Window=rgb(10,10,16), Panel=rgb(17,16,26), Field=rgb(26,24,40),
    Divider=rgb(23,21,36), Accent=rgb(255,45,149),
    Text=rgb(240,240,255), Muted=rgb(140,138,168)
}
Library.Themes.Monochrome = {
    Window=rgb(18,18,18), Panel=rgb(25,25,25), Field=rgb(36,36,36),
    Divider=rgb(32,32,32), Accent=rgb(200,200,200),
    Text=rgb(255,255,255), Muted=rgb(145,145,145)
}
Library.Themes.Daylight = {
    Window=rgb(238,240,245), Panel=rgb(252,252,254), Field=rgb(228,231,238),
    Divider=rgb(214,218,227), Accent=rgb(56,110,255),
    Text=rgb(28,30,38), Muted=rgb(108,113,128)
}
Library.Themes.Paper = {
    Window=rgb(244,241,234), Panel=rgb(253,251,246), Field=rgb(233,229,219),
    Divider=rgb(220,215,203), Accent=rgb(190,110,60),
    Text=rgb(48,42,34), Muted=rgb(124,116,102)
}
Library.Themes.Latte = {
    Window=rgb(239,241,245), Panel=rgb(250,251,253), Field=rgb(228,230,240),
    Divider=rgb(214,217,228), Accent=rgb(136,57,239),
    Text=rgb(76,79,105), Muted=rgb(124,127,152)
}
Library.Themes.Solarized = {
    Window=rgb(238,232,213), Panel=rgb(253,246,227), Field=rgb(228,220,198),
    Divider=rgb(213,205,183), Accent=rgb(38,139,210),
    Text=rgb(60,74,84), Muted=rgb(131,148,150)
}
Library.Themes["Rose Dawn"] = {
    Window=rgb(250,244,237), Panel=rgb(255,250,243), Field=rgb(240,231,220),
    Divider=rgb(223,214,203), Accent=rgb(180,99,122),
    Text=rgb(87,82,121), Muted=rgb(144,122,169)
}
Library.Themes["Sakura Light"] = {
    Window=rgb(252,240,244), Panel=rgb(255,249,251), Field=rgb(246,228,235),
    Divider=rgb(232,210,220), Accent=rgb(233,109,150),
    Text=rgb(60,40,50), Muted=rgb(150,120,132)
}
Library.Themes["Mint Light"] = {
    Window=rgb(238,247,242), Panel=rgb(250,254,252), Field=rgb(226,240,233),
    Divider=rgb(210,228,219), Accent=rgb(16,163,127),
    Text=rgb(28,44,38), Muted=rgb(105,128,118)
}
Library.Themes.Sand = {
    Window=rgb(245,240,230), Panel=rgb(253,250,243), Field=rgb(235,228,214),
    Divider=rgb(220,212,196), Accent=rgb(200,140,60),
    Text=rgb(52,46,36), Muted=rgb(130,122,106)
}
Library.Themes.Frost = {
    Window=rgb(236,243,248), Panel=rgb(250,253,255), Field=rgb(224,234,243),
    Divider=rgb(206,220,232), Accent=rgb(0,140,190),
    Text=rgb(24,38,48), Muted=rgb(104,122,136)
}

for name in pairs(Library.Themes) do
    table.insert(Library.ThemeNames, name)
end
table.sort(Library.ThemeNames)

local function applyTheme()
    local theme = Library.Themes[Library.Theme] or Library.Themes.Blade
    for k,v in pairs(DEFAULT) do
        Library[k] = theme[k] or v
    end

    for _,window in ipairs(Library.Windows) do
        if window._applyTheme then window:_applyTheme() end
    end
end

function Library:SetTheme(name)
    if not self.Themes[name] then return false end
    self.Theme = name
    applyTheme()
    return true
end

local function create(class, props, children)
    local obj = Instance.new(class)
    for k,v in pairs(props or {}) do
        obj[k] = v
    end
    for _,child in ipairs(children or {}) do
        child.Parent = obj
    end
    return obj
end

local function corner(parent, radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius or 4),
        Parent = parent
    })
end

local function stroke(parent, color, thickness)
    return create("UIStroke", {
        Color = color or Library.Divider,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

local function label(parent, text, size, color)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Enum.Font.Gotham,
        Text = tostring(text or ""),
        TextColor3 = color or Library.Text,
        TextSize = size or 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        AutomaticSize = Enum.AutomaticSize.XY,
        Parent = parent,
    })
end

local function bindHover(button, normal, hover)
    button.MouseEnter:Connect(function()
        tween(button, MOTION.Hover, normal and hover or {})
    end)
    button.MouseLeave:Connect(function()
        tween(button, MOTION.Hover, normal or {})
    end)
end

local Control = {}
Control.__index = Control

function Control:SetTooltip(text)
    self.Tooltip = text
    return self
end

function Control:SetText(text)
    self.Text = text
    if self._label then self._label.Text = tostring(text) end
    return self
end

function Control:SetLock(locked, forced, note)
    self.Locked = locked and true or false
    self.Forced = self.Locked and forced or nil
    self.LockNote = note
    if self._refresh then self:_refresh() end
    return self
end

function Control:AddColorpicker(idOrConfig, config)
    if type(idOrConfig) == "table" then
        config = idOrConfig
        idOrConfig = nil
    end
    config = config or {}
    local picker = self.Groupbox:AddColorpicker(idOrConfig, config)
    self.Colorpicker = picker
    return self
end

function Control:AddKeybind(idOrConfig, config)
    if type(idOrConfig) == "table" then
        config = idOrConfig
        idOrConfig = nil
    end
    config = config or {}
    local bind = self.Groupbox:AddKeybind(idOrConfig, config)
    self.Keybind = bind
    return self
end

local Groupbox = {}
Groupbox.__index = Groupbox

function Groupbox:_row(height)
    local row = create("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1,-12,0,height or 22),
        LayoutOrder = self._order,
        Parent = self.Elements,
    })
    self._order += 1
    return row
end

function Groupbox:AddLabel(text, wrap)
    local row = self:_row(20)
    row.AutomaticSize = Enum.AutomaticSize.Y
    local l = label(row, text, 10, Library.Muted)
    l.Size = UDim2.new(1,-6,0,0)
    l.AutomaticSize = Enum.AutomaticSize.Y
    l.TextWrapped = wrap ~= false
    l.Parent = row
    local c = setmetatable({
        Type="Label", Row=row, _label=l, Text=text, Groupbox=self
    }, Control)
    return c
end

function Groupbox:AddDivider()
    local row = self:_row(8)
    create("Frame", {
        BackgroundColor3 = Library.Divider,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(.5,.5),
        Position = UDim2.fromScale(.5,.5),
        Size = UDim2.new(1,-16,0,1),
        Parent = row
    })
    return {Type="Divider", Row=row}
end

function Groupbox:AddButton(config)
    if type(config) == "string" then config = {Text=config} end
    config = config or {}
    local entries = config.Text and {config} or config
    local row = self:_row(25)
    local layout = create("UIListLayout", {
        FillDirection=Enum.FillDirection.Horizontal,
        HorizontalAlignment=Enum.HorizontalAlignment.Center,
        VerticalAlignment=Enum.VerticalAlignment.Center,
        Padding=UDim.new(0,3),
        Parent=row
    })
    local controls = {}
    for _,entry in ipairs(entries) do
        local b = create("TextButton", {
            AutoButtonColor=false, BorderSizePixel=0,
            BackgroundColor3=Library.ButtonFill,
            TextColor3=Library.Muted, Font=Enum.Font.Gotham,
            TextSize=10, Text=entry.Text or "Button",
            Size=UDim2.new(1/#entries,-3,0,20),
            Parent=row
        })
        corner(b,3)
        bindHover(b,
            {BackgroundColor3=Library.ButtonFill,TextColor3=Library.Muted},
            {BackgroundColor3=Library.ButtonFillHover,TextColor3=Library.MutedHover})
        b.MouseButton1Click:Connect(function()
            if entry.Confirm then
                if b:GetAttribute("Confirming") then
                    b:SetAttribute("Confirming",false)
                    b.Text = entry.Text or "Button"
                    if entry.Func then task.spawn(entry.Func) end
                else
                    b:SetAttribute("Confirming",true)
                    b.Text = entry.Prompt or "Press again"
                    task.delay(2,function()
                        if b.Parent and b:GetAttribute("Confirming") then
                            b:SetAttribute("Confirming",false)
                            b.Text=entry.Text or "Button"
                        end
                    end)
                end
            elseif entry.Func then
                task.spawn(entry.Func)
            end
        end)
        table.insert(controls,b)
    end
    return setmetatable({Type="Button",Row=row,Buttons=controls,Groupbox=self},Control)
end

function Groupbox:AddToggle(id, config)
    if type(id) == "table" then config=id; id=config.Name end
    config=config or {}
    local row=self:_row(22)
    local title=label(row,config.Text or id or "Toggle",10,Library.Muted)
    title.Position=UDim2.new(0,0,.5,-7)
    title.Size=UDim2.new(1,-110,0,14)
    title.Parent=row

    local track=create("TextButton",{
        AutoButtonColor=false,Text="",BorderSizePixel=0,
        BackgroundColor3=Library.TrackOff,
        AnchorPoint=Vector2.new(1,.5),
        Position=UDim2.new(1,-2,.5,0),
        Size=UDim2.fromOffset(27,15),Parent=row
    })
    corner(track,8)
    local knob=create("Frame",{
        BorderSizePixel=0,BackgroundColor3=Library.KnobOff,
        AnchorPoint=Vector2.new(.5,.5),
        Position=UDim2.new(0,6.5,.5,0),
        Size=UDim2.fromOffset(9,9),Parent=track
    })
    corner(knob,9); stroke(knob,Library.KnobStroke,1)

    local obj=setmetatable({
        Type="Toggle",Value=config.Default==true,Default=config.Default==true,
        Callback=config.Callback,Row=row,_label=title,Track=track,Knob=knob,
        Groupbox=self,Text=config.Text or id,Locked=false
    },Control)

    function obj:_refresh()
        local on=self.Locked and self.Forced or self.Value
        local muted=self.Locked
        local x=on and 21 or 2
        tween(self.Knob,MOTION.ToggleSlide,{
            Position=UDim2.new(0,x+4.5,.5,0),
            BackgroundColor3=on and Library.Knob or (muted and Library.KnobOffHover or Library.KnobOff)
        })
        tween(self.Track,MOTION.Toggle,{
            BackgroundColor3=on and Library.TrackOn or (muted and Library.TrackOffHover or Library.TrackOff)
        })
        title.TextColor3=on and Library.Text or (muted and Library.MutedHover or Library.Muted)
    end

    function obj:SetValue(v,noCallback)
        self.Value=v and true or false
        self:_refresh()
        if not noCallback and self.Callback then task.spawn(self.Callback,self.Locked and self.Forced or self.Value) end
    end

    track.MouseButton1Click:Connect(function()
        if obj.Locked then
            if obj.LockNote then Library:Notify({Title=obj.LockNote,Type="Warn",Duration=3}) end
            return
        end
        obj:SetValue(not obj.Value)
    end)
    obj:_refresh()
    if id then Library.Options[id]=obj; Library.Toggles[id]=obj end
    return obj
end

function Groupbox:AddSlider(id, config)
    if type(id)=="table" then config=id; id=config.Name end
    config=config or {}
    local min,max,round=config.Min or 0,config.Max or 100,config.Rounding or 0
    local row=self:_row(26)
    local title=label(row,config.Text or id or "Slider",10,Library.Muted)
    title.Position=UDim2.new(0,0,.5,-7); title.Parent=row
    local track=create("Frame",{
        BackgroundColor3=Library.Field,BorderSizePixel=0,
        AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-4,.5,3),
        Size=UDim2.new(1,-135,0,4),Parent=row
    })
    corner(track,3)
    local fill=create("Frame",{BackgroundColor3=Library.Knob,BorderSizePixel=0,Size=UDim2.new(0,0,1,0),Parent=track})
    corner(fill,3)
    local knob=create("Frame",{BackgroundColor3=Library.Text,BorderSizePixel=0,
        AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(0,.5,0),
        Size=UDim2.fromOffset(8,8),Parent=track})
    corner(knob,8); stroke(knob,Library.SliderStroke,1)
    local valueLabel=label(row,"",9,Library.SliderValue)
    valueLabel.AnchorPoint=Vector2.new(1,.5); valueLabel.Position=UDim2.new(1,-2,.5,-7)
    valueLabel.Parent=row

    local obj=setmetatable({
        Type="Slider",Value=config.Default or min,Min=min,Max=max,Rounding=round,
        Prefix=config.Prefix or "",Suffix=config.Suffix or "",Callback=config.Callback,
        Live=config.Live,Track=track,Fill=fill,Knob=knob,_label=title,
        _valueLabel=valueLabel,Groupbox=self
    },Control)

    local function quant(v)
        local p=10^round
        return math.floor(v*p+.5)/p
    end
    function obj:_paint()
        local a=(self.Max-self.Min)>0 and (self.Value-self.Min)/(self.Max-self.Min) or 0
        a=clamp(a,0,1)
        fill.Size=UDim2.new(a,0,1,0)
        knob.Position=UDim2.new(a,0,0.5,0)
        valueLabel.Text=self.Prefix..tostring(quant(self.Value))..self.Suffix
    end
    function obj:SetValue(v,noCallback)
        v=quant(clamp(tonumber(v) or self.Min,self.Min,self.Max))
        local changed=v~=self.Value
        self.Value=v; self:_paint()
        if changed and not noCallback and self.Callback then task.spawn(self.Callback,v) end
    end

    local dragging=false
    local function move(pos)
        local x=clamp((pos.X-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
        obj:SetValue(min+(max-min)*x)
    end
    track.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true; move(input.Position)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            move(input.Position)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
    obj:_paint()
    if id then Library.Options[id]=obj end
    return obj
end

function Groupbox:AddInput(id, config)
    if type(id)=="table" then config=id; id=config.Name end
    config=config or {}
    local row=self:_row(24)
    local title=label(row,config.Text or id or "Textbox",10,Library.Muted)
    title.Position=UDim2.new(0,0,.5,-7); title.Parent=row
    local box=create("TextBox",{
        ClearTextOnFocus=false,Text=config.Default or "",
        PlaceholderText=config.Placeholder or "Write...",
        TextColor3=Library.Text,PlaceholderColor3=Library.Muted,
        BackgroundColor3=Library.Field,BorderSizePixel=0,
        Font=Enum.Font.Gotham,TextSize=9,
        TextXAlignment=Enum.TextXAlignment.Left,
        AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-2,.5,0),
        Size=UDim2.fromOffset(125,18),Parent=row
    })
    corner(box,3)
    local obj=setmetatable({
        Type="Input",Value=box.Text,Callback=config.Callback,Box=box,
        Row=row,_label=title,Groupbox=self
    },Control)
    function obj:SetValue(v,noCallback)
        self.Value=tostring(v or ""); box.Text=self.Value
        if not noCallback and self.Callback then task.spawn(self.Callback,self.Value) end
    end
    box.FocusLost:Connect(function()
        obj.Value=box.Text
        if obj.Callback then task.spawn(obj.Callback,obj.Value) end
    end)
    if id then Library.Options[id]=obj end
    return obj
end

function Groupbox:AddDropdown(id, config)
    if type(id)=="table" then config=id; id=config.Name end
    config=config or {}
    local values=config.Values or {}
    local multi=config.Multi==true
    local row=self:_row(24)
    local title=label(row,config.Text or id or "Dropdown",10,Library.Muted)
    title.Position=UDim2.new(0,0,.5,-7); title.Parent=row
    local button=create("TextButton",{
        AutoButtonColor=false,Text="",TextColor3=Library.Text,
        BackgroundColor3=Library.Field,BorderSizePixel=0,
        Font=Enum.Font.Gotham,TextSize=9,
        AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-2,.5,0),
        Size=UDim2.fromOffset(130,18),Parent=row
    })
    corner(button,3)
    local obj=setmetatable({
        Type="Dropdown",Values=values,Multi=multi,
        Value=multi and {} or config.Default,
        Callback=config.Callback,Row=row,Groupbox=self,_label=title,
        _button=button,Open=false
    },Control)

    local popup
    local function text()
        if multi then
            if #obj.Value==0 then return "None" end
            return table.concat(obj.Value,", ")
        end
        return tostring(obj.Value or "--")
    end
    local function refresh()
        button.Text=text()
    end
    function obj:SetValue(v,noCallback)
        if multi then
            local out={}
            if type(v)=="table" then
                for _,x in ipairs(v) do
                    if table.find(values,x) and not table.find(out,x) then table.insert(out,x) end
                end
            elseif v~=nil and table.find(values,v) then table.insert(out,v) end
            self.Value=out
        else
            if type(v)=="number" then v=values[v] end
            self.Value=v
        end
        refresh()
        if not noCallback and self.Callback then task.spawn(self.Callback,self.Value) end
    end
    local function close()
        if popup then popup:Destroy(); popup=nil end
        obj.Open=false
    end
    local function open()
        close()
        local root=button:FindFirstAncestorWhichIsA("ScreenGui")
        if not root then return end
        popup=create("Frame",{
            BackgroundColor3=Library.Popup,BorderSizePixel=0,
            Position=UDim2.fromOffset(button.AbsolutePosition.X,button.AbsolutePosition.Y+button.AbsoluteSize.Y+4),
            Size=UDim2.fromOffset(button.AbsoluteSize.X,math.min(180,#values*22+8)),
            ZIndex=10000,Parent=root
        })
        corner(popup,5); stroke(popup,Library.Divider,1)
        local scroll=create("ScrollingFrame",{
            BackgroundTransparency=1,BorderSizePixel=0,
            Size=UDim2.fromScale(1,1),CanvasSize=UDim2.new(),
            AutomaticCanvasSize=Enum.AutomaticSize.Y,
            ScrollBarThickness=3,ScrollBarImageColor3=Library.Muted,
            Parent=popup
        })
        create("UIListLayout",{Padding=UDim.new(0,2),Parent=scroll})
        for _,v in ipairs(values) do
            local b=create("TextButton",{
                AutoButtonColor=false,Text=tostring(v),
                TextColor3=Library.OptionTextOn or Library.Text,
                BackgroundColor3=Library.Option,BorderSizePixel=0,
                Font=Enum.Font.Gotham,TextSize=9,
                Size=UDim2.new(1,-8,0,20),Parent=scroll
            })
            corner(b,3)
            b.MouseButton1Click:Connect(function()
                if multi then
                    local t={}
                    for _,x in ipairs(obj.Value) do t[x]=true end
                    t[v]=not t[v]
                    local out={}
                    for _,x in ipairs(values) do if t[x] then table.insert(out,x) end end
                    obj:SetValue(out)
                else
                    obj:SetValue(v); close()
                end
            end)
        end
        obj.Open=true
    end
    button.MouseButton1Click:Connect(function() if obj.Open then close() else open() end end)
    obj.Close=close
    obj:SetValue(obj.Value,true)
    if id then Library.Options[id]=obj end
    return obj
end

function Groupbox:AddColorpicker(id, config)
    if type(id)=="table" then config=id; id=config.Name end
    config=config or {}
    local row=self:_row(22)
    local title=label(row,config.Title or id or "Color",10,Library.Muted)
    title.Position=UDim2.new(0,0,.5,-7); title.Parent=row
    local swatch=create("TextButton",{
        AutoButtonColor=false,Text="",BorderSizePixel=0,
        BackgroundColor3=config.Default or Library.Accent,
        AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-2,.5,0),
        Size=UDim2.fromOffset(25,15),Parent=row
    })
    corner(swatch,3)
    local obj=setmetatable({
        Type="Colorpicker",Value=config.Default or Library.Accent,
        Transparency=config.Transparency or 0,Callback=config.Callback,
        Row=row,Swatch=swatch,Groupbox=self
    },Control)
    function obj:SetValue(c,noCallback)
        if typeof(c)=="Color3" then self.Value=c; swatch.BackgroundColor3=c end
        if not noCallback and self.Callback then task.spawn(self.Callback,self.Value) end
    end
    function obj:SetTransparency(v,noCallback)
        self.Transparency=clamp(tonumber(v) or 0,0,1)
        swatch.BackgroundTransparency=self.Transparency
        if not noCallback and self.Callback then task.spawn(self.Callback,self.Value) end
    end
    swatch.MouseButton1Click:Connect(function()
        -- The original uses a full popup color editor. The compact reconstruction
        -- keeps the public object/API intact; a picker can be attached here.
        if self then
            obj:SetValue(obj.Value)
        end
    end)
    return obj
end

function Groupbox:AddKeybind(id, config)
    if type(id)=="table" then config=id; id=config.Name end
    config=config or {}
    local row=self:_row(22)
    local title=label(row,config.Text or id or "Keybind",10,Library.Muted)
    title.Position=UDim2.new(0,0,.5,-7); title.Parent=row
    local bind=create("TextButton",{
        AutoButtonColor=false,Text=tostring(config.Default or "None"),
        TextColor3=Library.Muted,BackgroundColor3=Library.Field,
        BorderSizePixel=0,Font=Enum.Font.Gotham,TextSize=9,
        AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-2,.5,0),
        Size=UDim2.fromOffset(55,17),Parent=row
    })
    corner(bind,3)
    local obj=setmetatable({
        Type="Keybind",Value={Key=config.Default,Mode=config.Mode or "Toggle"},
        Callback=config.Callback,OnPress=config.OnPress,Row=row,Groupbox=self
    },Control)
    local capture=false
    bind.MouseButton1Click:Connect(function()
        capture=true; bind.Text="..."
    end)
    local conn=UserInputService.InputBegan:Connect(function(input,gp)
        if capture then
            if input.KeyCode~=Enum.KeyCode.Unknown then
                obj.Value.Key=input.KeyCode.Name
                bind.Text=obj.Value.Key
                capture=false
            end
            return
        end
        if gp then return end
        if obj.Value.Key and input.KeyCode.Name==obj.Value.Key then
            if obj.OnPress then
                task.spawn(obj.OnPress,obj.Value)
            elseif obj.Value.Mode=="Hold" then
                if obj.Callback then task.spawn(obj.Callback,true) end
            else
                obj.State=not obj.State
                if obj.Callback then task.spawn(obj.Callback,obj.State) end
            end
        end
    end)
    table.insert(Library.Connections,conn)
    if id then Library.Options[id]=obj end
    return obj
end

function Groupbox:AddTable(id, config)
    if type(id)=="table" then config=id; id=config.Name end
    config=config or {}
    local row=self:_row(30)
    local title=label(row,config.Text or id or "Table",9,Library.TableText)
    title.Parent=row
    local obj=setmetatable({
        Type="Table",Value=config.Rows or {},Columns=config.Columns or {},
        Row=row,Groupbox=self
    },Control)
    function obj:SetValue(rows)
        self.Value=rows or {}
        -- Compact reconstruction stores the table data; callers can refresh their
        -- own renderer through Refresh.
    end
    function obj:Clear() self:SetValue({}) end
    function obj:Refresh() end
    if id then Library.Options[id]=obj end
    return obj
end

function Groupbox:AddSettings(control, config)
    return control
end

local Tab={}
Tab.__index=Tab

function Tab:_makeGroup(name)
    local box=create("Frame",{
        BackgroundColor3=Library.Panel,BorderSizePixel=0,
        Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        Parent=self.Content
    })
    corner(box,5); stroke(box,Library.Divider,.5)
    local title=label(box,name,10,Library.GroupTitle)
    title.Position=UDim2.fromOffset(10,8); title.Parent=box
    local elements=create("Frame",{
        BackgroundTransparency=1,BorderSizePixel=0,
        Position=UDim2.fromOffset(7,29),Size=UDim2.new(1,-14,0,0),
        AutomaticSize=Enum.AutomaticSize.Y,Parent=box
    })
    create("UIListLayout",{
        Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,Parent=elements
    })
    local group=setmetatable({
        Name=name,Container=box,Elements=elements,_order=0,Tab=self
    },Groupbox)
    self.Groupboxes[#self.Groupboxes+1]=group
    return group
end

function Tab:AddLeftGroupbox(name)
    return self:_makeGroup(name or "Groupbox")
end
function Tab:AddRightGroupbox(name)
    return self:_makeGroup(name or "Groupbox")
end
function Tab:AddGroupbox(name)
    return self:_makeGroup(name or "Groupbox")
end
function Tab:AddSubTab(name)
    local tab=self.Window:AddTab({Name=name})
    self.Subs=self.Subs or {}; table.insert(self.Subs,tab)
    return tab
end

local Window={}
Window.__index=Window

function Window:_applyTheme()
    self.Main.BackgroundColor3=Library.Window
    self.Rail.BackgroundColor3=Library.Rail
    for _,tab in ipairs(self.Tabs) do
        tab.Content.BackgroundColor3=Library.Window
        for _,g in ipairs(tab.Groupboxes) do
            g.Container.BackgroundColor3=Library.Panel
        end
    end
end

function Window:AddTab(config)
    if type(config)=="string" then config={Name=config} end
    config=config or {}
    local name=config.Name or config.Title or ("Tab "..(#self.Tabs+1))
    local button=create("TextButton",{
        AutoButtonColor=false,Text=name,TextColor3=Library.Muted,
        BackgroundColor3=Library.Rail,BorderSizePixel=0,
        Font=Enum.Font.Gotham,TextSize=10,
        Size=UDim2.new(1,-10,0,24),Parent=self.TabButtons
    })
    corner(button,4)
    local content=create("ScrollingFrame",{
        Visible=false,BackgroundTransparency=1,BorderSizePixel=0,
        Size=UDim2.fromScale(1,1),CanvasSize=UDim2.new(),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        ScrollBarThickness=3,ScrollBarImageColor3=Library.Muted,
        Parent=self.ContentHolder
    })
    create("UIListLayout",{
        Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=content
    })
    local tab=setmetatable({
        Name=name,Title=name,Window=self,Button=button,Content=content,
        Groupboxes={},Subs={}
    },Tab)
    table.insert(self.Tabs,tab)
    local function select()
        for _,t in ipairs(self.Tabs) do
            t.Content.Visible=false
            t.Button.BackgroundColor3=Library.Rail
            t.Button.TextColor3=Library.Muted
        end
        content.Visible=true
        button.BackgroundColor3=Library.TabFill
        button.TextColor3=Library.Text
        self.Active=tab
    end
    button.MouseButton1Click:Connect(select)
    button.MouseEnter:Connect(function()
        if self.Active~=tab then button.BackgroundColor3=Library.TabFillHover end
    end)
    button.MouseLeave:Connect(function()
        if self.Active~=tab then button.BackgroundColor3=Library.Rail end
    end)
    if #self.Tabs==1 then select() end
    return tab
end

function Window:ToggleOpen()
    self.Open=not self.Open
    self.Screen.Enabled=self.Open
end

function Window:Unload()
    if self.Screen then self.Screen:Destroy() end
    if self.MobileScreen then self.MobileScreen:Destroy() end
end

function Library:CreateWindow(config)
    config=config or {}
    local gui=create("ScreenGui",{
        Name=config.Name or "Blade",
        ResetOnSpawn=false,
        ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
        DisplayOrder=config.DisplayOrder or 100,
        Parent=config.Parent or LocalPlayer:WaitForChild("PlayerGui")
    })
    local main=create("Frame",{
        Name="MainFrame",BackgroundColor3=Library.Window,
        BorderSizePixel=0,AnchorPoint=Vector2.new(.5,.5),
        Position=UDim2.fromScale(.5,.5),
        Size=UDim2.fromOffset(config.Width or 550,config.Height or 400),
        Parent=gui
    })
    corner(main,8)
    local rail=create("Frame",{
        BackgroundColor3=Library.Rail,BorderSizePixel=0,
        Size=UDim2.fromOffset(150,main.Size.Y.Offset),
        Parent=main
    })
    corner(rail,8)
    local brand=label(rail,string.upper(config.Title or self.Title),11,Library.Text)
    brand.Position=UDim2.fromOffset(12,10); brand.Parent=rail
    local tabs=create("ScrollingFrame",{
        BackgroundTransparency=1,BorderSizePixel=0,
        Position=UDim2.fromOffset(5,42),Size=UDim2.new(1,-10,1,-52),
        CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
        ScrollBarThickness=0,Parent=rail
    })
    create("UIListLayout",{Padding=UDim.new(0,5),Parent=tabs})
    local holder=create("Frame",{
        BackgroundTransparency=1,BorderSizePixel=0,
        Position=UDim2.fromOffset(160,10),Size=UDim2.new(1,-170,1,-20),
        Parent=main
    })
    local content=create("Frame",{
        BackgroundTransparency=1,BorderSizePixel=0,
        Size=UDim2.fromScale(1,1),Parent=holder
    })
    local win=setmetatable({
        Screen=gui,Main=main,Rail=rail,TabButtons=tabs,
        ContentHolder=content,Tabs={},Open=true
    },Window)
    table.insert(self.Windows,win)

    -- Window dragging.
    local dragging=false
    local dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true; dragStart=input.Position; startPos=main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local d=input.Position-dragStart
            main.Position=startPos+UDim2.fromOffset(d.X,d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
    end)

    win:_applyTheme()
    return win
end

-- Notification system matching the source's public behavior.
Library.NotificationsEnabled=true
Library.NotifyDuration=5
Library._notifications={}

function Library:Notify(config)
    if not self.NotificationsEnabled then
        return {Close=function() end}
    end
    if type(config)=="string" then config={Title=config} end
    config=config or {}
    local parent=(self.Windows[1] and self.Windows[1].Screen)
    if not parent then return {Close=function() end} end

    local holder=parent:FindFirstChild("Notifications")
    if not holder then
        holder=create("Frame",{
            Name="Notifications",BackgroundTransparency=1,BorderSizePixel=0,
            AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-15,1,-15),
            Size=UDim2.fromOffset(300,0),AutomaticSize=Enum.AutomaticSize.Y,
            Parent=parent
        })
        create("UIListLayout",{
            HorizontalAlignment=Enum.HorizontalAlignment.Right,
            VerticalAlignment=Enum.VerticalAlignment.Bottom,
            Padding=UDim.new(0,6),Parent=holder
        })
    end

    local typeName=config.Type or "Default"
    local accent=Library.Text
    if typeName=="Warn" or typeName=="Warning" then accent=Library.NotifyWarn end
    if typeName=="Error" then accent=Library.NotifyError end

    local frame=create("Frame",{
        BackgroundColor3=Library.Window,BorderSizePixel=0,
        Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,
        Parent=holder
    })
    corner(frame,5); stroke(frame,Library.Divider,.5)
    local title=label(frame,config.Title or "Notification",10,Library.Text)
    title.Position=UDim2.fromOffset(10,8); title.Parent=frame
    local desc=label(frame,config.Description or "",9,Library.NotifyDesc)
    desc.Position=UDim2.fromOffset(10,25); desc.Parent=frame
    local bar=create("Frame",{
        BackgroundColor3=accent,BorderSizePixel=0,
        Position=UDim2.new(0,0,1,-2),Size=UDim2.new(1,0,0,2),Parent=frame
    })
    local closed=false
    local item={}
    function item:Close()
        if closed then return end
        closed=true
        frame:Destroy()
    end
    table.insert(self._notifications,item)
    local duration=tonumber(config.Duration)
    if duration==nil then duration=self.NotifyDuration end
    if duration>0 then
        task.delay(duration,function() item:Close() end)
    end
    return item
end

function Library:ClearNotifications()
    for _,n in ipairs(self._notifications) do pcall(function() n:Close() end) end
    table.clear(self._notifications)
end

function Library:SetNotificationsEnabled(enabled)
    self.NotificationsEnabled=enabled and true or false
    if not self.NotificationsEnabled then self:ClearNotifications() end
end

function Library:Unload()
    if self.Unloaded then return end
    self.Unloaded=true
    self:ClearNotifications()
    for _,c in ipairs(self.Connections) do pcall(function() c:Disconnect() end) end
    table.clear(self.Connections)
    for _,w in ipairs(self.Windows) do pcall(function() w:Unload() end) end
    table.clear(self.Windows)
    table.clear(self.Options)
    table.clear(self.Toggles)
end

applyTheme()

return Library
