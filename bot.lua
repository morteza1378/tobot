-- creator HIDDEN BOY
-- channel @shield_tm
package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua' 
  ..';.luarocks/share/lua/5.2/?/init.lua' 
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so' 
URL = require('socket.url') 
JSON = require('dkjson') 
HTTPS = require('ssl.https') 
----config---- 
local bot_api_key = "توکن" 
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key 
local BASE_FOLDER = "" 
local start = [[*⚡ Welcome To SHIELD BOT ⚡*

_📚 Help :_

1 - Send Me Sticker ▶️ Get It As Photo And File for sticker bot ‌  official telegram❗️

🎆 با ارسال استیکر به ربات عکس و فایل استیکرتان را دریافت کنید

⤵⤵⤵⤵⤵⤵⤵⤵⤵⤵⤵⤵⤵

2 - Send Me Photo ▶ ️Get It As sticker❗

🃏 با ارسال عکس به ربات استیکر عکس را دریافت کنید

✖✖✖✖✖✖✖✖✖✖✖✖✖
3 - /code text  ▶️ `code text`
4 - /bold text   ▶ ️*bold text*
5 - /italic text  ▶  ️_italic text_
6 - /link LINK TEXT ▶️  [HYPER](https://telegram.me)
👉➖➖➖➖➖➖➖➖➖➖👈
*Developer ⚡* [‌PEDI SHIELD](https://telegram.me/Xx_KinG_SuPeR_AdMiN_SHIELD_xX)
*Creator 🔧* [HIDDEN BOY](https://telegram.me/Xx_PesareShield_shah2Arvah_xX)

*Bot Channel 📣* [کانال ‌تـــیـــم شــیــلــد لمس کنید](https://telegram.me/shield_tm)


_Good Luck 👋_
===========================
🇸 🇭 🇮 🇪 🇱 🇩™ ]] 
----------

----utilites---- 

function is_admin(msg)-- Check if user is admin or not 
  local var = false 
  local admins = {ایدی ادمین}-- put your id here 
  for k,v in pairs(admins) do 
    if msg.from.id == v then 
      var = true 
    end 
  end 
  return var 
end 

function sendRequest(url) 
  local dat, res = HTTPS.request(url) 
  local tab = JSON.decode(dat) 

  if res ~= 200 then 
    return false, res 
  end 

  if not tab.ok then 
    return false, tab.description 
  end 

  return tab 

end 

function getMe()--https://core.telegram.org/bots/api#getfile 
    local url = BASE_URL .. '/getMe' 
  return sendRequest(url) 
end 

function getUpdates(offset)--https://core.telegram.org/bots/api#getupdates 

  local url = BASE_URL .. '/getUpdates?timeout=20' 

  if offset then 

    url = url .. '&offset=' .. offset 

  end 

  return sendRequest(url) 

end 
sendSticker = function(chat_id, sticker, reply_to_message_id)

	local url = BASE_URL .. '/sendSticker'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	io.popen(curl_command):read("*all")
	return end

sendPhoto = function(chat_id, photo, caption, reply_to_message_id) 

   local url = BASE_URL .. '/sendPhoto' 

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "photo=@' .. photo .. '"' 

   if reply_to_message_id then 
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"' 
   end 

   if caption then 
      curl_command = curl_command .. ' -F "caption=' .. caption .. '"' 
   end 

   io.popen(curl_command):read("*all") 
   return end 

forwardMessage = function(chat_id, from_chat_id, message_id) 

   local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id 

   return sendRequest(url) 

end 

function sendMessage(chat_id, text, disable_web_page_preview, reply_to_message_id, use_markdown)--https://core.telegram.org/bots/api#sendmessage 

   local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) 

   if disable_web_page_preview == true then 
      url = url .. '&disable_web_page_preview=true' 
   end 

   if reply_to_message_id then 
      url = url .. '&reply_to_message_id=' .. reply_to_message_id 
   end 

   if use_markdown then 
      url = url .. '&parse_mode=Markdown' 
   end 

   return sendRequest(url) 

end 
function sendDocument(chat_id, document, reply_to_message_id)--https://github.com/topkecleon/otouto/blob/master/bindings.lua 

   local url = BASE_URL .. '/sendDocument' 

   local curl_command = 'cd \''..BASE_FOLDER..currect_folder..'\' && curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"' 

   if reply_to_message_id then 
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"' 
   end 
   io.popen(curl_command):read("*all") 
   return 

end 
function download_to_file(url, file_name, file_path)--https://github.com/yagop/telegram-bot/blob/master/bot/utils.lua 
  print("url to download: "..url) 

  local respbody = {} 
  local options = { 
    url = url, 
    sink = ltn12.sink.table(respbody), 
    redirect = true 
  } 
  -- nil, code, headers, status 
  local response = nil 
    options.redirect = false 
    response = {HTTPS.request(options)} 
  local code = response[2] 
  local headers = response[3] 
  local status = response[4] 
  if code ~= 200 then return nil end 
  local file_path = BASE_FOLDER..currect_folder..file_name 

  print("Saved to: "..file_path) 

  file = io.open(file_path, "w+") 
  file:write(table.concat(respbody)) 
  file:close() 
  return file_path 
end 
-------- 

function bot_run() 
   bot = nil 

   while not bot do -- Get bot info 
      bot = getMe() 
   end 

   bot = bot.result 

   local bot_info = "ربات روشن شد\nیوزرنیم ربات: = @"..bot.username.."\nنام ربات: = "..bot.first_name.."\nایدی ربات: = "..bot.id.."\nسازنده: @Xx_PesareShield_shah2Arvah_xX\n@Xx_KinG_SuPeR_AdMiN_SHIELD_xX" 

   print(bot_info) 

   last_update = last_update or 0 

   is_running = true 

   currect_folder = "" 
end 

function msg_processor(msg)
if msg then
   if msg.new_chat_participant or msg.new_chat_title or msg.new_chat_photo or msg.left_chat_participant then return end 
   if msg.audio or msg.document or msg.video or msg.voice then return end -- Admins only ! 
   if msg.date < os.time() - 5 then -- Ignore old msgs 
      return 
    end 

  if msg.photo then 
   local matches = { (msg.photo) } 
   file = msg.photo[3].file_id 
   local url = BASE_URL .. '/getFile?file_id='..file 
   local res = HTTPS.request(url) 
   local jres = JSON.decode(res) 
   filename = "photo.jpg" 
   file = download_to_file("https://api.telegram.org/file/bot"..bot_api_key.."/"..jres.result.file_path, filename) 
local caption = [[slm]]
   sendSticker(msg.chat.id, file,caption) 

  elseif msg.sticker then
  local matches = { (msg.sticker) }
 file = msg.sticker.file_id
 local url = BASE_URL .. '/getFile?file_id='..file
 local res = HTTPS.request(url)
 local jres = JSON.decode(res)
 filename = "@SHIELD_robot.png"
file = download_to_file("https://api.telegram.org/file/bot"..bot_api_key.."/"..jres.result.file_path, filename)
 local caption = [[
🆔 Bot Channel : @shield_tm
➕➕➕➕➕➕➕➕➕➕➕
فایل زیر در استیکر ساز رسمی تلگرام قابل استفاده است⬇
➖➖➖➖➖➖➖➖➖➖➖
file under the sticker official telegram usable building⬇️️]]
 sendPhoto(msg.chat.id, file,caption)
sendDocument(msg.chat.id, file,caption)

  if msg.text then return end 

  elseif msg.text:match("^/bold (.*)") then 
   local matches = { string.match(msg.text, "^/bold (.*)") } 
   local text = '*'..matches[1]..'*' 
  sendMessage(msg.chat.id, text, true, false, true) 

  elseif msg.text:match("^/boldch (.*) (.*)") then 
   local matches = { string.match(msg.text, "^/boldch (.*) (.*)") } 
   local text = '*'..matches[2]..'*' 
   local channel = matches[1] 
   sendMessage(channel, text, true, false, true) 

  elseif msg.text:match("^/italic (.*)") then 
   local matches = { string.match(msg.text, "^/italic (.*)") } 
   local text = '_'..matches[1]..'_' 
   sendMessage(msg.chat.id, text, true, false, true) 

 elseif msg.text:match("^/italicch (.*) (.*)") then 
   local matches = { string.match(msg.text, "^/italicch (.*) (.*)") } 
   local text = '_'..matches[2]..'_' 
   local channel = matches[1] 
   sendMessage(channel, text, true, false, true) 

 elseif msg.text:match("^/link (.*) (.*)") then 
 local matches = { string.match(msg.text, "^/link (.*) (.*)") } 
 local text = '['..matches[2]..']('..matches[1]..')' 
 sendMessage(msg.chat.id, text, true, false, true) 

elseif msg.text:match("^/linkch (.*) (.*) (.*)") then 
 local matches = { string.match(msg.text, "^/linkch (.*) (.*) (.*)") } 
 local text = '['..matches[3]..']('..matches[2]..')' 
 local channel = matches[1] 
 sendMessage(channel, text, true, false, true) 

 elseif msg.text:match("^/code (.*)") then 
 local matches = { string.match(msg.text, "^/code (.*)") } 
 local text = '`'..matches[1]..'`' 
 sendMessage(msg.chat.id, text, true, false, true) 

 elseif msg.text:match("^/codech (.*) (.*)") then 
 local matches = { string.match(msg.text, "^/codech (.*) (.*)") } 
 local text = '`'..matches[2]..'`' 
 local channel = matches[1] 
 sendMessage(channel, text, true, false, true) 

elseif msg.text:match("^/[sS]tart") or msg.text:match("^/[Hh]elp") then 
 sendMessage(msg.chat.id, start, true, false, true) 

return end 

end 
end
bot_run()
while is_running do 
	local response = getUpdates(last_update+1) 
	if response then
		for i,v in ipairs(response.result) do
			last_update = v.update_id
			msg_processor(v.message)
		end
	else
		print("Crashed: @Xx_PesareShield_shah2Arvah_xX & @Xx_KinG_SuPeR_AdMiN_SHIELD_xX")
	end
end
print("Crashed: @Xx_PesareShield_shah2Arvah_xX & @Xx_KinG_SuPeR_AdMiN_SHIELD_xX")

-- creator HIDDEN BOY
-- channel @shield_tm
