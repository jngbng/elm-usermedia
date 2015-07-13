Elm.Native.UserMedia = {};
Elm.Native.UserMedia.make = function(elm) {
    elm.Native = elm.Native || {};
    elm.Native.UserMedia = elm.Native.UserMedia || {};

    if (elm.Native.UserMedia.values) return elm.Native.UserMedia.values;
    
    var values = {};

    values.getUserMedia = F3(function(constraints, successCallback, errorCallback) {
        navigator.webkitGetUserMedia(constraints, successCallback, errorCallback);
    });

    return Elm.Native.UserMedia.values = values;
}
