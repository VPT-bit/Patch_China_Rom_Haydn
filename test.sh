java -jar bin/apktool/apktool.jar -r -b -f d -c -api 34 --use-aapt2 PowerKeeper.apk -o tmp/PowerKeeper
VOID='.locals 1
    return-void'
python3 test.py "tmp/PowerKeeper/smali/com/miui/powerkeeper/statemachine/DisplayFrameSetting.smali" "setScreenEffect" "$VOID"
