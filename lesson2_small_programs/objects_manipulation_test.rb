def pass(v)
  puts(v.object_id)
  puts(v.upcase.object_id)
  puts(v.object_id)
end

a = "chris"
puts(a.object_id)
pass(a)
puts(a.object_id)