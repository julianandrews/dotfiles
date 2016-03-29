import Data.List (isPrefixOf)

import XMonad
import XMonad.Actions.CycleWS (nextScreen, swapNextScreen, prevScreen, swapPrevScreen)
import XMonad.Hooks.ManageDocks (manageDocks, docksEventHook)
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Layout.Fullscreen (fullscreenManageHook)
import XMonad.Layout.LayoutBuilder (IncLayoutN(..))
import XMonad.Layout.NoBorders (lessBorders, Ambiguity(OtherIndicated))
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)

import qualified XMonad.StackSet as W

import Layout
import Solarized
import StatusBar

main = do
  config <- addStatusBar . ewmh $ myConfig
  xmonad config

myConfig = defaultConfig {
    modMask = mod4Mask,
    workspaces = myWorkspaces,
    handleEventHook = myEventHook,
    layoutHook = lessBorders OtherIndicated $ myLayout,
    manageHook = myManageHook,
    focusedBorderColor = solarizedYellow,
    normalBorderColor = solarizedBase02,
    borderWidth = 2
  }
  `additionalKeysP` myKeys

myWorkspaceKeys :: String
myWorkspaceKeys = "1234567890"

myWorkspaces :: [String]
myWorkspaces = clickable . map xmobarEscape $ workspaces
  where
    workspaces = ["1", "2", "★", "4", "5", "6", "7", "8", "✉", "☺"]
    clickable = zipWith (addStatusBarAction . ("xdotool key super+" ++) . show) myWorkspaceKeys
    xmobarEscape = concatMap escapeLT
    escapeLT '<' = "<<"
    escapeLT c = [c]

myEventHook = composeAll [
    fullscreenEventHook,
    docksEventHook
  ]

myLayout = renamed [Replace "Horizontal"] horizontalTabbed |||
           renamed [Replace "Vertical"] verticalTabbed |||
           renamed [Replace "Tabbed"] myTabbed

myManageHook = composeAll [
    role =? "gimp-image-window" --> (ask >>= doF . W.sink),
    fmap (isPrefixOf "Gimp-") className --> doFloat,
    className =? "Transmission-gtk" --> doFloat,
    fmap (isPrefixOf "Sgt-") className --> doFloat,
    manageDocks,
    fullscreenManageHook,
    manageHook defaultConfig
  ]
  where role = stringProperty "WM_WINDOW_ROLE"

myKeys = [
    ("<XF86Sleep>", spawn "systemctl suspend"),
    ("<XF86HomePage>", spawn "sensible-browser"),
    ("<XF86Mail>", spawn "sensible-browser https://mail.google.com"),
    ("<XF86Calculator>", runInTerm "" "python" ),
    ("<XF86AudioMute>", spawn "amixer -qD pulse set Master 1+ toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer -qD pulse set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -qD pulse set Master 5%+ unmute"),
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock"),
    ("M-,", sendMessage $ IncLayoutN (-1)),
    ("M-.", sendMessage $ IncLayoutN 1),
    ("M-w", prevScreen),
    ("M-e", nextScreen),
    ("M-S-w", swapPrevScreen),
    ("M-S-e", swapNextScreen)
  ] ++ [
    ("M-" ++ modMasks ++ [key], action tag) |
      (tag, key)  <- zip myWorkspaces myWorkspaceKeys,
      (modMasks, action) <- [
          ("", windows . W.greedyView),
          ("S-", windows . W.shift)
        ]
  ]
