CODE = '(+ 1 (meow foo bar) (chicken-food blah meow) 3)'

class Rogue
  def initialize(code)
    @tokens = code.gsub("(", " ( ").gsub(")", " ) ").split(' ')
    puts @tokens
    puts parse.inspect
  end

  private def parse
    list = []
    loop do
      case token = @tokens.shift
        when '(' then list.push parse
        when ')', nil then (return list)
        when /\d+/ then list.push token.to_i
        else list.push token.to_sym
      end
    end
  end
end

Rogue.new CODE