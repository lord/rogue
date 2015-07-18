CODE = '(+ 1 3 3 (+ 2 (+ 3 1) 3))'

class Context
  def initialize(scope, parent=nil)
    @scope = scope
    @parent = parent
  end

  def get(id)
    # warning: scope could be set to false if we have #f,
    # but nil is returned for undefined
    @scope[id] || (@parent.nil? ? nil : @parent.get(id))
  end
end

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

  def initialize(code)
    code = self.class.parse(code) if code.class == String
    @result = code.map {|n| interpret(n)}
  end

  def interpretList(input, ctx)
    list = input.map do |x|
      interpret(x, ctx)
    end
    if Proc === list[0]
      return list[0].call(*list[1..-1])
    else
      # TODO return error!
    end
  end

  def interpret(input, ctx=nil)
    if !ctx
      interpret input, Context.new({:+ => Proc.new {|*nums| nums.inject(:+)}})
    elsif Array === input
      return interpretList(input, ctx)
    elsif Symbol === input
      return ctx.get(input)
    else
      return input
    end
  end
end

puts Rogue.new(CODE).inspect