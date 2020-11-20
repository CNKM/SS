#!/bin/bash
function RefashBash
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
#1-主菜单
 function MainMenu
 {
 	$option=''
	clear
	ShowTilte
	echo -e "\033[32m 1)基本组件安装\033[0m"
	echo -e "\033[32m 2)常用工具安装\033[0m"
	echo -e "\033[32m 3)常用配置\033[0m"
	echo -e "\033[32m 4)说明\033[0m"
	echo -e "\033[32m 0)退出\033[0m"
	echo "选择操作序号"		
	read  -s -n 1 option
		
}
#1-主菜单流程
function ProcMainMenu
{
while [ 1 ]
do 
MainMenu
case $option 
in 
 1)
   echo -e "\033[32m 基础组件安装，请稍后...\033[0m"
   InstallBase
   echo -e "\033[32m 操作结束！\033[0m"
   break ;;
 2)
    ProcCommMenu
    break;;
 3)
    ProcCommSetMenu
   break ;;
 4)
    cat ./README.md
   break ;;
 0)
   echo -e "\033[32m 退出\033[0m"
   break ;;
 *) 
	echo  -e "\033[31m输入错误,请重新选择，按任意健继续.....\033[0m";;
 esac
 read -s -n 1 line1
done
}

#2-常用组件
function CommMenu
{
	$SubOption=''
	clear
	ShowTilte
	echo -e "\033[32m 1)Java Devment Kit 安装配置\033[0m"
	echo -e "\033[32m 2)Grub Customer 安装\033[0m"
	echo -e "\033[32m 3)系统图标美化\033[0m"
	echo -e "\033[32m 4)系统字体美化\033[0m"
	echo -e "\033[32m 5)安装 vscode \033[0m"
	echo -e "\033[32m 6)安装 dotnet \033[0m"
	echo -e "\033[32m 7)安装 v2raya \033[0m"
	echo -e "\033[32m 0)返回\033[0m"
	echo "选择操作序号"		
	read  -s -n 1 SubOption
}

#2-常用组件流程
function ProcCommMenu
{
while [ 1 ]
do 
 CommMenu
 case $SubOption
in
1)
	echo -e "\033[32m JDK 安装配置，请稍后...\033[0m"
	InstallJDK
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
2)
	echo -e "\033[32m GrubCustomer 安装配置，请稍后...\033[0m"
	InstallGrubCustom
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
3)
	echo -e "\033[32m 系统图标美化，请稍后...\033[0m"
	BeautifySystemIcon
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
4)
	echo -e "\033[32m 系统字体美化，请稍后...\033[0m"
	Installfonts
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
5)
	echo -e "\033[32m 安装 vscode，请稍后...\033[0m"
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	sudo add-apt-repository universe
	sudo apt-get install apt-transport-https
	sudo apt-get update
	sudo apt-get install code dotnet-sdk-2.2  # or code-insiders
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
6)
	echo -e "\033[32m 安装 dotnet，请稍后...\033[0m"
	wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	sudo add-apt-repository universe
	sudo apt-get install apt-transport-https
	sudo apt-get update
	sudo apt-get install aspnetcore-runtime-2.2
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
7)
	echo -e "\033[32m 安装 v2raya，请稍后...\033[0m"
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
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
0)
	echo -e "\033[32m 返回 \033[0m"
	ProcMainMenu
	break;;
*)
	echo  -e "\033[31m输入错误,请重新选择，按任意健继续.....\033[0m";;
 esac
read -s -n 1 line
done
}


#3-常用设置
function CommSetMenu
{
	$SubSetOption=''
	clear
	ShowTilte
	echo -e "\033[32m 1)常用别名设置\033[0m"
	echo -e "\033[32m 2)Bash编辑器设置\033[0m"
	echo -e "\033[32m 3)汉化(浏览器 操作系统)\033[0m"
	echo -e "\033[32m 4)Lubuntu 基础组件优化\033[0m"
	echo -e "\033[32m 5)Github 清理\033[0m"
	echo -e "\033[32m 0)返回\033[0m"
	echo "选择操作序号"		
	read  -s -n 1 SubSetOption
}

#3-常用设置流程
function ProcCommSetMenu
{
while [ 1 ]
do 
 CommSetMenu
 case $SubSetOption
in
1)
	echo -e "\033[32m 常用别名设置，请稍后...\033[0m"
	SetAlias
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
2)
	echo -e "\033[32m Bash编辑器设置，请稍后...\033[0m"
	SetEditor
	echo -e "\033[32m 操作结束！\033[0m"
	break;;

