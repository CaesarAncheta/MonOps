import Control.Monad.Cont

divExcpt :: Int -> Int -> (String -> Cont r Int) -> Cont r Int
divExcpt x y handler = callCC $ \ok -> do
    err <- callCC $ \notOk -> do
        when (y == 0) $ notOk "Denominator 0"
        ok $ x `div` y
    handler err

main = do
  return $ runCont (divExcpt 10 0 error) id 
