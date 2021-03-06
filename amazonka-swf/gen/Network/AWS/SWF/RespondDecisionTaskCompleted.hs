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

-- Module      : Network.AWS.SWF.RespondDecisionTaskCompleted
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

-- | Used by deciders to tell the service that the 'DecisionTask' identified by the 'taskToken' has successfully completed. The 'decisions' argument specifies the list of
-- decisions made while processing the task.
--
-- A 'DecisionTaskCompleted' event is added to the workflow history. The 'executionContext' specified is attached to the event in the workflow execution history.
--
-- Access Control
--
-- If an IAM policy grants permission to use 'RespondDecisionTaskCompleted', it
-- can express permissions for the list of decisions in the 'decisions' parameter.
-- Each of the decisions has one or more parameters, much like a regular API
-- call. To allow for policies to be as readable as possible, you can express
-- permissions on decisions as if they were actual API calls, including applying
-- conditions to some parameters. For more information, see <http://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html Using IAM to ManageAccess to Amazon SWF Workflows>.
--
-- <http://docs.aws.amazon.com/amazonswf/latest/apireference/API_RespondDecisionTaskCompleted.html>
module Network.AWS.SWF.RespondDecisionTaskCompleted
    (
    -- * Request
      RespondDecisionTaskCompleted
    -- ** Request constructor
    , respondDecisionTaskCompleted
    -- ** Request lenses
    , rdtcDecisions
    , rdtcExecutionContext
    , rdtcTaskToken

    -- * Response
    , RespondDecisionTaskCompletedResponse
    -- ** Response constructor
    , respondDecisionTaskCompletedResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.SWF.Types
import qualified GHC.Exts

data RespondDecisionTaskCompleted = RespondDecisionTaskCompleted
    { _rdtcDecisions        :: List "decisions" Decision
    , _rdtcExecutionContext :: Maybe Text
    , _rdtcTaskToken        :: Text
    } deriving (Eq, Read, Show)

-- | 'RespondDecisionTaskCompleted' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rdtcDecisions' @::@ ['Decision']
--
-- * 'rdtcExecutionContext' @::@ 'Maybe' 'Text'
--
-- * 'rdtcTaskToken' @::@ 'Text'
--
respondDecisionTaskCompleted :: Text -- ^ 'rdtcTaskToken'
                             -> RespondDecisionTaskCompleted
respondDecisionTaskCompleted p1 = RespondDecisionTaskCompleted
    { _rdtcTaskToken        = p1
    , _rdtcDecisions        = mempty
    , _rdtcExecutionContext = Nothing
    }

-- | The list of decisions (possibly empty) made by the decider while processing
-- this decision task. See the docs for the 'Decision' structure for details.
rdtcDecisions :: Lens' RespondDecisionTaskCompleted [Decision]
rdtcDecisions = lens _rdtcDecisions (\s a -> s { _rdtcDecisions = a }) . _List

-- | User defined context to add to workflow execution.
rdtcExecutionContext :: Lens' RespondDecisionTaskCompleted (Maybe Text)
rdtcExecutionContext =
    lens _rdtcExecutionContext (\s a -> s { _rdtcExecutionContext = a })

-- | The 'taskToken' from the 'DecisionTask'.
--
-- 'taskToken' is generated by the service and should be treated as an opaque
-- value. If the task is passed to another process, its 'taskToken' must also be
-- passed. This enables it to provide its progress and respond with results.
rdtcTaskToken :: Lens' RespondDecisionTaskCompleted Text
rdtcTaskToken = lens _rdtcTaskToken (\s a -> s { _rdtcTaskToken = a })

data RespondDecisionTaskCompletedResponse = RespondDecisionTaskCompletedResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'RespondDecisionTaskCompletedResponse' constructor.
respondDecisionTaskCompletedResponse :: RespondDecisionTaskCompletedResponse
respondDecisionTaskCompletedResponse = RespondDecisionTaskCompletedResponse

instance ToPath RespondDecisionTaskCompleted where
    toPath = const "/"

instance ToQuery RespondDecisionTaskCompleted where
    toQuery = const mempty

instance ToHeaders RespondDecisionTaskCompleted

instance ToJSON RespondDecisionTaskCompleted where
    toJSON RespondDecisionTaskCompleted{..} = object
        [ "taskToken"        .= _rdtcTaskToken
        , "decisions"        .= _rdtcDecisions
        , "executionContext" .= _rdtcExecutionContext
        ]

instance AWSRequest RespondDecisionTaskCompleted where
    type Sv RespondDecisionTaskCompleted = SWF
    type Rs RespondDecisionTaskCompleted = RespondDecisionTaskCompletedResponse

    request  = post "RespondDecisionTaskCompleted"
    response = nullResponse RespondDecisionTaskCompletedResponse
