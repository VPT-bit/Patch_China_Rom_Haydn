VOID='.locals 1
    return-void'
    
FALSE='.locals 1
    const/4 p0, 0x0
    return p0'

java -jar bin/apktool/apktool_2.9.3.jar d PowerKeeper.apk -o PowerKeeper
for file in $(find PowerKeeper/smali/com/miui/powerkeeper -type f -name *.smali); do
    python3 test.py "$file" "setScreenEffect" "$VOID"
done
for file in $(find PowerKeeper/smali/com/miui/powerkeeper -type f -name *.smali); do
    python3 test.py "$file" "setScreenEffectInternal" "$VOID"
done
for file in $(find PowerKeeper/smali/com/miui/powerkeeper -type f -name *.smali); do
    python3 test.py "$file" "getDisplayCtrlCode" "$FALSE"
done
java -jar bin/apktool/apktool_2.9.3.jar b PowerKeeper -o PowerKeeper_patched_raw.apk
sudo chmod +x bin/apktool/zipalign
./bin/apktool/zipalign -p -v 4 PowerKeeper_patched_raw.apk PowerKeeper_patched.apk
