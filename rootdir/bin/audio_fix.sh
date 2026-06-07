#!/system/bin/sh
# audio_fix.sh

sleep 120
logcat -c
LAST_HIT=0

log -p i -t AudioFix "Audio Fixer (System_Ext) Started."

while true; do
    NOW=$(date +%s)
    
    if logcat -d -t 500 | grep -F "AudioALSAPlaybackHandlerNormal: write(), mPcm == NULL"; then
        if [ $((NOW - LAST_HIT)) -gt 300 ]; then
            log -p w -t AudioFix "mPcm == NULL detected triggering restart"
            
            setprop sys.audio_fix.trigger 1
            
            LAST_HIT=$NOW
            logcat -c
            sleep 120
        fi
    fi
    sleep 30
done
