#!/bin/bash
outinfo=""
errorinfo="";
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
function Fn_Printinfo()
{
	echo -e "\033[32m"$outinfo"\033[0m"
}

function Fn_DoProcessInfo()
{
	echo -e "\033[32m"正在执行$outinfo操作,请稍候..."\033[0m"	
}

function Fn_ComplateProcessinfo()
{
	echo -e "\033[32m"完成$outinfo操作,感谢使用!"\033[0m"	
}

function Fn_ErrorProcessInfo()
{
	
	echo -e  "\033[31m$errorinfo\033[0m"
}

function Fn_Readme()
{
	cat ./README.md
}

function Fn_RefashBaseSource()
{
	source ~/.bashrc 
}


function ShowTilte
{
	echo -e "\033[32m******************************************************************\033[0m"
	echo -e "\033[32m*       buntu 配置工具 Created by:PeerLessSoul                   *\033[0m"
	echo -e "\033[32m*       源码地址：                                               *\033[0m"
	echo -e "\033[32m*          git https://github.com/CNKM/SS                        *\033[0m"
	echo -e "\033[32m*       邮箱地址：                                               *\033[0m"
	echo -e "\033[32m*          km.liuz@qq.com                                        *\033[0m"
	echo -e "\033[32m*       版本: V2.3                                             *\033[0m"
	echo -e "\033[32m******************************************************************\033[0m"
}

#操作选现
MenuItems=(
"安装基础组件"
"安装v2ray"
"安装GrubCustomer"
"安装VScode"
"安装dotnet"
"安装JDK环境"
"设置alias"
"设置Bash编辑器"
"汉化(FireFox)"
"汉化(Chrome)"
"汉化Mint"
"Lubunt环境设置"
"设置Git帐号"
"清理Git历史"
"字体美化"
"图标美化"
"安装Tux"
"安装WPS字体"
"桌面默认值恢复"
"设置aria2"
"配置python"
"安装ccal"
"安装Wechat"
"安装MEdge"
"自定义组合"
"说明"
"退出"
)

function Fn_InstallBase()
{
	sudo apt-get install git screenfetch neofetch uget cmatrix oneko aria2 htop guake  fortunes-zh network-manager-* numlockx build-essential libgtk2.0-dev  variety  xcompmgr  sublime-text libjpeg62
}
function Fn_InstallV2ray()
{
	# download script
    curl -O https://cdn.jsdelivr.net/gh/v2rayA/v2rayA@master/install/go.sh
   # install v2ray-core from jsdelivr
    sudo bash go.sh
	# add public key
	wget -qO - https://raw.fastgit.org/v2rayA/v2raya-apt/master/key/public-key.asc | sudo apt-key add -
	# add V2RayA's repository
	echo "deb https://raw.fastgit.org/v2rayA/v2raya-apt/master/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
	sudo apt update
	# install V2RayA
	sudo apt install v2raya
	systemctl enable v2ray
}
function Fn_InstallGC()
{
	sudo add-apt-repository ppa:danielrichter2007/grub-customizer
	sudo apt-get update
	sudo apt-get install grub-customizer
}
function Fn_InstallVsCode()
{
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	sudo add-apt-repository universe
	sudo apt-get install apt-transport-https
	sudo apt-get update
	sudo apt-get install code dotnet-sdk-2.2  # or code-insiders
}

function Fn_InstallDonet()
{
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	sudo add-apt-repository universe
	sudo apt-get install apt-transport-https
	sudo apt-get update
	sudo apt-get install aspnetcore-runtime-2.2
}

