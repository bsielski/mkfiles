module Mkfiles

  def self.absolutize_paths(start_directory, rel_paths=[])
    rel_paths = rel_paths.uniq
    start_dir = File.absolute_path start_directory
    if rel_paths.map{|p| p.chomp("/")}.uniq.size != rel_paths.size
      raise ArgumentError.new('file and directory with the same name.')
    end
    abs_paths = []
    rel_paths.each do |path|
      abs_paths << (start_dir + "/" + path)
    end
    return abs_paths
  end
  
end
