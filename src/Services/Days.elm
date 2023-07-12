module Services.Days exposing (nextMonday, toPosix, toString)

import Date exposing (Date)
import Iso8601
import Time exposing (Month(..), Posix, utc)
import Time.Extra as TE exposing (Interval(..))


toPosix : String -> Posix
toPosix =
    Iso8601.toTime
        >> Result.withDefault (Time.millisToPosix 0)


toString : Posix -> String
toString =
    Iso8601.fromTime >> String.left 10


nextMonday : Date -> Posix
nextMonday today =
    Date.toIsoString today
        |> toPosix
        |> TE.ceiling Monday utc
