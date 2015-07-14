module UserMedia where

import Signal as S
import Task as T
import Debug exposing (log)
import Native.UserMedia


{-| Should actually be something like:

        audio:Either Bool MediaTrackConstraint, video:Either Boold MediaTrackConstraint

   (http://w3c.github.io/mediacapture-main/getusermedia.html#mediastreamconstraints)
-}
type alias Options
        = { audio:Bool, video:Bool }


{-| todo: implement
   http://w3c.github.io/mediacapture-main/getusermedia.html#idl-def-MediaStream
-}
type alias MediaStream = {}
type alias MediaStreamError = {}


{-| getUserMedia wrapper task that requests access to user media according to
    options given and forwards the stream to the mailbox userMediaStream.

    example:
        port getUserMedia' = getUserMedia { audio=True, video=False }
-}
getUserMedia : Options -> T.Task x ()
getUserMedia options =
    let callback stream = S.send userMediaStream.address (Just stream)
    in
        Native.UserMedia.getUserMedia options callback

userMediaStream : S.Mailbox (Maybe MediaStream)
userMediaStream =
    S.mailbox Nothing
