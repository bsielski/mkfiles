require 'fileutils'

module Mkfiles

  def self.create_directory(abs_path)

    FileUtils.mkdir_p abs_path

  end

end
