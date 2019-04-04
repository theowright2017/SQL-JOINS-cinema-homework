require_relative("../db/sql_runner")
require_relative("films.rb")
require_relative("tickets.rb")

class Customer

attr_reader :id
attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
      )
      VALUES
      (
        $1, $2
        )
        RETURNING id"
    values = [@name, @funds]
    star = SqlRunner.run(sql,values)[0]
    @id = star['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SQLRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|film| Film.new(film)}
  end

end
