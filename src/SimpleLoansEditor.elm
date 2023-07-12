module SimpleLoansEditor exposing (main)

import Browser
import Data.Model as Model exposing (Model)
import Data.Msg exposing (FieldType(..), Msg(..))
import Date
import Services.Days as Days
import Task
import Views.App as App


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = App.view
        , subscriptions = always Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.init
    , Date.today |> Task.perform ReceiveDate
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        newModel =
            case msg of
                ReceiveDate today ->
                    { model | startDate = Days.nextMonday today |> Days.toString |> Just }

                DateChanged value ->
                    { model | startDate = Just value }

                CurrencyChanged PurchaseAmount value ->
                    { model | purchaseAmount = value }

                InstallmentsCountChanged value ->
                    { model | installmentsCount = String.toInt value }

                CurrencyChanged PaidAmount value ->
                    { model | paidAmount = value }

                UpdateOffset value ->
                    { model | offset = String.toInt value |> Maybe.withDefault 1 }
    in
    ( { newModel | paymentPlan = Model.updatePaymentPlan newModel }, Cmd.none )
