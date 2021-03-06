{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE KindSignatures    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE ViewPatterns      #-}

-- Module      : Gen.TH
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

module Gen.TH where

import           Control.Applicative
import           Control.Lens
import qualified Data.Aeson.TH       as A
import qualified Data.Jason.TH       as J
import           Data.Text           (Text)
import qualified Data.Text           as Text
import           Gen.Names
import           Language.Haskell.TH

data TH = TH
    { _thCtor     :: Text -> Text
    , _thField    :: Text -> Text
    , _thLens     :: Text -> Text
    , _thTag      :: String
    , _thContents :: String
    , _thJSON     :: TH -> Name -> Q [Dec]
    }

makeLenses ''TH

input :: TH
input = TH ctorName keyName lensName "type" "contents" $
    \t -> J.deriveFromJSON (jason t)

output :: TH
output = input & thJSON .~ A.deriveToJSON . aeson

nullary :: TH -> Name -> Q [Dec]
nullary th = _thJSON th th

record :: TH -> Name -> Q [Dec]
record th n = concat <$> sequence
    [ makeLensesWith (lenses th lensRules) n
    , nullary th n
    ]

classy :: TH -> Name -> Q [Dec]
classy th n = concat <$> sequence
    [ makeLensesWith (lenses th classyRules) n
    , nullary th n
    ]

aeson :: TH -> A.Options
aeson th = A.defaultOptions
    { A.constructorTagModifier = text (_thCtor th)
    , A.fieldLabelModifier     = text (_thField th)
    , A.omitNothingFields      = False
    , A.allNullaryToStringTag  = True
    , A.sumEncoding            =
        A.defaultTaggedObject
            { A.tagFieldName      = _thTag th
            , A.contentsFieldName = _thContents th
            }
    }

jason :: TH -> J.Options
jason th = J.defaultOptions
    { J.constructorTagModifier = text (_thCtor th)
    , J.fieldLabelModifier     = text (_thField th)
    , J.allNullaryToStringTag  = True
    , J.sumEncoding            =
        J.defaultTaggedObject
            { J.tagFieldName      = _thTag th
            , J.contentsFieldName = _thContents th
            }
    }

lenses :: TH -> LensRules -> LensRules
lenses th = set lensField $ \_ _ x ->
    [ TopName (mkName (text (_thLens th) (nameBase x)))
    ]

text :: (Text -> Text) -> String -> String
text f = Text.unpack . f . Text.pack
