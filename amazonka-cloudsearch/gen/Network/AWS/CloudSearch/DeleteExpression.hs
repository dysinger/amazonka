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

-- Module      : Network.AWS.CloudSearch.DeleteExpression
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

-- | Removes an ''Expression' from the search domain. For more information, see Configuring Expressions
-- in the /Amazon CloudSearch Developer Guide/.
--
-- <http://docs.aws.amazon.com/cloudsearch/latest/developerguide/API_DeleteExpression.html>
module Network.AWS.CloudSearch.DeleteExpression
    (
    -- * Request
      DeleteExpression
    -- ** Request constructor
    , deleteExpression
    -- ** Request lenses
    , de2DomainName
    , de2ExpressionName

    -- * Response
    , DeleteExpressionResponse
    -- ** Response constructor
    , deleteExpressionResponse
    -- ** Response lenses
    , der1Expression
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.CloudSearch.Types
import qualified GHC.Exts

data DeleteExpression = DeleteExpression
    { _de2DomainName     :: Text
    , _de2ExpressionName :: Text
    } deriving (Eq, Ord, Read, Show)

-- | 'DeleteExpression' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'de2DomainName' @::@ 'Text'
--
-- * 'de2ExpressionName' @::@ 'Text'
--
deleteExpression :: Text -- ^ 'de2DomainName'
                 -> Text -- ^ 'de2ExpressionName'
                 -> DeleteExpression
deleteExpression p1 p2 = DeleteExpression
    { _de2DomainName     = p1
    , _de2ExpressionName = p2
    }

de2DomainName :: Lens' DeleteExpression Text
de2DomainName = lens _de2DomainName (\s a -> s { _de2DomainName = a })

-- | The name of the ''Expression' to delete.
de2ExpressionName :: Lens' DeleteExpression Text
de2ExpressionName =
    lens _de2ExpressionName (\s a -> s { _de2ExpressionName = a })

newtype DeleteExpressionResponse = DeleteExpressionResponse
    { _der1Expression :: ExpressionStatus
    } deriving (Eq, Read, Show)

-- | 'DeleteExpressionResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'der1Expression' @::@ 'ExpressionStatus'
--
deleteExpressionResponse :: ExpressionStatus -- ^ 'der1Expression'
                         -> DeleteExpressionResponse
deleteExpressionResponse p1 = DeleteExpressionResponse
    { _der1Expression = p1
    }

-- | The status of the expression being deleted.
der1Expression :: Lens' DeleteExpressionResponse ExpressionStatus
der1Expression = lens _der1Expression (\s a -> s { _der1Expression = a })

instance ToPath DeleteExpression where
    toPath = const "/"

instance ToQuery DeleteExpression where
    toQuery DeleteExpression{..} = mconcat
        [ "DomainName"     =? _de2DomainName
        , "ExpressionName" =? _de2ExpressionName
        ]

instance ToHeaders DeleteExpression

instance AWSRequest DeleteExpression where
    type Sv DeleteExpression = CloudSearch
    type Rs DeleteExpression = DeleteExpressionResponse

    request  = post "DeleteExpression"
    response = xmlResponse

instance FromXML DeleteExpressionResponse where
    parseXML = withElement "DeleteExpressionResult" $ \x -> DeleteExpressionResponse
        <$> x .@  "Expression"
