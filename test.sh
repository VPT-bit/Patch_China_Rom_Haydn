java -jar bin/apktool/apktool.jar -r -b -f d -c -api 34 --use-aapt2 PowerKeeper.apk -o tmp/PowerKeeper
VOID='.locals 1
    return-void'
python3 test.py "test.smali" "parseTopSmartAppFromDb" "$VOID"
