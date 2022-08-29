require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    url = "https://www.moh.gov.jm/updates/job-vacancies/"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    
 
     

end    
