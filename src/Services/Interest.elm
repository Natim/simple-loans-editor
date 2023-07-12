module Services.Interest exposing (optimal_interest_rate)

import Data.Installment exposing (Installment)
import Libs.Newton as Newton


optimal_interest_rate : List Installment -> Maybe Float
optimal_interest_rate paymentPlan =
    let
        purchaseAmount =
            paymentPlan
                |> List.map (\installment -> installment.purchaseAmount)
                |> List.sum
                |> toFloat

        installmentsCount =
            List.length paymentPlan

        planDurations =
            List.repeat installmentsCount 0
                |> List.indexedMap (\i _ -> 7 * (i + 1))

        f_sum x =
            List.map2
                (\d installment ->
                    toFloat installment.totalAmount * (1 / (1 + x)) ^ (toFloat d / 365)
                )
                planDurations
                paymentPlan
                |> List.sum

        f x =
            purchaseAmount - f_sum x

        maybe_taeg =
            Newton.optimize f
    in
    maybe_taeg
        |> Maybe.andThen
            (\taeg ->
                if taeg > 10 || taeg < 0 then
                    Nothing

                else
                    Just taeg
            )
