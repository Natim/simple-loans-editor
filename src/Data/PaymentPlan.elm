module Data.PaymentPlan exposing (PaymentPlan, annual_interest_rate)

import Data.Installment exposing (Installment)
import Libs.Utils exposing (percent)
import Services.Interest as Interest


type alias PaymentPlan =
    List Installment


annual_interest_rate : List Installment -> String
annual_interest_rate paymentPlan =
    Interest.optimal_interest_rate paymentPlan
        |> percent
