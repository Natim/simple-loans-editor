module Views.PaymentPlan exposing (view)

import Data.Msg exposing (Msg(..))
import Data.PaymentPlan exposing (PaymentPlan)
import Html exposing (Html, table, tbody, text, th, thead, tr)
import Html.Attributes exposing (class)
import Views.Installment as Installment


view : PaymentPlan -> Html Msg
view paymentPlan =
    case paymentPlan of
        [] ->
            text ""

        _ ->
            table [ class "table table-condensed" ]
                [ thead []
                    [ tr []
                        [ th []
                            [ text "#" ]
                        , th []
                            [ text "Date" ]
                        , th []
                            [ text "Montant" ]
                        , th []
                            [ text "Capital" ]
                        , th []
                            [ text "Commission" ]
                        ]
                    ]
                , List.indexedMap Installment.view paymentPlan |> tbody []
                ]
