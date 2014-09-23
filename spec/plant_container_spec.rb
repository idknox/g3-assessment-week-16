require "spec_helper"

describe "Plant Container" do
  it "takes a file path as argument" do
    PlantContainer.new("./data/metrics.tsv")
  end

  it "returns a hash with averages" do
    container = PlantContainer.new("./data/metrics.tsv")
    averages = container.averages
    expected_output = {
      container: 1,
      ph: 5.01,
      nsl: 39.02,
      temp: 57.76,
      water_level: 2.12
    }

    expect(averages[1]).to eq(expected_output)
  end

  it "returns container with highest avg temp" do
    container = PlantContainer.new("./data/metrics.tsv")
    highest_temp_container = container.highest_temp
    expected_container = 2

    expect(highest_temp_container).to eq(expected_container)
  end
end