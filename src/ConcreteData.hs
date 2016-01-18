--A type that can be converted to a single CSV record. ala Chris Allen, cma@bitemyapp.com
--From Cassava, in Hackage Data.Csv, a library for .csv files
--http://hackage.haskell.org/package/cassava-0.4.2.0/docs/src/Data-Csv-Conversion.html#FromRecord

{-# LANGUAGE BangPatterns, CPP, FlexibleInstances, OverloadedStrings,
             Rank2Types #-}
             
import Data.Csv
import Data.Text
-- -- An example type and instance:


data AnEither = AnEither { left :: !Text, right :: !Int }

instance ToRecord AnEither where
    toRecord (AnEither left right) = record [
        toField left, toField right]
 
---- ---- sample data for AnEither String Int     
-- SomeException, 42
-- IOException, 18446744073709551615
