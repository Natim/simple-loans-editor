module Views.CurrencyInput exposing (currencyInput)

import Data.Msg exposing (FieldType(..), Msg(..))
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class, id)
import Input.Float as CurrencyInput


inputOptions : FieldType -> CurrencyInput.Options Msg
inputOptions field =
    let
        defaultOptions =
            CurrencyInput.defaultOptions (CurrencyChanged field)
    in
    { defaultOptions
        | minValue = Just 0
    }


currencyInput : FieldType -> Maybe Float -> String -> Html Msg
currencyInput field fieldInfo formName =
    div [ class "input-group" ]
        [ CurrencyInput.input
            (inputOptions field)
            [ class "form-control", id formName ]
            fieldInfo
        , span [ class "input-group-addon" ] [ text "€" ]
        ]
