import XMonad
import Control.Monad (liftM2)
import XMonad.Layout.Tabbed
import XMonad.Util.Themes
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.ManageHelpers 
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Fullscreen
import qualified XMonad.StackSet as W

main = xmonad =<< xmobar myConfig

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

myKeys =
  [
    ("<XF86Sleep>", spawn "/home/julian/.local/bin/screen-lock.sh"),
    ("<XF86HomePage>", spawn "sensible-browser"),
    ("<XF86Mail>", spawn "xdg-open https://mail.google.com"),
    ("<XF86Calculator>", runInTerm "" "python" ),
    ("<XF86AudioMute>", spawn "amixer -qD pulse set Master 1+ toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer -qD pulse set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -qD pulse set Master 5%+ unmute"),
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock.sh"),
    ("M-0", windows $ W.greedyView "0"),
    ("M-S-0", windows $ W.shift "0")
  ]

myLayouts = tall ||| myTabbed
  where
    tall = smartBorders $ Tall 1 (3/100) (1/2)
    myTabbed = renamed [Replace "Tabbed" ] . fullscreenFull . noBorders $ tabbed shrinkText myTheme
    myTheme = (theme kavonPeacockTheme) {
      fontName = "xft:Deja Vu Mono:size=10:antialias=true:hinting=true"
    }

myManageHook = composeAll
  [
    className =? "Transmission-gtk"  --> doFloat,
    className =? "chromium-browser" --> viewShift "3",
    manageDocks,
    fullscreenManageHook,
    manageHook defaultConfig
  ]
  where viewShift = doF . liftM2 (.) W.view W.shift

myEventHook = composeAll
  [
    fullscreenEventHook,
    docksEventHook
  ]

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
