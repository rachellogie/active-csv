require 'rspec'
require 'active_csv/base'
require 'csv'
require_relative '../../lib/normalizer'

describe ActiveCSV::Base do

  it "can be initialized with nothing" do
    active_csv = ActiveCSV::Base.new
    expect(active_csv).to be_kind_of(ActiveCSV::Base)
  end

  describe "attribute readers" do
    it "defines an attribute reader for every column in the csv" do
      row = CSV::Row.new(["name", "age"], ["joe", "24"])

      active_csv = ActiveCSV::Base.new(row)

      expect(active_csv.name).to eq("joe")
      expect(active_csv.age).to eq("24")
    end

    it "responds to missing" do
      row = CSV::Row.new(["name", "age"], ["joe", "24"])

      active_csv = ActiveCSV::Base.new(row)

      actual = active_csv.respond_to?(:name)

      expect(actual).to eq true

      actual = active_csv.respond_to?(:blah)

      expect(actual).to eq false
    end

    it "returns nil if the field name is nil" do
      row = CSV::Row.new(["name", "age"], [nil, "24"])

      active_csv = ActiveCSV::Base.new(row)

      actual = active_csv.name

      expect(actual).to eq nil

      actual = active_csv.respond_to?(:name)

      expect(actual).to eq true
    end

    it "dynamically generates headers into standard ruby names" do
      instance = Normalizer.new(CSV::Row.new(["FIrst   NAme  "], ["Joe"]))

      actual = instance.first_name

      expect(actual).to eq "Joe"
    end
  end




  describe ".file_path" do
    it "allows you to set the file path to the CSV" do
      pending
      klass = Class.new(ActiveCSV::Base) do
        self.file_path = "foo"
      end
      expect(klass.file_path).to eq("foo")
    end
  end

end