function Fn_InstallJDK()
{
	echo  -e "\033[31m"
	filelist=`ls jdk*`
	if test -z "$filelist"
	then
		echo -e " 未找到相应的JDK文件；请在调用本脚本后加入需要安装配置的JDK包名"
		echo "如： ./initjdk jdk-8u91-linux-x64.tar.gz"
		echo "还未下载请到下列地址进行下载  http://www.oracle.com/technetwork/java/javase/downloads/index.html"
		echo  -e "选择下载 Linux tar.gz 版本 "
		echo -e "\033[0m "
	else
		echo -e "\033[0m "
		echo "选择要安装设置的JDK安装包 :" 
		select jdkfn in ${filelist[@]}
			do
				sudo rm -fR ./tempjvm
				sudo mkdir ./tempjvm
				sudo tar -zxvf $jdkfn -C ./tempjvm
				jdkn=`ls ./tempjvm/`
				jdkpath=/usr/lib/jvm/${jdkn}
				echo $jdkpath
				if [ ! -d "$jdkpath" ]; then 
		 	  		sudo mkdir /usr/lib/jvm/${jdkn}
				fi	
				sudo rm -fR /usr/lib/jvm/${jdkn}
				sudo mv ./tempjvm/${jdkn} /usr/lib/jvm/
				HasSeted=$(grep "设定Java 环境" ~/.bashrc) 
				if test -z "$HasSeted" ;then
					echo  -e "\033[32m从未设置过Java环境变量，正在设置\033[0m"
					echo "#设定Java 环境" >> ~/.bashrc
					echo "export JAVA_HOME="${jdkpath} >> ~/.bashrc
					echo 'export JRE_HOME=$JAVA_HOME/jre' >> ~/.bashrc
					echo 'export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH' >> ~/.bashrc
					echo 'export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' >> ~/.bashrc
					echo "" >> ~/.bashrc
				else
					echo  -e "\033[31m已经设置过环境变量，手动调整 ~/.bashrc 文件 \033[0m"
				fi

				Fn_RefashBaseSource
				echo $jdkn
				echo $jdkpath
				sudo update-alternatives --install /usr/bin/javac javac $jdkpath/bin/javac 1071
				sudo update-alternatives --install /usr/bin/java java $jdkpath/bin/java 1071
				update-alternatives --config java
				java -version
				sudo rm -fR ./tempjvm
				break
			done
	fi
}

function Fn_InstallTux
{
	sudo apt-get install tuxmath tuxpaint tuxtype bovo kpat kreversi kmahjongg
}

