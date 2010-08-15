import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Text.IO as T
import qualified Data.Text as T
import qualified Data.Text.Lazy.IO as TL
import qualified Data.Text.Lazy as TL
import Data.Int (Int64)
import Numeric (readDec)
import System.Environment (getArgs)

bytestring file s e = do
  t <- B.readFile file
  B.putStr (cut s e t)
  where
    cut s e = B.unlines . map (B.take (e - s) . B.drop s) . B.lines

lazyBytestring file s e = do
  t <- BL.readFile file
  BL.putStr (cut (fromIntegral s) (fromIntegral e) t)
  where
    cut s e = BL.unlines . map (BL.take (e - s) . BL.drop s) . BL.lines

lazyText file s e = do
  t <- TL.readFile file
  TL.putStr (cut (fromIntegral s) (fromIntegral e) t)
  where
    cut s e = TL.unlines . map (TL.take (e - s) . TL.drop s) . TL.lines

text file s e = do
  t <- T.readFile file
  T.putStr (cut s e t)
  where
    cut s e = T.unlines . map (T.take (e - s) . T.drop s) . T.lines

main = do
  (name : ss : es : file : _) <- getArgs
  let [(s',"")] = readDec ss
      [(e,"")] = readDec es
      s = s' - 1
  case name of
    "bs" -> bytestring file s e
    "lbs" -> lazyBytestring file s e
    "ltext" -> lazyText file s e
    "text" -> text file s e
