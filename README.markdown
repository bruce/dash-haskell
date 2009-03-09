= Dash


    main = do
      result <- fetch "YOUR-APP-TOKEN-HERE" "YOUR-METRIC-NAME-HERE"
      putStrLn $ (show result)