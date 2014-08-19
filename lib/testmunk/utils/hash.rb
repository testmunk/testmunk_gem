class Hash
  def except(which)
    self.tap{ |h| h.delete(which) }
  end
end