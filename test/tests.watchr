ENV["WATCHR"] = "1"
system 'clear'

def growl(message)
  growlnotify = `which growlnotify`.chomp
  clean_message = message.gsub(/\[\d+m/, "")
  title = ''
  image = ''

  if clean_message =~ /0 failures/ && clean_message =~ /0 errors/
    title = "All Tests Passed"
    image = "~/.autotest_images/pass.png"
  else
    title = "Test FAILURES"
    image = "~/.autotest_images/fail.png"
  end

  options = "-w -n Tests --image '#{File.expand_path(image)}' -m '#{clean_message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def run(cmd)
  puts(cmd)
  `#{cmd}`
end

def run_test_file(file)
  system('clear')
  stdout_redirect(%Q(ruby -I"lib:test" -rubygems #{file}))
end

def run_all_tests
  system('clear')
  stdout_redirect("rake testall")
end

def stdout_redirect(command)
  op = []
  IO.popen(command) do |f|
    while (line = f.gets)
      op << line
      puts line
    end
  end
  growl(op.last)
end

def related_test_files(path)
  Dir['test/unit/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ } +
  Dir['test/functional/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }  +
  Dir['test/functional/*/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }
end

def run_suite
  run_all_tests
end

watch('test/test_helper\.rb') { run_all_tests }
watch('test/.*/.*_test\.rb') { |m| run_test_file(m[0]) }

# Doesnt look like this is working quite right at the moment.
watch('app/.*/.*\.rb') { |m| related_test_files(m[0]).map {|tf| run_test_file(tf) } }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    exit(0)
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    sleep(1)
    run_all_tests
  end
end
