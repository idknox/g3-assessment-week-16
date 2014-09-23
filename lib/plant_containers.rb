require "csv"

class PlantContainers
  def initialize(file)
    @file = file
  end

  def averages
    output = {}
    (1..container_totals.keys.length).each { |container| output[container] = build_container(container_totals, container) }
    output
  end

  def highest_avg_temp
    averages.values.sort_by { |container| container[:avg_temp] }.last[:name]
  end

  def all_averages
    totals, count = {phs: [], nsls: [], temps: [], water_levels: []}, 0
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      totals[:phs] << row[4].to_f
      totals[:nsls] << row[5].to_i
      totals[:temps] << row[6].to_i
      totals[:water_levels] << row[7].to_f
      count += 1.0
    end
    build_total_averages(totals, count)
  end

  def highest_water_level
    output = []
    CSV.foreach(@file, {:col_sep => " "}) { |row| output << {name: row[3], water_level: row[7]} }
    output.sort_by { |container| container[:water_level] }.last[:name]
  end

  def highest_ph(start_date, end_date)
    output = []
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      date = Date.parse(row[0])
      output << {name: row[3], ph: row[7]} if date >= start_date && date <= end_date
    end
    output.sort_by { |container| container[:ph] }.last[:name]
  end

  private
  def container_totals
    containers = {}
    CSV.foreach(@file, {:col_sep => " "}) do |row|
      container = row[3][-1].to_i
      containers[container] = empty_container unless containers.has_key?(container)

      containers[container][:phs] << row[4].to_f
      containers[container][:nsls] << row[5].to_i
      containers[container][:temps] << row[6].to_i
      containers[container][:water_levels] << row[7].to_f
      containers[container][:count] += 1
    end
    containers
  end

  def build_container(containers, container)
    {
      name: "container" + container.to_s,
      avg_ph: (sum(containers[container][:phs]) / containers[container][:count]).round(2),
      avg_nsl: (sum(containers[container][:nsls]) / containers[container][:count]).round(2),
      avg_temp: (sum(containers[container][:temps]) / containers[container][:count]).round(2),
      avg_water_level: (sum(containers[container][:water_levels]) / containers[container][:count]).round(2),
    }
  end

  def sum(array)
    array.inject { |sum, x| sum + x }
  end

  def empty_container
    {
      phs: [],
      nsls: [],
      temps: [],
      water_levels: [],
      count: 0.0
    }
  end

  def build_total_averages(totals, count)
    {
      ph: (sum(totals[:phs])/count).round(2),
      nsl: (sum(totals[:nsls])/count).round(2),
      temp: (sum(totals[:temps])/count).round(2),
      water_level: (sum(totals[:water_levels])/count).round(2)
    }
  end
end