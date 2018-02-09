{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TypeOperators   #-}
{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Data.Maybe         (fromMaybe)
import Network.Wai        (Application)
import Servant
import Servant.HTML.Blaze
import System.Environment (getArgs, lookupEnv)
import Text.Read          (readMaybe)

import qualified Text.Blaze.Html5 as H
import qualified Network.Wai.Handler.Warp as Warp

type API = "string" :> Get '[HTML] String
    :<|> "html" :> Get '[HTML] H.Html

api :: Proxy API
api = Proxy

server :: Server API
server = return "example" :<|> return html where
    html :: H.Html
    html = do
        H.b "bar"
        H.i "iik"

app :: Application
app = serve api server

main :: IO ()
main = do
    args <- getArgs
    case args of
        ("run":_) -> do
            port <- fmap (fromMaybe 8000 . (>>= readMaybe)) (lookupEnv "PORT")
            putStrLn $ "http://localhost:" ++ show port ++ "/"
            Warp.run port app
        _ -> do
            putStrLn "Example application, used as a compilation check"
            putStrLn "To run, pass run argument: --test-arguments run"
