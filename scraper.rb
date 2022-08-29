require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    url = "https://www.moh.gov.jm/updates/job-vacancies/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    
    job_titles = parsed_page.css('div.block-content').css('h2')
    job_info = parsed_page.css('div.entry-category')
    job_titles.each_with_index do |job_title, index|
        job = {
            title: job_title.css('a')[0].attributes["title"].value,
            information: job_info[index].css('p').text,
            url: job_title.css('a')[0].attributes["href"].value


        }
        byebug
    end 
    
     

end   
scraper 
