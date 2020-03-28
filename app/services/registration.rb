class Registration

  def self.register params
    person = Person.new(mapped_params(params)[:person])
    person.identity = Identity.new(mapped_params(params)[:identity])

    if person.valid? &&  person.identity.valid?
      person.save
    else
      person.errors.merge! person.identity.errors
    end
    person
  end

  def self.mapped_params params
    {
      identity: {
        email: params[:email], 
        password: params[:password],
      },
      person: {
        first_name: params[:firstName],
        last_name: params[:lastName]
      }
    }
  end

end
