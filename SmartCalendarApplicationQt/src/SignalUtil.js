.pragma library

// connects to the signal and calls the slot exactly once
function connectOnce(sig, slot) {
    var f = function() {
        slot.apply(this, arguments)
        sig.disconnect(f)
    }
    sig.connect(f)
}
