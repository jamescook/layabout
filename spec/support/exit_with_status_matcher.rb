RSpec::Matchers.define :exit_with_status do |status|
  match do |actual|
    begin
      actual.call
    rescue SystemExit => e
      case status
      when :success
        e.status == 0
      when :error
        e.status != 0
      else
        raise e
      end
    end
  end

  def supports_block_expectations?
    true
  end
end
