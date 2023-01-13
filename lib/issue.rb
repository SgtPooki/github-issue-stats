
class Issue
  def initialize(hash)
    @hash = hash
  end

  def created_at
    @created_at ||= Time.parse(@hash['created_at'])
  end

  def closed_at
    @closed_at ||= @hash['closed_at'].nil? ? nil : Time.parse(@hash['closed_at'])
  end

  def updated_at
    @updated_at ||= @hash['updated_at'].nil? ? nil : Time.parse(@hash['updated_at'])
  end

  def number
    @hash['number']
  end

  def lead_time
    @closed_at ? closed_at - created_at : nil
  end

  def status(timestamp)
    return :unborn if timestamp < created_at
    return :closed if closed_at && (closed_at < timestamp)
    return :open
  end
end
