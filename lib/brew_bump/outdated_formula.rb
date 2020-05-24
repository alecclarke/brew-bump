require "formula"
require_relative "brew_commands"

class OutdatedFormula
  def self.bump_all
    outdated_formulae = BrewCommands.livecheck

    outdated_formulae.reject do |formula|
      formula["version"]["guessed"]
    end.each do |formula|
      new(formula["formula"], formula["version"]["latest"]).open_bump_pr
    end
  end

  attr_reader :stable, :formula_name, :latest_version

  def initialize(formula_name, latest_version)
    @formula_name = formula_name
    @stable = Formula[formula_name].stable
    @latest_version = latest_version
  end

  def open_bump_pr
    BrewCommands.bump_formula_pr(formula_name: formula_name, url: url)
  end

  private

  def url
    stable.url.gsub(stable.version, latest_version) if stable.url # TODO: bump formulae that use a git download strategy
  end
end
