function compute_as_kB(ram_usage) {
    if (gsub("[Kk]i*B", "", ram_usage) == 0) {
        if (gsub("[Mm]i*B", "", ram_usage) == 0) {
            if (gsub("[Gg]i*B", "", ram_usage) == 0) {
                if (gsub("i*B", "", ram_usage) == 0) {
                   
                } else {
                    ram_usage = (ram_usage / 1000000)
                }
            } else {
                ram_usage = (ram_usage * 1000000)
            }
        } else {
            ram_usage = (ram_usage * 1000)
        }
    }
    return ram_usage
}
BEGIN {
    print "# HELP container_cpu_time_percent CPU time percentage of use by the container";
    print "# TYPE container_cpu_time_percent gauge";
    print "# HELP container_memory_use RAM usage of the container, in "ram_usage_unit;
    print "# TYPE container_memory_use gauge";
    print "# HELP container_memory_use_percent RAM usage of the container, in %";
    print "# TYPE container_memory_use_percent gauge";
    print "# HELP container_net_input network data input accumulated, in "net_input_unit;
    print "# TYPE container_net_input counter";
    print "# HELP container_net_output network data output accumulated, in "net_output_unit;
    print "# TYPE container_net_output counter";
    print "# HELP container_disk_input disk data input accumulated, in "disk_input_unit;
    print "# TYPE container_disk_input counter";
    print "# HELP container_disk_output disk data output accumulated, in "disk_output_unit;
    print "# TYPE container_disk_output counter";
}
{
    # $1 container id
    # $2 container name
    # $3 container cpu %
    # $4 container ram XiB
    # $5 /
    # $6 container ram total XiB
    # $7 container ram %
    # $8 container net input XB counter
    # $9 /
    # $10 container net output XB counter
    # $11 container io input XB counter
    # $12 /
    # $13 container io output XB counter
    # $14 container pid

    labels="{container_name=\""$2"\"}"

    ram_usage = compute_as_kB($4)
    ram_usage_unit="KiB" 
    ##print "result="ram_usage" original="$4" replacements="res

    ram_total = compute_as_kB($6)
    ram_total_unit="KiB"
    ##print "result="ram_total" original="$6" replacements="res

    net_input = compute_as_kB($8)
    net_input_unit="KiB"
    ##print "result="net_input" original="$8" replacements="res

    net_output = compute_as_kB($10)
    net_output_unit="KiB"
    ##print "result="net_output" original="$10" replacements="res

    disk_input = compute_as_kB($11)
    disk_input_unit="KiB"
    ##print "result="disk_input" original="$11" replacements="res

    disk_output = compute_as_kB($13)
    disk_output_unit="KiB"
    ##print "result="disk_output" original="$13" replacements="res

    gsub("%", "", $3)
    gsub("%", "", $7)

    print "container_cpu_time_percent"labels" "$3;

    print "container_memory_use"labels" "ram_usage;

    print "container_memory_use_percent"labels" "$7;

    print "container_net_input"labels" "net_input;

    print "container_net_output"labels" "net_output;

    print "container_disk_input"labels" "disk_input;

    print "container_disk_output"labels" "disk_output;
}
END {
}
