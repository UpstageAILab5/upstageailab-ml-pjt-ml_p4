CrawlerService

Python 기반 네이버 블로그 크롤러 서비스입니다. 검색어(Query)를 입력받아 크롤링을 수행하고, 결과를 JSON 또는 CSV 형식으로 저장합니다.

---

## 주요 기능

- **Scrapy 기반 크롤링**: Scrapy와 Selenium을 사용하여 데이터를 효율적으로 크롤링합니다.
- **결과 저장**: 크롤링 결과를 JSON 및 CSV 형식으로 저장.
- **사용 편의성**: Python 함수 호출 또는 명령줄 인터페이스로 실행 가능.

---

## 설치 방법

1. 저장소 클론
   git clone <repository_url>
   cd CrawlerService

2. 가상환경 설정
   python3.10 -m venv venv
   source venv/bin/activate  # Windows: venv\Scripts\activate

3. 의존성 설치
   pip install -r requirements.txt

---

## 실행 방법

1. Scrapy 명령어로 실행
   검색어(Query)를 입력하여 크롤링을 실행하고 결과를 저장합니다.
   [예시]
   scrapy crawl naver_blog_spider
   scrapy crawl naver_blog_spider -a verbose=True
   scrapy crawl naver_blog_spider -a verbose=True -o output/naver_blog_crawling.csv
   scrapy crawl naver_blog_spider -a verbose=True -a query=스위스,독일
   scrapy crawl naver_blog_spider -a verbose=True -a query=스위스,독일 -a max_results=4
   scrapy crawl naver_blog_spider -a verbose=True -a query=이탈리아 -a max_results=2
   scrapy crawl naver_blog_spider -a verbose=True -a query=일본,중국,베트남 -a max_results=5
   scrapy crawl naver_blog_spider -a verbose=True -a query=일본,중국,베트남 -a max_results=5 -o output/test001.csv
   [ERROR]
   아래와 같은 경우 error가 발생합니다.
   # ######################################################################
   crawl: error: running 'scrapy crawl' with more than one spider is not supported
   # ######################################################################
   scrapy crawl naver_blog_spider -a verbose=True -t csv  [crawl: error]
   scrapy crawl naver_blog_spider -a verbose=True -a query= 스위스,독일  [crawl: error]
   # ######################################################################

2. Python 코드로 실행
   crawler_service.py의 run_crawler 함수를 호출하여 실행합니다:

   [test_crawler.py]
   from CrawlerService.crawler_service import run_crawler

   # 크롤링 테스트
   output_filename = "naver_blog_crawling"
   result = run_crawler(query="일본 도쿄,한국 서울", verbose=True, max_results=4, output_filename=output_filename)
   print(f"크롤링 결과 저장 (CSV file): output/{output_filename}.csv")
   print(f"크롤링 결과 저장 (JSON file): output/{output_filename}.json")

---

## 개발 및 디버깅

1. 의존성 분석
   pipdeptree를 사용하여 프로젝트 의존성을 분석할 수 있습니다:
   pip install pipdeptree
   pipdeptree

2. 로깅
   크롤링 과정에서 발생하는 모든 로그는 logs/ 폴더에 저장됩니다.

---

## 프로젝트 디렉토리 구조

프로젝트 디렉토리 구조는 다음과 같습니다:
CrawlerService
├── CrawlerService
│   ├── __init__.py
│   ├── crawler_service.py
│   ├── items.py
│   ├── pipelines.py
│   ├── settings.py
│   ├── setup.py
│   └── spiders
│       ├── __init__.py
│       └── naver_blog_spider.py
├── README.md
├── app
│   └── main.py
├── logs
├── output
├── requirements.txt
├── scrapy.cfg
├── test_crawler.py
├── .gitignore
└── venv
