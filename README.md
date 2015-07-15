# elm-usermedia
elm wrapper for ```navigator.getUserMedia```

## usage
See ```examples/Example.elm```.

Basically, the ```UserMedia``` module exports some types needed
to work with getUserMedia, and a function ``` requestUserMedia :
Signal.Address (Maybe MediaStream) -> Options -> Task x () ```
which takes an address to a mailbox that will receive the
```MediaStream``` if the user accepts. ```Options``` correspond
to
[MediaStreamConstraints](http://w3c.github.io/mediacapture-main/getusermedia.html#mediastreamconstraints)
(currently very partially implemented). Obtaining
microphone/webcam stream is just a matter of initializing a
mailbox and handing ```requestUserMedia mailbox.address
options``` to a port.
