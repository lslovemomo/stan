# frozen_string_literal: true

# disable Sinatra's logger
if defined?(Clogger) || ENV["DISABLE_ACCESS_LOG"]
  disable :logging
end

# https://bogomips.org/clogger/
# this format is similar to "Combined", but without $time_local and $http_user_agent (and using $ip instead of $remote_addr)
# removing time and user-agent saves ~50% on log filesize
# the purpose of ~ is to allow for easier grepping with -E '^~' (i.e. filtering out exceptions and other crap)
if defined?(Clogger) && !ENV["DISABLE_ACCESS_LOG"]
  use Clogger, logger: $stdout, reentrant: true, format: '~ $ip "$request" $status $response_length "$http_referer"'
end