3)
	echo -e "\033[32m 浏览器汉化，请稍后...\033[0m"
	localChinesWebTools
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
4)
	echo -e "\033[32m Lubuntu 基础组件优化，请稍后...\033[0m"
	LubuntuInit
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
5)
	echo -e "\033[32m git 清理...\033[0m"
	GitClear
	echo -e "\033[32m 操作结束！\033[0m"
	break;;
0)
	echo -e "\033[32m 返回 \033[0m"
	ProcMainMenu
	break;;
*)
	echo  -e "\033[31m输入错误,请重新选择，按任意健继续.....\033[0m";;
 esac
read -s -n 1 line
done
}

function InstallBase
{
    
	sudo apt-get install git htop guake  fortunes-zh network-manager-* numlockx build-essential libgtk2.0-dev  variety  xcompmgr 

    git config --global user.email "km.liuz@gmail.com"
    git config --global user.name "CNKM"
}


function LubuntuInit
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
}

function GitClear()
{
	 git checkout --orphan latest_branch
	 git add -A
	 git commit -am "latest"
	 git branch -D master
	 git branch -m master
	 git push -f origin master
}

function Installshadowsocks
{
	sudo add-apt-repository ppa:hzwhuang/ss-qt5
	sudo apt-get update
	sudo apt-get install shadowsocks-qt5
	proxyaddress='127.0.0.1'
	proxyport=54322
	if test -z  "./ps" ;then
		rm  ./ps
	fi
	if test -z  "./pp" ;then
		rm  ./pp
	fi

	if test -z  "./pt" ;then
		rm  ./pt
	fi
	echo "#!/bin/bash" >./ps
	echo  "gsettings set org.gnome.system.proxy mode 'manual' " >> ./ps
	echo  "gsettings set org.gnome.system.proxy.http host "$proxyaddress >> ./ps
	echo  "gsettings set org.gnome.system.proxy.http port  "$proxyport >> ./ps
	echo  "gsettings set org.gnome.system.proxy.https host " $proxyaddress>> ./ps
	echo  "gsettings set org.gnome.system.proxy.https port "$proxyport >> ./ps
	echo  "gsettings set org.gnome.system.proxy.ftp host "$proxyaddress >>./ps
	echo  "gsettings set org.gnome.system.proxy.ftp port "$proxyport  >>./ps
	echo "gsettings set org.gnome.system.proxy.socks host "$proxyaddress >>./ps
	echo "gsettings set org.gnome.system.proxy.socks port "$proxyport  >>./ps
	echo "echo \"已启动代理:代理地址为:127.0.0.1  端口为:54322\" " >>./ps
	##

	echo  "gsettings set org.gnome.system.proxy mode 'none' " >./pp
	echo "echo \"恢复直接连接\" " >>./pp
	
	echo "#!/bin/bash" >./pt
	echo "mode=\$(gsettings get org.gnome.system.proxy mode)" >>./pt
	echo "host=\$(gsettings get org.gnome.system.proxy.http host)" >>./pt
	echo "port=\$(gsettings get org.gnome.system.proxy.http port)" >>./pt
	echo "none=\\'none\\'"  >>./pt
	echo "if  test \"\$mode\" = \"\$none\" "  >>./pt
	echo "then"  >>./pt
	echo "	echo \"当前代理模式为:\$mode \"" >>./pt
	echo "else"  >>./pt
	echo "	echo \"当前代理模式为:\$mode，地址为:127.0.0.1  端口为:54322\" "  >>./pt
	echo "fi"  >>./pt
	
	sudo chmod  a+x  ./ps
	sudo chmod  a+x  ./pp
	sudo chmod  a+x  ./pt
}

function InstallJDK
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
	fi
}

function Installfonts
{
	echo "安装微软字体( 脚本来源 Deng.Yangjun@Gmail.com)"
	sudo ./3th/get-fonts.sh
}

function  InstallGrubCustom
{
	sudo add-apt-repository ppa:danielrichter2007/grub-customizer
	sudo apt-get update
	sudo apt-get install grub-customizer
}

function SetEditor
{
	echo -e "\033[32m 设置编辑器\033[0m"
	sudo update-alternatives --config editor
}

function SetAlias
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

function BeautifySystemIcon
{
	
	sudo apt-add-repository ppa:numix/ppa -y
	sudo add-apt-repository ppa:papirus/papirus -y
	sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 90127F5B
	sudo apt-get update
	sudo apt-get install faenza-icon-theme moka-icon-theme numix-icon-theme-circle
}

function localChinesWebTools
{
	sudo apt-get install chromium-browser-l10n firefox-locale-zh-hans
	sudo apt-get install language-pack-zh-hans language-pack-gnome-zh-hans libreoffice-l10n-zh-cn thunderbird-locale-zh-hans firefox-locale-zh-hans
}


ProcMainMenu
