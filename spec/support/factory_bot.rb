FactoryBot::SyntaxRunner.instance_eval do
  def fixture_path
    File.absolute_path('spec/fixtures/files')
  end

  def file_fixture_path
    'spec/fixtures/files'
  end
end