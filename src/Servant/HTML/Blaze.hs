{-# LANGUAGE CPP                   #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}

-- | An @HTML@ empty data type with `MimeRender` instances for @blaze-html@'s
-- `ToMarkup` class and `Html` datatype.
-- You should only need to import this module for its instances and the
-- `HTML` datatype:
--
-- >>> type Eg = Get '[HTML] a
--
-- Will then check that @a@ has a `ToMarkup` instance, or is `Html`.
module Servant.HTML.Blaze where

import           Data.Typeable                 (Typeable)
import qualified Network.HTTP.Media            as M
import           Servant.API                   (Accept (..), MimeRender (..))
import           Text.Blaze.Html               (Html, ToMarkup, toHtml)
import           Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import qualified Data.List.NonEmpty            as NE

data HTML deriving Typeable

-- | @text/html;charset=utf-8@
instance Accept HTML where
    contentTypes _ =
      "text" M.// "html" M./: ("charset", "utf-8") NE.:|
      ["text" M.// "html"]

instance ToMarkup a => MimeRender HTML a where
    mimeRender _ = renderHtml . toHtml
