require 'yaml'

files = Dir.open('notes')
    .select { |file| file =~ /.+\.md/ }
    .map do |filename|
        contents = File.read("notes/" + filename)
        contents = YAML.load(contents)
        contents["filename"] = filename.split(".")[0]
        contents
    end
    .select {|file| file["public"] }

puts "<h1>Notes and thoughts</h1>"
puts "<ul>"
files.sort {|x,y| y["date"] <=> x["date"] }
    .each do |file|
        print "<li><a href='#{file["filename"]}.html'>"
        print "<span class='date'>#{file["date"]}</span>"
        puts "<span class='title'>#{file["title"]}</span></a></li>" 
    end
puts "</ul>"
