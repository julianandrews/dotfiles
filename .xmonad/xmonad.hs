import Data.List (isPrefixOf)

import XMonad
import XMonad.Actions.PhysicalScreens (onNextNeighbour, onPrevNeighbour)
import XMonad.Hooks.ManageDocks (manageDocks, docksEventHook)
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageHelpers ((-?>), composeOne, isDialog)
import XMonad.Layout.LayoutBuilder (IncLayoutN(..))
import XMonad.Layout.NoBorders (lessBorders, Ambiguity(OnlyLayoutFloat))
import XMonad.Util.EZConfig (additionalKeysP)
import Data.Default (def)

import qualified XMonad.StackSet as W

import Layout
import Solarized
import StatusBar

main = do
  config <- addStatusBar . ewmh $ myConfig
  xmonad config

myConfig = defaultConfig {
    modMask = mod4Mask,
    terminal = "urxvt",
    workspaces = myWorkspaces,
    handleEventHook = myEventHook,
    layoutHook = lessBorders OnlyLayoutFloat myLayout,
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
    composeOne [
        isDialog -?> doFloat,
        fmap (isPrefixOf "Sgt-") className -?> doFloat
    ],
    manageDocks
  ]

myKeys = [
    ("M-S-z", spawn "xautolock -locknow"),
    ("M-w", onPrevNeighbour def W.view),
    ("M-e", onNextNeighbour def W.view),
    ("M-S-w", onPrevNeighbour def W.shift),
    ("M-S-e", onNextNeighbour def W.shift)
  ] ++ [
    ("M-" ++ modMasks ++ [key], action tag) |
      (tag, key)  <- zip myWorkspaces myWorkspaceKeys,
      (modMasks, action) <- [
          ("", windows . W.greedyView),
          ("S-", windows . W.shift)
        ]
  ]
