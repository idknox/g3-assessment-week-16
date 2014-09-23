require "spec_helper"

describe "Plant Container" do
  it "takes a file path as argument" do
    PlantContainer.new("./data/metrics.tsv")
  end
end