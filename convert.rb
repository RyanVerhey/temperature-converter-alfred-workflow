require_relative 'alfred_helper'

def f_to_c(f_temp)
  ((f_temp.to_f - 32.0) / 1.8).round(2)#.to_f
end

def c_to_f(c_temp)
  (c_temp.to_f * 1.8 + 32.0).round(2)#.to_f
end

def c_to_k(c_temp)
  (c_temp + 273.15).round(2)#.to_f
end

def k_to_c(k_temp)
  (k_temp - 273.15).round(2)#.to_f
end

input = ARGV.first.strip

input_unit = input[input.length - 1].downcase

f, c, k = nil

case input_unit
when "f"
  f = input.to_f
  c = f_to_c(f)
  k = c_to_k(c)
when "c"
  c = input.to_f
  f = c_to_f(c)
  k = c_to_k(c)
when "k"
  k = input.to_f
  c = k_to_c(k)
  f = c_to_f(c)
end

units = { "f" => f, "c" => c, "k" => k }

xml = Alfred::Workflow.new

if f && c && k && input =~ /\d+.*[CcFfKk]/
  units.each do |unit, value|
    if unit != input_unit
      item = Alfred::Item.new({
        arg: value,
        title: "#{value}°#{unit.upcase}",
        subtitle: "Copy to clipboard" })
      xml << item
    end
  end
else
  error = Alfred::Item.new({
    valid: "no",
    title: "Type in &lt;temp&gt;F or &lt;temp&gt;C or &lt;temp&gt;K..." })
  xml << error
end

puts xml
