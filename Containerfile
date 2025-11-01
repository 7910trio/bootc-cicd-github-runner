# 기존 bootc 이미지 기반
FROM quay.io/fedora/fedora-bootc:42
LABEL containers.bootc="1"

ARG GIT_COMMIT_HASH
LABEL org.opencontainers.image.revision=${GIT_COMMIT_HASH}

# 패키지 설치
RUN mkdir -p /var/roothome && \
		dnf -y install cloud-init httpd openssh-server vim && \
    dnf clean all 
    
# systemd 서비스 활성화
RUN systemctl enable httpd \
    && systemctl enable cloud-init \
    && systemctl enable sshd

# 사용자 HTML 복사
COPY index.html /var/www/html/index.html

# 부팅 시 init 시작
CMD ["/sbin/init"]
