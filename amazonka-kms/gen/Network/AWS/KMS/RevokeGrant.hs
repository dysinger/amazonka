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

-- Module      : Network.AWS.KMS.RevokeGrant
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Revokes a grant. You can revoke a grant to actively deny operations that
-- depend on it.
--
-- <http://docs.aws.amazon.com/kms/latest/APIReference/API_RevokeGrant.html>
module Network.AWS.KMS.RevokeGrant
    (
    -- * Request
      RevokeGrant
    -- ** Request constructor
    , revokeGrant
    -- ** Request lenses
    , rgGrantId
    , rgKeyId

    -- * Response
    , RevokeGrantResponse
    -- ** Response constructor
    , revokeGrantResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.KMS.Types
import qualified GHC.Exts

data RevokeGrant = RevokeGrant
    { _rgGrantId :: Text
    , _rgKeyId   :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'RevokeGrant' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rgGrantId' @::@ 'Text'
--
-- * 'rgKeyId' @::@ 'Text'
--
revokeGrant :: Text -- ^ 'rgKeyId'
            -> Text -- ^ 'rgGrantId'
            -> RevokeGrant
revokeGrant p1 p2 = RevokeGrant
    { _rgKeyId   = p1
    , _rgGrantId = p2
    }

-- | Identifier of the grant to be revoked.
rgGrantId :: Lens' RevokeGrant Text
rgGrantId = lens _rgGrantId (\s a -> s { _rgGrantId = a })

-- | A unique identifier for the customer master key associated with the grant.
-- This value can be a globally unique identifier or the fully specified ARN to
-- a key.  Key ARN Example -
-- arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012 Globally Unique Key ID Example - 12345678-1234-1234-123456789012
--
rgKeyId :: Lens' RevokeGrant Text
rgKeyId = lens _rgKeyId (\s a -> s { _rgKeyId = a })

data RevokeGrantResponse = RevokeGrantResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'RevokeGrantResponse' constructor.
revokeGrantResponse :: RevokeGrantResponse
revokeGrantResponse = RevokeGrantResponse

instance ToPath RevokeGrant where
    toPath = const "/"

instance ToQuery RevokeGrant where
    toQuery = const mempty

instance ToHeaders RevokeGrant

instance ToJSON RevokeGrant where
    toJSON RevokeGrant{..} = object
        [ "KeyId"   .= _rgKeyId
        , "GrantId" .= _rgGrantId
        ]

instance AWSRequest RevokeGrant where
    type Sv RevokeGrant = KMS
    type Rs RevokeGrant = RevokeGrantResponse

    request  = post "RevokeGrant"
    response = nullResponse RevokeGrantResponse
