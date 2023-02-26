--244_V2_PopescuVasileAlin_P3

newtype WriterM a = MW {getMW :: (Either String a, String)}






instance  Monad WriterM where
  return va = MW (va, "")
  ma >>= k = let (va, log1) = getMW ma
                 (vb, log2) = getMW (k va)
             in  MW (vb, log1 ++ log2)



testWriterM :: WriterM Int
testWriterM = ma >>= k
 where
    ma =
        MW (Right 7, "ana are mere ")
    k x =
        MW (if x `mod` 2==0 then Right x else Left "", "si pere!" )