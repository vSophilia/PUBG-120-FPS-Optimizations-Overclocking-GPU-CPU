#!/bin/sh



check_file() {
  if [[ -f "$1" ]]; then
    return 0
  else
    return 1
  fi
}

read_file_unlock() {
  if check_file "$1"; then
    chmod 444 "$1"
    cat "$1"
  fi
}

write_file_lock() {
  if check_file "$1"; then
    chmod 666 "$1"
    echo "$2" > "$1"
    chmod 444 "$1"
  fi
}

sleep 30

chmod 000 /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_max_freq
chmod 000 /sys/devices/system/cpu/cpu0/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu1/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu2/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu3/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu4/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu5/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu6/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu7/cpu_capacity
chmod 000 /sys/devices/system/cpu/cpu0/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu1/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu2/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu3/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu4/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu5/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu6/topology/physical_package_id
chmod 000 /sys/devices/system/cpu/cpu7/topology/physical_package_id
echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
echo 0 > /sys/devices/system/cpu/cpu6/core_ctl/enable

rm /data/media/0/.fstrim.txt
rm /data/media/0/.fstrimm.txt

function wait_sixty_second() {
sleep 30
}

function get_busybox_dir() {
BUSYBOX=$(find /data/adb/ -type f -name busybox | head -n 1)
}

function create_log_file() {
touch /data/media/0/.fstrim.txt
touch /data/media/0/.fstrimm.txt
}

function set_log_dir() {
LOG=/data/media/0/.fstrim.txt
}

function set_log_dirr() {
LOVG=/data/media/0/.fstrimm.txt
}

function get_exec_date() {
DATE=${date}
}

function run_fstrim_debug() {
$BUSYBOX fstrim -v $1 >> "$LOG"
}

function run_fstrim_magisk() {
$BUSYBOX fstrim -v $1 >> "$LOVG"
}

get_busybox_dir
create_log_file
set_log_dir
set_log_dirr
wait_sixty_second

run_fstrim_debug /system
run_fstrim_debug /vendor
run_fstrim_debug /metadata
run_fstrim_debug /odm
run_fstrim_debug /system_ext
run_fstrim_debug /data
run_fstrim_debug /cache

echo "0" > /proc/sys/kernel/panic
echo "0" > /proc/sys/kernel/panic_on_oops
echo "0" > /proc/sys/kernel/panic_on_rcu_stall
echo "0" > /proc/sys/kernel/panic_on_warn
echo "0" > /sys/module/kernel/parameters/panic
echo "0" > /sys/module/kernel/parameters/panic_on_warn
echo "0" > /sys/module/kernel/parameters/panic_on_oops
echo "0" > /sys/vm/panic_on_oom

write_file_lock "/proc/sys/kernel/printk" "0 0 0 0"
write_file_lock "/proc/sys/kernel/printk_devkmsg" "off"
write_file_lock "/sys/module/printk/parameters/console_suspend" "Y"
write_file_lock "/sys/module/printk/parameters/cpu" "N"
write_file_lock "/sys/module/printk/parameters/ignore_loglevel" "Y"
write_file_lock "/sys/module/printk/parameters/pid" "N"
write_file_lock "/sys/module/printk/parameters/time" "N"
write_file_lock "/sys/kernel/printk_mode/printk_mode" "0"

chmod 666 /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
chmod 666 /sys/devices/system/cpu/cpufreq/policy6/scaling_governor
chmod 666 /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/governor
chmod 666 /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling
chmod 666 /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/thermal_pwrlevel
chmod 666 /dev/cpuset/foreground/boost/cpus

echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor
echo "performance" > /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/governor
echo "0" > /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling
echo "0" > /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/thermal_pwrlevel

write_file_lock /sys/devices/system/cpu/cpufreq/policy0/scaling_governor performance
write_file_lock /sys/devices/system/cpu/cpufreq/policy6/scaling_governor performance
write_file_lock /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/devfreq/5000000.qcom,kgsl-3d0/governor performance
write_file_lock /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling 0
write_file_lock /sys/devices/platform/soc/5000000.qcom,kgsl-3d0/kgsl/kgsl-3d0/thermal_pwrlevel 0
write_file_lock /dev/cpuset/foreground/boost/cpus 0-5
write_file_lock /dev/cpuset/foreground/cpus 0-5
write_file_lock /dev/cpuset/top-app/cpus 0-7

