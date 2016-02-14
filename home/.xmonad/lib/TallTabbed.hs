module TallTabbed (
    horizontal,
    vertical
  ) where

import XMonad
import XMonad.Layout.LayoutBuilder (layoutN, layoutAll, relBox)
import XMonad.Layout.Tabbed (simpleTabbed)
import qualified XMonad.StackSet as W

horizontal baseLayout n1 n2 r1 r2 = 
  layoutN n1 (relBox 0 0 r1 1) (Just $ relBox 0 0 1 1) baseLayout
  $ layoutN n2 (relBox r1 0 1 r2) (Just $ relBox r1 0 1 1) baseLayout
  $ layoutAll (relBox r1 r2 1 1) baseLayout

vertical baseLayout n1 n2 r1 r2 = 
  layoutN n1 (relBox 0 0 1 r1) (Just $ relBox 0 0 1 1) baseLayout
  $ layoutN n2 (relBox 0 r1 r2 1) (Just $ relBox 0 r1 1 1) baseLayout
  $ layoutAll (relBox r2 r1 1 1) baseLayout
