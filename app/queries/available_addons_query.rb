class AvailableAddonsQuery

  def self.call
    Addon.joins(:addon_items)
         .where(addon_items: { status: :available })
         .group(:id)
  end
end