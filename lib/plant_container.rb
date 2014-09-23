require "csv"

class PlantContainer
  def initialize(file)
    @file = file
  end

  def averages
    containers, output = {}, {}

    CSV.foreach(@file, {:col_sep => " "}) do |row|
      container = row[3][-1].to_i
      unless containers.has_key?(container)
        containers[container] = {
          :ph_sum => 0,
          :nsl_sum => 0,
          :temp_sum => 0,
          :water_level_sum => 0,
          :count => 0.0
        }
      end
      containers[container][:ph_sum] += row[4].to_f
      containers[container][:nsl_sum] += row[5].to_i
      containers[container][:temp_sum] += row[6].to_i
      containers[container][:water_level_sum] += row[7].to_f
      containers[container][:count] += 1.0
    end
    (1..containers.keys.length).each do |container|
      output[container] = {
        container: container,
        ph: (containers[container][:ph_sum]/containers[container][:count]).round(2),
        nsl: (containers[container][:nsl_sum]/containers[container][:count]).round(2),
        temp: (containers[container][:temp_sum]/containers[container][:count]).round(2),
        water_level: (containers[container][:water_level_sum]/containers[container][:count]).round(2),
      }
    end
    output
  end

end