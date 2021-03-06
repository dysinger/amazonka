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

-- Module      : Network.AWS.DynamoDB.Scan
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

-- | The /Scan/ operation returns one or more items and item attributes by accessing
-- every item in a table or a secondary index. To have DynamoDB return fewer
-- items, you can provide a /ScanFilter/ operation.
--
-- If the total number of scanned items exceeds the maximum data set size limit
-- of 1 MB, the scan stops and results are returned to the user as a /LastEvaluatedKey/ value to continue the scan in a subsequent operation. The results also
-- include the number of items exceeding the limit. A scan can result in no
-- table data meeting the filter criteria.
--
-- The result set is eventually consistent.
--
-- By default, /Scan/ operations proceed sequentially; however, for faster
-- performance on a large table or secondary index, applications can request a
-- parallel /Scan/ operation by providing the /Segment/ and /TotalSegments/
-- parameters. For more information, see <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#QueryAndScanParallelScan Parallel Scan> in the /Amazon DynamoDBDeveloper Guide/.
--
-- <http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Scan.html>
module Network.AWS.DynamoDB.Scan
    (
    -- * Request
      Scan
    -- ** Request constructor
    , scan
    -- ** Request lenses
    , sAttributesToGet
    , sConditionalOperator
    , sExclusiveStartKey
    , sExpressionAttributeNames
    , sExpressionAttributeValues
    , sFilterExpression
    , sIndexName
    , sLimit
    , sProjectionExpression
    , sReturnConsumedCapacity
    , sScanFilter
    , sSegment
    , sSelect
    , sTableName
    , sTotalSegments

    -- * Response
    , ScanResponse
    -- ** Response constructor
    , scanResponse
    -- ** Response lenses
    , srConsumedCapacity
    , srCount
    , srItems
    , srLastEvaluatedKey
    , srScannedCount
    ) where

import Network.AWS.Prelude
import Network.AWS.Request.JSON
import Network.AWS.DynamoDB.Types
import qualified GHC.Exts

data Scan = Scan
    { _sAttributesToGet           :: List1 "AttributesToGet" Text
    , _sConditionalOperator       :: Maybe ConditionalOperator
    , _sExclusiveStartKey         :: Map Text AttributeValue
    , _sExpressionAttributeNames  :: Map Text Text
    , _sExpressionAttributeValues :: Map Text AttributeValue
    , _sFilterExpression          :: Maybe Text
    , _sIndexName                 :: Maybe Text
    , _sLimit                     :: Maybe Nat
    , _sProjectionExpression      :: Maybe Text
    , _sReturnConsumedCapacity    :: Maybe ReturnConsumedCapacity
    , _sScanFilter                :: Map Text Condition
    , _sSegment                   :: Maybe Nat
    , _sSelect                    :: Maybe Select
    , _sTableName                 :: Text
    , _sTotalSegments             :: Maybe Nat
    } deriving (Eq, Read, Show)

-- | 'Scan' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'sAttributesToGet' @::@ 'NonEmpty' 'Text'
--
-- * 'sConditionalOperator' @::@ 'Maybe' 'ConditionalOperator'
--
-- * 'sExclusiveStartKey' @::@ 'HashMap' 'Text' 'AttributeValue'
--
-- * 'sExpressionAttributeNames' @::@ 'HashMap' 'Text' 'Text'
--
-- * 'sExpressionAttributeValues' @::@ 'HashMap' 'Text' 'AttributeValue'
--
-- * 'sFilterExpression' @::@ 'Maybe' 'Text'
--
-- * 'sIndexName' @::@ 'Maybe' 'Text'
--
-- * 'sLimit' @::@ 'Maybe' 'Natural'
--
-- * 'sProjectionExpression' @::@ 'Maybe' 'Text'
--
-- * 'sReturnConsumedCapacity' @::@ 'Maybe' 'ReturnConsumedCapacity'
--
-- * 'sScanFilter' @::@ 'HashMap' 'Text' 'Condition'
--
-- * 'sSegment' @::@ 'Maybe' 'Natural'
--
-- * 'sSelect' @::@ 'Maybe' 'Select'
--
-- * 'sTableName' @::@ 'Text'
--
-- * 'sTotalSegments' @::@ 'Maybe' 'Natural'
--
scan :: Text -- ^ 'sTableName'
     -> NonEmpty Text -- ^ 'sAttributesToGet'
     -> Scan
