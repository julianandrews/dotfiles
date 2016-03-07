{-# LANGUAGE FlexibleContexts #-}
module StatusBar (addStatusBarAction, addStatusBar) where

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (AvoidStruts)
import XMonad.Layout.LayoutModifier (ModifiedLayout(..))

import Solarized

addStatusBarAction :: String -> String -> String
addStatusBarAction action = wrap ("<action=" ++ action ++ ">") "</action>"

addStatusBar :: LayoutClass l Window => XConfig l -> IO (XConfig (ModifiedLayout AvoidStruts l))
addStatusBar = statusBar "xmobar" myPP toggleStrutsKey
  where
    myPP = xmobarPP {
        ppCurrent = xmobarColor solarizedMagenta "",
        ppHiddenNoWindows = const "",
        ppTitle = xmobarColor solarizedCyan "" . shorten 80,
        ppVisible = xmobarColor solarizedYellow "",
        ppLayout = xmobarColor solarizedYellow "" . addStatusBarAction "xdotool key super+space",
        ppUrgent = xmobarColor solarizedRed ""
      }
    toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
