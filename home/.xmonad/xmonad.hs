import Data.List (isPrefixOf)

import XMonad
import XMonad.Actions.PhysicalScreens (onNextNeighbour, onPrevNeighbour)
import XMonad.Hooks.ManageDocks (manageDocks, docksEventHook)
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Layout.Fullscreen (fullscreenManageHook)
import XMonad.Layout.LayoutBuilder (IncLayoutN(..))
import XMonad.Layout.NoBorders (lessBorders, Ambiguity(OtherIndicated))
import XMonad.Util.EZConfig (additionalKeysP)

import qualified XMonad.StackSet as W

import Layout
import Solarized
import StatusBar

main = do
  config <- addStatusBar . ewmh $ myConfig
  xmonad config

myConfig = defaultConfig {
    modMask = mod4Mask,
    terminal = "urxvtc",
    workspaces = myWorkspaces,
    handleEventHook = myEventHook,
    layoutHook = lessBorders OtherIndicated myLayout,
    manageHook = myManageHook,
    startupHook = myStartupHook,
    focusedBorderColor = solarizedYellow,
    normalBorderColor = solarizedBase02,
    borderWidth = 2
  }
  `additionalKeysP` myKeys

myStartupHook = do
  spawn "/home/julian/.config/xmobar/volume.sh"
  spawn "/home/julian/.config/xmobar/gmail-status.sh"

myWorkspaceKeys :: String
myWorkspaceKeys = "1234567890"

myWorkspaces :: [String]
myWorkspaces = clickable . map xmobarEscape $ workspaces
  where
    workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    clickable = zipWith (addStatusBarAction . ("xdotool key super+" ++) . show) myWorkspaceKeys
    xmobarEscape = concatMap escapeLT
    escapeLT '<' = "<<"
    escapeLT c = [c]

myEventHook = composeAll [
    fullscreenEventHook,
    docksEventHook
  ]

myLayout = myHorizontal ||| myVertical ||| myTabbed

myManageHook = composeAll [
    windowRole =? "gimp-image-window" --> (ask >>= doF . W.sink),
    fmap (isPrefixOf "Gimp-") className --> doFloat,
    className =? "Transmission-gtk" --> doFloat,
    fmap (isPrefixOf "Sgt-") className --> doFloat,
    manageDocks,
    fullscreenManageHook,
    manageHook defaultConfig
  ]
  where windowRole = stringProperty "WM_WINDOW_ROLE"

myKeys = [
    ("<XF86Sleep>", spawn "systemctl suspend"),
    ("<XF86HomePage>", spawn "sensible-browser"),
    ("<XF86Mail>", spawn "sensible-browser https://mail.google.com"),
    ("<XF86AudioMute>", spawn "amixer -qD pulse set Master 1+ toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer -qD pulse set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -qD pulse set Master 5%+ unmute"),
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock"),
    ("M-,", sendMessage $ IncLayoutN (-1)),
    ("M-.", sendMessage $ IncLayoutN 1),
    ("M-w", onPrevNeighbour W.view),
    ("M-e", onNextNeighbour W.view),
    ("M-S-w", onPrevNeighbour W.shift),
    ("M-S-e", onNextNeighbour W.shift)
  ] ++ [
    ("M-" ++ modMasks ++ [key], action tag) |
      (tag, key)  <- zip myWorkspaces myWorkspaceKeys,
      (modMasks, action) <- [
          ("", windows . W.greedyView),
          ("S-", windows . W.shift)
        ]
  ]