scan p1 p2 = Scan
    { _sTableName                 = p1
    , _sAttributesToGet           = withIso _List1 (const id) p2
    , _sIndexName                 = Nothing
    , _sLimit                     = Nothing
    , _sSelect                    = Nothing
    , _sScanFilter                = mempty
    , _sConditionalOperator       = Nothing
    , _sExclusiveStartKey         = mempty
    , _sReturnConsumedCapacity    = Nothing
    , _sTotalSegments             = Nothing
    , _sSegment                   = Nothing
    , _sProjectionExpression      = Nothing
    , _sFilterExpression          = Nothing
    , _sExpressionAttributeNames  = mempty
    , _sExpressionAttributeValues = mempty
    }

-- | There is a newer parameter available. Use /ProjectionExpression/ instead. Note
-- that if you use /AttributesToGet/ and /ProjectionExpression/ at the same time,
-- DynamoDB will return a /ValidationException/ exception.
--
-- This parameter allows you to retrieve attributes of type List or Map;
-- however, it cannot retrieve individual elements within a List or a Map.
--
-- The names of one or more attributes to retrieve. If no attribute names are
-- provided, then all attributes will be returned. If any of the requested
-- attributes are not found, they will not appear in the result.
--
-- Note that /AttributesToGet/ has no effect on provisioned throughput
-- consumption. DynamoDB determines capacity units consumed based on item size,
-- not on the amount of data that is returned to an application.
sAttributesToGet :: Lens' Scan (NonEmpty Text)
sAttributesToGet = lens _sAttributesToGet (\s a -> s { _sAttributesToGet = a }) . _List1

-- | There is a newer parameter available. Use /ConditionExpression/ instead. Note
-- that if you use /ConditionalOperator/ and / ConditionExpression / at the same
-- time, DynamoDB will return a /ValidationException/ exception.
--
-- A logical operator to apply to the conditions in a /ScanFilter/ map:
--
-- 'AND' - If all of the conditions evaluate to true, then the entire map
-- evaluates to true.
--
-- 'OR' - If at least one of the conditions evaluate to true, then the entire map
-- evaluates to true.
--
-- If you omit /ConditionalOperator/, then 'AND' is the default.
--
-- The operation will succeed only if the entire map evaluates to true.
--
-- This parameter does not support attributes of type List or Map.
--
sConditionalOperator :: Lens' Scan (Maybe ConditionalOperator)
sConditionalOperator =
    lens _sConditionalOperator (\s a -> s { _sConditionalOperator = a })

-- | The primary key of the first item that this operation will evaluate. Use the
-- value that was returned for /LastEvaluatedKey/ in the previous operation.
--
-- The data type for /ExclusiveStartKey/ must be String, Number or Binary. No set
-- data types are allowed.
--
-- In a parallel scan, a /Scan/ request that includes /ExclusiveStartKey/ must
-- specify the same segment whose previous /Scan/ returned the corresponding value
-- of /LastEvaluatedKey/.
sExclusiveStartKey :: Lens' Scan (HashMap Text AttributeValue)
sExclusiveStartKey =
    lens _sExclusiveStartKey (\s a -> s { _sExclusiveStartKey = a })
        . _Map

-- | One or more substitution tokens for attribute names in an expression. The
-- following are some use cases for using /ExpressionAttributeNames/:
--
-- To access an attribute whose name conflicts with a DynamoDB reserved word.
--
-- To create a placeholder for repeating occurrences of an attribute name in
-- an expression.
--
-- To prevent special characters in an attribute name from being
-- misinterpreted in an expression.
--
-- Use the # character in an expression to dereference an attribute name. For
-- example, consider the following attribute name:
--
-- 'Percentile'
--
-- The name of this attribute conflicts with a reserved word, so it cannot be
-- used directly in an expression. (For the complete list of reserved words, go
-- to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html Reserved Words> in the /Amazon DynamoDB Developer Guide/). To work around
-- this, you could specify the following for /ExpressionAttributeNames/:
--
-- '{"#P":"Percentile"}'
--
-- You could then use this substitution in an expression, as in this example:
--
-- '#P = :val'
--
-- Tokens that begin with the : character are /expression attribute values/,
-- which are placeholders for the actual value at runtime.
--
-- For more information on expression attribute names, go to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html Accessing ItemAttributes> in the /Amazon DynamoDB Developer Guide/.
sExpressionAttributeNames :: Lens' Scan (HashMap Text Text)
sExpressionAttributeNames =
    lens _sExpressionAttributeNames
        (\s a -> s { _sExpressionAttributeNames = a })
            . _Map

