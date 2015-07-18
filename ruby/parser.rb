CODE = '(+ 1 (meow foo bar) (chicken-food blah meow) 3)'

class Rogue
  def self.parse(tokens)
    return parse(tokens.gsub("(", " ( ").gsub(")", " ) ").split(' ')) if tokens.class == String
    list = []
    loop do
      case token = tokens.shift
        when '(' then list.push parse(tokens)
        when ')', nil then (return list)
        when /\d+/ then list.push token.to_i
        else list.push token.to_sym
      end
    end
  end
end

puts Rogue.parse(CODE).inspect