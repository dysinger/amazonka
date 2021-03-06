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

-- Module      : Network.AWS.Redshift.DeleteHsmClientCertificate
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

-- | Deletes the specified HSM client certificate.
--
-- <http://docs.aws.amazon.com/redshift/latest/APIReference/API_DeleteHsmClientCertificate.html>
module Network.AWS.Redshift.DeleteHsmClientCertificate
    (
    -- * Request
      DeleteHsmClientCertificate
    -- ** Request constructor
    , deleteHsmClientCertificate
    -- ** Request lenses
    , dhcc1HsmClientCertificateIdentifier

    -- * Response
    , DeleteHsmClientCertificateResponse
    -- ** Response constructor
    , deleteHsmClientCertificateResponse
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.Query
import Network.AWS.Redshift.Types
import qualified GHC.Exts

newtype DeleteHsmClientCertificate = DeleteHsmClientCertificate
    { _dhcc1HsmClientCertificateIdentifier :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'DeleteHsmClientCertificate' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dhcc1HsmClientCertificateIdentifier' @::@ 'Text'
--
deleteHsmClientCertificate :: Text -- ^ 'dhcc1HsmClientCertificateIdentifier'
                           -> DeleteHsmClientCertificate
deleteHsmClientCertificate p1 = DeleteHsmClientCertificate
    { _dhcc1HsmClientCertificateIdentifier = p1
    }

-- | The identifier of the HSM client certificate to be deleted.
dhcc1HsmClientCertificateIdentifier :: Lens' DeleteHsmClientCertificate Text
dhcc1HsmClientCertificateIdentifier =
    lens _dhcc1HsmClientCertificateIdentifier
        (\s a -> s { _dhcc1HsmClientCertificateIdentifier = a })

data DeleteHsmClientCertificateResponse = DeleteHsmClientCertificateResponse
    deriving (Eq, Ord, Read, Show, Generic)

-- | 'DeleteHsmClientCertificateResponse' constructor.
deleteHsmClientCertificateResponse :: DeleteHsmClientCertificateResponse
deleteHsmClientCertificateResponse = DeleteHsmClientCertificateResponse

instance ToPath DeleteHsmClientCertificate where
    toPath = const "/"

instance ToQuery DeleteHsmClientCertificate where
    toQuery DeleteHsmClientCertificate{..} = mconcat
        [ "HsmClientCertificateIdentifier" =? _dhcc1HsmClientCertificateIdentifier
        ]

instance ToHeaders DeleteHsmClientCertificate

instance AWSRequest DeleteHsmClientCertificate where
    type Sv DeleteHsmClientCertificate = Redshift
    type Rs DeleteHsmClientCertificate = DeleteHsmClientCertificateResponse

    request  = post "DeleteHsmClientCertificate"
    response = nullResponse DeleteHsmClientCertificateResponse
