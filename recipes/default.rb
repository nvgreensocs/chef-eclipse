
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

bash "Installing Eclipse..." do
    code <<-EOH
    if [ ! -e /usr/eclipse ]; then
        # Depending of the running guest...
        processor=`uname -p`
        cd /tmp
        if [ "$processor" = "x86_64" ]; then
            wget http://greensocs.com/files/eclipse/eclipse-cpp-juno-SR2-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
        else
            wget http://greensocs.com/files/eclipse/eclipse-cpp-juno-SR2-linux-gtk.tar.gz -O eclipse.tar.gz
        fi
        wget http://greensocs.com/files/eclipse/gdb_hardware.tar.bz2
        cd /usr
        tar -xf /tmp/eclipse.tar.gz
        cd eclipse
        tar -xf /tmp/gdb_hardware.tar.bz2
        rm /usr/bin/eclipse
        ln -s /usr/eclipse/eclipse /usr/bin/eclipse
        rm /tmp/eclipse.tar.gz
        rm /tmp/gdb_hardware.tar.bz2
    else
        echo "Already installed."
    fi
    EOH
end
