module Libs.Newton exposing (optimize)

-- Newton Secant method
-- https://en.wikipedia.org/wiki/Secant_method


maxiter : Int
maxiter =
    50


abs_tol : Float
abs_tol =
    1.48e-8


eps : Float
eps =
    1.0e-4


optimize : (Float -> Float) -> Maybe Float
optimize f =
    let
        p0 =
            0

        p1 =
            eps

        q0 =
            f p0

        q1 =
            f p1
    in
    optimizer f p0 p1 q0 q1 maxiter


optimizer : (Float -> Float) -> Float -> Float -> Float -> Float -> Int -> Maybe Float
optimizer f p0 p1 q0 q1 step =
    if step == 0 then
        Nothing

    else if q1 == q0 then
        Just <| (p1 + p0) / 2

    else
        let
            p =
                p1 - (p1 - p0) / (q1 - q0) * q1
        in
        if abs (p - p1) <= abs_tol then
            Just p

        else
            let
                q =
                    f p
            in
            optimizer f p1 p q1 q (step - 1)
