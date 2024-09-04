.class Lcom/xiaomi/joyose/cloud/h$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/xiaomi/joyose/cloud/h;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Z

.field final synthetic b:Lcom/xiaomi/joyose/cloud/h;


# direct methods
.method constructor <init>(Lcom/xiaomi/joyose/cloud/h;Z)V
    .registers 3

    .line 1
    iput-object p1, p0, Lcom/xiaomi/joyose/cloud/h$a;->b:Lcom/xiaomi/joyose/cloud/h;

    iput-boolean p2, p0, Lcom/xiaomi/joyose/cloud/h$a;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 7

    .line 1
    iget-boolean v0, p0, Lcom/xiaomi/joyose/cloud/h$a;->a:Z

    const-string v1, "CloudStrategy"

    if-nez v0, :cond_4b

    .line 2
    iget-object v0, p0, Lcom/xiaomi/joyose/cloud/h$a;->b:Lcom/xiaomi/joyose/cloud/h;

    invoke-static {v0}, Lcom/xiaomi/joyose/cloud/h;->a(Lcom/xiaomi/joyose/cloud/h;)Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/xiaomi/joyose/smartop/smartp/a;->b(Landroid/content/Context;)J

    move-result-wide v2

    const/4 v0, 0x0

    const-string v4, "persist.sys.sc_allow_conn"

    .line 3
    invoke-static {v4, v0}, Lcom/xiaomi/joyose/d/f;->a(Ljava/lang/String;Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "count is "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v5, " allow connect: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/xiaomi/joyose/smartop/c/b;->c(Ljava/lang/String;Ljava/lang/String;)I

    const-wide/16 v4, 0x0

    cmp-long v1, v2, v4

    if-gtz v1, :cond_45

    if-nez v0, :cond_45

    .line 5
    iget-object v0, p0, Lcom/xiaomi/joyose/cloud/h$a;->b:Lcom/xiaomi/joyose/cloud/h;

    invoke-static {v0}, Lcom/xiaomi/joyose/cloud/h;->b(Lcom/xiaomi/joyose/cloud/h;)V

    goto :goto_55

    .line 6
    :cond_45
    iget-object v0, p0, Lcom/xiaomi/joyose/cloud/h$a;->b:Lcom/xiaomi/joyose/cloud/h;

    invoke-static {v0}, Lcom/xiaomi/joyose/cloud/h;->e(Lcom/xiaomi/joyose/cloud/h;)V

    goto :goto_55

    :cond_4b
    const-string v0, "job exist, sync local..."

    .line 7
    invoke-static {v1, v0}, Lcom/xiaomi/joyose/smartop/c/b;->c(Ljava/lang/String;Ljava/lang/String;)I

    .line 8
    iget-object v0, p0, Lcom/xiaomi/joyose/cloud/h$a;->b:Lcom/xiaomi/joyose/cloud/h;

    invoke-virtual {v0}, Lcom/xiaomi/joyose/cloud/h;->b()V

    :goto_55
    return-void
.end method
