module Libs.Utils exposing (euros, percent)

import Round


euros : Int -> String
euros cents =
    let
        amount =
            toFloat cents / 100
    in
    (Round.round 2 amount ++ "€")
        |> String.replace "." ","
        |> String.replace ",00" ""


percent : Maybe Float -> String
percent maybe_value =
    case maybe_value of
        Just value ->
            Round.round 2 (value * 100)

        Nothing ->
            "-,--"
