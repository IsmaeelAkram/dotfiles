#!/bin/zsh
# Moves Picture-in-Picture windows to whichever workspace becomes active (run by the
# local.omniwm.pip-follow LaunchAgent). Needed because OmniWM 0.8 leaves PiP unmanaged only when
# Chrome's title is "Picture-in-picture", but Chrome uses "Picture in Picture", so OmniWM manages it
# and hides it with its workspace. Needs ipcEnabled = true in OmniWM.
C=/Applications/OmniWM.app/Contents/MacOS/omniwmctl
JQ=/usr/bin/jq
ws_of() { print -r -- "$1" | "$JQ" -r 'select(.kind == "event") | .result.payload.workspace.rawName // empty'; }
"$C" subscribe active-workspace --reconnect --format ndjson | while IFS= read -r line; do
    ws=$(ws_of "$line")
    # Act only after 0.25 s without events: moving while OmniWM is still parking the window from the
    # switch (or mid focus-bounce) made it reappear in the wrong spot.
    while IFS= read -r -t 0.25 line; do w=$(ws_of "$line"); [[ -n $w ]] && ws=$w; done
    [[ -n $ws ]] || continue
    "$C" query windows --fields id,title,workspace --format json \
        | "$JQ" -r --arg ws "$ws" '.result.payload.windows[]
            | select((.title // "") | test("^Picture[- ]in[- ]picture$"; "i"))
            | select(.workspace.rawName != $ws) | .id' \
        | while IFS= read -r id; do "$C" window move-to-workspace "$id" "$ws" >/dev/null 2>&1; done
done
