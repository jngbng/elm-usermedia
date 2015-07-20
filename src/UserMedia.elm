module UserMedia where

import Signal as S
import Task as T
import Native.UserMedia
import Either exposing (..)


{-| Implement MediaTrackConstraints that will be given to getUserMedia
(http://w3c.github.io/mediacapture-main/getusermedia.html#mediastreamconstraints)
-}
type alias Options =
    { audio : Either Bool TrackConstraints
    , video : Either Bool TrackConstraints
    }

type alias TrackConstraints =
    { width : Int
    , height : Int
    , aspectRatio : Float
    , frameRate : Float
    }

{-| todo: implement
   http://w3c.github.io/mediacapture-main/getusermedia.html#idl-def-MediaStream
-}
type alias Stream =
    { id : String
    , label : String
    , active : Signal Bool
    }

type alias Track =
    { id : String
    , label : String
    }

type TrackKind
        = Audio
        | Video

type TrackState 
        = Live
        | Ended

type alias Error = {}


{-| getUserMedia wrapper task that requests access to user media according to
    options given and forwards the stream to the mailbox userMediaStream.

    example:
        userMedia : S.Mailbox (Maybe MediaStream)
        userMedia = S.mailbox Nothing
        port getUserMedia = requestUserMedia userMedia.address { audio=True, video=False }
-}
requestUserMedia : S.Address (Maybe Stream) -> Options -> T.Task x ()
requestUserMedia address {audio,video} =
    {- big case expr to unwrap Either into getUserMedia.
    very very ugly and todo: refactor
    -}
    case audio of
        Left audioFlag ->
            case video of
                Left videoFlag ->
                    T.toMaybe (Native.UserMedia.getUserMedia {audio=audioFlag, video=videoFlag})
                        `T.andThen` S.send address 
                Right videoConstraints ->
                    T.toMaybe (Native.UserMedia.getUserMedia {audio=audioFlag, video=videoConstraints})
                        `T.andThen` S.send address 
        Right audioConstraints ->
            case video of
                Left videoFlag ->
                    T.toMaybe (Native.UserMedia.getUserMedia {audio=audioConstraints, video=videoFlag})
                        `T.andThen` S.send address 
                Right videoConstraints ->
                    T.toMaybe (Native.UserMedia.getUserMedia {audio=audioConstraints, video=videoConstraints})
                        `T.andThen` S.send address 


getTracks : Stream -> List Track
getTracks = Native.UserMedia.getTracks

getKind : Track -> TrackKind
getKind = Native.UserMedia.getMediaStreamTrackKind

getTrackState : Track -> TrackState
getTrackState = Native.UserMedia.getMediaStreamTrackState

removeTrack : Stream -> Track -> Stream
removeTrack = Native.UserMedia.removeTrack
