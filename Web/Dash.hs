{-# OPTIONS_GHC -XCPP -XMultiParamTypeClasses -XTypeSynonymInstances #-}
--------------------------------------------------------------------
-- |
-- Module    : Web.Dash
-- Copyright : (c) 2009 Bruce Williams, Adam Keys
-- License   : BSD3
--
-- Maintainer:  Bruce Williams <bruce@codefluency.com>, Adam Keys <adam@therealadam.com>
-- Stability :  provisional
-- Portability: portable
--
--------------------------------------------------------------------
--
-- Provides an API for Haskell applications to the FiveRuns Dash service,
-- http://dash.fiveruns.com
--
module Web.Dash (fetch, fetch') where
  import Web.Dash.Fetch