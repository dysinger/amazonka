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

-- Module      : Network.AWS.SNS.ListEndpointsByPlatformApplication
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

-- | Lists the endpoints and endpoint attributes for devices in a supported push
-- notification service, such as GCM and APNS. The results for 'ListEndpointsByPlatformApplication' are paginated and return a limited list of endpoints, up to 100. If
-- additional records are available after the first page results, then a
-- NextToken string will be returned. To receive the next page, you call 'ListEndpointsByPlatformApplication' again using the NextToken string received from the previous call. When there
-- are no more records to return, NextToken will be null. For more information,
-- see <http://docs.aws.amazon.com/sns/latest/dg/SNSMobilePush.html Using Amazon SNS Mobile Push Notifications>.
--
-- <http://docs.aws.amazon.com/sns/latest/api/API_ListEndpointsByPlatformApplication.html>
module Network.AWS.SNS.ListEndpointsByPlatformApplication
    (
    -- * Request
      ListEndpointsByPlatformApplication
    -- ** Request constructor
    , listEndpointsByPlatformApplication
    -- ** Request lenses
    , lebpaNextToken
    , lebpaPlatformApplicationArn

    -- * Response
    , ListEndpointsByPlatformApplicationResponse
    -- ** Response constructor
    , listEndpointsByPlatformApplicationResponse
    -- ** Response lenses
    , lebparEndpoints
    , lebparNextToken
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.SNS.Types
import qualified GHC.Exts

data ListEndpointsByPlatformApplication = ListEndpointsByPlatformApplication
    { _lebpaNextToken              :: Maybe Text
    , _lebpaPlatformApplicationArn :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ListEndpointsByPlatformApplication' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lebpaNextToken' @::@ 'Maybe' 'Text'
--
-- * 'lebpaPlatformApplicationArn' @::@ 'Text'
--
listEndpointsByPlatformApplication :: Text -- ^ 'lebpaPlatformApplicationArn'
                                   -> ListEndpointsByPlatformApplication
listEndpointsByPlatformApplication p1 = ListEndpointsByPlatformApplication
    { _lebpaPlatformApplicationArn = p1
    , _lebpaNextToken              = Nothing
    }

-- | NextToken string is used when calling ListEndpointsByPlatformApplication
-- action to retrieve additional records that are available after the first page
-- results.
lebpaNextToken :: Lens' ListEndpointsByPlatformApplication (Maybe Text)
lebpaNextToken = lens _lebpaNextToken (\s a -> s { _lebpaNextToken = a })

-- | PlatformApplicationArn for ListEndpointsByPlatformApplicationInput action.
lebpaPlatformApplicationArn :: Lens' ListEndpointsByPlatformApplication Text
lebpaPlatformApplicationArn =
    lens _lebpaPlatformApplicationArn
        (\s a -> s { _lebpaPlatformApplicationArn = a })

data ListEndpointsByPlatformApplicationResponse = ListEndpointsByPlatformApplicationResponse
    { _lebparEndpoints :: List "member" Endpoint
    , _lebparNextToken :: Maybe Text
    } deriving (Eq, Read, Show)

-- | 'ListEndpointsByPlatformApplicationResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lebparEndpoints' @::@ ['Endpoint']
--
-- * 'lebparNextToken' @::@ 'Maybe' 'Text'
--
listEndpointsByPlatformApplicationResponse :: ListEndpointsByPlatformApplicationResponse
listEndpointsByPlatformApplicationResponse = ListEndpointsByPlatformApplicationResponse
    { _lebparEndpoints = mempty
    , _lebparNextToken = Nothing
    }

-- | Endpoints returned for ListEndpointsByPlatformApplication action.
lebparEndpoints :: Lens' ListEndpointsByPlatformApplicationResponse [Endpoint]
lebparEndpoints = lens _lebparEndpoints (\s a -> s { _lebparEndpoints = a }) . _List

-- | NextToken string is returned when calling ListEndpointsByPlatformApplication
-- action if additional records are available after the first page results.
lebparNextToken :: Lens' ListEndpointsByPlatformApplicationResponse (Maybe Text)
lebparNextToken = lens _lebparNextToken (\s a -> s { _lebparNextToken = a })

instance ToPath ListEndpointsByPlatformApplication where
    toPath = const "/"

instance ToQuery ListEndpointsByPlatformApplication where
    toQuery ListEndpointsByPlatformApplication{..} = mconcat
        [ "NextToken"              =? _lebpaNextToken
        , "PlatformApplicationArn" =? _lebpaPlatformApplicationArn
        ]

instance ToHeaders ListEndpointsByPlatformApplication

instance AWSRequest ListEndpointsByPlatformApplication where
    type Sv ListEndpointsByPlatformApplication = SNS
    type Rs ListEndpointsByPlatformApplication = ListEndpointsByPlatformApplicationResponse

    request  = post "ListEndpointsByPlatformApplication"
    response = xmlResponse

instance FromXML ListEndpointsByPlatformApplicationResponse where
    parseXML = withElement "ListEndpointsByPlatformApplicationResult" $ \x -> ListEndpointsByPlatformApplicationResponse
        <$> x .@? "Endpoints" .!@ mempty
        <*> x .@? "NextToken"

instance AWSPager ListEndpointsByPlatformApplication where
    page rq rs
        | stop (rs ^. lebparNextToken) = Nothing
        | otherwise = (\x -> rq & lebpaNextToken ?~ x)
            <$> (rs ^. lebparNextToken)
