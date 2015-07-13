module UserMedia where

import Native.UserMedia


{- Sholuld actually be something like:

        audio:Either Bool MediaTrackConstraint, video:Either Boold MediaTrackConstraint

   (http://w3c.github.io/mediacapture-main/getusermedia.html#mediastreamconstraints)
-}
type alias MediaStreamConstraints
        = { audio:Bool, video:Bool }


{- todo: implement
   http://w3c.github.io/mediacapture-main/getusermedia.html#idl-def-MediaStream
-}
type alias MediaStream = {}


{- The return type of getUserMedia is Promise<MediaStream> which should be
   translated into a corresponding Elm idiom.

   Below, e : MediaStreamError, x and y are free variables.
-}
getUserMedia : MediaStreamConstraints -> (MediaStream -> x) -> (e -> y)
getUserMedia =
    Native.UserMedia.getUserMedia
