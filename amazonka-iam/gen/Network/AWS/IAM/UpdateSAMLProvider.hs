{-# LANGUAGE DataKinds                   #-}
{-# LANGUAGE DeriveGeneric               #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving  #-}
{-# LANGUAGE LambdaCase                  #-}
{-# LANGUAGE NoImplicitPrelude           #-}
{-# LANGUAGE OverloadedStrings           #-}
{-# LANGUAGE RecordWildCards             #-}
{-# LANGUAGE TypeFamilies                #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Module      : Network.AWS.IAM.UpdateSAMLProvider
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Updates the metadata document for an existing SAML provider.
--
-- This operation requires <http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html Signature Version 4>.
--
-- <http://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateSAMLProvider.html>
module Network.AWS.IAM.UpdateSAMLProvider
    (
    -- * Request
      UpdateSAMLProvider
    -- ** Request constructor
    , updateSAMLProvider
    -- ** Request lenses
    , usamlpSAMLMetadataDocument
    , usamlpSAMLProviderArn

    -- * Response
    , UpdateSAMLProviderResponse
    -- ** Response constructor
    , updateSAMLProviderResponse
    -- ** Response lenses
    , usamlprSAMLProviderArn
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.IAM.Types
import qualified GHC.Exts

data UpdateSAMLProvider = UpdateSAMLProvider
    { _usamlpSAMLMetadataDocument :: Text
    , _usamlpSAMLProviderArn      :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'UpdateSAMLProvider' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'usamlpSAMLMetadataDocument' @::@ 'Text'
--
-- * 'usamlpSAMLProviderArn' @::@ 'Text'
--
updateSAMLProvider :: Text -- ^ 'usamlpSAMLMetadataDocument'
                   -> Text -- ^ 'usamlpSAMLProviderArn'
                   -> UpdateSAMLProvider
updateSAMLProvider p1 p2 = UpdateSAMLProvider
    { _usamlpSAMLMetadataDocument = p1
    , _usamlpSAMLProviderArn      = p2
    }

-- | An XML document generated by an identity provider (IdP) that supports SAML
-- 2.0. The document includes the issuer's name, expiration information, and
-- keys that can be used to validate the SAML authentication response
-- (assertions) that are received from the IdP. You must generate the metadata
-- document using the identity management software that is used as your
-- organization's IdP.
usamlpSAMLMetadataDocument :: Lens' UpdateSAMLProvider Text
usamlpSAMLMetadataDocument =
    lens _usamlpSAMLMetadataDocument
        (\s a -> s { _usamlpSAMLMetadataDocument = a })

-- | The Amazon Resource Name (ARN) of the SAML provider to update.
usamlpSAMLProviderArn :: Lens' UpdateSAMLProvider Text
usamlpSAMLProviderArn =
    lens _usamlpSAMLProviderArn (\s a -> s { _usamlpSAMLProviderArn = a })

newtype UpdateSAMLProviderResponse = UpdateSAMLProviderResponse
    { _usamlprSAMLProviderArn :: Maybe Text
    } deriving (Eq, Ord, Read, Show, Monoid)

-- | 'UpdateSAMLProviderResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'usamlprSAMLProviderArn' @::@ 'Maybe' 'Text'
--
updateSAMLProviderResponse :: UpdateSAMLProviderResponse
updateSAMLProviderResponse = UpdateSAMLProviderResponse
    { _usamlprSAMLProviderArn = Nothing
    }

-- | The Amazon Resource Name (ARN) of the SAML provider that was updated.
usamlprSAMLProviderArn :: Lens' UpdateSAMLProviderResponse (Maybe Text)
usamlprSAMLProviderArn =
    lens _usamlprSAMLProviderArn (\s a -> s { _usamlprSAMLProviderArn = a })

instance ToPath UpdateSAMLProvider where
    toPath = const "/"

instance ToQuery UpdateSAMLProvider where
    toQuery UpdateSAMLProvider{..} = mconcat
        [ "SAMLMetadataDocument" =? _usamlpSAMLMetadataDocument
        , "SAMLProviderArn"      =? _usamlpSAMLProviderArn
        ]

instance ToHeaders UpdateSAMLProvider

instance AWSRequest UpdateSAMLProvider where
    type Sv UpdateSAMLProvider = IAM
    type Rs UpdateSAMLProvider = UpdateSAMLProviderResponse

    request  = post "UpdateSAMLProvider"
    response = xmlResponse

instance FromXML UpdateSAMLProviderResponse where
    parseXML = withElement "UpdateSAMLProviderResult" $ \x -> UpdateSAMLProviderResponse
        <$> x .@? "SAMLProviderArn"
