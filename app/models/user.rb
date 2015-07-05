class User

  attr_accessor :id, :email, :first_name, :last_name, :mobile_number
  attr_accessor :password, :confirm_password

  def initialize attributes
    @id = attributes[:id] || ""
    @email = attributes[:email] || ""
    @password = attributes[:password] || ""
    @confirm_password = attributes[:confirm_password] || ""
    if attributes[:info].present?
      @first_name = attributes[:info][:first_name] || ""
      @last_name = attributes[:info][:last_name] || ""
      @mobile_number = attributes[:info][:mobile_number] || ""
    else
      @first_name = attributes[:first_name] || ""
      @last_name = attributes[:last_name] || ""
      @mobile_number = attributes[:mobile_number] || ""
    end
  end

  def self.authenticate(emailid, submitted_password, header_options)
    @api = Api.new
    options = { 
        resource: "sessions",
        :attributes => { 
          session: { email: emailid, password: submitted_password }
        }
    }
    options.merge!(header_options)
    @api.post(options)
  end

  def self.find id, header_options
    @api = Api.new
    options = { resource: "users/#{id}" }
    options.merge!(header_options)
    response = @api.get(options)
    response.present? ? new(response) : nil
  end

  def save header_options
    @api = Api.new
    options = {
        resource: "users",
        :attributes => {
          user: { email: email, password: password },
          user_detail: { 
            first_name: first_name,
            last_name: last_name,
            mobile_number: mobile_number
          }
        }
    }
    options.merge!(header_options)
    @api.post(options)
  end

  def self.destroy id, header_options
    @api = Api.new
    options = { resource: "sessions/#{id}" }
    options.merge!(header_options)
    response = @api.delete(options)
    response.present? ? new(response) : nil
  end

  def valid?
    first_name.present? && last_name.present? && email.present? && password.present? && confirm_password.present?
  end

  def password_valid?
    password == confirm_password
  end

end

