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

-- Module      : Network.AWS.Route53Domains.TransferDomain
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

-- | This operation transfers a domain from another registrar to Amazon Route 53.
-- When the transfer is complete, the domain is registered with the AWS
-- registrar partner, Gandi.
--
-- For transfer requirements, a detailed procedure, and information about
-- viewing the status of a domain transfer, see <http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-transfer-to-route-53.html Transferring Registration for aDomain to Amazon Route 53> in the Amazon Route 53 Developer Guide.
--
-- If the registrar for your domain is also the DNS service provider for the
-- domain, we highly recommend that you consider transferring your DNS service
-- to Amazon Route 53 or to another DNS service provider before you transfer
-- your registration. Some registrars provide free DNS service when you purchase
-- a domain registration. When you transfer the registration, the previous
-- registrar will not renew your domain registration and could end your DNS
-- service at any time.
--
-- Caution! If the registrar for your domain is also the DNS service provider
-- for the domain and you don't transfer DNS service to another provider, your
-- website, email, and the web applications associated with the domain might
-- become unavailable. If the transfer is successful, this method returns an
-- operation ID that you can use to track the progress and completion of the
-- action. If the transfer doesn't complete successfully, the domain registrant
-- will be notified by email.
--
-- <http://docs.aws.amazon.com/Route53/latest/APIReference/api-TransferDomain.html>
module Network.AWS.Route53Domains.TransferDomain
    (
    -- * Request
      TransferDomain
    -- ** Request constructor
    , transferDomain
    -- ** Request lenses
    , tdAdminContact
    , tdAuthCode
    , tdAutoRenew
    , tdDomainName
    , tdDurationInYears
    , tdIdnLangCode
    , tdNameservers
    , tdPrivacyProtectAdminContact
    , tdPrivacyProtectRegistrantContact
    , tdPrivacyProtectTechContact
    , tdRegistrantContact
    , tdTechContact

    -- * Response
    , TransferDomainResponse
    -- ** Response constructor
    , transferDomainResponse
    -- ** Response lenses
    , tdrOperationId
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.Route53Domains.Types
import qualified GHC.Exts

data TransferDomain = TransferDomain
    { _tdAdminContact                    :: ContactDetail
    , _tdAuthCode                        :: Maybe (Sensitive Text)
    , _tdAutoRenew                       :: Maybe Bool
    , _tdDomainName                      :: Text
    , _tdDurationInYears                 :: Nat
    , _tdIdnLangCode                     :: Maybe Text
    , _tdNameservers                     :: List "Nameservers" Nameserver
    , _tdPrivacyProtectAdminContact      :: Maybe Bool
    , _tdPrivacyProtectRegistrantContact :: Maybe Bool
    , _tdPrivacyProtectTechContact       :: Maybe Bool
    , _tdRegistrantContact               :: ContactDetail
    , _tdTechContact                     :: ContactDetail
    } deriving (Eq, Read, Show)

-- | 'TransferDomain' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'tdAdminContact' @::@ 'ContactDetail'
--
-- * 'tdAuthCode' @::@ 'Maybe' 'Text'
--
-- * 'tdAutoRenew' @::@ 'Maybe' 'Bool'
--
-- * 'tdDomainName' @::@ 'Text'
--
-- * 'tdDurationInYears' @::@ 'Natural'
--
-- * 'tdIdnLangCode' @::@ 'Maybe' 'Text'
--
-- * 'tdNameservers' @::@ ['Nameserver']
--
-- * 'tdPrivacyProtectAdminContact' @::@ 'Maybe' 'Bool'
--
-- * 'tdPrivacyProtectRegistrantContact' @::@ 'Maybe' 'Bool'
--
-- * 'tdPrivacyProtectTechContact' @::@ 'Maybe' 'Bool'
--
-- * 'tdRegistrantContact' @::@ 'ContactDetail'
--
-- * 'tdTechContact' @::@ 'ContactDetail'
--
transferDomain :: Text -- ^ 'tdDomainName'
               -> Natural -- ^ 'tdDurationInYears'
               -> ContactDetail -- ^ 'tdAdminContact'
               -> ContactDetail -- ^ 'tdRegistrantContact'
               -> ContactDetail -- ^ 'tdTechContact'
               -> TransferDomain
transferDomain p1 p2 p3 p4 p5 = TransferDomain
    { _tdDomainName                      = p1
    , _tdDurationInYears                 = withIso _Nat (const id) p2
    , _tdAdminContact                    = p3
    , _tdRegistrantContact               = p4
    , _tdTechContact                     = p5
    , _tdIdnLangCode                     = Nothing
    , _tdNameservers                     = mempty
    , _tdAuthCode                        = Nothing
    , _tdAutoRenew                       = Nothing
    , _tdPrivacyProtectAdminContact      = Nothing
    , _tdPrivacyProtectRegistrantContact = Nothing
    , _tdPrivacyProtectTechContact       = Nothing
    }

-- | Provides detailed contact information.
--
-- Type: Complex
--
-- Children: 'FirstName', 'MiddleName', 'LastName', 'ContactType', 'OrganizationName', 'AddressLine1', 'AddressLine2', 'City', 'State', 'CountryCode', 'ZipCode', 'PhoneNumber', 'Email', 'Fax', 'ExtraParams'
--
-- Required: Yes
tdAdminContact :: Lens' TransferDomain ContactDetail
tdAdminContact = lens _tdAdminContact (\s a -> s { _tdAdminContact = a })

-- | The authorization code for the domain. You get this value from the current
-- registrar.
--
-- Type: String
--
-- Required: Yes
tdAuthCode :: Lens' TransferDomain (Maybe Text)
tdAuthCode = lens _tdAuthCode (\s a -> s { _tdAuthCode = a }) . mapping _Sensitive

-- | Indicates whether the domain will be automatically renewed (true) or not
-- (false). Autorenewal only takes effect after the account is charged.
--
-- Type: Boolean
--
-- Valid values: 'true' | 'false'
--
-- Default: true
--
-- Required: No
tdAutoRenew :: Lens' TransferDomain (Maybe Bool)
tdAutoRenew = lens _tdAutoRenew (\s a -> s { _tdAutoRenew = a })

-- | The name of a domain.
--
-- Type: String
--
-- Default: None
--
-- Constraints: The domain name can contain only the letters a through z, the
-- numbers 0 through 9, and hyphen (-). Internationalized Domain Names are not
-- supported.
--
-- Required: Yes
tdDomainName :: Lens' TransferDomain Text
tdDomainName = lens _tdDomainName (\s a -> s { _tdDomainName = a })

-- | The number of years the domain will be registered. Domains are registered for
-- a minimum of one year. The maximum period depends on the top-level domain.
--
-- Type: Integer
--
-- Default: 1
--
-- Valid values: Integer from 1 to 10
--
-- Required: Yes
tdDurationInYears :: Lens' TransferDomain Natural
tdDurationInYears =
    lens _tdDurationInYears (\s a -> s { _tdDurationInYears = a })
        . _Nat

-- | Reserved for future use.
tdIdnLangCode :: Lens' TransferDomain (Maybe Text)
tdIdnLangCode = lens _tdIdnLangCode (\s a -> s { _tdIdnLangCode = a })

-- | Contains details for the host and glue IP addresses.
--
-- Type: Complex
--
-- Children: 'GlueIps', 'Name'
--
-- Required: No
tdNameservers :: Lens' TransferDomain [Nameserver]
tdNameservers = lens _tdNameservers (\s a -> s { _tdNameservers = a }) . _List

-- | Whether you want to conceal contact information from WHOIS queries. If you
-- specify true, WHOIS ("who is") queries will return contact information for
-- our registrar partner, Gandi, instead of the contact information that you
-- enter.
--
-- Type: Boolean
--
-- Default: 'true'
--
-- Valid values: 'true' | 'false'
--
-- Required: No
tdPrivacyProtectAdminContact :: Lens' TransferDomain (Maybe Bool)
tdPrivacyProtectAdminContact =
    lens _tdPrivacyProtectAdminContact
        (\s a -> s { _tdPrivacyProtectAdminContact = a })

-- | Whether you want to conceal contact information from WHOIS queries. If you
-- specify true, WHOIS ("who is") queries will return contact information for
-- our registrar partner, Gandi, instead of the contact information that you
-- enter.
--
-- Type: Boolean
--
-- Default: 'true'
--
-- Valid values: 'true' | 'false'
--
-- Required: No
tdPrivacyProtectRegistrantContact :: Lens' TransferDomain (Maybe Bool)
tdPrivacyProtectRegistrantContact =
    lens _tdPrivacyProtectRegistrantContact
        (\s a -> s { _tdPrivacyProtectRegistrantContact = a })

-- | Whether you want to conceal contact information from WHOIS queries. If you
-- specify true, WHOIS ("who is") queries will return contact information for
-- our registrar partner, Gandi, instead of the contact information that you
-- enter.
--
-- Type: Boolean
--
-- Default: 'true'
--
-- Valid values: 'true' | 'false'
--
-- Required: No
tdPrivacyProtectTechContact :: Lens' TransferDomain (Maybe Bool)
tdPrivacyProtectTechContact =
    lens _tdPrivacyProtectTechContact
        (\s a -> s { _tdPrivacyProtectTechContact = a })

-- | Provides detailed contact information.
--
-- Type: Complex
--
-- Children: 'FirstName', 'MiddleName', 'LastName', 'ContactType', 'OrganizationName', 'AddressLine1', 'AddressLine2', 'City', 'State', 'CountryCode', 'ZipCode', 'PhoneNumber', 'Email', 'Fax', 'ExtraParams'
--
-- Required: Yes
tdRegistrantContact :: Lens' TransferDomain ContactDetail
tdRegistrantContact =
    lens _tdRegistrantContact (\s a -> s { _tdRegistrantContact = a })

-- | Provides detailed contact information.
--
-- Type: Complex
--
-- Children: 'FirstName', 'MiddleName', 'LastName', 'ContactType', 'OrganizationName', 'AddressLine1', 'AddressLine2', 'City', 'State', 'CountryCode', 'ZipCode', 'PhoneNumber', 'Email', 'Fax', 'ExtraParams'
--
-- Required: Yes
tdTechContact :: Lens' TransferDomain ContactDetail
tdTechContact = lens _tdTechContact (\s a -> s { _tdTechContact = a })

newtype TransferDomainResponse = TransferDomainResponse
    { _tdrOperationId :: Text
    } deriving (Eq, Ord, Read, Show, Monoid, IsString)

-- | 'TransferDomainResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'tdrOperationId' @::@ 'Text'
--
transferDomainResponse :: Text -- ^ 'tdrOperationId'
                       -> TransferDomainResponse
transferDomainResponse p1 = TransferDomainResponse
    { _tdrOperationId = p1
    }

-- | Identifier for tracking the progress of the request. To use this ID to query
-- the operation status, use GetOperationDetail.
--
-- Type: String
--
-- Default: None
--
-- Constraints: Maximum 255 characters.
tdrOperationId :: Lens' TransferDomainResponse Text
tdrOperationId = lens _tdrOperationId (\s a -> s { _tdrOperationId = a })

instance ToPath TransferDomain where
    toPath = const "/"

instance ToQuery TransferDomain where
    toQuery = const mempty

instance ToHeaders TransferDomain

instance ToJSON TransferDomain where
    toJSON TransferDomain{..} = object
        [ "DomainName"                      .= _tdDomainName
        , "IdnLangCode"                     .= _tdIdnLangCode
        , "DurationInYears"                 .= _tdDurationInYears
        , "Nameservers"                     .= _tdNameservers
        , "AuthCode"                        .= _tdAuthCode
        , "AutoRenew"                       .= _tdAutoRenew
        , "AdminContact"                    .= _tdAdminContact
        , "RegistrantContact"               .= _tdRegistrantContact
        , "TechContact"                     .= _tdTechContact
        , "PrivacyProtectAdminContact"      .= _tdPrivacyProtectAdminContact
        , "PrivacyProtectRegistrantContact" .= _tdPrivacyProtectRegistrantContact
        , "PrivacyProtectTechContact"       .= _tdPrivacyProtectTechContact
        ]

instance AWSRequest TransferDomain where
    type Sv TransferDomain = Route53Domains
    type Rs TransferDomain = TransferDomainResponse

    request  = post "TransferDomain"
    response = jsonResponse

instance FromJSON TransferDomainResponse where
    parseJSON = withObject "TransferDomainResponse" $ \o -> TransferDomainResponse
        <$> o .:  "OperationId"
