{- Sketch/idea of how one might bring getUserMedia into Elm
-} 

import UserMedia exposing (Stream, requestUserMedia)
import Html exposing (text, div)
import Task exposing (Task)
import Signal as S exposing ((<~))
import Either exposing (..)

view model =
    case model of
        Nothing -> div [] [ text "Nothing" ]
        Just _ -> div [] [ text "Got user media" ]

userMediaStream : S.Mailbox (Maybe Stream)
userMediaStream =
    S.mailbox Nothing

port getUserMedia : Task x ()
port getUserMedia =
    let options = { audio=Left True, video=Left False }
    in
        requestUserMedia userMediaStream.address options


main =
    view <~ userMediaStream.signal
