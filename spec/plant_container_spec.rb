require "spec_helper"

describe "Plant Container" do
  it "takes a file path as argument" do
    PlantContainer.new("./data/metrics.tsv")
  end

  it "returns a hash with averages" do
    container = PlantContainer.new("./data/metrics.tsv")
    averages = container.averages(1)
    expected_output = {
      container: 1,
      ph: 5.01,
      nsl: 39.02,
      temp: 57.76,
      water_level: 2.12
    }

    expect(averages).to eq(expected_output)
  end
end