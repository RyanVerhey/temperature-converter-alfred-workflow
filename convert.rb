input = ARGV.first

unit = input[input.length - 1].downcase

output = nil

case unit
when "f"
  output = '%.2f' % ((input.to_f - 32) / 1.8)
when "c"
  output = '%.2f' % (input.to_f * 1.8 + 32)
end

xml = "<items>"

if output && input.strip =~ /\d+.+[CcFf]/
  xml += "<item arg='#{output}' valid='YES'>"
  xml += "<title>#{output}°#{unit == 'f' ? 'C' : 'F'} = #{input.to_f}°#{unit.upcase}</title>"
  xml += "<subtitle>Copy to clipboard</subtitle>"
else
  xml += "<item valid='NO'>"
  xml += "<title>Type in &lt;temp&gt;F or &lt;temp&gt;C...</title>"
end

xml += "</item></items>"

puts xml
