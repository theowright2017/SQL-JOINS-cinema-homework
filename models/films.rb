require_relative("../db/sql_runner")
require_relative("customers.rb")
require_relative("tickets.rb")

class Film

attr_reader :id
attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      )
      VALUES
      (
        $1, $2
        )
        RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql,values)[0]
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SQLRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|customer| Customer.new(customer)}
  end

end
