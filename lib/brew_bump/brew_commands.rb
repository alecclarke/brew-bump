require "json"
require "open3"

module BrewCommands
  def self.bump_formula_pr(formula_name:, url:)
    command_args = [
      "brew",
      "bump-formula-pr",
      "--no-browse",
      "--dry-run",
      "--url=#{url}",
      formula_name
    ]

    bump_pr_response, status = Open3.capture2e(*command_args)

    puts "#{bump_pr_response} - #{status}"
  end

  def self.livecheck
    command_args = [
      "brew",
      "livecheck",
      "--quiet",
      "--newer-only",
      "--full-name",
      "--json"
    ]

    livecheck_response, _status = Open3.capture2e(*command_args)
    JSON.parse(livecheck_response)
  end
end
