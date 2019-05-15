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

  context "with '-h/help' as the only argument or no arguments" do
    let(:results) {
      [
        Mkfiles.parse_options(["-h"]),
        Mkfiles.parse_options(["--help"]),
        Mkfiles.parse_options([]),
      ]
    }
    it "return hash with help key" do
      expect(results.all? { |r| !r[:help].nil? }).to be true
    end
    it "return hash with help key and value that has a string" do
      expect(results.all? { |r| r[:help].is_a?(String) }).to be true
    end
    it "return hash with help key and value that has a manual" do
      expect(results.all? { |r| r[:help].include?("Usage: mkfiles") }).to be true
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

  context "with -v/--version option as arguments" do
    it "returns hash with version key and the true as value" do
      expect(Mkfiles.parse_options ["-v"])
        .to eq({version: true})
      expect(Mkfiles.parse_options ["--version"])
        .to eq({version: true})
    end
  end
  
end
