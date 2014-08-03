class CronRunner
  def self.update_lottery_number
    email_exception_if_raised(:update_lottery_number) do
      LotteryNumbersUpdater.update_all
    end
  end

  # Note: it will catch all the standard error except background jobs,
  #       and the background error will be captured by other handler
  #
  def self.email_exception_if_raised(caller, &block)
    begin
      yield
    rescue StandardError => e
      DevMailer.send_error("#{self.name}##{caller}", e.backtrace, e.message, e.class.name).deliver
    end
  end
end