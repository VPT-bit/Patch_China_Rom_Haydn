.method public setScreenEffect(II)V
    .registers 4

    .line 1
    iget-boolean v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->FPS_SWITCH_DEFAULT:Z

    if-eqz v0, :cond_18

    .line 2
    iget-boolean v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->FPS_SWITCH_THERMAL:Z

    if-eqz v0, :cond_18

    const/16 v0, 0xfd

    if-ne p2, v0, :cond_18

    .line 3
    iget-object p0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mContext:Landroid/content/Context;

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string/jumbo v0, "thermal_limit_refresh_rate"

    invoke-static {p0, v0, p1}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 4
    :cond_18
    invoke-static {}, Lmiui/hardware/display/DisplayFeatureManager;->getInstance()Lmiui/hardware/display/DisplayFeatureManager;

    move-result-object p0

    const/16 v0, 0x18

    invoke-virtual {p0, v0, p1, p2}, Lmiui/hardware/display/DisplayFeatureManager;->setScreenEffect(III)V

    return-void
.end method

.method private setScreenEffect(Ljava/lang/String;II)V
    .registers 20

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    .line 5
    iget v4, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mIsUltimate:I

    const-string v5, "miui_refresh_rate"

    const/16 v6, 0xfe

    const/16 v7, 0xf7

    const/4 v8, 0x1

    if-ne v4, v8, :cond_35

    if-eq v3, v6, :cond_35

    if-eq v3, v7, :cond_35

    const-string v4, "com.android.camera"

    .line 6
    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_35

    .line 7
    iget v1, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCurrentFps:I

    iget v2, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mUserFps:I

    if-eq v1, v2, :cond_34

    .line 8
    iget-object v1, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    iget v2, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mUserFps:I

    invoke-static {v1, v5, v2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 9
    iget v1, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mUserFps:I

    iput v1, v0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCurrentFps:I

    :cond_34
    return-void
.end method

.method private setScreenEffectInternal(IILjava/lang/String;)V
    .registers 7

    .line 1
    iget-boolean v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->FPS_SWITCH_DEFAULT:Z

    .line 3
    const/16 v1, 0x18

    .line 5
    if-eqz v0, :cond_53

    .line 7
    iget v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCurrentFps:I

    .line 9
    if-eq v0, p1, :cond_15

    .line 11
    iget-object v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mContext:Landroid/content/Context;

    .line 13
    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    .line 16
    move-result-object v0

    .line 17
    const-string v2, "miui_refresh_rate"

    .line 19
    invoke-static {v0, v2, p1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 22
    :cond_15
    iget v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCurrentCookie:I

    .line 24
    if-eq v0, p2, :cond_5a

    .line 26
    invoke-direct {p0, p2}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->wifiLogControl(I)V

    .line 29
    invoke-static {}, Lmiui/hardware/display/DisplayFeatureManager;->getInstance()Lmiui/hardware/display/DisplayFeatureManager;

    .line 32
    move-result-object v0

    .line 33
    invoke-virtual {v0, v1, p1, p2}, Lmiui/hardware/display/DisplayFeatureManager;->setScreenEffect(III)V

    .line 36
    iget-boolean v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->IS_ENABLE_SMART_DFPS:Z

    .line 38
    if-eqz v0, :cond_5a

    .line 40
    iget-boolean v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->IS_ENABLE_CONTENT_DETECTION:Z

    .line 42
    if-eqz v0, :cond_5a

    .line 44
    invoke-direct {p0, p2, p1, p3}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->notifySFDfpsMode(IILjava/lang/String;)V

    .line 47
    new-instance v0, Ljava/lang/StringBuilder;

    .line 49
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 52
    const-string v1, "WhitelistPolicy notifySFDfpsMode run cookie="

    .line 54
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 57
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 60
    const-string v1, "fps="

    .line 62
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 65
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 68
    const-string v1, "pkg="

    .line 70
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 73
    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 76
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 79
    move-result-object p3

    .line 80
    invoke-direct {p0, p3}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 83
    goto :goto_5a

    .line 84
    :cond_53
    invoke-static {}, Lmiui/hardware/display/DisplayFeatureManager;->getInstance()Lmiui/hardware/display/DisplayFeatureManager;

    .line 87
    move-result-object p3

    .line 88
    invoke-virtual {p3, v1, p1, p2}, Lmiui/hardware/display/DisplayFeatureManager;->setScreenEffect(III)V

    .line 91
    :cond_5a
    :goto_5a
    iput p1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCurrentFps:I

    .line 93
    iput p2, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCurrentCookie:I

    .line 95
    return-void
.end method

.method public getDisplayCtrlCode()I
    .registers 2

    .line 1
    iget p0, p0, Lcom/miui/powerkeeper/feedbackcontrol/ThermalManager;->mTempStateNow:I

    .line 3
    const v0, 0x989680

    .line 6
    div-int/2addr p0, v0

    .line 7
    rem-int/lit8 p0, p0, 0xa

    .line 9
    return p0
.end method
