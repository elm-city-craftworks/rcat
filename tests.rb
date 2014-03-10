# Task: Implement the rcat utility and get these tests to pass on a system 
# which has the UNIX cat command present

# To see Gregory Brown's solution, see http://github.com/elm-city-craftworks/rcat
# Feel free to publicly share your own solutions

# If you want to see detailed commentary on how to solve this problem
# please subscribe to the Practicing Ruby Journal ( practicingruby.com )
# An article on this topic will be released on Tuesday 10/18.

require "open3"

working_dir = File.dirname(__FILE__)
gettysburg_file = "#{working_dir}/data/gettysburg.txt"
spaced_file     = "#{working_dir}/data/spaced_out.txt"

############################################################################

cat_output  = `cat #{gettysburg_file}`
rcat_output = `rcat #{gettysburg_file}`

fail "Failed 'cat == rcat'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat #{gettysburg_file} #{spaced_file}`
rcat_output = `rcat #{gettysburg_file} #{spaced_file}`

fail "Failed 'cat [f1 f2] == rcat [f1 f2]'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat < #{spaced_file}`
rcat_output = `rcat < #{spaced_file}`

unless cat_output == rcat_output
  fail "Failed 'cat < file == rcat < file" 
end

############################################################################

cat_output  = `cat -n #{gettysburg_file}`
rcat_output = `rcat -n #{gettysburg_file}`

fail "Failed 'cat -n == rcat -n'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat -b #{gettysburg_file}`
rcat_output = `rcat -b #{gettysburg_file}`

fail "Failed 'cat -b == rcat -b'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat -s #{spaced_file}`
rcat_output = `rcat -s #{spaced_file}`

fail "Failed 'cat -s == rcat -s'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat -bs #{spaced_file}`
rcat_output = `rcat -bs #{spaced_file}`

fail "Failed 'cat -bns == rcat -bns'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat -bns #{spaced_file}`
rcat_output = `rcat -bns #{spaced_file}`

fail "Failed 'cat -bns == rcat -bns'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat -nbs #{spaced_file}`
rcat_output = `rcat -nbs #{spaced_file}`

fail "Failed 'cat -nbs == rcat -nbs'" unless cat_output == rcat_output

############################################################################

cat_output  = `cat -ns #{gettysburg_file} #{spaced_file}`
rcat_output = `rcat -ns #{gettysburg_file} #{spaced_file}`

unless cat_output == rcat_output
  fail "Failed 'cat -ns [f1 f2] == rcat -ns [f1 f2]'" 
end

############################################################################

cat_output  = `cat -bs #{gettysburg_file} #{spaced_file}`
rcat_output = `rcat -bs #{gettysburg_file} #{spaced_file}`

unless cat_output == rcat_output
  fail "Failed 'cat -bs [f1 f2] == rcat -bs [f1 f2]'" 
end

############################################################################

`cat #{gettysburg_file}`
cat_success = $?

`rcat #{gettysburg_file}`
rcat_success = $?

unless cat_success.exitstatus == 0 && rcat_success.exitstatus == 0
  fail "Failed 'cat and rcat success exit codes match"
end

############################################################################

cat_out, cat_err, cat_process    = Open3.capture3("cat some_invalid_file")
rcat_out, rcat_err, rcat_process = Open3.capture3("rcat some_invalid_file") 

unless cat_process.exitstatus == 1 && rcat_process.exitstatus == 1
  fail "Failed 'cat and rcat exit codes match on bad file"
end

#unless rcat_err == "rcat: No such file or directory - some_invalid_file\n"
#  fail "Failed 'cat and rcat error messages match on bad file'"
#end

############################################################################


cat_out, cat_err, cat_proccess  = Open3.capture3("cat -x #{gettysburg_file}")
rcat_out,rcat_err, rcat_process = Open3.capture3("rcat -x #{gettysburg_file}") 

unless cat_process.exitstatus == 1 && rcat_process.exitstatus == 1
  fail "Failed 'cat and rcat exit codes match on bad switch"
end

unless rcat_err == "rcat: invalid option: -x\nusage: rcat [-bns] [file ...]\n"
  fail "Failed 'rcat provides usage instructions when given invalid option"
end

############################################################################

puts "You passed the tests, yay!"
