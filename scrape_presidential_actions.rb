require 'open-uri'
require 'nokogiri'
require 'csv'
csv_path = 'documents_of_type_presidential_document_and_of_presidential_document_type_executive_order.csv'
table = CSV.parse(File.read(csv_path), headers: true)

i = 0

table.each do |r|
  url = r["html_url"]
  doc = Nokogiri::HTML(URI.open(url))
  target_html = doc.css("#fulltext_content_area").to_html
  filename = doc.css(".eo").first.text.downcase.gsub(" ", "_") + ".html"
  File.write(filename, target_html)
  i += 1
  break if i > 10
end
