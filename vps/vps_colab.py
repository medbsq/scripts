#@title ← ឵឵ ឵Run this cell to crash your current Runtime if you're low on memory
#@markdown <i>After crashing, you'll have access to all the preoccupied storage</i>
some_str = ' ' * 5120000000000




#@markdown <h3>⬅️ Click Here to Install Tools And Create SSH Tunnel</h3>
#@markdown <br><center><img src='https://raw.githubusercontent.com/hackingguy/hackingguy.github.io/master/assets/images/logo.png' height="200" alt="ssh"/></center>
#@markdown <center><h3>Bug Hunting VPS </h3></center><br>
import os
import random
import string
import urllib.request
import requests
from urllib.parse import quote
from IPython.display import HTML, clear_output
import time

#####################################
USE_FREE_TOKEN = False #Free Token Disabled
CREATE_VNC = False # @paeam {type:"boolean"}
CREATE_SSH = True # @param {type:"boolean"}Are you invoking ngrok asking for a TCP tunnel? (ngrok -proto=tcp 5901)
TOKEN = "1bx748aMWVC4LQbWelqgZIOcqSl_4QwhcLCk1x6i581uyWeQk"  # @param {type:"string"}
USE_TELERGAM_BOT = False # @param {type:"boolean"}
TELEGRAM_API_TOKEN = "" # @param {type:"string"}
TELEGRAM_CHAT_ID = "" # @param {type:"string"}

#Script Credit Goes To https://github.com/unethicalnoob/
TOOLS_GIST = "https://raw.githubusercontent.com/unethicalnoob/BBHTv2/master/bbhtv2.sh" # @param {type:"string"}
#@markdown <center><h3>Note: Latest Golang Version Will Be Installed Even If You Change Gist</center>
#@markdown <center><h3>So Please Don't Write Go Installation In Gist Script</h3></center>

HOME = os.path.expanduser("~")
runW = get_ipython()
Version = '2.0.0'


if not os.path.exists(f"{HOME}/.ipython/ttmg.py"):
    hCode = "https://raw.githubusercontent.com/hackingguy/Bug-Bounty-Colab/master/ttmg.py"
    urllib.request.urlretrieve(hCode, f"{HOME}/.ipython/ttmg.py")

from ttmg import (
    runSh,
    loadingAn,
    ngrok,
    displayUrl,
    findProcess,
    CWD,
    textAn,
    updateCheck,
)

if updateCheck("Checking updates ...", Version):  # VERSION CHECKING ...
    !kill -9 -1 &
clear_output()

def tgnotify(bot_message):
    send_text = 'https://api.telegram.org/bot' + TELEGRAM_API_TOKEN + '/sendMessage?chat_id=' + TELEGRAM_CHAT_ID + '&parse_mode=Markdown&text=' + quote(bot_message)
    res = requests.get(send_text)


loadingAn()

# password generate
try:
  print(f"Found old password! : {password}")
except:
  password = ''.join(random.choice(string.ascii_letters + string.digits) for i in range(20))

textAn("updating system packages...")
runW.system_raw('apt-get update && apt-get -y upgrade')
#Set root password
if CREATE_SSH  and os.path.exists('/var/run/sshd') == False:
  #Setup sshdsshd9
  runSh('apt install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen')
  runW.system_raw("echo root:$password | chpasswd")
  os.makedirs("/var/run/sshd", exist_ok=True)
  runW.system_raw('echo "PermitRootLogin yes" >> /etc/ssh/sshd_config')
  runW.system_raw('echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config')
  runW.system_raw('echo "ClientAliveInterval 0" >> /etc/ssh/sshd_config')
  runW.system_raw('echo "ClientAliveCountMax 3" >> /etc/ssh/sshd_config')
  runW.system_raw('echo "LD_LIBRARY_PATH=/usr/lib64-nvidia:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/usr/lib" >> /root/.bashrc')
  runW.system_raw('echo "export LD_LIBRARY_PATH" >> /root/.bashrc')

  #Run sshd
  if not findProcess("/usr/sbin/sshd", command="-D"):
    runSh('/usr/sbin/sshd -D &', shell=True)

