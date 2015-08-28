module Main where

import qualified Lang.Rogue.Raw as RR

main :: IO ()
--main = getContents >>= (return . show . RR.parse . RR.tokenize) >>= putStrLn
main = do
    ast <- getContents >>= (return . RR.parse . RR.tokenize)
    RR.pprint ast
    print $ "Result: " ++ show (RR.eval ast)

-- eof
