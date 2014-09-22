class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    begin

    reg = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){4,10}$/
    r = reg.match(value)

    rescue Exception => e   
      r = false
    end
    record.errors[attribute] << (options[:message] || "is invalid. Password  should contain at least one integer, one alphabet, any special chars and it has to be from 4 to 10 chars long!") unless r
  end
end