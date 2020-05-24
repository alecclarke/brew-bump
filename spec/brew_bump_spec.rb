RSpec.describe BrewBump do
  it "bumps all outdated formulae" do
    expect(OutdatedFormula).to receive(:bump_all)

    BrewBump.bump_outdated_fromulae
  end
end