function Fn_InstallWPSFont
{
	sudo rm  -fr ./wps-font-symbols
	sudo rm -fr /usr/share/fonts/wps-font-symbols 
	git clone https://github.com/pengphei/wps-font-symbols.git && sleep 1s
	sudo cp -r ./wps-font-symbols /usr/share/fonts/wps-font-symbols && sleep 1s
	sudo chmod 755 /usr/share/fonts/wps-font-symbols 
	sudo chmod 644 /usr/share/fonts/wps-font-symbols/* 
	sudo rm -fr /usr/share/fonts/wps-font-symbols/.git
	sudo rm -fr /usr/share/fonts/wps-font-symbols/.uuid
	sudo mkfontdir /usr/share/fonts/wps-font-symbols/
	sudo fc-cache /usr/share/fonts/wps-font-symbols/
	sudo rm  -fr ./wps-font-symbols
}
function Fn_Installccal
{
	wget http://ccal.chinesebay.com/ccal/ccal-2.5.3.tar.gz && tar -zxvf ccal-2.5.3.tar.gz
	cd ccal-2.5.3
	sudo make && sudo make install
	ccal -u 06 1985
	cd ..
	rm ./ccal-2.5.3.tar.gz -fr
	rm ./ccal-2.5.3 -rf
}
function Fn_InstallWeChat
{
	wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
	sudo apt-get install com.qq.weixin.deepin
	echo -e "\033[32mdeepin 包\033[0m"
	echo -e "\033[32m微信 com.qq.weixin.deepin\033[0m"
	echo -e "\033[32mQQ com.qq.im.deepin\033[0m"
	echo -e "\033[32m钉钉 com.dingtalk.deepin\033[0m"
	echo -e "\033[32m阿里旺旺 com.taobao.wangwang.deepin\033[0m"
	echo -e "\033[32m阿里旺旺 com.taobao.wangwang.deepin\033[0m"
	echo -e "\033[32mQQ音乐 com.qq.music.deepin\033[0m"
	echo -e "\033[32mQQ视频 com.qq.video.deepin\033[0m"
	echo -e "\033[32m爱奇艺 com.iqiyi.deepin\033[0m"
}

function FN_InstallEdge
{
		## Setup
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
	sudo rm microsoft.gpg
	## Install
	sudo apt update
	sudo apt install microsoft-edge-dev
}
function Fn_SetDefaultDesk()
{
	sudo dconf reset -f /
}

function Fn_SetAlias()
{
	sed -i '/alias notepad=/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias rb=/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias suin=/d' ~/.bashrc >> ~/.bashrc;
	sed -i '/alias suun=/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias suup/d' ~/.bashrc >> ~/.bashrc;
	sed -i '/alias sucls/d' ~/.bashrc >> ~/.bashrc;
	sed -i '/alias bye/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias version/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias untar/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias dr/d' ~/.bashrc >> ~/.bashrc ;
	sed -i '/alias dl/d' ~/.bashrc >> ~/.bashrc ;

	N1=$(grep "alias notepad" ~/.bashrc) 
	if test -z "$N1" ;then
    	echo "alias notepad='subl'" >> ~/.bashrc
    fi

	N2=$(grep "alias rb=" ~/.bashrc) 
	if test -z "$N2" ;then
    	echo "alias rb='reboot'" >> ~/.bashrc
    fi

    N3=$(grep "alias suin=" ~/.bashrc) 
	if test -z "$N3" ;then
    	echo "alias suin='sudo apt-get install '" >> ~/.bashrc
    fi

    N4=$(grep "alias suun=" ~/.bashrc) 
	if test -z "$N4" ;then
		
    	echo "alias suun='sudo apt-get  remove '">> ~/.bashrc
    fi

    N5=$(grep "alias suup" ~/.bashrc) 
	if test -z "$N5" ;then
		
    	echo "alias suup='sudo apt-get update && sudo apt-get upgrade'" >> ~/.bashrc
    fi

    N6=$(grep "alias sucls" ~/.bashrc) 
	if test -z "$N6" ;then
		
    	echo "alias sucls='sudo apt-get autoclean && sudo apt-get autoremove'">> ~/.bashrc
    fi

    N7=$(grep "alias bye" ~/.bashrc) 
	if test -z "$N7" ;then
		
    	echo "alias bye='shutdown  now'">> ~/.bashrc
    fi

    N8=$(grep "alias version" ~/.bashrc) 
	if test -z "$N8" ;then
		
    	echo "alias version='lsb_release -a && uname -a && cat /proc/version && neofetch'">> ~/.bashrc
    fi

    N9=$(grep "alias untar" ~/.bashrc) 
	if test -z "$N9" ;then
		
    	echo "alias untar='tar -zxvf'">> ~/.bashrc
    fi

    N10=$(grep "alias dr" ~/.bashrc) 
	if test -z "$N10" ;then
		
    	echo "alias dr='less -N '">> ~/.bashrc
    fi

    N10=$(grep "alias dl" ~/.bashrc) 
	if test -z "$N11" ;then
		
    	echo "alias dl='aria2c -c -s 100 '">> ~/.bashrc
    fi

    Fn_RefashBaseSource
}
function Fn_SetBashEditor()
{
	sudo update-alternatives --config editor
}

function Fn_LocalFireFox()
{
	sudo apt-get install firefox-locale-zh-hans
}

function Fn_LocalChrome()
{
	sudo apt-get install chromium-browser-l10n
}

function Fn_LocalMint()
{
	sudo apt-get install language-pack-zh-hans language-pack-gnome-zh-hans libreoffice-l10n-zh-cn thunderbird-locale-zh-hans
}

function Fn_SetLubuntu()
{
	HasSeted1=$(sudo grep "greeter-setup-script=/usr/bin/numlockx on" /usr/share/lightdm/lightdm.conf.d/50-guest-wrapper.conf) 
    if test -z "$HasSeted1" ;then
        echo "greeter-setup-script=/usr/bin/numlockx on" >> /usr/share/lightdm/lightdm.conf.d/50-guest-wrapper.conf
    fi
    H1=$(grep "xcompmgr" ~/.config/lxsession/Lubuntu/autostart) 
	if test -z "$H1" ;then
		echo "#设定xcompmgr" >> ~/.bashrc
		echo "xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &">> ~/.config/lxsession/Lubuntu/autostart
	else
		echo  -e "\033[31m已经设置过 ~/.config/lxsession/Lubuntu/autostart 文件 \033[0m"
	fi

	H2=$(grep "guake" ~/.config/lxsession/Lubuntu/autostart) 
	if test -z "$H2" ;then
		echo "#设定guake" >> ~/.bashrc
		echo "guake">> ~/.config/lxsession/Lubuntu/autostart
	else
		echo  -e "\033[31m已经设置过 ~/.config/lxsession/Lubuntu/autostart 文件 \033[0m"
	fi
	echo -e "\033[32m 操作结束！\033[0m"
}

function Fn_SetGitUser()
{
   git config --global user.email "km.liuz@gmail.com"
   git config --global user.name "CNKM"
}

function FN_SetAria2()
{
	sudo mkdir /usr/customer/aria2    #新建文件夹 
	sudo touch /usr/customer/aria2/aria2.session    #新建session文件
	sudo chmod 777 /usr/customer/aria2/aria2.session    #设置aria2.session可写 
	sudo mkdir /usr/customer/    #创建配置文件e
	sudo mkdir /usr/customer/aria2
	sudo cp $SHELL_FOLDER/ext/aria2.conf  /usr/customer/aria2/  
	sudo cp $SHELL_FOLDER/ext/aria2c /etc/init.d/  
	sudo chmod 755 /etc/init.d/aria2c
	sudo update-rc.d aria2c defaults
	sudo service aria2c start
	#sudo systemctl status aria2c

	#sudo aria2c --conf-path=/usr/customer/aria2/aria2.conf
	#sudo aria2c --conf-path=/usr/customer/aria2/aria2.conf -D
	#aria2c -c -s 5 https://mirrors.bfsu.edu.cn/linuxmint-cd/stable/20/linuxmint-20-mate-64bit.iso

}

function Fn_SetPython()
{
	ls /usr/bin/python*
	echo " 采用 sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8  1077 类似安装"
	sudo update-alternatives --config python
}

function Fn_ClearGitHistory()
{
	 git checkout --orphan latest_branch
	 git add -A
	 git commit -am "latest"
	 git branch -D master
	 git branch -m master
	 git push -f origin master
}

function Fn_NiceFont()
{
	echo "安装微软字体( 脚本来源 Deng.Yangjun@Gmail.com)"
	sudo ./3th/get-fonts.sh
}

function Fn_NiceIcon()
{
	sudo apt-add-repository ppa:numix/ppa -y
	sudo add-apt-repository ppa:papirus/papirus -y
	sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 90127F5B
	sudo apt-get update
	sudo apt-get install faenza-icon-theme moka-icon-theme numix-icon-theme-circle
}

while [[ 1 ]]; do
	#statements
	clear
	ShowTilte
	select MenuItem in ${MenuItems[@]} 
	do
		break
	done
	 outinfo=$MenuItem
	 Fn_DoProcessInfo
	case $MenuItem in 
		${MenuItems[0]})
			Fn_InstallBase
			break;;
		${MenuItems[1]})
			Fn_InstallV2ray
		 	break;;
		${MenuItems[2]})
			Fn_InstallGC
		 	break;; 	
		${MenuItems[3]})
			Fn_InstallVsCode
		 	break;;
		${MenuItems[4]})
			Fn_InstallDonet
		 	break;;
		${MenuItems[5]})
			Fn_InstallJDK
		 	break;;
		${MenuItems[6]})
			Fn_SetAlias
		 	break;; 	
		${MenuItems[7]})
			Fn_SetBashEditor
		 	break;;
		${MenuItems[8]})
			Fn_LocalFireFox
		 	break;;
		${MenuItems[9]})
			Fn_LocalChrome
		 	break;;
		${MenuItems[10]})
			Fn_LocalMint
		 	break;; 	
		${MenuItems[11]})
			Fn_SetLubuntu
		 	break;;
		${MenuItems[12]})
			Fn_SetGitUser
		 	break;;
		${MenuItems[13]})
			Fn_ClearGitHistory
		 	break;;
		${MenuItems[14]})
			Fn_NiceFont
		 	break;; 	
		${MenuItems[15]})
			Fn_NiceIcon
		 	break;;
		${MenuItems[16]})
			Fn_InstallTux
		 	break;;
		${MenuItems[17]})
			Fn_InstallWPSFont
		 	break;;
		${MenuItems[18]})
			FN_SetAria2
		 	break;;
		${MenuItems[19]})
			Fn_SetDefaultDesk
			break;;
		${MenuItems[20]})
			Fn_SetPython
			break;;
		${MenuItems[21]})
			Fn_Installccal
			break;;
		${MenuItems[22]})
			Fn_InstallWeChat
			break;;
		${MenuItems[23]})
			FN_InstallEdge
			break;;
		#新增功能加这里
		#${MenuItems[操作项目索引])
		#Fn_Dosomething
		#break;;
		${MenuItems[${#MenuItems[@]}-3]})
			Fn_InstallBase
			Fn_InstallV2ray
			Fn_LocalFireFox
			Fn_LocalChrome
			Fn_LocalMint
		 	break;;
		${MenuItems[${#MenuItems[@]}-2]})
			Fn_Readme
		 	break;;	
		 	#break;;
		${MenuItems[${#MenuItems[@]}-1]})
		 	break;;
		*)
			errorinfo=无效的输入选择$REPLY,按任意键重新选择
			Fn_ErrorProcessInfo
			read

	esac

done
Fn_ComplateProcessinfo