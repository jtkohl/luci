add_luci_statistics_conffiles()
{
	local filelist="$1"
	# create a backup if needed
	local rrd_enabled=$(uci -q get luci_statistics.collectd_rrdtool.enable)
	local rrd_backups_enabled=$(uci -q get luci_statistics.collectd_rrdtool.backup)
	local rrd_dir=$(uci -q get luci_statistics.collectd_rrdtool.DataDir)

	### Backups are enabled if RRD is enabled, backups enabled, and the data directory name is non-empty
	[ "$rrd_enabled" = "1" \
		 -a "$rrd_backups_enabled" = "1" \
		 -a -n "$rrd_dir" ] && {
		echo "/etc/luci_statistics/rrdbackup.tgz" >>$filelist
		### If statistics are running, trigger a backup now
		/etc/init.d/luci_statistics status >/dev/null 2>&1 && /etc/init.d/luci_statistics backup
	}
}


sysupgrade_init_conffiles="$sysupgrade_init_conffiles add_luci_statistics_conffiles"
