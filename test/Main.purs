module Test.Main where

import Prelude

import Data.Generic.Rep as GR
import Effect (Effect)
import Type.Prelude (Proxy(..))
import ValidateSumTypeCheck (class ValidateSumRep)

data Test = Apple Int | Banana String | Cherry Boolean
derive instance gTest :: GR.Generic Test _

data Test2 = Apple2 Int | Banana2 Int | Cherry2 Boolean
derive instance gTest2 :: GR.Generic Test2 _

data Test3 = Apple3 Int | Banana3 String | Cherry3 String
derive instance gTest3 :: GR.Generic Test3 _

check :: forall a rep. GR.Generic a rep => ValidateSumRep rep => Proxy a -> Unit
check _ = unit

-- checks
test = check (Proxy :: Proxy Test) :: Unit

-- A custom type error occurred while solving type class constraints:
--   Repeated type for differerent constructor name at
--       Banana2
--   from
--       Apple2
--   at type
--       Int
-- test2 = check (Proxy :: Proxy Test2) :: Unit

-- A custom type error occurred while solving type class constraints:
--   Repeated type for differerent constructor name at
--       Cherry3
--   from
--       Banana3
--   at type
--       String
-- test3 = check (Proxy :: Proxy Test3) :: Unit

main :: Effect Unit
main = do
  pure unit
