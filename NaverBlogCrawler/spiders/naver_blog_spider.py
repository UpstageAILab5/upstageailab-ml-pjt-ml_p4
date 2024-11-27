import scrapy
from NaverBlogCrawler.items import NaverBlogCrawlerItem

class NaverBlogSpider(scrapy.Spider):
    name = "naver_blog_spider"  # Spider 이름
    allowed_domains = ["blog.naver.com"]  # 크롤링 허용 도메인
    start_urls = ["https://blog.naver.com/navigator"]  # 시작 URL

    def parse(self, response):
        # 각 블로그 포스트에서 데이터 추출
        for post in response.css(".post"):  # 게시글 컨테이너 선택자 (HTML 구조에 맞게 수정 필요)
            content = post.css(".content::text").get()

            # 특정 키워드 필터링: "대한항공"이 포함된 게시글만 처리
            if "대한항공" in (content or ""):  # content가 None일 수 있으므로 기본값 처리
                item = NaverBlogCrawlerItem()
                item["title"] = post.css("h1::text").get()
                item["author"] = post.css(".author::text").get()
                item["date"] = post.css(".date::text").get()
                item["content"] = content
                item["url"] = response.url
                yield item

        # "다음 페이지" 링크 추출 및 처리
        next_page = response.css("a.next::attr(href)").get()
        if next_page:
            self.log(f"Following next page: {next_page}")
            yield response.follow(next_page, self.parse)

