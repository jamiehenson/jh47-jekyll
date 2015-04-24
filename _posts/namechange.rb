require 'yaml'

Dir.open("./").each do |file|
  if file.include?(".md") && !file.start_with?("20")
    f = File.open(file, "r")
    f_string = f.read
    frontmatter = f_string.split("---").first
    rest = f_string.split("---").last
    hash = YAML.load(frontmatter)
    hash.delete("id")
    hash = hash.merge({"layout" => "post"})
    date = hash["date"].to_s.split(" ").first
    fw = File.open(file, "w")
    fw.write(hash.to_yaml + "---" + rest)
    File.rename(file, "#{date}-#{file}")
  end
end
