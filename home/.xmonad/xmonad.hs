import Control.Monad (liftM2)

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (manageDocks, docksEventHook, avoidStruts)
import XMonad.StackSet (view, shift)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)
import XMonad.Util.Themes (theme, kavonPeacockTheme)
import XMonad.Layout.Tabbed (tabbed, shrinkText, fontName)
import XMonad.Layout.LayoutBuilder (layoutN, layoutAll, relBox)
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Fullscreen (
    fullscreenFull, fullscreenEventHook, fullscreenManageHook
  )

main = do
  config <- buildConfig
  xmonad config

buildConfig = statusBar "xmobar" myPP toggleStrutsKey myConfig
  where
    myPP = xmobarPP {
        ppCurrent = xmobarColor "yellow" "" . wrap "[" "]",
        ppHiddenNoWindows = \workspaceId -> "",
        ppTitle = xmobarColor "green"  "" . shorten 120,
        ppVisible = wrap "(" ")",
        ppLayout = \layout -> "<action=xdotool key super+space>" ++ layout ++ "</action>",
        ppUrgent = xmobarColor "red" "yellow"
      }
    toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig {
    modMask = mod4Mask,
    workspaces = myWorkspaces,
    handleEventHook = myEventHook,
    layoutHook = myLayout,
    manageHook = myManageHook,
    focusedBorderColor = "#00FFFF",
    normalBorderColor = "#000000"
  }
  `additionalKeysP` myKeys

myWorkspaces = clickable . (map xmobarEscape) $ workspaces
  where
    workspaces = ["✣", "⚙", "★", "4", "5", "6", "7", "8", "✉", "☺"]
    clickable list = [
        "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>" |
          (i, ws) <- zip "1234567890" list
      ]
    xmobarEscape = concatMap $ \char -> case char of
      '<' -> "<<"
      _ -> [char]

myEventHook = composeAll [
    fullscreenEventHook,
    docksEventHook
  ] 

myLayout = avoidStruts $ myMain ||| (noBorders myTabbed)
  where
    myTabbed = renamed [Replace "Tabbed"] . fullscreenFull
      $ tabbed shrinkText myTheme
    myTheme = (theme kavonPeacockTheme) {
        fontName = "xft:Deja Vu Mono:size=10:antialias=true:hinting=true"
      }
    myMain  = 
      renamed [Replace "Main"] . smartBorders
        $ layoutN 1 (relBox 0 0 (3/5) 1) (Just $ relBox 0 0 1 1) Full
        $ layoutN 1 (relBox (3/5) 0 1 (1/2)) (Just $ relBox (3/5) 0 1 1) Full 
        $ layoutAll (relBox (3/5) (1/2) 1 1) myTabbed

myManageHook = composeAll [
    className =? "Transmission-gtk" --> doFloat,
    manageDocks,
    fullscreenManageHook,
    manageHook defaultConfig
  ]

myKeys = [
    ("<XF86Sleep>", spawn "systemctl suspend"),
    ("<XF86HomePage>", spawn "sensible-browser"),
    ("<XF86Mail>", spawn "sensible-browser https://mail.google.com"),
    ("<XF86Calculator>", runInTerm "" "python" ),
    ("<XF86AudioMute>", spawn "amixer -qD pulse set Master 1+ toggle"),
    ("<XF86AudioLowerVolume>", spawn "amixer -qD pulse set Master 5%- unmute"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -qD pulse set Master 5%+ unmute"),
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock.sh")
  ] ++ [
    ("M-" ++ modMasks ++ [key], action tag) |
      (tag, key)  <- zip myWorkspaces "1234567890",
      (modMasks, action) <- [
          ("", windows . view),
          ("S-", windows . shift)
        ]
  ]
