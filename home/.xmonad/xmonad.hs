import XMonad
import Control.Monad (liftM2)
import XMonad.Layout.Tabbed
import XMonad.Util.Themes
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run (runInTerm)
import XMonad.Hooks.ManageHelpers 
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Fullscreen
import qualified XMonad.StackSet as W

main = do
  config <- buildConfig
  xmonad config

buildConfig = statusBar "xmobar" myPP toggleStrutsKey myConfig
  where
    myPP = xmobarPP {
        ppCurrent = xmobarColor "yellow" "" . wrap "[" "]",
        ppHiddenNoWindows = xmobarColor "grey" "",
        ppTitle = xmobarColor "green"  "" . shorten 120,
        ppVisible = wrap "(" ")",
        ppUrgent = xmobarColor "red" "yellow"
      }
    toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig {
    modMask = mod4Mask,
    workspaces = myWorkspaces,
    handleEventHook = myEventHook,
    layoutHook = myLayouts,
    manageHook = myManageHook,
    focusedBorderColor = "#00FFFF",
    normalBorderColor = "#000000"
  }
  `additionalKeysP` myKeys

myWorkspaces = clickable . (map xmobarEscape) $ workspaces
  where
    workspaces = ["✣", "⚙", "★", "4", "5", "6", "7", "8", "✉", "☺"]
    clickable list = [
        "<action=xdotool key super+" ++ show (i) ++ ">" ++ ws ++ "</action>" |
          (i, ws) <- zip "1234567890" list
      ]
    xmobarEscape = concatMap doubleLts
      where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myEventHook = composeAll [
    fullscreenEventHook,
    docksEventHook
  ] 

myLayouts = avoidStruts $ tall ||| myTabbed
  where
    tall = smartBorders $ Tall 1 (3/100) (1/2)
    myTabbed = renamed [Replace "Tabbed"] . fullscreenFull . noBorders $
      tabbed shrinkText myTheme
    myTheme = (theme kavonPeacockTheme) {
      fontName = "xft:Deja Vu Mono:size=10:antialias=true:hinting=true"
    }
 
myManageHook = composeAll [
    className =? "Transmission-gtk" --> doFloat,
    manageDocks,
    fullscreenManageHook,
    manageHook defaultConfig
  ]

myKeys = [
    ("<XF86Sleep>", spawn "/home/julian/.local/bin/screen-lock.sh"),
    ("<XF86HomePage>", spawn "sensible-browser"),
    ("<XF86Mail>", spawn "xdg-open https://mail.google.com"),
    ("<XF86Calculator>", runInTerm "" "python" ),
    ("<XF86AudioMute>", spawn "amixer -qD pulse set Master 1+ toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer -qD pulse set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -qD pulse set Master 5%+ unmute"),
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock.sh")
  ] ++ [
    ("M-" ++ modMasks ++ [key], action tag) |
      (tag, key)  <- zip myWorkspaces "1234567890",
      (modMasks, action) <- [("", windows . W.view), ("S-", windows . W.shift)]
  ]
