require "csv"

class PlantContainers
  def initialize(file)
    @file = file
  end

  def averages
    containers = container_totals
    output = {}
    (1..containers.keys.length).each { |container| output[container] = build_container(containers, container) }
    output
  end

  def highest_avg_temp
    averages.values.sort_by { |container| container[:avg_temp] }.last[:name]
  end

  def all_averages
    ph, nsl, temp, water_level, count = 0, 0, 0, 0, 0
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      ph += row[4].to_f
      nsl += row[5].to_i
      temp += row[6].to_i
      water_level += row[7].to_f
      count += 1.0
    end
    {
      ph: (ph/count).round(2),
      nsl: (nsl/count).round(2),
      temp: (temp/count).round(2),
      water_level: (water_level/count).round(2)
    }
  end

  def highest_water_level
    output = []
    CSV.foreach(@file, {:col_sep => " "}) { |row| output << {name: row[3], water_level: row[7]} }
    output.sort_by { |container| container[:water_level] }.last[:name]
  end

  def highest_ph(start_date, end_date)
    output = []
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      date= Date.parse(row[0])
      output << {name: row[3], ph: row[7]} if date >= start_date && date <= end_date
    end
    output.sort_by { |container| container[:ph] }.last[:name]
  end

  private

  def build_container(containers, container)
    {
      name: "container" + container.to_s,
      avg_ph: (containers[container][:ph_sum]/containers[container][:count]).round(2),
      avg_nsl: (containers[container][:nsl_sum]/containers[container][:count]).round(2),
      avg_temp: (containers[container][:temp_sum]/containers[container][:count]).round(2),
      avg_water_level: (containers[container][:water_level_sum]/containers[container][:count]).round(2),
    }
  end

  def empty_container
    {
      ph_sum: 0,
      nsl_sum: 0,
      temp_sum: 0,
      water_level_sum: 0,
      count: 0.0
    }
  end

  def container_totals
    containers = {}
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      container = row[3][-1].to_i
      containers[container] = empty_container unless containers.has_key?(container)

      containers[container][:ph_sum] += row[4].to_f
      containers[container][:nsl_sum] += row[5].to_i
      containers[container][:temp_sum] += row[6].to_i
      containers[container][:water_level_sum] += row[7].to_f
      containers[container][:count] += 1
    end
    containers
  end
end