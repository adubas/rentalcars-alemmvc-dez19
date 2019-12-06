class RentalByCategoryAndSubsidiaryQuery
  attr_reader :start_at, :end_at

  def initialize(start_at, end_at)
    @start_at = start_at
    @end_at = end_at
  end

  def call
    sql = %Q(
      SELECT s.name AS subsidiary, c.name AS category, COUNT(*) AS total
      FROM rentals r
      LEFT JOIN subsidiaries s ON r.subsidiary_id = s.id
      LEFT JOIN categories c ON r.category_id = c.id
      WHERE start_date BETWEEN '#{start_at}' and '#{end_at}'
      GROUP BY s.id, c.id
      ORDER BY total DESC;
    )

    ActiveRecord::Base.connection.execute(sql)
  end
end