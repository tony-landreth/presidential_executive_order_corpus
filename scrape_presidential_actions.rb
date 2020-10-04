require 'open-uri'
require 'nokogiri'
require 'csv'
csv_path = 'documents_of_type_presidential_document_and_of_presidential_document_type_executive_order.csv'
table = CSV.parse(File.read(csv_path), headers: true)

table.each do |r|
  url = r["html_url"]
  eo_number = r["executive_order_number"]
  doc = Nokogiri::HTML(URI.open(url))
  puts "URL: #{url}   EO NUMBER: #{eo_number}"
  target_html = doc.css("#fulltext_content_area").to_html
  filename = eo_number + ".html"
  File.write(filename, target_html)
end
