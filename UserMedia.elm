module UserMedia where

import Native.UserMedia


{- Actually Bool or MediaTrackConstraint allowing
   for more specific requests/desires
-}
type alias MediaStreamConstraints
        = { audio:Bool, video:Bool }

type alias MediaStream = {}

getUserMedia : MediaStreamConstraints -> (MediaStream -> x) -> (e -> x)
getUserMedia =
    Native.UserMedia.getUserMedia
