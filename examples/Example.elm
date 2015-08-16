{- Sketch/idea of how one might bring getUserMedia into Elm
-} 

import UserMedia exposing (MediaStream, requestUserMedia)
import Url
import Html exposing (text, div, video)
import Html.Attributes exposing (src, autoplay)
import Task exposing (Task)
import Signal as S exposing ((<~))
import Debug

view model =
    case model of
        Nothing -> div [] [ text "Nothing" ]
        Just mediaStream ->
          div [] [video [
                   src (Url.createObjectURL mediaStream),
                   autoplay True] [],
                 text "Got user media" ]

userMediaStream : S.Mailbox (Maybe MediaStream)
userMediaStream =
    S.mailbox Nothing

port getUserMedia : Task x ()
port getUserMedia =
    let options = { audio=True, video=True } in
    requestUserMedia userMediaStream.address options

main =
    view <~ userMediaStream.signal
