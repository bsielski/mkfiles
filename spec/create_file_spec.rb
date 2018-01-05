require "mkfiles/create_file"
require "tmpdir"

RSpec.describe Mkfiles do

  describe "::create_file" do

    it "creates one entry" do
      Dir.mktmpdir do |dir|
        Mkfiles.create_file(dir + "/example.txt")
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "example.txt")
      end
    end

    it "creates a file" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/example.txt"
        Mkfiles.create_file(abs_file_path)
        expect(File.file?(abs_file_path)).to be true        
      end
    end

    it "doesn't create a directory" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/example.txt"
        Mkfiles.create_file(abs_file_path)
        expect(File.directory?(abs_file_path)).to be false        
      end
    end
    
    it "creates a file in existed directory" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/some_dir/example.txt"
        Mkfiles.create_directory(dir + "/some_dir")
        Mkfiles.create_file(abs_file_path)
        Mkfiles.create_file(abs_file_path + "2")
        expect(Dir.entries(dir + "/some_dir")).to contain_exactly(".", "..", "example.txt", "example.txt2")
      end
    end

    it "creates a directory if it is needed" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/some_dir/example.txt"
        Mkfiles.create_file(abs_file_path)
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "some_dir")
      end
    end

    it "works with spaces in directory name" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/some dir/example file.txt"
        Mkfiles.create_file(abs_file_path)
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "some dir")
      end
    end

    it "works with spaces in file name" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/some dir/example file.txt"
        Mkfiles.create_file(abs_file_path)
        expect(Dir.entries(dir + "/some dir")).to contain_exactly(".", "..", "example file.txt")
      end
    end

  end

end
