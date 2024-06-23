#!/bin/bash

clear

if [ $(id -u) -ne 0 ]; then
    echo -e "\nЭтот скрипт должен быть запущен от имени пользователя root.\n"
    exit 1
fi

echo -e "Выберите действие:\n"
echo "1. Узнать версию ОС"
echo "2. Открыть лог файл /var/log/messages"
echo "3. Открыть лог файл /var/log/screen_saver.log"
echo "4. Обновить списки доступных пакетов и обновление всех установленных пакетов."
echo "5. Проверка версий пакетов."
echo "6. Выход"
echo "7. Перезагрузка"
echo -e "8. Выключение\n"

read -p "Введите число: " choice
echo -e "\n"


case $choice in
    1)
	clear		
	if [ -f "/etc/redos-release" ]; then
	echo -e "Версия РЕД ОС:\n"
	cat /etc/redos-release
	echo -e "\n"
	elif [ -f "/etc/altlinux-release" ]; then
	echo -e "Версия ALT Linux:\n"
	cat /etc/altlinux-release
	echo -e "\n"
	elif [ -f "/etc/astra_version" ]; then
	echo -e "Версия Astra Linux:\n"
	cat /etc/astra_version
	echo -e "\n"
	else
	echo "Вашу версию ОС не удалось определить."
	fi
	;;
    2)
	clear
	mcedit /var/log/messages
	;;
    3)
	clear
	mcedit /var/log/screen_saver.log
	;;
    4)
	clear		
	if [ -f "/etc/redos-release" ]; then
	yum update -y && yum upgrade -y		
	elif [ -f "/etc/altlinux-release" ]; then
	apt-get update -y && apt-get dist-upgrade -y
	elif [ -f "/etc/astra_version" ]; then
	apt update -y && apt dist-upgrade -y
	else
	echo "Не удалось выполнить обновление."
	fi
        ;;
    5)
	clear
	
	echo -e "Выберите операционну систему:\n"
	echo "1. Проверка версий пакетов для систем Газпрома."
	echo "2. РЕД ОС 7.3"
	echo "3. ALT Linux 9"
	echo "4. Astra Linux 1.7"
	echo "5. Astra Linux 1.8"
	echo "6. Astra Linux 2.12"
	echo -e "7. Astra Linux (другая версия).\n"
	
	read -p "Введите число: " chc
	echo -e "\n"
	
	case $chc in
		1) 
			packages=("dbus >= 1.12.16" "pcre2-utf16 >= 10.36" "pcsc-lite-libs >= 1.9.1" "pcsc-lite >= 1.9.1" "pcsc-lite-ccid >= 1.5.2"
			"opensc >= 0.21.0" "qt-settings" "qt5-qtbase >= 5.15.1" "qt5-qtbase-gui >= 5.15.1" "xcb-util-image >= 0.4.0"
			"xcb-util-keysyms >= 0.4.0" "xcb-util-renderutil >= 0.3.9" "xcb-util-wm >= 0.4.1" "qt5-qtbase-common >= 5.15.1"
			"qt5-qtdeclarative >= 5.15.1" "qt5-qtxmlpatterns >= 5.15.1" "qt5-qtgraphicaleffects >= 5.15.1"
			"qt5-qtquickcontrols >= 5.15.1" "qt5-qtquickcontrols2 >= 5.15.1" "openh264-libs >= 1.7.0" "freerdp >= 2.10.0"
			"brotli >= 1.0.7" "lightdm-qt5 >= 1.30.0" "libcurl >= 7.85.0" "jsoncpp >= 1.9.4" "sssd" "sssd-tools" 
			"sssd-client" "nss-tools >= 3.79.4" "krb5-pkinit >= 1.20.1" "bind-utils >= 9.18.16" "libstdc++ >= 11.4.0"
			"openssl-pkcs11 >= 0.4.11" "xfreerdp")


			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(rpm -q $pkg_name --qf "%{VERSION}\n" | sort -V | tail -n 1)

				if rpm --quiet -q $pkg_name && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ $pkg. ВЕРСИЯ УСТАНОВЛЕННАЯ В СИСТЕМЕ: $pkg_name ($installed_version)\n"
				fi
			done
			;;
		2) 
    		packages=("bash" "dbus >= 1.12.16" "pcre2-utf16 >= 10.36" "pcsc-lite-libs >= 1.9.1" "pcsc-lite >= 1.9.1" "pcsc-lite-ccid >= 1.5.2"
			"qt-settings" "qt5-qtbase >= 5.15.1" "qt5-qtbase-gui >= 5.15.1" "xcb-util-image >= 0.4.0"
			"xcb-util-keysyms >= 0.4.0" "xcb-util-renderutil >= 0.3.9" "xcb-util-wm >= 0.4.1" "qt5-qtbase-common >= 5.15.1"
			"qt5-qtdeclarative >= 5.15.1" "qt5-qtxmlpatterns >= 5.15.1" "qt5-qtgraphicaleffects >= 5.15.1"
			"qt5-qtquickcontrols >= 5.15.1" "qt5-qtquickcontrols2 >= 5.15.1" "openh264-libs >= 1.7.0" "freerdp >= 2.10.0"
			"brotli >= 1.0.7" "lightdm-qt5 >= 1.30.0" "libcurl >= 7.85.0" "jsoncpp >= 1.9.4" "sssd" "sssd-tools" 
			"sssd-client" "nss-tools >= 3.79.4" "krb5-pkinit >= 1.20.1" "bind-utils >= 9.18.16" "libstdc++ >= 11.4.0"
			"openssl-pkcs11 >= 0.4.11" "xfreerdp")


			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(rpm -q $pkg_name --qf "%{VERSION}\n" | sort -V | tail -n 1)

				if rpm --quiet -q $pkg_name && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ $pkg. ВЕРСИЯ УСТАНОВЛЕННАЯ В СИСТЕМЕ: $pkg_name ($installed_version)\n"
				fi
			done
    		;;
		3) 
    		packages=("libxkbcommon-x11" "libxcb-render-util" "libxcbutil-keysyms" "libxcbutil-image" "libxcbutil-icccm" "libts0"
			"qt5-base-common" "libqt5-core" "libqt5-dbus" "libqt5-network" "libqt5-xcbqpa" "libqt5-eglfskmssupport"
			"libqt5-gui" "libqt5-widgets" "libqt5-opengl" "libqt5-printsupport" "libqt5-eglfskmssupport"
			"pcsc-lite" "pcsc-lite-ccid" "cracklib" "cracklib-utils" "cracklib-words" "libpwquality"
			"libp11" "libcrypto1.1" "qt5-graphicaleffects" "qt5-quickcontrols" "qt5-quickcontrols2" "freerdp"
			"liblightdm-qt5" "libcurl" "json-cpp" "xwininfo" "syslog-ng" "syslog-ng-journal" "libjsoncpp19"
			"openssl-gost-engine")


			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(rpm -q $pkg_name --qf "%{VERSION}\n" | sort -V | tail -n 1)

				if rpm --quiet -q $pkg_name && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ.\n"
				fi
			done
    		;;
		4)
			packages=("jcpkcs11-2 >= 2.4.3" "dbus" "libccid" "libpcsclite1" "pcscd" "libnss3" "libnss3-tools" "ca-certificates" "libengine-pkcs11-openssl"
			"qml-module-qt-labs-settings" "qml-module-qt-labs-folderlistmodel" "qml-module-qtquick-controls" "qml-module-qtquick-controls2"
			"libfreerdp-client2-2" "libfreerdp2-2" "libwinpr2-2" "freerdp2-x11" "sssd" "sssd-tools" "krb5-pkinit" "dnsutils" "syslog-ng"
			"libp11-3" "libavcodec58" "libavutil56" "libswresample3" "libgost-astra" "krb5-pkinit" "libcurl4" "libjsoncpp1")

			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(dpkg-query -W -f='${Version}\n' $pkg_name 2>/dev/null | sort -V | tail -n 1)

				if dpkg-query -l $pkg_name &>/dev/null && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n 1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					if [ -z "$installed_version" ]; then
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ. ПАКЕТ НЕ УСТАНОВЛЕН.\n"
					else
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ $pkg. ВЕРСИЯ УСТАНОВЛЕННАЯ В СИСТЕМЕ: $pkg_name ($installed_version)\n"
					fi
				fi
			done
			;;
		5)
			packages=("jcpkcs11-2 >= 2.4.3" "dbus" "libccid" "libpcsclite1" "pcscd" "libnss3" "libnss3-tools" "ca-certificates" "libengine-pkcs11-openssl"
			"qml-module-qt-labs-settings" "qml-module-qt-labs-folderlistmodel" "qml-module-qtquick-controls" "qml-module-qtquick-controls2"
			"libfreerdp-client2-2" "libfreerdp2-2" "libwinpr2-2" "freerdp2-x11" "sssd" "sssd-tools" "krb5-pkinit" "dnsutils" "syslog-ng"
			"libp11-3" "libavcodec59" "libavutil57" "libswresample4" "libgost-astra" "krb5-pkinit" "libcurl4" "libjsoncpp25")

			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(dpkg-query -W -f='${Version}\n' $pkg_name 2>/dev/null | sort -V | tail -n 1)

				if dpkg-query -l $pkg_name &>/dev/null && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n 1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					if [ -z "$installed_version" ]; then
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ. ПАКЕТ НЕ УСТАНОВЛЕН.\n"
					else
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ $pkg. ВЕРСИЯ УСТАНОВЛЕННАЯ В СИСТЕМЕ: $pkg_name ($installed_version)\n"
					fi
				fi
			done
			;;
		6)
			packages=("jcpkcs11-2 >= 2.4.3" "dbus" "libccid" "libpcsclite1" "pcscd" "libnss3" "libnss3-tools" "ca-certificates" "libengine-pkcs11-openssl"
			"qml-module-qt-labs-settings" "qml-module-qt-labs-folderlistmodel" "qml-module-qtquick-controls" "qml-module-qtquick-controls2"
			"libfreerdp-client2-2" "libfreerdp2-2" "libwinpr2-2" "freerdp2-x11" "sssd" "sssd-tools" "krb5-pkinit" "dnsutils" "syslog-ng"
			"libp11-3" "libavcodec57" "libavutil55" "libswresample2" "libgost-astra" "krb5-pkinit" "libcurl3" "libjsoncpp1")

			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(dpkg-query -W -f='${Version}\n' $pkg_name 2>/dev/null | sort -V | tail -n 1)

				if dpkg-query -l $pkg_name &>/dev/null && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n 1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					if [ -z "$installed_version" ]; then
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ. ПАКЕТ НЕ УСТАНОВЛЕН.\n"
					else
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ $pkg. ВЕРСИЯ УСТАНОВЛЕННАЯ В СИСТЕМЕ: $pkg_name ($installed_version)\n"
					fi
				fi
			done
			;;
		7)
			packages=("jcpkcs11-2 >= 2.4.3" "dbus" "libccid" "libpcsclite1" "pcscd" "libnss3" "libnss3-tools" "ca-certificates" "libengine-pkcs11-openssl"
			"qml-module-qt-labs-settings" "qml-module-qt-labs-folderlistmodel" "qml-module-qtquick-controls" "qml-module-qtquick-controls2"
			"libfreerdp-client2-2" "libfreerdp2-2" "libwinpr2-2" "freerdp2-x11" "sssd" "sssd-tools" "krb5-pkinit" "dnsutils" "syslog-ng"
			"libp11-2" "libavcodec57" "libavutil55" "libswresample2" "libgost-astra" "openssl" "krb5-pkinit" "libcurl3" "libjsoncpp1")

			for pkg in "${packages[@]}"
			do
				pkg_name=$(echo $pkg | awk '{print $1}')
				pkg_version=$(echo $pkg | awk '{print $3}')
				installed_version=$(dpkg-query -W -f='${Version}\n' $pkg_name 2>/dev/null | sort -V | tail -n 1)

				if dpkg-query -l $pkg_name &>/dev/null && [[ "$(printf '%s\n' "$installed_version" "$pkg_version" | sort -V | tail -n 1)" == "$installed_version" ]]; then
					echo "$pkg_name версии $installed_version удовлетворяет требованиям $pkg"
				else
					if [ -z "$installed_version" ]; then
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ. ПАКЕТ НЕ УСТАНОВЛЕН.\n"
					else
						echo -e "\n$pkg_name НЕ УДОВЛЕТВОРЯЕТ ТРЕБОВАНИЯМ $pkg. ВЕРСИЯ УСТАНОВЛЕННАЯ В СИСТЕМЕ: $pkg_name ($installed_version)\n"
					fi
				fi
			done			
			;;
		*) 			
			echo -e "\nНекорректный выбор\n"
			;;
	esac
	echo -e "\n"
	;;
    6) 
	clear
	exit
        ;;
    7) 
        reboot
        ;;
    8) 
        poweroff
        ;;
    *)         
		echo -e "\nНекорректный выбор\n"
        ;;
esac
