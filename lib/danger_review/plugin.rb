module Danger
  class DangerReview < Plugin

    def check(branch = nil)
      return if branch.nil?
      puts "env var is #{review_bootup}"
      puts "aws command output is #{aws_command(branch)}"
      markdown(branch) if review_bootup || aws_command(branch)
    end

    private

    def aws_command(branch)
      `aws ec2 describe-instances --filters 'Name=tag:branch,Values=#{branch}' | jq .Reservations | jq 'length'`.gsub("\n","").to_i
    end

    def markdown(branch)
      "[Available here](https://#{branch}.review.bergamotte.com)"
    end

    def review_bootup
      ENV['REVIEW_ENVIRONMENT'] || false
    end
  end
end
