# FiveRuns Dash API for Haskell

This is a library that fetches data from your apps in [Dash](http://dash.fiveruns.com) for use in Haskell applications.

## Dependencies

The json, curl, and url packages.  It's probably GHC-only, too.

## Usage

The short version:
    
    import Web.Dash
    
    main = do
      result <- fetch "YOUR-APP-READ-TOKEN-HERE" "YOUR-METRIC-NAME-HERE"
      putStrLn $ show result

We might add a long version later.

## Limitations

* For now only read access, similar in scope to that of the [dash-javascript library](http://github.com/fiveruns/dash-javascript), is supported.  Write access is planned.

## Authors

Bruce Williams and Adam Keys.

## Contributing

We welcome community contributors!  Haskell tips, help on conventions, etc greatly appreciated, as this is primarily a learning experience for us.
    
## Support

This isn't an officially sanctioned, supported FiveRuns library; this is an independent project of Bruce & Adam.  If you have problems, suggestions, etc, contact us directly.

## License

See LICENSE.

