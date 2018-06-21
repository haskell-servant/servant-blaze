# servant-blaze - Blaze-html support for servant

![servant](https://raw.githubusercontent.com/haskell-servant/servant/master/servant.png)

This package allows you to use [blaze-html](http://hackage.haskell.org/package/blaze-html-0.8.0.0/docs/Text-Blaze-Html5.html) to serve html pages in your servant APIs. More specifically, it exports a `HTML` datatype with the correct `MimeRender` instances so that you can write `type API = Get '[HTML] User` for example.

## Minimal example:

```haskell
{-# LANGUAGE OverloadedStrings, DataKinds #-}

module Test where

import           Servant
import           Servant.HTML.Blaze
import qualified Text.Blaze.Html5   as H

type API = Get '[HTML] Homepage
type Homepage = H.Html

server :: Server API
server = return myHome

myHome :: Homepage
myHome = H.docTypeHtml $ do
    H.head $ do
             H.title "Live to serve"
    H.body $ do
             H.h1 "Templates!"
             H.p "This will be type-checked, rendered and served"
```
