require "mkfiles/config"

RSpec.describe Mkfiles::Config do

  describe "::new" do

    context "correct yaml is passed" do

      subject {
        Mkfiles::Config.new(
          {
            "start_place" => ".",
            "sub_paths" => [
              "ads/",
              "ewqrfsd.txt",
              "vdfewre/fwewfevc.tx",
              "qewasdsdf/sdfv/gv/dfvgd/",
              "Nowy Folder/Nowy Folder/new document.txt",
            ]
          }
        )
      }

      it "creates an object that has correct start directory" do
        expect(subject.start_place).to eq "."
      end

      it "creates an object that has correct sub paths" do
        expect(subject.sub_paths)
          .to eq [
                "ads/",
                "ewqrfsd.txt",
                "vdfewre/fwewfevc.tx",
                "qewasdsdf/sdfv/gv/dfvgd/",
                "Nowy Folder/Nowy Folder/new document.txt"
              ]
      end

    end

  end

end
