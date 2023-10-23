add_luci_statistics_conffiles()
{
	local filelist="$1"
	# create a backup if needed
	/etc/init.d/luci_statistics backups_enabled && {
		echo "/etc/luci_statistics/rrdbackup.tgz" >>$filelist
		### If statistics are running, trigger a backup now.
		### (If not running, then it saved backups already)
		/etc/init.d/luci_statistics status >/dev/null 2>&1 && /etc/init.d/luci_statistics backup
	}
}


sysupgrade_init_conffiles="$sysupgrade_init_conffiles add_luci_statistics_conffiles"
