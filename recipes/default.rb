
#  -------    CHEF-ECLIPSE --------

# LICENSETEXT
# 
#   Copyright (C) 2013 : GreenSocs Ltd
#       http://www.greensocs.com/ , email: info@greensocs.com
# 
# The contents of this file are subject to the licensing terms specified
# in the file LICENSE. Please consult this file for restrictions and
# limitations that may apply.
# 
# ENDLICENSETEXT
base_directory = "#{node[:prefix]}"
eclipse_directory = "#{base_directory}/eclipse"
user_home = "/#{node[:user]}"

bash "Installing Eclipse..." do
    code <<-EOH
    if [ ! -e "#{eclipse_directory}" ]; then
        # Depending of the running guest...
        processor=`uname -p`
        cd "#{base_directory}" 
        if [ "$processor" = "x86_64" ]; then
             wget http://ftp.osuosl.org/pub/eclipse//technology/epp/downloads/release/juno/SR2/eclipse-cpp-juno-SR2-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
        else
            wget http://ftp.ussg.iu.edu/eclipse/technology/epp/downloads/release/juno/SR2/eclipse-cpp-juno-SR2-linux-gtk.tar.gz -O eclipse.tar.gz
        fi
        tar -xf eclipse.tar.gz && rm eclipse.tar.gz &&
        cd #{eclipse_directory} &&
        wget http://greensocs.com/files/eclipse/gdb_hardware.tar.bz2 &&
        tar -xf gdb_hardware.tar.bz2 && rm gdb_hardware.tar.bz2
    else
        echo "Already installed."
    fi
    EOH
end
