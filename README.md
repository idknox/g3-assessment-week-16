# Hydroponics Tracker

## Background

You want to automate your indoor garden setup.  Being a crafty, nerdy type of person, 
you hooked up sensors to your plant containers, and you track metrics such as:

* container name
* pH levels
* Nutrient solution levels
* Temperature
* Water levels

Each container's data are written out to tab-delimited log files, in this format:

```
<timestamp>	<container name>	<pH>	<nutrient solution level>	<temperature>	<water level>
```

## Stories

Your mission is to be able to be able to tell what the average pH, nutrient solution level,
temperature and water levels were for each plant container.

Your program must, at a minimum:

* take a file path as an argument
* return a hash that has the
average ph, average nutrient solution level, average temperature and average water level for _each_ container
mentioned in the file


## Check your work

The correct answers are:

**container1**

pH   | nutrient solution level | temperature | water level
---- | ----------------------- | ----------- | -----------
5.01 | 39.02                   | 57.76       | 2.12

**container2**

pH   | nutrient solution level | temperature | water level
---- | ----------------------- | ----------- | -----------
5.95 | 19.77                   | 73.06       | 3.8

**container3**

pH   | nutrient solution level | temperature | water level
---- | ----------------------- | ----------- | -----------
7.01 | 10.97                   | 67.61       | 4.7

## References

* [:col_sep option for CSV](http://ruby-doc.org/stdlib-2.1.1/libdoc/csv/rdoc/CSV.html)
* [File.expand_path](http://www.ruby-doc.org/core-2.1.2/File.html#method-c-expand_path)
