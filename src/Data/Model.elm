module Data.Model exposing (Model, init, updatePaymentPlan)

import Data.Installment exposing (Installment)
import Services.Commission as Commission


type alias Model =
    { purchaseAmount : Maybe Float
    , startDate : Maybe String
    , offset : Int
    , installmentsCount : Maybe Int
    , paidAmount : Maybe Float
    , paymentPlan : List Installment
    }


init : Model
init =
    { purchaseAmount = Just 300000
    , startDate = Nothing
    , offset = 1
    , installmentsCount = Just 16
    , paidAmount = Just 312660
    , paymentPlan = []
    }


updatePaymentPlan : Model -> List Installment
updatePaymentPlan model =
    case
        ( ( model.purchaseAmount, model.startDate ), ( model.installmentsCount, model.paidAmount ) )
    of
        ( ( Just purchaseAmount, Just startDate ), ( Just installmentsCount, Just paidAmount ) ) ->
            Commission.getPaymentPlan
                installmentsCount
                startDate
                model.offset
                (round <| purchaseAmount * 100)
                (round <| (paidAmount - purchaseAmount) * 100)

        _ ->
            []
