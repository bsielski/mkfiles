require "mkfiles/parse_options"

RSpec.describe "Mkfiles::parse_options" do

    
    
  context "without any arguments" do
    it "raise an ArgumentError" do
      expect { Mkfiles.parse_options }
        .to raise_error(
              ArgumentError,
              "wrong number of arguments (given 0, expected 1)"
            )
    end
  end
  
  context "with just a file name as an argument" do
    it "returns hash with the file name" do
      expect(Mkfiles.parse_options ["test.yml"])
        .to eq({files: ["test.yml"]})
    end
  end

  context "with '-h' as the only argument" do
    it "return hash with help option as true" do
      expect(Mkfiles.parse_options ["-h"]).to eq({help: true})
    end
  end
  
  context "with '--help' as the only argument" do
    it "return hash with help option as true" do
      expect(Mkfiles.parse_options ["--help"]).to eq({help: true})
    end
  end

  context "with an empty array as an argument" do
    it "return hash with help option as true" do
      expect(Mkfiles.parse_options []) .to eq({help: true})
    end
  end

  context "with -g/--generate option and file name as arguments" do
    it "returns hash with generate_yaml key and the file name value" do
      expect(Mkfiles.parse_options ["-g", "test.yaml"])
        .to eq({generate_yaml: "test.yaml"})
      expect(Mkfiles.parse_options ["--generate", "test.yaml"])
        .to eq({generate_yaml: "test.yaml"})
    end
  end

  
end
