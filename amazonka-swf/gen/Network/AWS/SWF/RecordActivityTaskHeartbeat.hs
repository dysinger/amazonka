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

-- Module      : Network.AWS.SWF.RecordActivityTaskHeartbeat
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

-- | Used by activity workers to report to the service that the 'ActivityTask'
-- represented by the specified 'taskToken' is still making progress. The worker
-- can also (optionally) specify details of the progress, for example percent
-- complete, using the 'details' parameter. This action can also be used by the
-- worker as a mechanism to check if cancellation is being requested for the
-- activity task. If a cancellation is being attempted for the specified task,
-- then the boolean 'cancelRequested' flag returned by the service is set to 'true'.
--
-- This action resets the 'taskHeartbeatTimeout' clock. The 'taskHeartbeatTimeout'
-- is specified in 'RegisterActivityType'.
--
-- This action does not in itself create an event in the workflow execution
-- history. However, if the task times out, the workflow execution history will
-- contain a 'ActivityTaskTimedOut' event that contains the information from the
-- last heartbeat generated by the activity worker.
--
-- The 'taskStartToCloseTimeout' of an activity type is the maximum duration of
-- an activity task, regardless of the number of 'RecordActivityTaskHeartbeat'
-- requests received. The 'taskStartToCloseTimeout' is also specified in 'RegisterActivityType'. This operation is only useful for long-lived activities to report
-- liveliness of the task and to determine if a cancellation is being attempted.
-- If the 'cancelRequested' flag returns 'true', a cancellation is being attempted.
-- If the worker can cancel the activity, it should respond with 'RespondActivityTaskCanceled'. Otherwise, it should ignore the cancellation request. Access Control
--
-- You can use IAM policies to control this action's access to Amazon SWF
-- resources as follows:
--
-- Use a 'Resource' element with the domain name to limit the action to only
-- specified domains. Use an 'Action' element to allow or deny permission to call
-- this action. You cannot use an IAM policy to constrain this action's
-- parameters.  If the caller does not have sufficient permissions to invoke the
-- action, or the parameter values fall outside the specified constraints, the
-- action fails. The associated event attribute's cause parameter will be set to
-- OPERATION_NOT_PERMITTED. For details and example IAM policies, see <http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html Using IAMto Manage Access to Amazon SWF Workflows>.
--
-- <http://docs.aws.amazon.com/amazonswf/latest/apireference/API_RecordActivityTaskHeartbeat.html>
module Network.AWS.SWF.RecordActivityTaskHeartbeat
    (
    -- * Request
      RecordActivityTaskHeartbeat
    -- ** Request constructor
    , recordActivityTaskHeartbeat
    -- ** Request lenses
    , rathDetails
    , rathTaskToken

    -- * Response
    , RecordActivityTaskHeartbeatResponse
    -- ** Response constructor
    , recordActivityTaskHeartbeatResponse
    -- ** Response lenses
    , rathrCancelRequested
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.SWF.Types
import qualified GHC.Exts

data RecordActivityTaskHeartbeat = RecordActivityTaskHeartbeat
    { _rathDetails   :: Maybe Text
    , _rathTaskToken :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'RecordActivityTaskHeartbeat' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rathDetails' @::@ 'Maybe' 'Text'
--
-- * 'rathTaskToken' @::@ 'Text'
--
recordActivityTaskHeartbeat :: Text -- ^ 'rathTaskToken'
                            -> RecordActivityTaskHeartbeat
recordActivityTaskHeartbeat p1 = RecordActivityTaskHeartbeat
    { _rathTaskToken = p1
    , _rathDetails   = Nothing
    }

-- | If specified, contains details about the progress of the task.
rathDetails :: Lens' RecordActivityTaskHeartbeat (Maybe Text)
rathDetails = lens _rathDetails (\s a -> s { _rathDetails = a })

-- | The 'taskToken' of the 'ActivityTask'.
--
-- 'taskToken' is generated by the service and should be treated as an opaque
-- value. If the task is passed to another process, its 'taskToken' must also be
-- passed. This enables it to provide its progress and respond with results.
rathTaskToken :: Lens' RecordActivityTaskHeartbeat Text
rathTaskToken = lens _rathTaskToken (\s a -> s { _rathTaskToken = a })

newtype RecordActivityTaskHeartbeatResponse = RecordActivityTaskHeartbeatResponse
    { _rathrCancelRequested :: Bool
    } deriving (Eq, Ord, Read, Show, Enum)

-- | 'RecordActivityTaskHeartbeatResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rathrCancelRequested' @::@ 'Bool'
--
recordActivityTaskHeartbeatResponse :: Bool -- ^ 'rathrCancelRequested'
                                    -> RecordActivityTaskHeartbeatResponse
recordActivityTaskHeartbeatResponse p1 = RecordActivityTaskHeartbeatResponse
    { _rathrCancelRequested = p1
    }

-- | Set to 'true' if cancellation of the task is requested.
rathrCancelRequested :: Lens' RecordActivityTaskHeartbeatResponse Bool
rathrCancelRequested =
    lens _rathrCancelRequested (\s a -> s { _rathrCancelRequested = a })

instance ToPath RecordActivityTaskHeartbeat where
    toPath = const "/"

instance ToQuery RecordActivityTaskHeartbeat where
    toQuery = const mempty

instance ToHeaders RecordActivityTaskHeartbeat

instance ToJSON RecordActivityTaskHeartbeat where
    toJSON RecordActivityTaskHeartbeat{..} = object
        [ "taskToken" .= _rathTaskToken
        , "details"   .= _rathDetails
        ]

instance AWSRequest RecordActivityTaskHeartbeat where
    type Sv RecordActivityTaskHeartbeat = SWF
    type Rs RecordActivityTaskHeartbeat = RecordActivityTaskHeartbeatResponse

    request  = post "RecordActivityTaskHeartbeat"
    response = jsonResponse

instance FromJSON RecordActivityTaskHeartbeatResponse where
    parseJSON = withObject "RecordActivityTaskHeartbeatResponse" $ \o -> RecordActivityTaskHeartbeatResponse
        <$> o .:  "cancelRequested"
