--- ~/.config/hilbish/init.lua

local hilbish = require('hilbish')
local promptua = require('promptua')
local col = require('lunacolors')

-- Prompt
---------
promptua.setConfig {
   prompt = { icon = 'λ' }
}
promptua.setTheme {
   -- Leaves a line before the prompt to prevent the terminal from looking cluttered.
   { separator = ' \n' },
   -- Git repo information.
   { provider = 'git.dirty',  style = 'red',    separator = '',   icon = ' [!] ' },
   { provider = 'git.branch', style = 'yellow', separator = '\n', icon = 'on branch ' },
   -- Current work path, shortened to ~/ within os.getenv('HOME').
   {
      -- provider = 'dir.path', style = 'italic white', separator = ' ',
      provider = 'dir.path', style = 'white', separator = ' ',
      format = '@style @icon@info'
   },
   -- Actual prompt thing.
   { provider = 'prompt.icon', style = 'green', separator = ' ' }
}
promptua.init()

-- Highlighting
---------------
function hilbish.highlighter(line)
   return line:gsub('".-"', function(c) return col.blue(c) end)
end

-- Aliases
----------
hilbish.alias('xtest', 'Xephyr -screen 1152x720 :5 & sleep 1; DISPLAY=:5 awesome')

-- Path
-------
hilbish.prependPath(os.getenv('HOME') .. '/.local/bin/')
hilbish.prependPath(os.getenv('HOME') .. '/go/bin/')

-- Misc
-------
hilbish.opts.motd = false
hilbish.opts.tips = false
hilbish.runnerMode('hybridRev')

-- Greeter
----------
local user, host = os.getenv('USER'), os.getenv('HOSTNAME')
if user == nil or host == nil then return end

-- Line 1
local gl1 = '{white}0{red}=={blue}[{white}=====>{reset}  ' ..
   'Welcome to {green}' .. host .. '{reset}, {blue}' .. user .. '{reset}!' ..
   '  {white}<====={blue}]{red}=={white}0{reset}'
-- Line 2
local gl2 = tostring(os.date('{blue}%A {white}%d/%m/%Y{reset} {magenta}%H:%M{reset}'))

-- Obtain the length of the "raw" (no lunacolors formatting) strings.
local l1 = (gl1:gsub('{%a+}', '')):len()
local l2 = (gl2:gsub('{%a+}', '')):len()

-- Align line 2 to the center of line 1.
local spaces, append = '', ''
local n_spaces = math.floor((l1 - l2) / 2)
for _ = 1, n_spaces do
   spaces = spaces .. ' '
end

-- Append an ending period only if the string can't be aligned due to mismatched
-- parity.
if (l1 + l2) % 2 == 1 then
   append = '.'
end

hilbish.opts.greeting = col.format(gl1 .. '\n' .. spaces .. gl2 .. append)
