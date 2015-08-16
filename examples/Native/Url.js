Elm.Native.Url = {};
Elm.Native.Url.make = function(elm) {
    elm.Native = elm.Native || {};
    elm.Native.Url = elm.Native.Url || {};

    if (elm.Native.Url.values) return elm.Native.Url.values;

    // var Task = Elm.Native.Task.make(elm);
    // var Utils = Elm.Native.Utils.make(elm);

    var venderUrl = window.URL || window.webkitURL;

    if (!venderUrl) {
        console.log("URL not supported.");
        // how to handle this idiomatically in Elm?
        return;
    }

    // https://developer.mozilla.org/en-US/docs/Web/API/URL
    function createObjectURL(fileOrBlob) {
        var venderUrl = window.URL || window.webkitURL;
        return venderUrl.createObjectURL(fileOrBlob);
    }
    
    function revokeObjectURL(objectUrl) {
        var venderUrl = window.URL || window.webkitURL;
        return venderUrl.createObjectURL(objectUrl);
    }

    var values = {
        createObjectURL: createObjectURL,
        revokeObjectURL: revokeObjectURL
    };

    // function getUserMediaWrapper(options) {
    //     return Task.asyncFunction(function(callback) {
    //         navigator.getUserMedia(options, function(stream) {
    //             callback(Task.succeed(stream))
    //         }, function(error) {
    //             callback(Task.fail(error));
    //         });
    //     });
    // };

    return Elm.Native.Url.values = values;
}
