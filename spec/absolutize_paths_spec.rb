require "mkfiles/absolutize_paths"
require "tmpdir"

RSpec.describe "Mkfiles::absolutize_paths" do

  let (:absolute_start_path) { File.expand_path('~') + "/Documents/Example" }
  
  context "no arguments are passed" do
    it "raise an ArgumentError" do
      expect { Mkfiles.absolutize_paths() }.to raise_error(ArgumentError, "wrong number of arguments (given 0, expected 1..2)")
    end
  end

  context "no paths are passed" do
    it "returns empty array" do
      expect(Mkfiles.absolutize_paths(absolute_start_path)).to eq []
    end
  end

  context "one path is passed" do
    
    it "returns an array with one absolute path for file" do
      start_dir = absolute_start_path
      rel_paths = ["projects/Ruby/test.rb"]
      expected = [absolute_start_path + "/projects/Ruby/test.rb"]
      expect(Mkfiles.absolutize_paths(absolute_start_path, rel_paths)).to eq expected
    end

    it "returns an array with one absolute path for directory" do
      start_dir = absolute_start_path
      rel_paths = ["projects/Ruby/lib/"]
      expected = [absolute_start_path + "/projects/Ruby/lib/"]
      expect(Mkfiles.absolutize_paths(absolute_start_path, rel_paths)).to eq expected
    end

  end

  context "multiple path is passed" do
    
    let (:absolute_start_path) { File.expand_path('~') + "/Documents" }

    it "returns an array with correct absolute path for file" do
      start_dir = absolute_start_path
      rel_paths = [
        "projects/JS/script.js",
        "projects/",
        "projects/Ruby/test.rb",
        "projects/Ruby/",
        "projects/Ruby/Gemfile",
      ]
      expected = [
        absolute_start_path + "/projects/",
        absolute_start_path + "/projects/Ruby/",
        absolute_start_path + "/projects/Ruby/test.rb",
        absolute_start_path + "/projects/Ruby/Gemfile",
        absolute_start_path + "/projects/JS/script.js",
      ]
      expect(Mkfiles.absolutize_paths(absolute_start_path, rel_paths)).to contain_exactly(*expected)
    end

  end

  context "two same paths to files are passed" do

    let (:absolute_start_path) { File.expand_path('~') + "/Example_for_duplicates" }

    it "returns pathes with removed duplicated pathes" do
      rel_paths = [
        "projects/Ruby/test.rb",
        "projects/Ruby/test.rb",
      ]
      expected = [absolute_start_path + "/projects/Ruby/test.rb"]
      expect(Mkfiles.absolutize_paths(absolute_start_path, rel_paths)).to contain_exactly(*expected)
    end
  end

  context "two same paths to directories are passed" do

    let (:absolute_start_path) { File.expand_path('~') + "/Example_for_duplicates" }

    it "returns pathes with removed duplicated pathes" do
      rel_paths = [
        "projects/Ruby/specs/",
        "projects/Ruby/specs/",
      ]
      expected = [absolute_start_path + "/projects/Ruby/specs/"]
      expect(Mkfiles.absolutize_paths(absolute_start_path, rel_paths)).to contain_exactly(*expected)
    end
  end

  context "start directory is relative" do
    
    it "does the job anyway" do
      start_dir = "."
      rel_paths = [
        "projects/Ruby/specs/",
        "projects/Ruby/lib/",
      ]
      Dir.mktmpdir do |dir|
        Dir.chdir dir do
          expected = [Dir.pwd + "/" + "projects/Ruby/specs/", Dir.pwd + "/" + "projects/Ruby/lib/"]
          expect(Mkfiles.absolutize_paths(start_dir, rel_paths)).to contain_exactly(*expected)
        end
      end
    end

  end
  
  context "file and directory with same name" do
    
    let (:absolute_start_path) { File.expand_path('~') + "/Example_for_duplicates" }

    it "raise an ArgumentError" do
      rel_paths = [
        "projects/Ruby/config",
        "projects/Ruby/config/",
      ]
      expect { Mkfiles.absolutize_paths(absolute_start_path, rel_paths) }.to raise_error(ArgumentError, "file and directory with the same name.")
    end
  end
  
end
