RSpec.describe OutdatedFormula do
  describe "::bump_all" do
    let(:outdated_formula_double) { instance_double("OutdatedFormula") }
    let(:livecheck_response) do
      [
        {
          "formula" => "guessed_formula",
          "version" => {
            "guessed" => true,
            "latest" => "3.0.0",
          }
        },
        {
          "formula" => "verified_formula",
          "version" => {
            "guessed" => false,
            "latest" => "2.0.0",
          }
        }
      ]
    end

    before { allow(BrewCommands).to receive(:livecheck).and_return(livecheck_response) }

    it "bumps all verified outdated formulae" do
      expect(OutdatedFormula).to receive(:new).once.and_return(outdated_formula_double)
      expect(outdated_formula_double).to receive(:open_bump_pr)
      
      described_class.bump_all
    end
  end

  describe "#open_bump_pr" do
    it "opens a bump pr for the outdated formula with the correct args" do
      outdated_formula = described_class.new("test_formula", "2.0.0")
      new_url = "https://github.com/test-formula/archive/2.0.0.tar.gz"

      expect(BrewCommands).to receive(:bump_formula_pr).with(formula_name: "test_formula", url: new_url)

      outdated_formula.open_bump_pr
    end
  end
end
