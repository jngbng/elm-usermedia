module UserMedia where

{-| An interface for navigator.getUserMedia

# Definition
@docs Options, MediaStream, MediaStreamError, requestUserMedia

-}

import Signal as S
import Task as T
import Native.UserMedia


{-| Should actually be something like:

        audio:Either Bool MediaTrackConstraint, video:Either Bool MediaTrackConstraint

   (http://w3c.github.io/mediacapture-main/getusermedia.html#mediastreamconstraints)
-}
type alias Options
        = { audio:Bool, video:Bool }


{-| todo: implement
   http://w3c.github.io/mediacapture-main/getusermedia.html#idl-def-MediaStream
-}
type alias MediaStream =
    { active:Signal Bool
    , ended:Signal Bool
    , label:String
    , id:String
    }

{-| MediaStream error type. Not implemented
-}
type alias MediaStreamError = {}


{-| getUserMedia wrapper task that requests access to user media according to
    options given and forwards the stream to the mailbox userMediaStream.

    example:
        userMedia : S.Mailbox (Maybe MediaStream)
        userMedia = S.mailbox Nothing
        port getUserMedia = requestUserMedia userMedia.address { audio=True, video=False }
-}
requestUserMedia : S.Address (Maybe MediaStream) -> Options -> T.Task x ()
requestUserMedia address options =
    T.toMaybe (Native.UserMedia.getUserMedia options)
        `T.andThen` S.send address 
