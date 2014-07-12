def f_to_c(f_temp)
  ('%.2f' % ((f_temp.to_f - 32.0) / 1.8)).to_f
end

def c_to_f(c_temp)
  ('%.2f' % (c_temp.to_f * 1.8 + 32.0)).to_f
end

def c_to_k(c_temp)
  ('%.2f' % (c_temp + 273.15)).to_f
end

def k_to_c(k_temp)
  ('%.2f' % (k_temp - 273.15)).to_f
end

input = ARGV.first.strip

input_unit = input[input.length - 1].downcase

f = nil
c = nil
k = nil

case input_unit
when "f"
  f = input.to_f
  c = f_to_c(f)
  k = c_to_k(c)
when "c"
  c = input.to_f
  f = c_to_f(c)
  k = to_k(c)
when "k"
  k = input.to_f
  c = k_to_c(k)
  f = c_to_f(c)
end

units = { "f" => f, "c" => c, "k" => k }

xml = "<items>"

if f && c && k && input =~ /\d+.*[CcFfKk]/
  units.each do |unit, value|
    if unit != input_unit
      xml += "<item arg='#{value}' valid='YES'>"
      xml += "<title>#{value}°#{unit.upcase}</title>"
      xml += "<subtitle>Copy to clipboard</subtitle>"
      xml += "</item>"
    end
  end
else
  xml += "<item valid='NO'>"
  xml += "<title>Type in &lt;temp&gt;F or &lt;temp&gt;C or &lt;temp&gt;K...</title>"
  xml += "</item>"
end

xml += "</items>"

puts xml
