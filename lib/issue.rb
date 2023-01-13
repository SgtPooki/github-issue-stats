
class Issue
  def initialize(hash)
    @hash = hash
  end

  def created_at
    @created_at ||= Time.parse(@hash['createdAt'])
  end

  def closed_at
    @closed_at ||= @hash['closedAt'].nil? ? nil : Time.parse(@hash['closedAt'])
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
