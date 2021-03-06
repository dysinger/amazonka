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

-- Module      : Network.AWS.Redshift.DeleteClusterSubnetGroup
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

-- | Deletes the specified cluster subnet group.
--
-- <http://docs.aws.amazon.com/redshift/latest/APIReference/API_DeleteClusterSubnetGroup.html>
module Network.AWS.Redshift.DeleteClusterSubnetGroup
    (
    -- * Request
      DeleteClusterSubnetGroup
    -- ** Request constructor
    , deleteClusterSubnetGroup
    -- ** Request lenses
    , dcsgClusterSubnetGroupName

    -- * Response
    , DeleteClusterSubnetGroupResponse
    -- ** Response constructor
    , deleteClusterSubnetGroupResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.Redshift.Types
import qualified GHC.Exts

newtype DeleteClusterSubnetGroup = DeleteClusterSubnetGroup
    { _dcsgClusterSubnetGroupName :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'DeleteClusterSubnetGroup' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dcsgClusterSubnetGroupName' @::@ 'Text'
--
deleteClusterSubnetGroup :: Text -- ^ 'dcsgClusterSubnetGroupName'
                         -> DeleteClusterSubnetGroup
deleteClusterSubnetGroup p1 = DeleteClusterSubnetGroup
    { _dcsgClusterSubnetGroupName = p1
    }

-- | The name of the cluster subnet group name to be deleted.
dcsgClusterSubnetGroupName :: Lens' DeleteClusterSubnetGroup Text
dcsgClusterSubnetGroupName =
    lens _dcsgClusterSubnetGroupName
        (\s a -> s { _dcsgClusterSubnetGroupName = a })

data DeleteClusterSubnetGroupResponse = DeleteClusterSubnetGroupResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'DeleteClusterSubnetGroupResponse' constructor.
deleteClusterSubnetGroupResponse :: DeleteClusterSubnetGroupResponse
deleteClusterSubnetGroupResponse = DeleteClusterSubnetGroupResponse

instance ToPath DeleteClusterSubnetGroup where
    toPath = const "/"

instance ToQuery DeleteClusterSubnetGroup where
    toQuery DeleteClusterSubnetGroup{..} = mconcat
        [ "ClusterSubnetGroupName" =? _dcsgClusterSubnetGroupName
        ]

instance ToHeaders DeleteClusterSubnetGroup

instance AWSRequest DeleteClusterSubnetGroup where
    type Sv DeleteClusterSubnetGroup = Redshift
    type Rs DeleteClusterSubnetGroup = DeleteClusterSubnetGroupResponse

    request  = post "DeleteClusterSubnetGroup"
    response = nullResponse DeleteClusterSubnetGroupResponse
