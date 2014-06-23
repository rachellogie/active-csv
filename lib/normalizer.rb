

class Normalizer < ActiveCSV::Base

  def initialize(row)
    @row = row
    normalize_headers
  end

  def normalize_headers
    head = @row.headers.first
    part_way = head.downcase.strip
    new_header = part_way.split(" ").join("_")
    @row << [new_header, @row.field(head)]
    @row.delete(head)
  end
end