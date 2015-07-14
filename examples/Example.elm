{- Sketch/idea of how one might bring getUserMedia into Elm

   This doesn't work as I expect it to; it prompts the user for access to
   the microphone (as desired), but it seems to me that the stream isn't
   being forwarded to the userMediaStream mailbox (since the view isn't
   updating)
-} 

import UserMedia exposing (MediaStream, getUserMedia, userMediaStream)
import Html exposing (text, div)
import Task exposing (Task)
import Signal exposing ((<~))

view model =
    case model of
        Nothing -> div [] [ text "Nothing" ]
        Just _ -> div [] [ text "Got user media" ]

port getUserMedia' : Task x ()
port getUserMedia' =
    getUserMedia { audio=True, video=False }


main =
    view <~ userMediaStream.signal
