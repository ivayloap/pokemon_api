module JsonHelper
  def json_payload(file)
    File.read(Pathname.new(__dir__).join('..', 'fixtures').join("#{file}.json"))
  end
end
