module Views.App exposing (view)

import Data.Model exposing (Model)
import Data.Msg exposing (FieldType(..), Msg(..))
import Data.PaymentPlan exposing (annual_interest_rate)
import Html exposing (Html, div, h3, input, label, span, text)
import Html.Attributes exposing (class, for, id, style, type_, value)
import Html.Events exposing (onInput)
import Views.CurrencyInput exposing (currencyInput)
import Views.PaymentPlan as PaymentPlan


view : Model -> Html Msg
view { startDate, offset, purchaseAmount, installmentsCount, paidAmount, paymentPlan } =
    div []
        [ div [ class "col-sm-6" ]
            [ div [ class "form-group col-sm-6" ]
                [ label [ for "purchase_amount", class "col-sm-6 control-label" ] [ text "Montant de l'achat" ]
                , div [ class "col-sm-6" ]
                    [ currencyInput PurchaseAmount purchaseAmount "purchase_amount" ]
                ]
            , div [ class "form-group col-sm-6" ]
                [ label [ for "paid_amount", class "col-sm-6 control-label" ] [ text "Montant payé" ]
                , div [ class "col-sm-6" ]
                    [ currencyInput PaidAmount paidAmount "paid_amount"
                    ]
                ]
            , div [ class "form-group col-sm-6" ]
                [ label [ for "start_date", class "col-sm-6 control-label" ] [ text "Date d'achat" ]
                , div [ class "col-sm-6" ]
                    [ input
                        [ type_ "date"
                        , class "form-control"
                        , style "padding-top" "0"
                        , id "start_date"
                        , value <| Maybe.withDefault "" startDate
                        , onInput <| DateChanged
                        ]
                        []
                    ]
                ]
            , div [ class "form-group col-sm-6" ]
                [ label [ for "installments_count", class "col-sm-6 control-label" ] [ text "Nombre d'échéances" ]
                , div [ class "col-sm-6" ]
                    [ div [ class "input-group" ]
                        [ input
                            [ type_ "text"
                            , class "form-control"
                            , id "installments_count"
                            , value <| String.fromInt <| Maybe.withDefault 0 installmentsCount
                            , onInput <| InstallmentsCountChanged
                            ]
                            []
                        , span [ class "input-group-addon" ] [ text "fois" ]
                        ]
                    ]
                ]
            , div [ class "form-group col-sm-6" ]
                [ label [ for "offset", class "col-sm-6 control-label" ] [ text "Décalage" ]
                , div [ class "col-sm-6" ]
                    [ div [ class "input-group" ]
                        [ input
                            [ type_ "text"
                            , class "form-control"
                            , id "offset"
                            , value <| String.fromInt <| offset
                            , onInput <| UpdateOffset
                            ]
                            []
                        , span [ class "input-group-addon" ] [ text "semaines" ]
                        ]
                    ]
                ]
            ]
        , div [ class "col-sm-6" ]
            [ PaymentPlan.view paymentPlan
            , h3 [ class "text-right" ]
                [ text "Repayment over "
                , text <| String.fromInt (Maybe.withDefault 0 installmentsCount + offset)
                , text " weeks — "
                , text "TAEG: "
                , text <| annual_interest_rate paymentPlan
                , text "%"
                ]
            ]
        ]
