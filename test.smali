.method private parseTopSmartAppFromDb(Ljava/lang/String;Landroid/util/ArraySet;)V
    .registers 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Landroid/util/ArraySet<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 1
    if-nez p1, :cond_68

    .line 2
    .line 3
    iget-object p1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCloudObserver:Lz0/a;

    .line 4
    .line 5
    sget v0, Lz0/b;->l:I

    .line 6
    .line 7
    invoke-virtual {p1, v0}, Lz0/a;->l(I)Lorg/json/JSONObject;

    .line 8
    .line 9
    .line 10
    move-result-object p1

    .line 11
    iget-object v1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCloudObserver:Lz0/a;

    .line 12
    .line 13
    invoke-virtual {v1, v0}, Lz0/a;->s(I)Z

    .line 14
    .line 15
    .line 16
    move-result v1

    .line 17
    const/4 v2, 0x0

    .line 18
    const-string v3, "fps_smart_group"

    .line 19
    .line 20
    if-eqz v1, :cond_3f

    .line 21
    .line 22
    if-eqz p1, :cond_3f

    .line 23
    .line 24
    sget-object v1, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCloudControlStatus:Landroid/util/ArrayMap;

    .line 25
    .line 26
    sget-object v4, Lz0/b;->R:Ljava/util/ArrayList;

    .line 27
    .line 28
    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 29
    .line 30
    .line 31
    move-result-object v0

    .line 32
    check-cast v0, Ljava/lang/String;

    .line 33
    .line 34
    sget-object v4, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 35
    .line 36
    invoke-virtual {v1, v0, v4}, Landroid/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 37
    .line 38
    .line 39
    invoke-virtual {p1, v3, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 40
    .line 41
    .line 42
    move-result-object p1

    .line 43
    new-instance v0, Ljava/lang/StringBuilder;

    .line 44
    .line 45
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 46
    .line 47
    .line 48
    const-string v1, "parseTopSmartAppFromDb new cloud = "

    .line 49
    .line 50
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 51
    .line 52
    .line 53
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 54
    .line 55
    .line 56
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 57
    .line 58
    .line 59
    move-result-object v0

    .line 60
    invoke-direct {p0, v0}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 61
    .line 62
    .line 63
    goto :goto_68

    .line 64
    :cond_3f
    sget-object p1, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mCloudControlStatus:Landroid/util/ArrayMap;

    .line 65
    .line 66
    sget-object v1, Lz0/b;->R:Ljava/util/ArrayList;

    .line 67
    .line 68
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 69
    .line 70
    .line 71
    move-result-object v0

    .line 72
    check-cast v0, Ljava/lang/String;

    .line 73
    .line 74
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 75
    .line 76
    invoke-virtual {p1, v0, v1}, Landroid/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 77
    .line 78
    .line 79
    iget-object p1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mContext:Landroid/content/Context;

    .line 80
    .line 81
    invoke-static {p1, v3, v2}, Lcom/miui/powerkeeper/provider/SimpleSettings$Misc;->getString(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 82
    .line 83
    .line 84
    move-result-object p1

    .line 85
    new-instance v0, Ljava/lang/StringBuilder;

    .line 86
    .line 87
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 88
    .line 89
    .line 90
    const-string v1, "parseTopSmartAppFromDb old cloud = "

    .line 91
    .line 92
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 93
    .line 94
    .line 95
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 96
    .line 97
    .line 98
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 99
    .line 100
    .line 101
    move-result-object v0

    .line 102
    invoke-direct {p0, v0}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 103
    .line 104
    .line 105
    :cond_68
    :goto_68
    iget-object v0, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mTopSmartApps:Landroid/util/ArrayMap;

    .line 106
    .line 107
    invoke-virtual {v0}, Landroid/util/ArrayMap;->clear()V

    .line 108
    .line 109
    .line 110
    invoke-direct {p0}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->getSupportFps()[I

    .line 111
    .line 112
    .line 113
    move-result-object v0

    .line 114
    const/16 v1, 0x100

    .line 115
    .line 116
    const/4 v2, 0x3

    .line 117
    const/16 v3, 0x18

    .line 118
    .line 119
    const-string v4, "setScreenEffect enable blacklist"

    .line 120
    .line 121
    const-string v5, "mIsWhiteFpsList = true "

    .line 122
    .line 123
    const-string v6, "defaultFps"

    .line 124
    .line 125
    const/16 v7, 0x3c

    .line 126
    .line 127
    if-eqz p1, :cond_197

    .line 128
    .line 129
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    .line 130
    .line 131
    .line 132
    move-result v8

    .line 133
    if-eqz v8, :cond_88

    .line 134
    .line 135
    goto/16 :goto_197

    .line 136
    .line 137
    :cond_88
    if-nez p2, :cond_8e

    .line 138
    .line 139
    invoke-static {}, Lcom/miui/powerkeeper/utils/PowerKeeperPackageManager;->getInstalledThirdPartApps()Landroid/util/ArraySet;

    .line 140
    .line 141
    .line 142
    move-result-object p2

    .line 143
    :cond_8e
    :try_start_8e
    new-instance v8, Lorg/json/JSONObject;

    .line 144
    .line 145
    invoke-direct {v8, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 146
    .line 147
    .line 148
    iget-boolean v9, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mIsWhiteFpsList:Z

    .line 149
    .line 150
    if-eqz v9, :cond_9d

    .line 151
    .line 152
    invoke-direct {p0, v5}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 153
    .line 154
    .line 155
    iput v7, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 156
    .line 157
    goto :goto_ab

    .line 158
    :cond_9d
    invoke-static {v6, v7}, Lmiui/util/FeatureParser;->getInteger(Ljava/lang/String;I)I

    .line 159
    .line 160
    .line 161
    move-result v5

    .line 162
    iput v5, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 163
    .line 164
    if-ne v5, v7, :cond_ab

    .line 165
    .line 166
    invoke-static {v0, v5}, Lcom/miui/powerkeeper/utils/Utils;->getArrayMaxMember([II)I

    .line 167
    .line 168
    .line 169
    move-result v5

    .line 170
    iput v5, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 171
    .line 172
    :cond_ab
    :goto_ab
    invoke-direct {p0, v4}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 173
    .line 174
    .line 175
    invoke-static {}, Lmiui/hardware/display/DisplayFeatureManager;->getInstance()Lmiui/hardware/display/DisplayFeatureManager;

    .line 176
    .line 177
    .line 178
    move-result-object v4

    .line 179
    invoke-virtual {v4, v3, v2, v1}, Lmiui/hardware/display/DisplayFeatureManager;->setScreenEffect(III)V

    .line 180
    .line 181
    .line 182
    iget v1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I
    :try_end_b7
    .catch Lorg/json/JSONException; {:try_start_8e .. :try_end_b7} :catch_181

    .line 183
    .line 184
    const-string v2, ","

    .line 185
    .line 186
    const-string v3, ""

    .line 187
    .line 188
    const/4 v4, 0x0

    .line 189
    if-eq v7, v1, :cond_e9

    .line 190
    .line 191
    :try_start_be
    const-string v1, "list60"

    .line 192
    .line 193
    invoke-virtual {v8, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 194
    .line 195
    .line 196
    move-result-object v1

    .line 197
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    .line 198
    .line 199
    .line 200
    move-result v5

    .line 201
    if-nez v5, :cond_e9

    .line 202
    .line 203
    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 204
    .line 205
    .line 206
    move-result-object v1

    .line 207
    move v5, v4

    .line 208
    :goto_cf
    array-length v6, v1

    .line 209
    if-ge v5, v6, :cond_e9

    .line 210
    .line 211
    aget-object v6, v1, v5

    .line 212
    .line 213
    invoke-virtual {p0, v6, p2}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->isInstalledPackage(Ljava/lang/String;Landroid/util/ArraySet;)Z

    .line 214
    .line 215
    .line 216
    move-result v6

    .line 217
    if-nez v6, :cond_db

    .line 218
    .line 219
    goto :goto_e6

    .line 220
    :cond_db
    iget-object v6, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mTopSmartApps:Landroid/util/ArrayMap;

    .line 221
    .line 222
    aget-object v9, v1, v5

    .line 223
    .line 224
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 225
    .line 226
    .line 227
    move-result-object v10

    .line 228
    invoke-virtual {v6, v9, v10}, Landroid/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 229
    .line 230
    .line 231
    :goto_e6
    add-int/lit8 v5, v5, 0x1

    .line 232
    .line 233
    goto :goto_cf

    .line 234
    :cond_e9
    const/16 v1, 0x5a

    .line 235
    .line 236
    invoke-direct {p0, v0, v1}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->getSuitableFps([II)I

    .line 237
    .line 238
    .line 239
    move-result v1

    .line 240
    iget v5, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 241
    .line 242
    if-eq v1, v5, :cond_11e

    .line 243
    .line 244
    const-string v5, "list90"

    .line 245
    .line 246
    invoke-virtual {v8, v5, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 247
    .line 248
    .line 249
    move-result-object v5

    .line 250
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    .line 251
    .line 252
    .line 253
    move-result v6

    .line 254
    if-nez v6, :cond_11e

    .line 255
    .line 256
    invoke-virtual {v5, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 257
    .line 258
    .line 259
    move-result-object v5

    .line 260
    move v6, v4

    .line 261
    :goto_104
    array-length v7, v5

    .line 262
    if-ge v6, v7, :cond_11e

    .line 263
    .line 264
    aget-object v7, v5, v6

    .line 265
    .line 266
    invoke-virtual {p0, v7, p2}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->isInstalledPackage(Ljava/lang/String;Landroid/util/ArraySet;)Z

    .line 267
    .line 268
    .line 269
    move-result v7

    .line 270
    if-nez v7, :cond_110

    .line 271
    .line 272
    goto :goto_11b

    .line 273
    :cond_110
    iget-object v7, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mTopSmartApps:Landroid/util/ArrayMap;

    .line 274
    .line 275
    aget-object v9, v5, v6

    .line 276
    .line 277
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 278
    .line 279
    .line 280
    move-result-object v10

    .line 281
    invoke-virtual {v7, v9, v10}, Landroid/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 282
    .line 283
    .line 284
    :goto_11b
    add-int/lit8 v6, v6, 0x1

    .line 285
    .line 286
    goto :goto_104

    .line 287
    :cond_11e
    const/16 v1, 0x78

    .line 288
    .line 289
    invoke-direct {p0, v0, v1}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->getSuitableFps([II)I

    .line 290
    .line 291
    .line 292
    move-result v0

    .line 293
    iget v1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 294
    .line 295
    if-eq v0, v1, :cond_153

    .line 296
    .line 297
    const-string v1, "list120"

    .line 298
    .line 299
    invoke-virtual {v8, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 300
    .line 301
    .line 302
    move-result-object v1

    .line 303
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    .line 304
    .line 305
    .line 306
    move-result v3

    .line 307
    if-nez v3, :cond_153

    .line 308
    .line 309
    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    .line 310
    .line 311
    .line 312
    move-result-object v1

    .line 313
    move v2, v4

    .line 314
    :goto_139
    array-length v3, v1

    .line 315
    if-ge v2, v3, :cond_153

    .line 316
    .line 317
    aget-object v3, v1, v2

    .line 318
    .line 319
    invoke-virtual {p0, v3, p2}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->isInstalledPackage(Ljava/lang/String;Landroid/util/ArraySet;)Z

    .line 320
    .line 321
    .line 322
    move-result v3

    .line 323
    if-nez v3, :cond_145

    .line 324
    .line 325
    goto :goto_150

    .line 326
    :cond_145
    iget-object v3, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mTopSmartApps:Landroid/util/ArrayMap;

    .line 327
    .line 328
    aget-object v5, v1, v2

    .line 329
    .line 330
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    .line 331
    .line 332
    .line 333
    move-result-object v6

    .line 334
    invoke-virtual {v3, v5, v6}, Landroid/util/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 335
    .line 336
    .line 337
    :goto_150
    add-int/lit8 v2, v2, 0x1

    .line 338
    .line 339
    goto :goto_139

    .line 340
    :cond_153
    const-string/jumbo p2, "videoGameSwitch"

    .line 341
    .line 342
    .line 343
    invoke-virtual {v8, p2, v4}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    .line 344
    .line 345
    .line 346
    move-result p2

    .line 347
    iput-boolean p2, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mVideoGameSwitch:Z

    .line 348
    .line 349
    iget-boolean p2, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->DBG_DISPLAY:Z

    .line 350
    .line 351
    if-eqz p2, :cond_196

    .line 352
    .line 353
    const-string p2, "DisplayFrameSetting"

    .line 354
    .line 355
    new-instance v0, Ljava/lang/StringBuilder;

    .line 356
    .line 357
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 358
    .line 359
    .line 360
    const-string v1, "parseTopSmartAppFromDb mTopSmartApps="

    .line 361
    .line 362
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 363
    .line 364
    .line 365
    iget-object v1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mTopSmartApps:Landroid/util/ArrayMap;

    .line 366
    .line 367
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 368
    .line 369
    .line 370
    const-string v1, " appJsonStr="

    .line 371
    .line 372
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 373
    .line 374
    .line 375
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 376
    .line 377
    .line 378
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 379
    .line 380
    .line 381
    move-result-object p1

    .line 382
    invoke-static {p2, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_180
    .catch Lorg/json/JSONException; {:try_start_be .. :try_end_180} :catch_181

    .line 383
    .line 384
    .line 385
    goto :goto_196

    .line 386
    :catch_181
    move-exception p1

    .line 387
    new-instance p2, Ljava/lang/StringBuilder;

    .line 388
    .line 389
    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    .line 390
    .line 391
    .line 392
    const-string v0, "parseTopDefaultAppFromDb e="

    .line 393
    .line 394
    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 395
    .line 396
    .line 397
    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 398
    .line 399
    .line 400
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 401
    .line 402
    .line 403
    move-result-object p1

    .line 404
    invoke-direct {p0, p1}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 405
    .line 406
    .line 407
    :cond_196
    :goto_196
    return-void

    .line 408
    :cond_197
    :goto_197
    const-string p1, "parseTopSmartAppFromDb empty"

    .line 409
    .line 410
    invoke-direct {p0, p1}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 411
    .line 412
    .line 413
    iget-boolean p1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mIsWhiteFpsList:Z

    .line 414
    .line 415
    if-eqz p1, :cond_1a6

    .line 416
    .line 417
    invoke-direct {p0, v5}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 418
    .line 419
    .line 420
    iput v7, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 421
    .line 422
    goto :goto_1be

    .line 423
    :cond_1a6
    invoke-static {v6, v7}, Lmiui/util/FeatureParser;->getInteger(Ljava/lang/String;I)I

    .line 424
    .line 425
    .line 426
    move-result p1

    .line 427
    iput p1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 428
    .line 429
    if-ne p1, v7, :cond_1b4

    .line 430
    .line 431
    invoke-static {v0, p1}, Lcom/miui/powerkeeper/utils/Utils;->getArrayMaxMember([II)I

    .line 432
    .line 433
    .line 434
    move-result p1

    .line 435
    iput p1, p0, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->mDefaultFps:I

    .line 436
    .line 437
    :cond_1b4
    invoke-direct {p0, v4}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->writeLocalLog(Ljava/lang/String;)V

    .line 438
    .line 439
    .line 440
    invoke-static {}, Lmiui/hardware/display/DisplayFeatureManager;->getInstance()Lmiui/hardware/display/DisplayFeatureManager;

    .line 441
    .line 442
    .line 443
    move-result-object p0

    .line 444
    invoke-virtual {p0, v3, v2, v1}, Lmiui/hardware/display/DisplayFeatur

.method public displayControl(I)V
    .registers 4

    .line 1
    iget v0, p0, Lcom/miui/powerkeeper/feedbackcontrol/ThermalManager;->fpsLast:I

    .line 2
    .line 3
    if-eq p1, v0, :cond_15

    .line 4
    .line 5
    iget-object v0, p0, Lcom/miui/powerkeeper/feedbackcontrol/ThermalManager;->mDisplayFeatureManager:Lmiui/hardware/display/DisplayFeatureManager;

    .line 6
    .line 7
    if-eqz v0, :cond_15

    .line 8
    .line 9
    invoke-static {}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->getDFSInstance()Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;

    .line 10
    .line 11
    .line 12
    move-result-object v0

    .line 13
    if-eqz v0, :cond_15

    .line 14
    .line 15
    const/16 v1, 0xfd

    .line 16
    .line 17
    invoke-virtual {v0, p1, v1}, Lcom/miui/powerkeeper/statemachine/DisplayFrameSetting;->setScreenEffect(II)V

    .line 18
    .line 19
    .line 20
    iput p1, p0, Lcom/miui/powerkeeper/feedbackcontrol/ThermalManager;->fpsLast:I

    .line 21
    .line 22
    :cond_15
    return-void
.end method