require "mkfiles/create_entries"
require "tmpdir"

RSpec.describe "Mkfiles::create_entries" do

  context "when an empty array is passed" do
    
    it "creates no entries" do
      Dir.mktmpdir do |dir|
        Mkfiles.create_entries([])
        expect(Dir.entries(dir)).to contain_exactly(".", "..")
      end
    end

  end

  it "creates a very deep nested directory" do
    Dir.mktmpdir do |dir|
      directory = dir + "/1/2/3/4/5/6/7/8/9/0/q/w/e/r/t/y/u/i/o/p/a/s/d/f/g/h/j/k/l/z/x/c/v/b/n/m/itsme/"
      Mkfiles.create_entries([directory])
      expect(File.directory?(directory)).to be true
    end
  end

  it "creates a very deep nested file" do
    Dir.mktmpdir do |dir|
      file = dir + "/g/h/j/k/l/z/x/4/3/2/3/4/5/6/7/yh/f/d/f/gh/fd/gs/h/gr/g/g/g/t4/t4/t/3t/c/v/b/n/m/itsme"
      Mkfiles.create_entries([file])
      expect(File.file?(file)).to be true
    end
  end
  
  context "when one file and one directory are passed" do

    it "creates a file" do
      Dir.mktmpdir do |dir|
        file = dir + "/example.txt"
        directory = dir + "/example/"
        Mkfiles.create_entries([file, directory])
        expect(File.file?(file)).to be true
      end
    end

    it "creates a directory" do
      Dir.mktmpdir do |dir|
        file = dir + "/example.txt"
        directory = dir + "/example/"
        Mkfiles.create_entries([file, directory])
        expect(File.directory?(directory)).to be true
      end
    end

    it "creates two entries" do
      Dir.mktmpdir do |dir|
        file = dir + "/example.txt"
        directory = dir + "/example/"
        Mkfiles.create_entries([file, directory])
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "example.txt", "example")
      end
    end

  end


  context "when two deep nested files are passed" do

    it "creates two directories in the last common ancestor" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest_one/nest_two/nest_three_a/example.txt"
        file2 = dir + "/nest_one/nest_two/nest_three_b/example.txt"
        Mkfiles.create_entries([file1, file2])
        expect(Dir.entries(dir + "/nest_one/nest_two")).to contain_exactly(".", "..", "nest_three_a", "nest_three_b")
      end
    end

    it "creates single common first ancestor" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest_one/nest_two/nest_three_a/example.txt"
        file2 = dir + "/nest_one/nest_two/nest_three_b/example.txt"
        Mkfiles.create_entries([file1, file2])
        expect(Dir.entries(dir)).to contain_exactly(".", "..", "nest_one")
      end
    end

    it "creates single common second ancestor" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest_one/nest_two/nest_three_a/example.txt"
        file2 = dir + "/nest_one/nest_two/nest_three_b/example.txt"
        Mkfiles.create_entries([file1, file2])
        expect(Dir.entries(dir + "/nest_one")).to contain_exactly(".", "..", "nest_two")
      end
    end

    it "creates first leaf" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest_one/nest_two/nest_three_a/example.txt"
        file2 = dir + "/nest_one/nest_two/nest_three_b/example.txt"
        Mkfiles.create_entries([file1, file2])
        expect(Dir.entries(dir + "/nest_one/nest_two/nest_three_a/")).to contain_exactly(".", "..", "example.txt")
      end
    end

    it "creates second leaf" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest_one/nest_two/nest_three_a/example.txt"
        file2 = dir + "/nest_one/nest_two/nest_three_b/example.txt"
        Mkfiles.create_entries([file1, file2])
        expect(Dir.entries(dir + "/nest_one/nest_two/nest_three_b/")).to contain_exactly(".", "..", "example.txt")
      end
    end

    it "both leafs are files" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest_one/nest_two/nest_three_a/example.txt"
        file2 = dir + "/nest_one/nest_two/nest_three_b/example.txt"
        Mkfiles.create_entries([file1, file2])
        expect(File.file?(file1) && File.file?(file2)).to be true
      end
    end

  end

  context "when paths have spaces" do
    
    it "creates entries correctly" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/nest one/nest two/example file1.txt"
        dir1 = dir + "/nest one/nest two/nest three_b"
        Mkfiles.create_entries([file1, dir1])
        expect(Dir.entries(dir + "/nest one/nest two")).to contain_exactly(".", "..", "nest three_b", "example file1.txt")
      end
    end
    
  end
  
  context "when paths have spaces and dots" do
    
    it "creates entries correctly" do
      Dir.mktmpdir do |dir|
        file1 = dir + "/.nest one/nest .two/.example file1.txt"
        dir1 = dir + "/.nest one/nest .two/.nest three_b"
        Mkfiles.create_entries([file1, dir1])
        expect(Dir.entries(dir + "/.nest one/nest .two")).to contain_exactly(".", "..", ".nest three_b", ".example file1.txt")
        expect(Dir.entries(dir)).to contain_exactly(".", "..", ".nest one")
      end
    end
    
  end
  
end