echo "0" > /sys/block/loop0/queue/iostats
echo "0" > /sys/block/loop1/queue/iostats
echo "0" > /sys/block/loop2/queue/iostats
echo "0" > /sys/block/loop3/queue/iostats
echo "0" > /sys/block/loop4/queue/iostats
echo "0" > /sys/block/loop5/queue/iostats
echo "0" > /sys/block/loop6/queue/iostats
echo "0" > /sys/block/loop7/queue/iostats
echo "0" > /sys/block/loop8/queue/iostats
echo "0" > /sys/block/loop9/queue/iostats
echo "0" > /sys/block/loop10/queue/iostats
echo "0" > /sys/block/loop11/queue/iostats
echo "0" > /sys/block/loop12/queue/iostats
echo "0" > /sys/block/loop13/queue/iostats
echo "0" > /sys/block/loop14/queue/iostats
echo "0" > /sys/block/loop15/queue/iostats
echo "0" > /sys/block/loop16/queue/iostats
echo "0" > /sys/block/loop17/queue/iostats
echo "0" > /sys/block/loop18/queue/iostats
echo "0" > /sys/block/loop19/queue/iostats
echo "0" > /sys/block/loop20/queue/iostats
echo "0" > /sys/block/loop21/queue/iostats
echo "0" > /sys/block/loop22/queue/iostats
echo "0" > /sys/block/loop23/queue/iostats
echo "0" > /sys/block/loop24/queue/iostats
echo "0" > /sys/block/loop25/queue/iostats
echo "0" > /sys/block/loop26/queue/iostats
echo "0" > /sys/block/loop27/queue/iostats
echo "0" > /sys/block/loop28/queue/iostats
echo "0" > /sys/block/loop29/queue/iostats
echo "0" > /sys/block/loop30/queue/iostats

echo '3072' > /sys/block/ram0/queue/read_ahead_kb
echo '3072' > /sys/block/ram1/queue/read_ahead_kb
echo '3072' > /sys/block/ram2/queue/read_ahead_kb
echo '3072' > /sys/block/ram3/queue/read_ahead_kb
echo '3072' > /sys/block/ram4/queue/read_ahead_kb
echo '3072' > /sys/block/ram5/queue/read_ahead_kb
echo '3072' > /sys/block/ram6/queue/read_ahead_kb
echo '3072' > /sys/block/ram7/queue/read_ahead_kb
echo '3072' > /sys/block/ram8/queue/read_ahead_kb
echo '3072' > /sys/block/ram9/queue/read_ahead_kb
echo '3072' > /sys/block/ram10/queue/read_ahead_kb
echo '3072' > /sys/block/ram11/queue/read_ahead_kb
echo '3072' > /sys/block/ram12/queue/read_ahead_kb
echo '3072' > /sys/block/ram13/queue/read_ahead_kb
echo '3072' > /sys/block/ram14/queue/read_ahead_kb
echo '3072' > /sys/block/ram15/queue/read_ahead_kb

echo 100 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 0-7 > /dev/cpuset/top-app/cpus
echo 0-7 > /dev/cpuset/game/cpus
echo 0-7 > /dev/cpuset/gamelite/cpus
echo 0-5 > /dev/cpuset/foreground/cpus
echo 0-5 > /dev/cpuset/foreground/boost/cpus
echo 0-1 > /dev/cpuset/background/cpus
echo 2-3 > /dev/cpuset/system-background/cpus

sleep 2

run_fstrim_magisk /system
run_fstrim_magisk /vendor
run_fstrim_magisk /metadata
run_fstrim_magisk /odm
run_fstrim_magisk /system_ext
run_fstrim_magisk /data
run_fstrim_magisk /cache

stop mi_thermald
stop thermal-engine
