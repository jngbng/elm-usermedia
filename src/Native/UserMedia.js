Elm.Native.UserMedia = {};
Elm.Native.UserMedia.make = function(elm) {
    elm.Native = elm.Native || {};
    elm.Native.UserMedia = elm.Native.UserMedia || {};

    if (elm.Native.UserMedia.values) return elm.Native.UserMedia.values;

    var Task = Elm.Native.Task.make(elm);
    var Utils = Elm.Native.Utils.make(elm);

    navigator.getUserMedia = navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia;

    if (!navigator.getUserMedia) {
        console.log("getUserMedia not supported.");

        // how to handle this idiomatically in Elm?
        return;
    }
    
    function getUserMediaWrapper(options, callback) {
        return Task.asyncFunction(function() { // <- function should take an argument? 
            navigator.getUserMedia(options, function(stream) {

                // this part doesn't feel quite right
                Task.succeed(Utils.Tuple0);
                console.log("success");
                callback(stream);

                // if I did instead:
                // callback(Task.succeed(stream))
                // then I'd have
                // getUserMedia : Task x MediaStream ? 

            }, function(error) {
                console.log("failure");
                Task.fail(error);
            });
        });
    };

    var values = {
        getUserMedia: F2(getUserMediaWrapper)
    };

    return Elm.Native.UserMedia.values = values;
}
