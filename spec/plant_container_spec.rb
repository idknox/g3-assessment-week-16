require "spec_helper"

describe "Plant Container" do
  it "takes a file path as argument" do
    PlantContainer.new("./data/metrics.tsv")
  end

  it "returns a hash with averages" do
    container = PlantContainer.new("./data/metrics.tsv")
    averages = container.averages
    expected_output = {
      name: "container1",
      avg_ph: 5.01,
      avg_nsl: 39.02,
      avg_temp: 57.76,
      avg_water_level: 2.12
    }

    expect(averages[1]).to eq(expected_output)
  end

  it "returns container with highest avg temp" do
    container = PlantContainer.new("./data/metrics.tsv")
    highest_temp_container = container.highest_avg_temp
    expected_container = "container2"

    expect(highest_temp_container).to eq(expected_container)
  end

  it "returns container with highest absolute water level" do
    container = PlantContainer.new("./data/metrics.tsv")
    highest_temp_container = container.highest_water_level
    expected_container = "container3"

    expect(highest_temp_container).to eq(expected_container)
  end

  it "returns avgs for all containers" do
    container = PlantContainer.new("./data/metrics.tsv")
    averages = container.all_averages
    expected_averages = {
      ph: 5.99,
      nsl: 23.25,
      temp: 66.15,
      water_level: 3.54
    }

    expect(averages).to eq(expected_averages)
  end

  it "returns highest absolute ph for a date range" do
    container = PlantContainer.new("./data/metrics.tsv")
    start_date = Date.parse("2014-01-01")
    end_date = Date.parse("2014-01-01")
    highest_ph_container = container.highest_ph(start_date, end_date)
    expected_container = "container3"

    expect(highest_ph_container).to eq(expected_container)
  end
end