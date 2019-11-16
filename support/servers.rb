# pid = spawn("`appium -p #{device[:appium_port]}`")
pid = spawn("`appium -p 4567`")
# pid_arr << pid
# Process.detach(pid)

system("echo 'hi2'")

puts 'bye...'
`kill -9 #{pid}`
p "killed"
