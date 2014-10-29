module StdoutHelper
  def without_output
    org, $stdout = $stdout, double(:stdout, write: nil)
    yield
  ensure
    $stdout = org
  end
end
