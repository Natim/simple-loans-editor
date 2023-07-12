module Data.Msg exposing (FieldType(..), Msg(..))

import Date exposing (Date)


type FieldType
    = PurchaseAmount
    | PaidAmount


type Msg
    = DateChanged String
    | InstallmentsCountChanged String
    | CurrencyChanged FieldType (Maybe Float)
    | ReceiveDate Date
    | UpdateOffset String
