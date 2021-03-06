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

-- Module      : Network.AWS.AutoScaling.ResumeProcesses
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

-- | Resumes the specified suspended Auto Scaling processes for the specified Auto
-- Scaling group. To resume specific processes, use the 'ScalingProcesses'
-- parameter. To resume all processes, omit the 'ScalingProcesses' parameter. For
-- more information, see <http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/US_SuspendResume.html Suspend and Resume Auto Scaling Processes> in the /AutoScaling Developer Guide/.
--
-- <http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_ResumeProcesses.html>
module Network.AWS.AutoScaling.ResumeProcesses
    (
    -- * Request
      ResumeProcesses
    -- ** Request constructor
    , resumeProcesses
    -- ** Request lenses
    , rpAutoScalingGroupName
    , rpScalingProcesses

    -- * Response
    , ResumeProcessesResponse
    -- ** Response constructor
    , resumeProcessesResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.AutoScaling.Types
import qualified GHC.Exts

data ResumeProcesses = ResumeProcesses
    { _rpAutoScalingGroupName :: Text
    , _rpScalingProcesses     :: List "member" Text
    } deriving (Eq, Ord, Read, Show)

-- | 'ResumeProcesses' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rpAutoScalingGroupName' @::@ 'Text'
--
-- * 'rpScalingProcesses' @::@ ['Text']
--
resumeProcesses :: Text -- ^ 'rpAutoScalingGroupName'
                -> ResumeProcesses
resumeProcesses p1 = ResumeProcesses
    { _rpAutoScalingGroupName = p1
    , _rpScalingProcesses     = mempty
    }

-- | The name or Amazon Resource Name (ARN) of the Auto Scaling group.
rpAutoScalingGroupName :: Lens' ResumeProcesses Text
rpAutoScalingGroupName =
    lens _rpAutoScalingGroupName (\s a -> s { _rpAutoScalingGroupName = a })

-- | One or more of the following processes:
--
-- Launch Terminate HealthCheck ReplaceUnhealthy AZRebalance AlarmNotification
-- ScheduledActions AddToLoadBalancer
rpScalingProcesses :: Lens' ResumeProcesses [Text]
rpScalingProcesses =
    lens _rpScalingProcesses (\s a -> s { _rpScalingProcesses = a })
        . _List

data ResumeProcessesResponse = ResumeProcessesResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'ResumeProcessesResponse' constructor.
resumeProcessesResponse :: ResumeProcessesResponse
resumeProcessesResponse = ResumeProcessesResponse

instance ToPath ResumeProcesses where
    toPath = const "/"

instance ToQuery ResumeProcesses where
    toQuery ResumeProcesses{..} = mconcat
        [ "AutoScalingGroupName" =? _rpAutoScalingGroupName
        , "ScalingProcesses"     =? _rpScalingProcesses
        ]

instance ToHeaders ResumeProcesses

instance AWSRequest ResumeProcesses where
    type Sv ResumeProcesses = AutoScaling
    type Rs ResumeProcesses = ResumeProcessesResponse

    request  = post "ResumeProcesses"
    response = nullResponse ResumeProcessesResponse
