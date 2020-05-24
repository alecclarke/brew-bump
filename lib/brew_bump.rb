require_relative "brew_bump/outdated_formula"

module BrewBump
  def self.bump_outdated_fromulae
    OutdatedFormula.bump_all
  end
end
