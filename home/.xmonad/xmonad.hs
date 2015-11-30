import XMonad
import Control.Monad (liftM2)
import XMonad.Layout.Tabbed
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)
import XMonad.Hooks.DynamicLog (xmobar)
import qualified XMonad.StackSet as W

main = xmonad =<< xmobar myConfig

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myKeys =
  [
    ("<XF86Sleep>", spawn "/home/julian/.local/bin/screen-lock.sh"),
    ("<XF86HomePage>", spawn "sensible-browser"),
    ("<XF86Mail>", spawn "xdg-open https://mail.google.com"),
    ("<XF86Calculator>", runInTerm "" "python" ),
    ("<XF86AudioMute>", spawn "amixer -qD pulse set Master 1+ toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer -qD pulse set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -qD pulse set Master 5%+ unmute"),
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock.sh")
  ] ++ 
  [
   (otherModMasks ++ "M-" ++ [key], action tag)
      | (tag, key)  <- zip myWorkspaces "123456789"
      , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                                      , ("S-", windows . W.shift)] 
  ]

myLayouts = tall ||| simpleTabbed
  where
    tall = Tall 1 (3/100) (1/2)

myManageHook = composeAll
  [
    className =? "Transmission-gtk"  --> doFloat,
    className =? "chromium-browser" --> viewShift "3",
    manageDocks
  ]
  where viewShift = doF . liftM2 (.) W.greedyView W.shift

myConfig = defaultConfig {
    modMask = mod4Mask,
    workspaces = myWorkspaces,
    layoutHook = myLayouts,
    manageHook = myManageHook <+> manageHook defaultConfig,
    focusedBorderColor = "#00FFFF",
    normalBorderColor = "#000000"
  }
  `additionalKeysP` myKeys
