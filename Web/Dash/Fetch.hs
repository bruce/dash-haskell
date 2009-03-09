module Web.Dash.Fetch (
    fetch
  , fetch'
  ) where
  
  import Data.Maybe
  import Network.URL
  import Network.Curl 
  import Text.JSON
  
  type PeriodOptions = [(String, String)]
  
  -- | @fetch'@ fetches the data for the given API Token, @token@, 
  -- and metric name, @metric@, in the time window, @opts@
  fetch' :: String -> String -> PeriodOptions -> IO JSValue
  fetch' token metric opts = do
    contents <- readContentsURL $ urlString token metric opts
    return $ deserialize contents
  
  -- | @fetch@ fetches the data for the given API Token, @token@, 
  -- and metric name, @metric@, in the default time window
  fetch :: String -> String -> IO JSValue
  fetch token metric = fetch' token metric []
  
  -- | @baseURL@ is the base URL for the given API Token, @token@
  baseURL :: String -> Maybe URL
  baseURL token = importURL $ "https://dash.fiveruns.com/apps/" ++ token ++ "/data-v1.js"

  -- | @urlString@ builds the full API URL from the @token@, @metric@,
  -- and given time window, @opts@
  urlString :: String -> String -> PeriodOptions -> String
  urlString token metric opts = case baseURL token of
    Just url -> exportURL $ foldl (add_param) url (("metric_name", metric):opts)
    Nothing -> error "Could not generate URL"

  -- | @deserialize@ parses the JSON input, @input@, into a JSValue
  deserialize :: String -> JSValue
  deserialize input = case decodeStrict input of
    Ok value -> value
    Error e -> error $ "Could not parse result: " ++ e
  
  -- | @readContentsURL@ reads the content from the given URL, @u@.
  -- Via a standard @GET@.
  readContentsURL :: URLString -> IO String
  readContentsURL u = do
    let opts = [ CurlFollowLocation True ]
    (_,xs) <- curlGetString u opts
    return xs