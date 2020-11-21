#!/bin/bash
outinfo=""
function Fn_Printinfo()
{
   echo -e "\033[32m"$outinfo"...\033[0m"
}

function Fn_DoProcess()
{
	outinfo ="开始执行"
	Fn_Printinfo
}

function Fn_ComplateProcess()
{
	outinfo ="执行结束"
	Fn_Printinfo;
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
	echo -e "\033[32m*         git https://github.com/CNKM/SS                        *\033[0m"
	echo -e "\033[32m*       邮箱地址：                                               *\033[0m"
	echo -e "\033[32m*          km.liuz@qq.com                                        *\033[0m"
	echo -e "\033[32m*       版本: V1.8 				                                 *\033[0m"
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
"汉化(浏览器FF)"
"汉化(浏览器Chrome)"
"汉化Mint"
"Lubunt环境设置"
"设置Git帐号"
"清理Git历史"
"字体美化"
"图标美化"
"自定义组合"
"退出"
)

function Fn_InstallBase()
{
	sudo apt-get install git uget aria2 htop guake  fortunes-zh network-manager-* numlockx build-essential libgtk2.0-dev  variety  xcompmgr 	
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
	echo "选择要安装设置的JDK安装包 :" 
			select jdkfn in ${filelist[@]}
			do
				sudo rm -fR ./tempjvm
				sudo mkdir ./tempjvm
				tar -zxvf $jdkfn -C ./tempjvm
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
					echo "export JAVA_HOME="${jdkpath} >> ~/.bashrc
					echo "export JRE_HOME=${JAVA_HOME}/jre" >> ~/.bashrc
					echo 'export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH' >> ~/.bashrc
					echo 'export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' >> ~/.bashrc
					echo "" >> ~/.bashrc
				else
					echo  -e "\033[31m已经设置过环境变量，手动调整 ~/.bashrc 文件 \033[0m"
				fi
				RefashBash
				echo $jdkn
				java -version
				sudo rm -fR ./tempjvm
				break
			done
}


function Fn_SetAlias()
{
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
    	    echo "alias suin='sudo apt-get install'" >> ~/.bashrc
    	fi

    	N4=$(grep "alias suun=" ~/.bashrc) 
	if test -z "$N4" ;then
    	    echo "alias suun='sudo apt-get  remove' ">> ~/.bashrc
    	fi

    	N5=$(grep "alias suup" ~/.bashrc) 
	if test -z "$N5" ;then
    	    echo "alias suup='sudo apt-get update && sudo apt-get upgrade'" >> ~/.bashrc
    	fi

    	 N6=$(grep "alias sucls" ~/.bashrc) 
	if test -z "$N6" ;then
    	    echo "alias sucls='sudo apt-get autoclean && sudo apt-get autoremove' ">> ~/.bashrc
    	fi

    	 N7=$(grep "alias  bye" ~/.bashrc) 
	if test -z "$N7" ;then
    	    echo "alias bye='shutdown  now' ">> ~/.bashrc
    	fi

    	N8=$(grep "alias  version" ~/.bashrc) 
	if test -z "$N8" ;then
    	    echo "alias version='lsb_release -a && uname -a && cat /proc/version' ">> ~/.bashrc
    	fi
    RefashBash
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

	case $MenuItem in 
		${MenuItems[0]})
			Fn_InstallBase
			exit;;
		${MenuItems[1]})
			Fn_InstallV2ray
		 	exit;;
		${MenuItems[2]})
			Fn_InstallGC
		 	exit;; 	
		${MenuItems[3]})
			Fn_InstallVsCode
		 	exit;;
		${MenuItems[4]})
			Fn_InstallDonet
		 	exit;;
		${MenuItems[5]})
			Fn_InstallJDK
		 	exit;;
		${MenuItems[6]})
			Fn_SetAlias
		 	exit;; 	
		${MenuItems[7]})
			Fn_SetBashEditor
		 	exit;;
		${MenuItems[8]})
			Fn_LocalFireFox
		 	exit;;
		${MenuItems[9]})
			Fn_LocalChrome
		 	exit;;
		${MenuItems[10]})
			Fn_LocalMint
		 	exit;; 	
		${MenuItems[11]})
			Fn_SetLubuntu
		 	exit;;
		${MenuItems[12]})
			Fn_SetGitUser
		 	exit;;
		${MenuItems[13]})
			Fn_ClearGitHistory
		 	exit;;
		${MenuItems[14]})
			Fn_NiceFont
		 	exit;; 	
		${MenuItems[15]})
			Fn_NiceIcon
		 	exit;;
    	 ${MenuItems[16]})
			Fn_InstallBase
			Fn_InstallV2ray
			Fn_LocalFireFox
			Fn_LocalChrome
			Fn_LocalMint
		 	exit;;
		#新增功能加这里
		#${MenuItems[${#MenuItems[@]}-1]})
			
		 	#exit;;
		${MenuItems[${#MenuItems[@]}-1]})
			echo "谢谢使用！"
		 	exit;;
		*)
			echo -e  "\033[31m无效的输入选择 $REPLY,按任意键重新选择\033[0m"
			read
	esac

done