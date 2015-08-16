module Url where
{-| An interface for window.URL

# Definition
@docs Options, MediaStream, MediaStreamError, requestUserMedia

-}

import Native.Url

{-| a
-}
createObjectURL : { active:Signal Bool , ended:Signal Bool , label:String , id:String} -> String
createObjectURL = Native.Url.createObjectURL
