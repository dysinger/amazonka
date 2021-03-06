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

-- Module      : Network.AWS.ImportExport.GetStatus
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

-- | This operation returns information about a job, including where the job is in
-- the processing pipeline, the status of the results, and the signature value
-- associated with the job. You can only return information about jobs you own.
--
-- <http://docs.aws.amazon.com/AWSImportExport/latest/DG/WebGetStatus.html>
module Network.AWS.ImportExport.GetStatus
    (
    -- * Request
      GetStatus
    -- ** Request constructor
    , getStatus
    -- ** Request lenses
    , gsAPIVersion
    , gsJobId

    -- * Response
    , GetStatusResponse
    -- ** Response constructor
    , getStatusResponse
    -- ** Response lenses
    , gsrArtifactList
    , gsrCarrier
    , gsrCreationDate
    , gsrCurrentManifest
    , gsrErrorCount
    , gsrJobId
    , gsrJobType
    , gsrLocationCode
    , gsrLocationMessage
    , gsrLogBucket
    , gsrLogKey
    , gsrProgressCode
    , gsrProgressMessage
    , gsrSignature
    , gsrSignatureFileContents
    , gsrTrackingNumber
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.ImportExport.Types
import qualified GHC.Exts

data GetStatus = GetStatus
    { _gsAPIVersion :: Maybe Text
    , _gsJobId      :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'GetStatus' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gsAPIVersion' @::@ 'Maybe' 'Text'
--
-- * 'gsJobId' @::@ 'Text'
--
getStatus :: Text -- ^ 'gsJobId'
          -> GetStatus
getStatus p1 = GetStatus
    { _gsJobId      = p1
    , _gsAPIVersion = Nothing
    }

gsAPIVersion :: Lens' GetStatus (Maybe Text)
gsAPIVersion = lens _gsAPIVersion (\s a -> s { _gsAPIVersion = a })

gsJobId :: Lens' GetStatus Text
gsJobId = lens _gsJobId (\s a -> s { _gsJobId = a })

data GetStatusResponse = GetStatusResponse
    { _gsrArtifactList          :: List "member" Artifact
    , _gsrCarrier               :: Maybe Text
    , _gsrCreationDate          :: Maybe ISO8601
    , _gsrCurrentManifest       :: Maybe Text
    , _gsrErrorCount            :: Maybe Int
    , _gsrJobId                 :: Maybe Text
    , _gsrJobType               :: Maybe JobType
    , _gsrLocationCode          :: Maybe Text
    , _gsrLocationMessage       :: Maybe Text
    , _gsrLogBucket             :: Maybe Text
    , _gsrLogKey                :: Maybe Text
    , _gsrProgressCode          :: Maybe Text
    , _gsrProgressMessage       :: Maybe Text
    , _gsrSignature             :: Maybe Text
    , _gsrSignatureFileContents :: Maybe Text
    , _gsrTrackingNumber        :: Maybe Text
    } deriving (Eq, Read, Show)

-- | 'GetStatusResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gsrArtifactList' @::@ ['Artifact']
--
-- * 'gsrCarrier' @::@ 'Maybe' 'Text'
--
-- * 'gsrCreationDate' @::@ 'Maybe' 'UTCTime'
--
-- * 'gsrCurrentManifest' @::@ 'Maybe' 'Text'
--
-- * 'gsrErrorCount' @::@ 'Maybe' 'Int'
--
-- * 'gsrJobId' @::@ 'Maybe' 'Text'
--
-- * 'gsrJobType' @::@ 'Maybe' 'JobType'
--
-- * 'gsrLocationCode' @::@ 'Maybe' 'Text'
--
-- * 'gsrLocationMessage' @::@ 'Maybe' 'Text'
--
-- * 'gsrLogBucket' @::@ 'Maybe' 'Text'
--
-- * 'gsrLogKey' @::@ 'Maybe' 'Text'
--
-- * 'gsrProgressCode' @::@ 'Maybe' 'Text'
--
-- * 'gsrProgressMessage' @::@ 'Maybe' 'Text'
--
-- * 'gsrSignature' @::@ 'Maybe' 'Text'
--
-- * 'gsrSignatureFileContents' @::@ 'Maybe' 'Text'
--
-- * 'gsrTrackingNumber' @::@ 'Maybe' 'Text'
--
getStatusResponse :: GetStatusResponse
getStatusResponse = GetStatusResponse
    { _gsrJobId                 = Nothing
    , _gsrJobType               = Nothing
    , _gsrLocationCode          = Nothing
    , _gsrLocationMessage       = Nothing
    , _gsrProgressCode          = Nothing
    , _gsrProgressMessage       = Nothing
    , _gsrCarrier               = Nothing
    , _gsrTrackingNumber        = Nothing
    , _gsrLogBucket             = Nothing
    , _gsrLogKey                = Nothing
    , _gsrErrorCount            = Nothing
    , _gsrSignature             = Nothing
    , _gsrSignatureFileContents = Nothing
    , _gsrCurrentManifest       = Nothing
    , _gsrCreationDate          = Nothing
    , _gsrArtifactList          = mempty
    }

gsrArtifactList :: Lens' GetStatusResponse [Artifact]
gsrArtifactList = lens _gsrArtifactList (\s a -> s { _gsrArtifactList = a }) . _List

gsrCarrier :: Lens' GetStatusResponse (Maybe Text)
gsrCarrier = lens _gsrCarrier (\s a -> s { _gsrCarrier = a })

gsrCreationDate :: Lens' GetStatusResponse (Maybe UTCTime)
gsrCreationDate = lens _gsrCreationDate (\s a -> s { _gsrCreationDate = a }) . mapping _Time

gsrCurrentManifest :: Lens' GetStatusResponse (Maybe Text)
gsrCurrentManifest =
    lens _gsrCurrentManifest (\s a -> s { _gsrCurrentManifest = a })

gsrErrorCount :: Lens' GetStatusResponse (Maybe Int)
gsrErrorCount = lens _gsrErrorCount (\s a -> s { _gsrErrorCount = a })

gsrJobId :: Lens' GetStatusResponse (Maybe Text)
gsrJobId = lens _gsrJobId (\s a -> s { _gsrJobId = a })

gsrJobType :: Lens' GetStatusResponse (Maybe JobType)
gsrJobType = lens _gsrJobType (\s a -> s { _gsrJobType = a })

gsrLocationCode :: Lens' GetStatusResponse (Maybe Text)
gsrLocationCode = lens _gsrLocationCode (\s a -> s { _gsrLocationCode = a })

gsrLocationMessage :: Lens' GetStatusResponse (Maybe Text)
gsrLocationMessage =
    lens _gsrLocationMessage (\s a -> s { _gsrLocationMessage = a })

gsrLogBucket :: Lens' GetStatusResponse (Maybe Text)
gsrLogBucket = lens _gsrLogBucket (\s a -> s { _gsrLogBucket = a })

gsrLogKey :: Lens' GetStatusResponse (Maybe Text)
gsrLogKey = lens _gsrLogKey (\s a -> s { _gsrLogKey = a })

gsrProgressCode :: Lens' GetStatusResponse (Maybe Text)
gsrProgressCode = lens _gsrProgressCode (\s a -> s { _gsrProgressCode = a })

gsrProgressMessage :: Lens' GetStatusResponse (Maybe Text)
gsrProgressMessage =
    lens _gsrProgressMessage (\s a -> s { _gsrProgressMessage = a })

gsrSignature :: Lens' GetStatusResponse (Maybe Text)
gsrSignature = lens _gsrSignature (\s a -> s { _gsrSignature = a })

gsrSignatureFileContents :: Lens' GetStatusResponse (Maybe Text)
gsrSignatureFileContents =
    lens _gsrSignatureFileContents
        (\s a -> s { _gsrSignatureFileContents = a })

gsrTrackingNumber :: Lens' GetStatusResponse (Maybe Text)
gsrTrackingNumber =
    lens _gsrTrackingNumber (\s a -> s { _gsrTrackingNumber = a })

instance ToPath GetStatus where
    toPath = const "/"

instance ToQuery GetStatus where
    toQuery GetStatus{..} = mconcat
        [ "APIVersion" =? _gsAPIVersion
        , "JobId"      =? _gsJobId
        ]

instance ToHeaders GetStatus

instance AWSRequest GetStatus where
    type Sv GetStatus = ImportExport
    type Rs GetStatus = GetStatusResponse

    request  = post "GetStatus"
    response = xmlResponse

instance FromXML GetStatusResponse where
    parseXML = withElement "GetStatusResult" $ \x -> GetStatusResponse
        <$> x .@? "ArtifactList" .!@ mempty
        <*> x .@? "Carrier"
        <*> x .@? "CreationDate"
        <*> x .@? "CurrentManifest"
        <*> x .@? "ErrorCount"
        <*> x .@? "JobId"
        <*> x .@? "JobType"
        <*> x .@? "LocationCode"
        <*> x .@? "LocationMessage"
        <*> x .@? "LogBucket"
        <*> x .@? "LogKey"
        <*> x .@? "ProgressCode"
        <*> x .@? "ProgressMessage"
        <*> x .@? "Signature"
        <*> x .@? "SignatureFileContents"
        <*> x .@? "TrackingNumber"
