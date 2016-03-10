module Layout (myTabbed, horizontalTabbed, verticalTabbed) where

import XMonad
import XMonad.Layout.Decoration (Theme(..), defaultTheme, Decoration, DefaultShrinker)
import XMonad.Layout.LayoutBuilder (LayoutN(..), layoutN, layoutAll, relBox)
import XMonad.Layout.Tabbed (TabbedDecoration, tabbed, shrinkText)
import XMonad.Util.Themes (ThemeInfo(..))

import Solarized

import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Simplest (Simplest)
import qualified XMonad.StackSet as W

solarizedTheme :: ThemeInfo
solarizedTheme = TI "Solarized Theme" "Julian Andrews" "Theme using Solarized's colors" (
  defaultTheme {
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

horizontal :: (Eq a, Read a, Show a, Typeable a, LayoutClass l a) =>
  l a -> Int -> Int -> Rational -> Rational -> LayoutN l (LayoutN l (LayoutN l Full)) a
horizontal baseLayout n1 n2 r1 r2 =
  layoutN n1 (relBox 0 0 r1 1) (Just $ relBox 0 0 1 1) baseLayout
  $ layoutN n2 (relBox r1 0 1 r2) (Just $ relBox r1 0 1 1) baseLayout
  $ layoutAll (relBox r1 r2 1 1) baseLayout

vertical :: (Eq a, Read a, Show a, Typeable a, LayoutClass l a) =>
  l a -> Int -> Int -> Rational -> Rational -> LayoutN l (LayoutN l (LayoutN l Full)) a
vertical baseLayout n1 n2 r1 r2 =
  layoutN n1 (relBox 0 0 1 r1) (Just $ relBox 0 0 1 1) baseLayout
  $ layoutN n2 (relBox 0 r1 r2 1) (Just $ relBox 0 r1 1 1) baseLayout
  $ layoutAll (relBox r2 r1 1 1) baseLayout

type MyTabbed = ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest
type MixedTabbed = LayoutN MyTabbed (LayoutN MyTabbed (LayoutN MyTabbed Full))

myTabbed :: (Eq a, Read a) => MyTabbed a
myTabbed = tabbed shrinkText (theme solarizedTheme)

horizontalTabbed :: MixedTabbed Window
horizontalTabbed = horizontal myTabbed 1 1 (3/5) (1/2)

verticalTabbed :: MixedTabbed Window
verticalTabbed = vertical myTabbed 1 1 (3/5) (1/2)
