require "mkfiles/create_directory"
require "mkfiles/create_file"
require "tmpdir"

RSpec.describe Mkfiles do

  describe "::create_directory" do

    it "creates one entry" do
      Dir.mktmpdir do |dir|
        Mkfiles.create_directory(dir + "/example_d")
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "example_d")
      end
    end

    it "creates a directory" do
      Dir.mktmpdir do |dir|
        abs_directory_path = dir + "/example_d"
        Mkfiles.create_directory(abs_directory_path)
        expect(File.directory?(abs_directory_path)).to be true        
      end
    end

    it "creates an empty directory" do
      Dir.mktmpdir do |dir|
        abs_directory_path = dir + "/example_d"
        Mkfiles.create_directory(abs_directory_path)
        expect(Dir.entries(abs_directory_path)).to contain_exactly(".", "..")
      end
    end

    it "doesn't create a file" do
      Dir.mktmpdir do |dir|
        abs_directory_path = dir + "/example_d"
        Mkfiles.create_directory(abs_directory_path)
        expect(File.file?(abs_directory_path)).to be false        
      end
    end

    it "creates a directory in existed directory" do
      Dir.mktmpdir do |dir|
        abs_directory_path = dir + "/some_dir/example"
        Mkfiles.create_directory(dir + "/some_dir")
        Mkfiles.create_directory(abs_directory_path)
        Mkfiles.create_directory(abs_directory_path + "2")
        expect(Dir.entries(dir + "/some_dir")).to contain_exactly(".", "..", "example", "example2")
      end
    end

    it "creates a directory if it is needed" do
      Dir.mktmpdir do |dir|
        abs_directory_path = dir + "/some_dir/example_d"
        Mkfiles.create_directory(abs_directory_path)
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "some_dir")
      end
    end

    it "works with spaces in directory name" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/some dir/example dir"
        Mkfiles.create_file(abs_file_path)
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "some dir")
      end
    end

    it "works with spaces in subdirectory name" do
      Dir.mktmpdir do |dir|
        abs_file_path = dir + "/some dir/example dir"
        Mkfiles.create_file(abs_file_path)
        expect(Dir.entries(dir + "/some dir")).to contain_exactly(".", "..", "example dir")
      end
    end
    
  end

end
