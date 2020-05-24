RSpec.describe BrewCommands do
  describe "::bump_formula_pr" do
    it "runs brew bump-formula-pr with the correct args" do
      formula_url = "https://github.com/test-formula/archive/2.0.0.tar.gz"
      expected_command_args = [
        "brew",
        "bump-formula-pr",
        "--no-browse",
        "--dry-run", # TODO: switch to a real run once ready
        "--url=#{formula_url}",
        "test_formula"
      ]

      expect(Open3).to receive(:capture2e).with(*expected_command_args)

      described_class.bump_formula_pr(formula_name: "test_formula", url: formula_url)
    end
  end

  describe "::livecheck" do
    it "runs brew livecheck with the correct args" do
      expected_command_args = [
        "brew",
        "livecheck",
        "--all",
        "--quiet",
        "--newer-only",
        "--full-name",
        "--json"
      ]

      expect(Open3).to receive(:capture2e).with(*expected_command_args).and_return("{}")

      described_class.livecheck
    end
  end
end
