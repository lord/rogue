module Lang.Rogue.Raw
( tokenize
, parse
, pprint
, psprint
, eval
) where

import qualified Control.Monad as M

import qualified Data.DList as DL
import Data.DList (DList)

import Text.Regex.TDFA (AllTextMatches(..), (=~))

tokenize :: String -> [String]
tokenize input = getAllTextMatches $ input =~ "[()]|[^[:space:]()]+"

data RRaw
    = E [RRaw]
    | S String
    | I Int
    deriving (Show)

parse :: [String] -> RRaw
parse tokens = case fmap DL.toList . parseHelper $ (tokens, DL.empty) of
    ([], [ast]) -> ast
    x -> error $ "unconsumed tokens or too many ASTs: " ++ show x

parseHelper :: ([String], DList RRaw) -> ([String], DList RRaw)
parseHelper ([], asts) = ([], asts)
parseHelper (t:okens, asts)
    | t == ")" = (t:okens, asts)
    | t == "(" = case parseHelper (okens, DL.empty) of
        (")":okens', asts') -> parseHelper (okens', asts `DL.snoc` (E $ DL.toList asts'))
        x -> error $ "unmatched parentheses: " ++ show x
    | t =~ "^[[:digit:]]+$" = parseHelper (okens, asts `DL.snoc` (I $ read t))
    | otherwise = parseHelper (okens, asts `DL.snoc` S t)

pprint :: RRaw -> IO ()
pprint = M.void . mapM putStrLn . psprint

psprint :: RRaw -> [String]
psprint = psprintHelper " " 0

indent :: String -> Int -> String -> String
indent pad level s = (concat . replicate level $ pad) ++ s

psprintHelper :: String -> Int -> RRaw -> [String]
psprintHelper pad level (E rraws)
    = [indent pad level "("]
    ++ concatMap (psprintHelper pad (1 + level)) rraws
    ++ [indent pad level ")"]
psprintHelper pad level (S s) = [indent pad level $ show s]
psprintHelper pad level (I i) = [indent pad level $ show i]

eval = id -- ast -> action

-- eof
