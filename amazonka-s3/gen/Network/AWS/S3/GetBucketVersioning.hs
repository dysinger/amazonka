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

-- Module      : Network.AWS.S3.GetBucketVersioning
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

-- | Returns the versioning state of a bucket.
--
-- <http://docs.aws.amazon.com/AmazonS3/latest/API/GetBucketVersioning.html>
module Network.AWS.S3.GetBucketVersioning
    (
    -- * Request
      GetBucketVersioning
    -- ** Request constructor
    , getBucketVersioning
    -- ** Request lenses
    , gbvBucket

    -- * Response
    , GetBucketVersioningResponse
    -- ** Response constructor
    , getBucketVersioningResponse
    -- ** Response lenses
    , gbvrMFADelete
    , gbvrStatus
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.S3
import Network.AWS.S3.Types
import qualified GHC.Exts

newtype GetBucketVersioning = GetBucketVersioning
    { _gbvBucket :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'GetBucketVersioning' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gbvBucket' @::@ 'Text'
--
getBucketVersioning :: Text -- ^ 'gbvBucket'
                    -> GetBucketVersioning
getBucketVersioning p1 = GetBucketVersioning
    { _gbvBucket = p1
    }

gbvBucket :: Lens' GetBucketVersioning Text
gbvBucket = lens _gbvBucket (\s a -> s { _gbvBucket = a })

data GetBucketVersioningResponse = GetBucketVersioningResponse
    { _gbvrMFADelete :: Maybe MFADeleteStatus
    , _gbvrStatus    :: Maybe BucketVersioningStatus
    } deriving (Eq, Read, Show)

-- | 'GetBucketVersioningResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gbvrMFADelete' @::@ 'Maybe' 'MFADeleteStatus'
--
-- * 'gbvrStatus' @::@ 'Maybe' 'BucketVersioningStatus'
--
getBucketVersioningResponse :: GetBucketVersioningResponse
getBucketVersioningResponse = GetBucketVersioningResponse
    { _gbvrStatus    = Nothing
    , _gbvrMFADelete = Nothing
    }

-- | Specifies whether MFA delete is enabled in the bucket versioning
-- configuration. This element is only returned if the bucket has been
-- configured with MFA delete. If the bucket has never been so configured, this
-- element is not returned.
gbvrMFADelete :: Lens' GetBucketVersioningResponse (Maybe MFADeleteStatus)
gbvrMFADelete = lens _gbvrMFADelete (\s a -> s { _gbvrMFADelete = a })

-- | The versioning state of the bucket.
gbvrStatus :: Lens' GetBucketVersioningResponse (Maybe BucketVersioningStatus)
gbvrStatus = lens _gbvrStatus (\s a -> s { _gbvrStatus = a })

instance ToPath GetBucketVersioning where
    toPath GetBucketVersioning{..} = mconcat
        [ "/"
        , toText _gbvBucket
        ]

instance ToQuery GetBucketVersioning where
    toQuery = const "versioning"

instance ToHeaders GetBucketVersioning

instance ToXMLRoot GetBucketVersioning where
    toXMLRoot = const (namespaced ns "GetBucketVersioning" [])

instance ToXML GetBucketVersioning

instance AWSRequest GetBucketVersioning where
    type Sv GetBucketVersioning = S3
    type Rs GetBucketVersioning = GetBucketVersioningResponse

    request  = get
    response = xmlResponse

instance FromXML GetBucketVersioningResponse where
    parseXML x = GetBucketVersioningResponse
        <$> x .@? "MfaDelete"
        <*> x .@? "Status"
