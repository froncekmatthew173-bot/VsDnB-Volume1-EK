
local ffi = require'ffi'
local shell32 = ffi.load'shell32'

ffi.cdef[[
typedef int BOOL;
typedef unsigned int DWORD;
typedef unsigned int UINT;
typedef intptr_t HANDLE;
typedef intptr_t HWND;
typedef intptr_t HICON;
typedef intptr_t HINSTANCE;
typedef struct {int Data[4];} GUID;

typedef struct {
  DWORD cbSize;
  HWND  hWnd;
  UINT  uID;
  UINT  uFlags;
  UINT  uCallbackMessage;
  HICON hIcon;
  char  szTip[128];
  DWORD dwState;
  DWORD dwStateMask;
  char  szInfo[256];
  union {
    UINT uTimeout;
    UINT uVersion;
  };
  char  szInfoTitle[64];
  DWORD dwInfoFlags;
  GUID  guidItem;
  HICON hBalloonIcon;
} NOTIFYICONDATAA;

BOOL Shell_NotifyIconA(
  int dwMessage,
  NOTIFYICONDATAA * lpData
);
HICON LoadIconA(
  HINSTANCE hInstance,
  intptr_t IconCode
);
BOOL DestroyIcon(
  HICON hIcon
);
HWND GetConsoleWindow();
]]



function onStepHit()
if curStep == 1435 then
    sendNotification("expunged.dat has Requested admin access", "EXPUNGED.DAT")
end
end

local elapsedTime = 0

function onUpdatePost(elapsed)
	elapsedTime = elapsedTime + elapsed
	setCharacterY("dad", defaultOpponentY + (250 * math.sin(elapsedTime)))
	setCharacterX("dad", defaultOpponentX + (50 * math.cos(elapsedTime)))
end

local tray_icon_code    = 32513  
local balloon_icon_code = 32518   

local tray_icon_handle = ffi.C.LoadIconA(0, tray_icon_code)
local balloon_icon_handle = ffi.C.LoadIconA(0, balloon_icon_code)
local notify_icon_data = ffi.new"NOTIFYICONDATAA"
notify_icon_data.cbSize = ffi.sizeof(notify_icon_data)
notify_icon_data.uFlags = 1 + 2 
notify_icon_data.uVersion = 4
shell32.Shell_NotifyIconA(0, notify_icon_data)  
shell32.Shell_NotifyIconA(4, notify_icon_data) 


local function copy_string(dest_array_ptr, str)
    ffi.copy(dest_array_ptr, (str or ""):sub(1, ffi.sizeof(dest_array_ptr) - 1))
end

local function show_notification(text, title)
    notify_icon_data.uFlags = 1 + 2 + 16  
    notify_icon_data.dwInfoFlags = 4 + 32  
    copy_string(notify_icon_data.szInfoTitle, title)
    copy_string(notify_icon_data.szInfo, text)
    shell32.Shell_NotifyIconA(1, notify_icon_data)
end
function sendNotification(chat, title)
show_notification(chat, title)
end