module Data.Installment exposing (Installment)


type alias Installment =
    { dueDate : String
    , totalAmount : Int
    , purchaseAmount : Int
    , customerInterest : Int
    }
