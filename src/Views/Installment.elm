module Views.Installment exposing (view)

import Data.Installment exposing (Installment)
import Data.Msg exposing (Msg(..))
import Html exposing (Html, td, text, tr)
import Html.Attributes exposing (class)
import Libs.Utils exposing (euros)


view : Int -> Installment -> Html Msg
view i installment =
    tr [ class "" ]
        [ td []
            [ text <| "E" ++ String.fromInt (i + 1) ]
        , td []
            [ text installment.dueDate ]
        , td []
            [ text <| euros installment.totalAmount ]
        , td []
            [ text <| euros installment.purchaseAmount ]
        , td []
            [ text <| euros installment.customerInterest ]
        ]
