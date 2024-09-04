void='.locals 1
    return-void'
    
FALSE='.locals 1
    const/4 p0, 0x0
    return p0'
    
python3 test.py test.smali "setScreenEffect" "$void"
python3 test.py test.smali "setScreenEffectInternal" "$void"
python3 test.py test.smali "cc" "$FALSE"
