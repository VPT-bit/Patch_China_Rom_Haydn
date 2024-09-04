VOID='.locals 1
    return-void'
    
FALSE='.locals 1
    const/4 p0, 0x0
    return p0'
target_dir="PowerKeeper/smali/com/miui/powerkeeper"
java -jar bin/apktool/apktool_2.9.3.jar d PowerKeeper.apk -o PowerKeeper
python3 test.py "$target_dir/statemachine/DisplayFrameSetting.smali" "setScreenEffect" "$VOID"
python3 test py "$target_dir/statemachine/DisplayFrameSetting.smali" "setScreenEffectInternal" "$VOID"
python3 test.py "$target_dir/feedbackcontrol/ThermalManager.smali" "getDisplayCtrlCode" "$FALSE"
java -jar bin/apktool/apktool_2.9.3.jar b PowerKeeper -o PowerKeeper_patched_raw.apk
zipalign -p -v 4 PowerKeeper_patched_raw.apk PowerKeeper_patched.apk
