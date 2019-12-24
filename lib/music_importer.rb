class MusicImporter
  attr_reader :path

  def initialize(file_path)
    @path = file_path
  end

  def files
    Dir.children(path)
  end

  def import
    files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