if CREATE_VNC:
  clear_output()

  textAn("Wait for almost 2 minutes. It's doing for VNC ready...")
  os.makedirs(f'{HOME}/.vnc', exist_ok=True)
  runW.system_raw('add-apt-repository -y ppa:apt-fast/stable < /dev/null')
  runW.system_raw('echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections')
  runW.system_raw('echo debconf apt-fast/dlflag boolean true | debconf-set-selections')
  runW.system_raw('echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections')
  runW.system_raw('apt install -y apt-fast dialog apt-utils')
  runW.system_raw('apt-fast install -y sshpass xfce4 xfce4-goodies firefox tigervnc-standalone-server tigervnc-common xorg dbus-x11 x11-xserver-utils tigervnc-xorg-extension')
  runW.system_raw(rf'echo "{password}" | vncpasswd -f > ~/.vnc/passwd')
  data = """
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
"""
  with open(f'{HOME}/.vnc/xstartup', 'w+') as wNow:
    wNow.write(data)
  os.chmod(f'{HOME}/.vnc/xstartup', 0o755)
  os.chmod(f'{HOME}/.vnc/passwd', 0o400)
  runW.system_raw(rf'sshpass -p "{password}" ssh -o StrictHostKeyChecking=no root@127.0.0.1 "vncserver -depth 32 -geometry 1366x768 &"')
  runSh(f'git clone https://github.com/novnc/noVNC.git {CWD}/noVNC')
  runSh("bash noVNC/utils/launch.sh --listen 6080 --vnc localhost:5901 &",
        shell=True)
  #end = time.time()

#few necessory tools
runW.system_raw('sudo apt-get install -y tmux vim htop net-tools')
runW.system_raw('wget -q -O - https://gist.githubusercontent.com/hackingguy/e0e401636e38551f8fa3d793bb371110/raw/1970f5de3b273896283d5e6e54a1b628594ef814/latest-go.sh | bash')
runW.system_raw('export GOROOT=$HOME/.go && export PATH=$GOROOT/bin:$PATH && export GOPATH=$HOME/go && curl '+TOOLS_GIST+' | bash ')
# bash aliases for tools from unethicalnoob
runW.system_raw('wget -q -O - https://raw.githubusercontent.com/unethicalnoob/aliases/master/bashprofile > ~/.bash_aliases && source ~/.bash_aliases')
# START_SERVER
# Ngrok region 'us','eu','ap','au','sa','jp','in'
clear_output()
Server = ngrok(TOKEN, USE_FREE_TOKEN, [['ssh', 22, 'tcp'],
               ['vnc', 6080, 'http']], 'in',
               [f"{HOME}/.ngrok2/sshVnc.yml", 4045])
data = Server.start('ssh', displayB=False)
# output
Host,port = data['url'][7:].split(':')
data2 = Server.start('vnc', displayB=False)
clear_output()

if USE_TELERGAM_BOT:
  tgnotify("noVNC URL: "+data2['url']+"/vnc.html?autoconnect=true&password="+password)
  tgnotify("SSH Details:\nHost:"+Host+"\nPort:"+port+"\nPassword:"+password)
  tgnotify("ssh -L 5901:127.0.0.1:5901 -N -f -l root "+Host+" -p "+port)
  runW.system_raw('git clone --quiet https://github.com/botgram/shell-bot && cd shell-bot && npm install --quiet && npm install --quiet pm2 -g && echo "{ \\"authToken\\":\\"'+TELEGRAM_API_TOKEN+'\\",\\"owner\\":'+TELEGRAM_CHAT_ID+' }" > config.json && pm2 start server.js')
  tgnotify(password)

