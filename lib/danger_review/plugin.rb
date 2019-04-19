module Danger
  class DangerReview < Plugin

    def check(branch = nil)
      return if branch.nil?
      markdown(branch) if review_bootup == "true" || aws_command(branch) == 1
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
