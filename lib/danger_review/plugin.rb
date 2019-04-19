module Danger
  class DangerReview < Plugin

    def check(branch = nil)
      return if branch.nil?
      @branch = branch
      check_review
    end

    private

    def check_review
      markdown if ENV['REVIEW_ENVIRONMENT'] == "true"
      markdown if aws_command
    end

    def aws_command
      `aws ec2 describe-instances --filters 'Name=tag:branch,Values=#{@branch}' | jq .Reservations | jq 'length'`.gsub("\n","").to_i
    end

    def markdown
      "[Available here](https://#{@branch}.review.bergamotte.com)"
    end

  end
end