if CREATE_VNC:
  displayUrl(data2, pNamU='noVnc : ',
            EcUrl=f'/vnc.html?autoconnect=true&password={password}')

if CREATE_SSH:
  display(HTML("""<style>@import url('https://fonts.googleapis.com/css?family=Source+Code+Pro:200,900');  :root {   --text-color: hsla(210, 50%, 85%, 1);   --shadow-color: hsla(210, 40%, 52%, .4);   --btn-color: hsl(210, 80%, 42%);   --bg-color: #141218; }  * {   box-sizing: border-box; } button { position:relative; padding: 10px 20px;     border: none;   background: none;      font-family: "Source Code Pro";   font-weight: 900;font-size: 20px;     color: var(--text-color);      background-color: var(--btn-color);   box-shadow: var(--shadow-color) 2px 2px 22px;   border-radius: 4px;    z-index: 0;overflow: hidden; -webkit-user-select: text;-moz-user-select: text;-ms-user-select: text;user-select: text;}  button:focus {   outline-color: transparent;   box-shadow: var(--btn-color) 2px 2px 22px; }  .right::after, button::after {   content: var(--content);   display: block;   position: absolute;   white-space: nowrap;   padding: 40px 40px;   pointer-events:none; }  button::after{   font-weight: 200;   top: -30px;   left: -20px; }   .right, .left {   position: absolute;   width: 100%;   height: 100%;   top: 0; } .right {   left: 66%; } .left {   right: 66%; } .right::after {   top: -30px;   left: calc(-66% - 20px);      background-color: var(--bg-color);   color:transparent;   transition: transform .4s ease-out;   transform: translate(0, -90%) rotate(0deg) }  button:hover .right::after {   transform: translate(0, -47%) rotate(0deg) }  button .right:hover::after {   transform: translate(0, -50%) rotate(-7deg) }  button .left:hover ~ .right::after {   transform: translate(0, -50%) rotate(7deg) }  /* bubbles */ button::before {   content: '';   pointer-events: none;   opacity: .6;   background:     radial-gradient(circle at 20% 35%,  transparent 0,  transparent 2px, var(--text-color) 3px, var(--text-color) 4px, transparent 4px),     radial-gradient(circle at 75% 44%, transparent 0,  transparent 2px, var(--text-color) 3px, var(--text-color) 4px, transparent 4px),     radial-gradient(circle at 46% 52%, transparent 0, transparent 4px, var(--text-color) 5px, var(--text-color) 6px, transparent 6px);    width: 100%;   height: 300%;   top: 0;   left: 0;   position: absolute;   animation: bubbles 5s linear infinite both; }  @keyframes bubbles {   from {     transform: translate();   }   to {     transform: translate(0, -66.666%);   } }.zui-table {    border: solid 1px #DDEEEE;    border-collapse: collapse;    border-spacing: 0;    font: normal 13px;}.zui-table thead th {    background-color: #DDEFEF;    border: solid 1px #DDEEEE;    color: #0000009e;    padding: 10px;    text-align: left;}.zui-table tbody td {border: solid 1px #effff97a;color: #ffffffd1;    padding: 10px;}</style><center><button><table class="zui-table blueBG"><p>SSH config<p><thead>        <tr>        <th>Host</th>            <th>Port</th>        <th>Password</th> </tr>    </thead>    <tbody>        <tr><td>"""+Host+"""</td><td>"""+port+"""</td><td>"""+password+"""</td></tr></tbody></table><center><br><table class="zui-table blueBG"><thead>        <tr>        <th>Simple ssh command</th></tr>    </thead>    <tbody>        <tr><td>ssh root@"""+Host+""" -p """+port+"""</td></tr></tbody></table></center><a target="_blank" style="text-decoration: none;color: hsla(210, 50%, 85%, 1);font-size: 10px;" href="http://bit.ly/2RDhV0c">NB. How to setup this's config. [Click ME]</a></button><center>"""))
  display(HTML("<br>"))

