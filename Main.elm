module Main where

{- Sketch/idea of how one might bring getUserMedia into Elm
-} 

import StartApp
import UserMedia
import Window
import Html exposing (..)
import Signal exposing (..)
import Html.Events exposing (onClick)


main =
    StartApp.start { model = model, view = view, update = update }


type alias Model
        = Maybe UserMedia.MediaStream

{- Nothing if user denies microphone access, update to
   Just UserMedia.MediaStream if access is granted.
-}
model = Nothing


view : Address action -> model -> Html
view address model =
    div [] []

type Action = Init

update : Action -> Model -> Model
update _ model = 
    case model of
        Nothing -> tryGetMicrophone
        m -> m

tryGetMicrophone =
    UserMedia.getUserMedia {audio=True,video=False} (Just) (\_ -> Nothing)
