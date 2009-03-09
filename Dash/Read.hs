module Dash.Read (
    fetch
  , fetchPeriod
  ) where
  
  import Data.Maybe
  import Network.URL
  import Network.Curl 
  import Text.JSON
  
  type Options = [(String, String)]
  
  baseURL :: String -> Maybe URL
  baseURL token = importURL $ "https://dash.fiveruns.com/apps/" ++ token ++ "/data-v1.js"

  urlString :: String -> String -> Options -> String
  urlString token metric opts = case baseURL token of
    Just url -> exportURL $ foldl (add_param) url (("metric_name", metric):opts)
    Nothing -> error "Could not generate URL"
    
  grab :: JSON a => String -> IO a
  grab url = do
    content <- readContentsURL url
    case (decode "{}") of
      Ok r -> return r
      Error e -> error $ "Could not decode return: " ++ e ++ " (" ++ content ++ ")"
  
  fetchPeriod :: JSON a => String -> String -> Options -> IO a
  fetchPeriod token metric opts = grab $ urlString token metric opts
  
  fetch :: JSON a => String -> String -> IO a
  fetch token metric = fetchPeriod token metric []
  
  -- | @readContentsURL@ fetches the content from the given URL, @u@.
  -- Via a standard, non-authenticated, @GET@.
  readContentsURL :: URLString -> IO String
  readContentsURL u = do
    let opts = [ CurlFollowLocation True ]
    (_,xs) <- curlGetString u opts
    return xs