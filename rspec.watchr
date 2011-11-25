watch('lib/(.*).rb') { |x| run_spec "spec/#{x[1]}_spec.rb" }
watch('spec/.*_spec.rb') { |x| run_spec x[0] }

def run_spec(spec)
  puts "Running spec: #{spec}"
  if system "rspec #{spec}"
    send_notification :all unless system "rspec spec/"
  else
    send_notification
  end
end

def send_notification(all=false)
  if all
    system "notify-send 'Erros nos SPEC', 'Um SPEC da suíte está falhando'"
  else
    system "notify-send 'Erros nos SPEC', 'O SPEC atual está falhando'"
  end
end
