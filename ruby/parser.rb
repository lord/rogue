CODE = '(+ 1 (-
  "blah  ( meow meow"   3))   (+ 1 (-
  "blah     meow meow"    3))'

class Rogue
  def initialize(code)
    puts tokenize(code).join(" ")
    puts parse(tokenize(code)).inspect
  end

  private def tokenize(code)
    code
      .split('"').map.with_index {|str, i| i%2==0 ? str : str.gsub(' ', '\s').gsub('(', '\o').gsub(')', '\c')}.join('"')
      .gsub("(", " ( ")
      .gsub(")", " ) ")
      .split(' ')
  end

  private def parse_atom(atom_string)
    if atom_string.to_i.to_s == atom_string
      atom_string.to_i
    else
      atom_string
    end
  end

  private def parse(tokens)
    stack = [[]] # this and the last line of `parse` are to create a virtual root
    tokens.each do |token|
      return nil if stack.length <= 1 && token == ")"
      case token
        when "(" then stack.push []
        when ")" then stack[-2].push(stack.pop)
        else stack[-1].push parse_atom(token)
      end
    end
    return nil if stack.length != 1
    stack.first
  end
end

Rogue.new CODE