module Services.Commission exposing (getPaymentPlan)

import Data.Installment exposing (Installment)
import Services.Days as Days
import Time exposing (Posix, utc)
import Time.Extra as TE exposing (Interval(..))


scheduleWeeklyPaymentDates : Int -> Posix -> List Posix
scheduleWeeklyPaymentDates installments_count starting_date =
    List.range 0 installments_count
        |> List.map (\i -> TE.add Week i utc starting_date)


getPaymentPlan : Int -> String -> Int -> Int -> Int -> List Installment
getPaymentPlan installmentsCount startingDate offset purchaseAmount customerFee =
    let
        dates =
            List.map Days.toString <| scheduleWeeklyPaymentDates (installmentsCount + offset) (Days.toPosix startingDate)

        totalPayAmount =
            (toFloat (purchaseAmount + customerFee) / toFloat installmentsCount)
                |> round

        totalAmountPhasing =
            List.concat
                [ List.repeat offset 0
                , List.repeat installmentsCount totalPayAmount
                ]

        capitalAmount =
            (toFloat purchaseAmount / toFloat installmentsCount) |> round

        capitalAmountPhasing =
            List.concat
                [ List.repeat offset 0
                , List.repeat installmentsCount capitalAmount
                ]

        commissionAmount =
            (toFloat customerFee / toFloat installmentsCount) |> round

        commissionAmountPhasing =
            List.concat
                [ List.repeat offset 0
                , List.repeat installmentsCount commissionAmount
                ]
    in
    List.map4 Installment
        dates
        totalAmountPhasing
        capitalAmountPhasing
        commissionAmountPhasing