if CREATE_VNC:
    display(HTML("""<style>@import url('https://fonts.googleapis.com/css?family=Source+Code+Pro:200,900');  :root {   --text-color: hsla(210, 50%, 85%, 1);   --shadow-color: hsla(210, 40%, 52%, .4);   --btn-color: hsl(210, 80%, 42%);   --bg-color: #141218; }  * {   box-sizing: border-box; } button { position:relative; padding: 10px 20px;     border: none;   background: none;      font-family: "Source Code Pro";   font-weight: 900;font-size: 20px;     color: var(--text-color);      background-color: var(--btn-color);   box-shadow: var(--shadow-color) 2px 2px 22px;   border-radius: 4px;    z-index: 0;overflow: hidden; -webkit-user-select: text;-moz-user-select: text;-ms-user-select: text;user-select: text;}  button:focus {   outline-color: transparent;   box-shadow: var(--btn-color) 2px 2px 22px; }  .right::after, button::after {   content: var(--content);   display: block;   position: absolute;   white-space: nowrap;   padding: 40px 40px;   pointer-events:none; }  button::after{   font-weight: 200;   top: -30px;   left: -20px; } .center{ margin-left: auto; margin-right: auto; };   .right, .left {   position: absolute;   width: 100%;   height: 100%;   top: 0; } .right {   left: 66%; } .left {   right: 66%; } .right::after {   top: -30px;   left: calc(-66% - 20px);      background-color: var(--bg-color);   color:transparent;   transition: transform .4s ease-out;   transform: translate(0, -90%) rotate(0deg) }  button:hover .right::after {   transform: translate(0, -47%) rotate(0deg) }  button .right:hover::after {   transform: translate(0, -50%) rotate(-7deg) }  button .left:hover ~ .right::after {   transform: translate(0, -50%) rotate(7deg) }  /* bubbles */ button::before {   content: '';   pointer-events: none;   opacity: .6;   background:     radial-gradient(circle at 20% 35%,  transparent 0,  transparent 2px, var(--text-color) 3px, var(--text-color) 4px, transparent 4px),     radial-gradient(circle at 75% 44%, transparent 0,  transparent 2px, var(--text-color) 3px, var(--text-color) 4px, transparent 4px),     radial-gradient(circle at 46% 52%, transparent 0, transparent 4px, var(--text-color) 5px, var(--text-color) 6px, transparent 6px);    width: 100%;   height: 300%;   top: 0;   left: 0;   position: absolute;   animation: bubbles 5s linear infinite both; }  @keyframes bubbles {   from {     transform: translate();   }   to {     transform: translate(0, -66.666%);   } }.zui-table {    border: solid 1px #DDEEEE;    border-collapse: collapse;    border-spacing: 0;    font: normal 13px;}.zui-table thead th {    background-color: #DDEFEF;    border: solid 1px #DDEEEE;    color: #0000009e;    padding: 10px;    text-align: left;}.zui-table tbody td {border: solid 1px #effff97a;color: #ffffffd1;    padding: 10px;}</style><center><button><table class="zui-table blueBG center"><p>VNC config(Desktop)<p><thead>        <tr>        <th>Host</th>            <th>Port</th>        <th>Password</th> </tr>    </thead>    <tbody>        <tr><td>"""+Host+"""</td><td>"""+port+"""</td><td>"""+password+"""</td></tr></tbody></table><center><br><table class="zui-table blueBG"><thead>        <tr>        <th>Step 1.Create ssh-tunnel</th></tr>    </thead>    <tbody>        <tr><td>ssh -L 5901:127.0.0.1:5901 -N -f -l root """+Host+""" -p """+port+"""</td></tr></tbody></table><table class="zui-table blueBG"><thead>     <br>   <tr>        <th>Step 2.Connect from VNC viewer(Set Encryption None)</th></tr>    </thead>    <tbody>        <tr><td>127.0.0.1:5901 """+password+"""</td></tr></tbody></table>"""))
