{-# LANGUAGE DeriveDataTypeable #-}
import Control.Monad (liftM2)
import Data.List (isPrefixOf)

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (manageDocks, docksEventHook, avoidStruts)
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runInTerm)
import XMonad.Util.Themes
import XMonad.Layout.Decoration
import XMonad.Actions.CycleWS (nextScreen,  swapNextScreen, prevScreen, swapPrevScreen)
import XMonad.Layout.Tabbed (tabbed, shrinkText, fontName)
import XMonad.Layout.LayoutBuilder (layoutN, layoutAll, relBox, IncLayoutN(..))
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Fullscreen (
    fullscreenFull, fullscreenEventHook, fullscreenManageHook
  )
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

main = do
  config <- buildConfig
  xmonad config

buildConfig = statusBar "xmobar" myPP toggleStrutsKey myConfig
  where
    myPP = xmobarPP {
        ppCurrent = xmobarColor "yellow" "" . wrap "[" "]",
        ppHiddenNoWindows = \workspaceId -> "",
        ppTitle = xmobarColor "#FF00FF"  "" . shorten 120,
        ppVisible = wrap "(" ")",
        ppLayout = \layout -> xmobarColor "#FF9000" "" $ "<action=xdotool key super+space>" ++ layout ++ "</action>",
        ppUrgent = xmobarColor "red" "yellow"
      }
    toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig {
    modMask = mod4Mask,
    workspaces = myWorkspaces,
    handleEventHook = myEventHook,
    layoutHook = myLayout,
    manageHook = myManageHook,
    focusedBorderColor = unfocusedColor,
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

purpleTheme :: ThemeInfo
purpleTheme =
    (TI "" "" "" defaultTheme) {
        themeName = "Purple Theme",
        themeAuthor = "Julian Andrews",
        themeDescription = "Pleasant purple theme",
        theme = defaultTheme {
            fontName = "xft:Deja Vu Mono:size=10:antialias=true:hinting=true",
            activeColor         = focusedColor,
            activeBorderColor   = focusedColor,
            activeTextColor     = "#FFFFFF",
            inactiveColor       = unfocusedColor,
            inactiveBorderColor = unfocusedColor,
            inactiveTextColor   = "#222222"
          }
      }

focusedColor = "#81206D"
unfocusedColor = "#51A39D"

myLayout = myHorizontal ||| myVertical ||| myFullscreenTabbed
  where
    myTabbed = tabbed shrinkText (theme purpleTheme)
    myFullscreenTabbed = noBorders . renamed [Replace "Tabbed"] . fullscreenFull
      $ myTabbed
    myHorizontal = 
      renamed [Replace "Horizontal"] . smartBorders
        $ layoutN 1 (relBox 0 0 (3/5) 1) (Just $ relBox 0 0 1 1) myTabbed
        $ layoutN 1 (relBox (3/5) 0 1 (1/2)) (Just $ relBox (3/5) 0 1 1) myTabbed
        $ layoutAll (relBox (3/5) (1/2) 1 1) myTabbed
    myVertical =
      renamed [Replace "Vertical"] . smartBorders
        $ layoutN 1 (relBox 0 0 1 (3/5)) (Just $ relBox 0 0 1 1) myTabbed
        $ layoutN 1 (relBox 0 (3/5) (1/2) 1) (Just $ relBox 0 (3/5) 1 1) myTabbed
        $ layoutAll (relBox (1/2) (3/5) 1 1) myTabbed
        

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
    ("M-S-z", spawn "/home/julian/.local/bin/screen-lock.sh"),
    ("M-,", sendMessage $ IncLayoutN (-1)),
    ("M-.", sendMessage $ IncLayoutN 1),
    ("M-w", prevScreen),
    ("M-e", nextScreen),
    ("M-S-w", swapPrevScreen),
    ("M-S-e", swapNextScreen),
    ("M-x", sendMessage $ Toggle MIRROR)
  ] ++ [
    ("M-" ++ modMasks ++ [key], action tag) |
      (tag, key)  <- zip myWorkspaces "1234567890",
      (modMasks, action) <- [
          ("", windows . W.greedyView),
          ("S-", windows . W.shift)
        ]
  ]
