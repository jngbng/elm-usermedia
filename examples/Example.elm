{- Sketch/idea of how one might bring getUserMedia into Elm
-} 

import UserMedia exposing (MediaStream, requestUserMedia)
import Html exposing (text, div)
import Task exposing (Task)
import Signal as S exposing ((<~))

view model =
    case model of
        Nothing -> div [] [ text "Nothing" ]
        Just _ -> div [] [ text "Got user media" ]

userMediaStream : S.Mailbox (Maybe MediaStream)
userMediaStream =
    S.mailbox Nothing

port getUserMedia : Task x ()
port getUserMedia =
    let options = { audio=True, video=False }
    in
        requestUserMedia userMediaStream.address options


main =
    view <~ userMediaStream.signal
