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
    while page <= number_of_pages
        pagination_url = "https://www.moh.gov.jm/updates/job-vacancies/page/#{page}/"
        puts ''
        puts pagination_url
        puts ''
        puts "Page: #{page}"
        puts ''

        pagination_unparsed_page = HTTParty.get(pagination_url )
        pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
        pagination_job_titles = pagination_parsed_page.css('div.block-content').css('h2')
        pagination_job_info = pagination_parsed_page.css('div.entry-category')
        
        pagination_job_titles.each_with_index do |job_title, index|
        job = {
            title: job_title.css('a')[0].attributes["title"].value,
            information: job_info[index].css('p').text,
            url: job_title.css('a')[0].attributes["href"].value


        }
        jobs << job 
        puts "Added #{job[:title]}"
        puts ''
        sleep 1 
      
        
        end 
    page += 1
    end
    byebug
 
     

end    
scraper