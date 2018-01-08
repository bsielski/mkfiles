require "mkfiles/cli_application"
require "mkfiles/version"

RSpec.describe "Mkfiles::cli_application" do

  context "options with version" do
    it "prints program name and version number" do
      expect { Mkfiles.cli_application({version: true}) }
        .to output("Mkfiles version #{Mkfiles::VERSION}").to_stdout
    end
  end  
  
end