-- | One or more values that can be substituted in an expression.
--
-- Use the : (colon) character in an expression to dereference an attribute
-- value. For example, suppose that you wanted to check whether the value of the /ProductStatus/ attribute was one of the following:
--
-- 'Available | Backordered | Discontinued'
--
-- You would first need to specify /ExpressionAttributeValues/ as follows:
--
-- '{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"},":disc":{"S":"Discontinued"} }'
--
-- You could then use these values in an expression, such as this:
--
-- 'ProductStatus IN (:avail, :back, :disc)'
--
-- For more information on expression attribute values, go to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.SpecifyingConditions.html SpecifyingConditions> in the /Amazon DynamoDB Developer Guide/.
sExpressionAttributeValues :: Lens' Scan (HashMap Text AttributeValue)
sExpressionAttributeValues =
    lens _sExpressionAttributeValues
        (\s a -> s { _sExpressionAttributeValues = a })
            . _Map

-- | A string that contains conditions that DynamoDB applies after the /Scan/
-- operation, but before the data is returned to you. Items that do not satisfy
-- the /FilterExpression/ criteria are not returned.
--
-- A /FilterExpression/ is applied after the items have already been read; the
-- process of filtering does not consume any additional read capacity units.
--
-- For more information, go to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#FilteringResults Filter Expressions> in the /Amazon DynamoDBDeveloper Guide/.
sFilterExpression :: Lens' Scan (Maybe Text)
sFilterExpression =
    lens _sFilterExpression (\s a -> s { _sFilterExpression = a })

-- | The name of a secondary index to scan. This index can be any local secondary
-- index or global secondary index. Note that if you use the 'IndexName'
-- parameter, you must also provide 'TableName'.
sIndexName :: Lens' Scan (Maybe Text)
sIndexName = lens _sIndexName (\s a -> s { _sIndexName = a })

-- | The maximum number of items to evaluate (not necessarily the number of
-- matching items). If DynamoDB processes the number of items up to the limit
-- while processing the results, it stops the operation and returns the matching
-- values up to that point, and a key in /LastEvaluatedKey/ to apply in a
-- subsequent operation, so that you can pick up where you left off. Also, if
-- the processed data set size exceeds 1 MB before DynamoDB reaches this limit,
-- it stops the operation and returns the matching values up to the limit, and a
-- key in /LastEvaluatedKey/ to apply in a subsequent operation to continue the
-- operation. For more information, see <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html Query and Scan> in the /Amazon DynamoDBDeveloper Guide/.
sLimit :: Lens' Scan (Maybe Natural)
sLimit = lens _sLimit (\s a -> s { _sLimit = a }) . mapping _Nat

-- | A string that identifies one or more attributes to retrieve from the
-- specified table or index. These attributes can include scalars, sets, or
-- elements of a JSON document. The attributes in the expression must be
-- separated by commas.
--
-- If no attribute names are specified, then all attributes will be returned.
-- If any of the requested attributes are not found, they will not appear in the
-- result.
--
-- For more information, go to <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.AccessingItemAttributes.html Accessing Item Attributes> in the /Amazon DynamoDBDeveloper Guide/.
sProjectionExpression :: Lens' Scan (Maybe Text)
sProjectionExpression =
    lens _sProjectionExpression (\s a -> s { _sProjectionExpression = a })

sReturnConsumedCapacity :: Lens' Scan (Maybe ReturnConsumedCapacity)
sReturnConsumedCapacity =
    lens _sReturnConsumedCapacity (\s a -> s { _sReturnConsumedCapacity = a })

-- | There is a newer parameter available. Use /FilterExpression/ instead. Note
-- that if you use /ScanFilter/ and /FilterExpression/ at the same time, DynamoDB
-- will return a /ValidationException/ exception.
--
-- A condition that evaluates the scan results and returns only the desired
-- values.
--
-- This parameter does not support attributes of type List or Map.
--
-- If you specify more than one condition in the /ScanFilter/ map, then by
-- default all of the conditions must evaluate to true. In other words, the
-- conditions are ANDed together. (You can use the /ConditionalOperator/ parameter
-- to OR the conditions instead. If you do this, then at least one of the
-- conditions must evaluate to true, rather than all of them.)
--
-- Each /ScanFilter/ element consists of an attribute name to compare, along with
-- the following:
--
-- /AttributeValueList/ - One or more values to evaluate against the supplied
-- attribute. The number of values in the list depends on the operator specified
-- in /ComparisonOperator/ .
--
-- For type Number, value comparisons are numeric.
--
-- String value comparisons for greater than, equals, or less than are based on
-- ASCII character code values. For example, 'a' is greater than 'A', and 'a' is
-- greater than 'B'. For a list of code values, see <http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters>.
--
-- For Binary, DynamoDB treats each byte of the binary data as unsigned when it
-- compares binary values.
--
-- For information on specifying data types in JSON, see <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataFormat.html JSON Data Format> in
-- the /Amazon DynamoDB Developer Guide/.
--
-- /ComparisonOperator/ - A comparator for evaluating attributes. For example,
-- equals, greater than, less than, etc.
--
-- The following comparison operators are available:
--
-- 'EQ | NE | LE | LT | GE | GT | NOT_NULL | NULL | CONTAINS | NOT_CONTAINS |BEGINS_WITH | IN | BETWEEN'
--
-- For complete descriptions of all comparison operators, see <http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Condition.html Condition>.
--
--
sScanFilter :: Lens' Scan (HashMap Text Condition)
sScanFilter = lens _sScanFilter (\s a -> s { _sScanFilter = a }) . _Map

