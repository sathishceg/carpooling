class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    begin

    #Password should contain atleast one integer.
    #Password should contain atleast one alphabet(either in downcase or upcase).
    #Password can have special characters from 20 to 7E ascii values.
    #Password should be minimum of 8 and maximum of 40 cahracters long.

    reg = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){4,10}$/
    r = reg.match(value)

    rescue Exception => e   
      r = false
    end
    record.errors[attribute] << (options[:message] || "is invalid. Password  should contain at least one integer, one alphabet, any special chars and it has to be from 4 to 10 chars long!") unless r
  end
end