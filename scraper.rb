require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    url = "https://www.moh.gov.jm/updates/job-vacancies/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    job_titles = parsed_page.css('div.block-content').css('h2')
    job_info = parsed_page.css('div.entry-category')
    jobs = Array.new
    page = 1
    per_page = job_titles.count 
    last_page_url = parsed_page.css('div.wp-pagenavi').css('a.last')[0].attributes["href"].value
    number_of_pages = last_page_url.chars.last(3).join.chop.to_i
    job_titles.each_with_index do |job_title, index|
        job = {
            title: job_title.css('a')[0].attributes["title"].value,
            information: job_info[index].css('p').text,
            url: job_title.css('a')[0].attributes["href"].value


        }
        jobs << job 
        
    end 
    byebug
 

end   
scraper 
