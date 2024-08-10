#!/bin/bash

echo "Starting installation..."

# تحقق من أن المستخدم هو مستخدم الجذر
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# تثبيت الحزم اللازمة (تعديل حسب الحاجة)
apt-get update
apt-get install -y figlet lolcat

echo "Installation complete!"