-- | For a parallel /Scan/ request, /Segment/ identifies an individual segment to be
-- scanned by an application worker.
--
-- Segment IDs are zero-based, so the first segment is always 0. For example,
-- if you want to use four application threads to scan a table or an index, then
-- the first thread specifies a /Segment/ value of 0, the second thread specifies
-- 1, and so on.
--
-- The value of /LastEvaluatedKey/ returned from a parallel /Scan/ request must be
-- used as /ExclusiveStartKey/ with the same segment ID in a subsequent /Scan/
-- operation.
--
-- The value for /Segment/ must be greater than or equal to 0, and less than the
-- value provided for /TotalSegments/.
--
-- If you provide /Segment/, you must also provide /TotalSegments/.
sSegment :: Lens' Scan (Maybe Natural)
sSegment = lens _sSegment (\s a -> s { _sSegment = a }) . mapping _Nat

-- | The attributes to be returned in the result. You can retrieve all item
-- attributes, specific item attributes, or the count of matching items.
--
-- 'ALL_ATTRIBUTES' - Returns all of the item attributes.
--
-- 'COUNT' - Returns the number of matching items, rather than the matching
-- items themselves.
--
-- 'SPECIFIC_ATTRIBUTES' - Returns only the attributes listed in /AttributesToGet/. This return value is equivalent to specifying /AttributesToGet/ without
-- specifying any value for /Select/.
--
-- If neither /Select/ nor /AttributesToGet/ are specified, DynamoDB defaults to 'ALL_ATTRIBUTES'. You cannot use both /AttributesToGet/ and /Select/ together in a single
-- request, unless the value for /Select/ is 'SPECIFIC_ATTRIBUTES'. (This usage is
-- equivalent to specifying /AttributesToGet/ without any value for /Select/.)
sSelect :: Lens' Scan (Maybe Select)
sSelect = lens _sSelect (\s a -> s { _sSelect = a })

-- | The name of the table containing the requested items; or, if you provide 'IndexName', the name of the table to which that index belongs.
sTableName :: Lens' Scan Text
sTableName = lens _sTableName (\s a -> s { _sTableName = a })

-- | For a parallel /Scan/ request, /TotalSegments/ represents the total number of
-- segments into which the /Scan/ operation will be divided. The value of /TotalSegments/ corresponds to the number of application workers that will perform the
-- parallel scan. For example, if you want to use four application threads to
-- scan a table or an index, specify a /TotalSegments/ value of 4.
--
-- The value for /TotalSegments/ must be greater than or equal to 1, and less
-- than or equal to 1000000. If you specify a /TotalSegments/ value of 1, the /Scan/
-- operation will be sequential rather than parallel.
--
-- If you specify /TotalSegments/, you must also specify /Segment/.
sTotalSegments :: Lens' Scan (Maybe Natural)
sTotalSegments = lens _sTotalSegments (\s a -> s { _sTotalSegments = a }) . mapping _Nat

data ScanResponse = ScanResponse
    { _srConsumedCapacity :: Maybe ConsumedCapacity
    , _srCount            :: Maybe Int
    , _srItems            :: List "Items" (Map Text AttributeValue)
    , _srLastEvaluatedKey :: Map Text AttributeValue
    , _srScannedCount     :: Maybe Int
    } deriving (Eq, Read, Show)

