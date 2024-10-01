ui_print "🗡--------------------------------🗡"
ui_print "    Tecno Pova 5 Pro GSI Autocut    "
ui_print "🗡--------------------------------🗡"
ui_print "         By: Kanagawa Yamada        "
ui_print "------------------------------------"
ui_print "      READ THE TELEGRAM MESSAGE     "
ui_print "------------------------------------"
ui_print " "

# Set permissions
sleep 3

on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  ui_print "BYPASS START"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  mkdir -p $MODPATH/system/bin
  unzip -o "$ZIPFILE" 'autocut' -d $MODPATH/system/bin >&2
  
  
}

set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm $MODPATH/system/bin/P0 0 0 0755 0755
  set_perm $MODPATH/system/bin/P1 0 0 0755 0755

  # Here are some examples:
  # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
  # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
}

am start -a android.intent.action.VIEW -d https://t.me/KanagawaLabAnnouncement/74 >/dev/null 2>&1