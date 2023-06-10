FROM ubuntu:22.04

ADD ohmyzsh ./oh-my-zsh

RUN true \
&& echo 'APT::Install-Recommends 0;\nAPT::Install-Suggests 0;\n' > /etc/apt/apt.conf.d/99norecommends \
&& apt update \
&& apt full-upgrade -y \
&& yes | unminimize \
&& DEBIAN_FRONTEND=noninteractive apt install -y \
    byobu \
    curl \
    git \
    less \
    man \
    sudo \
    vim-nox \
    zsh \
&& useradd -G sudo -m -s `which zsh` dev \
&& echo 'dev:dev' | chpasswd \
&& mv ./oh-my-zsh /home/dev/.oh-my-zsh \
&& chown -R dev:dev /home/dev/.oh-my-zsh \
&& su dev -c "cd /home/dev; echo 'if [[ -f ~/.tmprc ]];then source ~/.tmprc;fi' > .zshrc ; cat .oh-my-zsh/templates/zshrc.zsh-template >> .zshrc;sed -i -e 's/plugins=/plugins+=/' .zshrc; mkdir -p .local/bin; echo 'exec `which zsh`' > .local/bin/start && chmod +x .local/bin/start;" \
&& rm -rf /var/lib/apt/lists/* \
&& echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev_install_tmp \
&& true

ADD run /bin/run
ADD run_install /bin/run_install
WORKDIR /home/dev
USER dev
ENV LANG="C.UTF-8" 
CMD /bin/run
