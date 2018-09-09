module ValidateSumTypeCheck where

import Data.Generic.Rep as GR
import Prim.TypeError as TE

class ValidateSumRep rep

instance sumValidateSum ::
  ( ValidateSumTypeIter name ty b
  , ValidateSumRep b
  ) => ValidateSumRep (GR.Sum (GR.Constructor name (GR.Argument ty)) b)

instance argumentValidateSum :: ValidateSumRep (GR.Argument a)
instance constructorValidateSum :: ValidateSumRep (GR.Constructor name a)

class ValidateSumTypeIter (name :: Symbol) ty rep | rep -> name ty

instance sumValidateSumType ::
  ( ValidateSumTypeIter name ty a
  , ValidateSumTypeIter name ty b
  ) => ValidateSumTypeIter name ty (GR.Sum a b)

instance constructorValidateSumType ::
  ( ValidateSumTypeCheck name ty name' ty'
  ) => ValidateSumTypeIter name ty (GR.Constructor name' (GR.Argument ty'))

class ValidateSumTypeCheck (name :: Symbol) ty (name' :: Symbol) ty'

infixr 2 type TE.Beside as +
infixr 1 type TE.Above as ^

instance eqValidateSumTypeNameTy :: ValidateSumTypeCheck n a n a

else instance invalidRepeatedValidateSumTypeNameTy ::
  ( TE.Fail
      ( TE.Text "Repeated type for differerent constructor name at"
      ^ TE.Text ""
      ^ TE.Text "    " + TE.Text m
      ^ TE.Text ""
      ^ TE.Text "from"
      ^ TE.Text ""
      ^ TE.Text "    " + TE.Text n
      ^ TE.Text ""
      ^ TE.Text "at type"
      ^ TE.Text ""
      ^ TE.Text "    " + TE.Quote a
      )
  ) => ValidateSumTypeCheck n a m a

else instance notEqValidateSumTypeNameTy :: ValidateSumTypeCheck n a m b
