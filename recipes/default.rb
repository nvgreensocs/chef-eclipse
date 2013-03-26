
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

    if [ -w /usr/local/share ]; then
      prefix=/usr/local/share/
   else
      prefix="#{node[:prefix]}/"
   fi

    if [ ! -e $prefix/eclipse ]; then
        # Depending of the running guest...
        processor=`uname -p`
        cd $prefix

        if [ "$processor" = "x86_64" ]; then
             wget http://ftp.osuosl.org/pub/eclipse//technology/epp/downloads/release/juno/SR2/eclipse-cpp-juno-SR2-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
        else
            wget http://ftp.ussg.iu.edu/eclipse/technology/epp/downloads/release/juno/SR2/eclipse-cpp-juno-SR2-linux-gtk.tar.gz -O eclipse.tar.gz
        fi
        tar -xf eclipse.tar.gz && rm eclipse.tar.gz &&
        cd $prefix/eclipse &&
        wget http://greensocs.com/files/eclipse/gdb_hardware.tar.bz2 &&
        tar -xf gdb_hardware.tar.bz2 && rm gdb_hardware.tar.bz2

        if [ -w /usr/bin ]; then
           if [ ! -e /usr/bin/eclipse ]; then 
               ln -s $prefix/eclipse/eclipse /usr/bin/eclipse
           fi
        else
           echo "export PATH=\\\$PATH:/$prefix/eclipse/" > bash.profile.d/eclipse.profile
        fi
    else
        echo "Eclipse already installed."
    fi
    EOH
end
