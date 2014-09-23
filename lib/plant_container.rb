require "csv"

class PlantContainer
  def initialize(file)
    @file = file
  end

  def averages
    containers = totals
    output = {}

    (1..containers.keys.length).each do |container|
      output[container] = {
        name: "container" + container.to_s,
        avg_ph: (containers[container][:ph_sum]/containers[container][:count]).round(2),
        avg_nsl: (containers[container][:nsl_sum]/containers[container][:count]).round(2),
        avg_temp: (containers[container][:temp_sum]/containers[container][:count]).round(2),
        avg_water_level: (containers[container][:water_level_sum]/containers[container][:count]).round(2),
      }
    end
    output
  end

  def highest_avg_temp
    averages.values.sort_by { |container| container[:avg_temp] }.last[:name]
  end

  def highest_water_level
    output = []
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      container = {name: row[3], water_level: row[7]}
      output << container
    end
    output.sort_by {|container| container[:water_level]}.last[:name]
  end

  private

  def empty_container
    {
      ph_sum: 0,
      nsl_sum: 0,
      temp_sum: 0,
      water_level_sum: 0,
      count: 0.0
    }
  end

  def totals
    containers = {}
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      container = row[3][-1].to_i
      containers[container] = empty_container unless containers.has_key?(container)

      # container[container][:name] = row[3]
      containers[container][:ph_sum] += row[4].to_f
      containers[container][:nsl_sum] += row[5].to_i
      containers[container][:temp_sum] += row[6].to_i
      containers[container][:water_level_sum] += row[7].to_f
      containers[container][:count] += 1.0
    end
    containers
  end
end