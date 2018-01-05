require "mkfiles/generate_from_file"
require "tmpdir"

RSpec.describe Mkfiles do

  describe "::generate_from_file" do

    context "correct yaml is passed" do
      
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
      
      it "creates entries" do
        Dir.mktmpdir do |dir|
          Dir.chdir(dir) do
            filename = dir + "/mypaths.yaml"
            open(filename, "w") do |file|
              file.write(yaml_file_content)
            end
            Mkfiles.generate_from_file(filename)
            expect(Dir.entries(dir))
              .to contain_exactly(".", "..", "ads", "ewqrfsd.txt",
                                  "vdfewre", "qewasdsdf", "Nowy Folder", "mypaths.yaml")
            expect(Dir.entries(dir + "/ads"))
              .to contain_exactly(".", "..")
            expect(Dir.entries(dir + "/vdfewre"))
              .to contain_exactly(".", "..", "fwewfevc.tx")
            expect(Dir.entries(dir + "/qewasdsdf"))
              .to contain_exactly(".", "..", "sdfv")
            expect(Dir.entries(dir + "/qewasdsdf/sdfv"))
              .to contain_exactly(".", "..", "gv")
          end
        end
      end
      
    end

  end
  
end
