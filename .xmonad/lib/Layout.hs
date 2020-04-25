module Layout (myHorizontal, myVertical, myTabbed) where

import XMonad
import XMonad.Layout (Tall, Mirror)
import XMonad.Layout.Decoration (Theme(..), def, Decoration, DefaultShrinker)
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Tabbed (TabbedDecoration, tabbed, shrinkText)
import XMonad.Util.Themes (ThemeInfo(..))

import Solarized

import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Simplest (Simplest)
import qualified XMonad.StackSet as W

solarizedTheme :: ThemeInfo
solarizedTheme = TI "Solarized Theme" "Julian Andrews" "Theme using Solarized's colors" (
  def {
      fontName            = "xft:Deja Vu Mono:size=10.5",
      activeColor         = solarizedCyan,
      activeBorderColor   = solarizedBase03,
      activeTextColor     = solarizedBase03,
      inactiveColor       = solarizedBase02,
      inactiveBorderColor = solarizedBase03,
      inactiveTextColor   = solarizedBase00,
      urgentColor         = solarizedRed,
      decoHeight          = 27
    }
  )

type BaseTabbed = ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest

baseTabbed :: (Eq a, Read a) => BaseTabbed a
baseTabbed = tabbed shrinkText (theme solarizedTheme)

myHorizontal = renamed [Replace "Horizontal"] $ Tall 1 (3/100) (3/5)
myVertical = renamed [Replace "Vertical"] $ Mirror myHorizontal
myTabbed :: (Eq a, Read a) => ModifiedLayout Rename BaseTabbed a
myTabbed = renamed [Replace "Tabbed"] baseTabbed
