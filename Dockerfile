# 베이스 이미지
# Python 3.10 Slim 이미지 사용
FROM python:3.10-slim

# 작성자 정보
LABEL maintainer="dongwank@naver.com"

# 작업 디렉터리 설정
WORKDIR /app

# 환경 변수로 컨테이너 이름 전달
ENV CONTAINER_NAME="naver-blog-crawler"

# 수정된 profile 파일 복사
COPY profile /etc/profile

# set_prompt.sh 스크립트를 컨테이너의 /etc/profile.d/ 디렉토리에 복사
COPY set_prompt.sh /etc/profile.d/set_prompt.sh

# 스크립트에 실행 권한 부여
RUN chmod +x /etc/profile.d/set_prompt.sh

# 필요한 시스템 패키지 설치
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    chromium \
    chromium-driver \
    libnss3 \
    libgconf-2-4 \
    fonts-liberation \
    libasound2 \
    libgbm1 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libxss1 \
    libxtst6 \
    libxshmfence1 \
    iputils-ping \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# Google Chrome 설치 (ChromeDriver와 버전 맞춤)
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable && \
    apt-get clean

# 의존성 파일 복사
COPY requirements.txt ./

# Python 패키지 설치
RUN pip install --no-cache-dir --quiet -r requirements.txt

# Chrome 및 ChromeDriver 환경 변수 설정
ENV CHROME_BIN=/usr/bin/google-chrome
ENV CHROMEDRIVER_BIN=/usr/bin/chromedriver

# 로그 디렉터리 생성
RUN mkdir -p /app/logs /app/output

# 애플리케이션 파일 복사
COPY . .

# 기본 실행 명령
ENTRYPOINT ["scrapy"]
CMD ["crawl", "naver_blog_spider"]
