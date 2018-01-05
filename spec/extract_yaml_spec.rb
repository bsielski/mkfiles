require "mkfiles/extract_yaml"
require "tmpdir"

RSpec.describe Mkfiles do

  describe "::extract_yaml" do

    context "the correct file exists" do

      let (:yaml_file_content) do
        %q{
start_place: "."

sub_paths:
  - ads/
  - ewqrfsd.txt
  - vdfewre/fwewfevc.tx
  - qewasdsdf/sdfv/gv/dfvgd/
  - Nowy Folder/Nowy Folder/new document.txt
}
      end

      it "returns config object with subpaths" do
        Dir.mktmpdir do |dir|
          filename = dir + "/my_paths.yaml"
          open(filename, "w") do |file|
            file.write(yaml_file_content)
          end
          conf_object = Mkfiles.extract_yaml(filename)
          expect(conf_object.sub_paths)
            .to contain_exactly(
                  "ads/",
                  "ewqrfsd.txt",
                  "vdfewre/fwewfevc.tx",
                  "qewasdsdf/sdfv/gv/dfvgd/",
                  "Nowy Folder/Nowy Folder/new document.txt"
                )
        end
      end
      
      it "returns config object with start_place" do
        Dir.mktmpdir do |dir|
          filename = dir + "/my_paths.yaml"
          open(filename, "w") do |file|
            file.write(yaml_file_content)
          end
          conf_object = Mkfiles.extract_yaml(filename)
          expect(conf_object.start_place)
            .to eq "."
        end
      end
      
    end

    context "the file doesn't exists" do

      let (:yaml_file_content) do
        %q{
start_place: "."

sub_paths:
  - ads/
  - ewqrfsd.txt
  - vdfewre/fwewfevc.tx
  - qewasdsdf/sdfv/gv/dfvgd/
  - Nowy Folder/Nowy Folder/new document.txt
}
      end

      it "it raise an error" do
        Dir.mktmpdir do |dir|
          filename = dir + "/my_paths.yaml"
          open(filename, "w") do |file|
            file.write(yaml_file_content)
          end

          expect {
            Mkfiles.extract_yaml("not_existing_yaml_file.yaml")
          }.to raise_error(Errno::ENOENT)
        end
      end
      
    end
    
  end
  
end