-- | 'ScanResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'srConsumedCapacity' @::@ 'Maybe' 'ConsumedCapacity'
--
-- * 'srCount' @::@ 'Maybe' 'Int'
--
-- * 'srItems' @::@ ['HashMap' 'Text' 'AttributeValue']
--
-- * 'srLastEvaluatedKey' @::@ 'HashMap' 'Text' 'AttributeValue'
--
-- * 'srScannedCount' @::@ 'Maybe' 'Int'
--
scanResponse :: ScanResponse
scanResponse = ScanResponse
    { _srItems            = mempty
    , _srCount            = Nothing
    , _srScannedCount     = Nothing
    , _srLastEvaluatedKey = mempty
    , _srConsumedCapacity = Nothing
    }

srConsumedCapacity :: Lens' ScanResponse (Maybe ConsumedCapacity)
srConsumedCapacity =
    lens _srConsumedCapacity (\s a -> s { _srConsumedCapacity = a })

-- | The number of items in the response.
--
-- If you set /ScanFilter/ in the request, then /Count/ is the number of items
-- returned after the filter was applied, and /ScannedCount/ is the number of
-- matching items before the filter was applied.
--
-- If you did not use a filter in the request, then /Count/ is the same as /ScannedCount/.
srCount :: Lens' ScanResponse (Maybe Int)
srCount = lens _srCount (\s a -> s { _srCount = a })

-- | An array of item attributes that match the scan criteria. Each element in
-- this array consists of an attribute name and the value for that attribute.
srItems :: Lens' ScanResponse [HashMap Text AttributeValue]
srItems = lens _srItems (\s a -> s { _srItems = a }) . _List

-- | The primary key of the item where the operation stopped, inclusive of the
-- previous result set. Use this value to start a new operation, excluding this
-- value in the new request.
--
-- If /LastEvaluatedKey/ is empty, then the "last page" of results has been
-- processed and there is no more data to be retrieved.
--
-- If /LastEvaluatedKey/ is not empty, it does not necessarily mean that there is
-- more data in the result set. The only way to know when you have reached the
-- end of the result set is when /LastEvaluatedKey/ is empty.
srLastEvaluatedKey :: Lens' ScanResponse (HashMap Text AttributeValue)
srLastEvaluatedKey =
    lens _srLastEvaluatedKey (\s a -> s { _srLastEvaluatedKey = a })
        . _Map

-- | The number of items evaluated, before any /ScanFilter/ is applied. A high /ScannedCount/ value with few, or no, /Count/ results indicates an inefficient /Scan/
-- operation. For more information, see <http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/QueryAndScan.html#Count Count and ScannedCount> in the /AmazonDynamoDB Developer Guide/.
--
-- If you did not use a filter in the request, then /ScannedCount/ is the same as /Count/.
srScannedCount :: Lens' ScanResponse (Maybe Int)
srScannedCount = lens _srScannedCount (\s a -> s { _srScannedCount = a })

instance ToPath Scan where
    toPath = const "/"

instance ToQuery Scan where
    toQuery = const mempty

instance ToHeaders Scan

instance ToJSON Scan where
    toJSON Scan{..} = object
        [ "TableName"                 .= _sTableName
        , "IndexName"                 .= _sIndexName
        , "AttributesToGet"           .= _sAttributesToGet
        , "Limit"                     .= _sLimit
        , "Select"                    .= _sSelect
        , "ScanFilter"                .= _sScanFilter
        , "ConditionalOperator"       .= _sConditionalOperator
        , "ExclusiveStartKey"         .= _sExclusiveStartKey
        , "ReturnConsumedCapacity"    .= _sReturnConsumedCapacity
        , "TotalSegments"             .= _sTotalSegments
        , "Segment"                   .= _sSegment
        , "ProjectionExpression"      .= _sProjectionExpression
        , "FilterExpression"          .= _sFilterExpression
        , "ExpressionAttributeNames"  .= _sExpressionAttributeNames
        , "ExpressionAttributeValues" .= _sExpressionAttributeValues
        ]

instance AWSRequest Scan where
    type Sv Scan = DynamoDB
    type Rs Scan = ScanResponse

    request  = post "Scan"
    response = jsonResponse

instance FromJSON ScanResponse where
    parseJSON = withObject "ScanResponse" $ \o -> ScanResponse
        <$> o .:? "ConsumedCapacity"
        <*> o .:? "Count"
        <*> o .:? "Items" .!= mempty
        <*> o .:? "LastEvaluatedKey" .!= mempty
        <*> o .:? "ScannedCount"

instance AWSPager Scan where
    page rq rs
        | stop (rs ^. srLastEvaluatedKey) = Nothing
        | otherwise = Just $ rq
            & sExclusiveStartKey .~ rs ^. srLastEvaluatedKey
