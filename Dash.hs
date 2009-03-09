import Dash.Read

main = do
    result <- fetch "bf717b77669cadbf357566530e6fa098d2d0aa72" "ar_time"
    putStrLn $ result