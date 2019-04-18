module Danger
  class DangerReview < Plugin

    def check(branch = nil)
      return if branch.nil?

      review_exists = `aws ec2 describe-instances --filters 'Name=tag:branch,Values=#{branch}' | jq .Reservations | jq 'length'`.gsub("\n","").to_i
      if review_exists
        "[Available here](https://#{branch}.review.bergamotte.com)"
      else
        "none"
      end
    end

  end
end
