{-# LANGUAGE FlexibleContexts, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances, PatternGuards, DeriveDataTypeable #-}

module CornerTabbed (
    CornerTabbed(..)
  ) where

import XMonad
import XMonad.Layout.Tabbed
import XMonad.Layout.LayoutBuilder
import qualified XMonad.StackSet as W

data CornerTabbed a = CornerTabbed {
    nFirst :: !Int,
    nSecond :: !Int,
    ratio :: !Rational,
    ratioIncrement :: !Rational
  } deriving (Show, Read)

instance LayoutClass (CornerTabbed n1 n2 r i) a where
  runLayout (W.Workspace wId l@(CornerTabbed n1 n2 r i) ms) = 
    return . runLayout (W.Workspace wId l' ms)
      where l' = buildLayout n1 n2 r

  handleMessage (CornerTabbed n1 n2 i r) = handleMessage l'
    where l' = buildLayout n1 n2 r
  
buildLayout nFirst nSecond ratio = 
  layoutN nFirst (relBox 0 0 ratio 1) (Just $ relBox 0 0 1 1) 
  $ layoutN nSecond (relBox ratio 0 1 (1/2)) (Just $ relBox ratio 0 1 1) Full 
  $ layoutAll (relBox ratio (1/2) 1 1) simpleTabbed
