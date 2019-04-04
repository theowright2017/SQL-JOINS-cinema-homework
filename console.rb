require_relative( 'models/tickets' )
require_relative( 'models/films' )
require_relative( 'models/customers' )

require( 'pry-byebug' )

film1 = Film.new({  'title' => 'The Hateful Eight',
                       'price' =>   '20'})
film2 = Film.new({  'title' => 'Die Hard',
                      'price' =>   '30'})

film1.save()
film2.save()

customer1 = Customer.new({    'name'  =>  'Tom Jones',
                          'funds' =>  '80'})
customer2 = Customer.new({    'name'  =>  'Daisy Duke',
                               'funds' =>  '90'})
customer1.save()
customer2.save()

ticket1 = Ticket.new({  'customer_id' =>  customer1.id,
                          'film_id'  =>  film1.id})
ticket2 = Ticket.new({  'customer_id' =>  customer2.id,
                        'film_id'  =>  film2.id})
ticket1.save()
ticket2.save()

binding.pry
nil
