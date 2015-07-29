CODE = '(* (- 5 6) (- (+ 1 1 1 1) 4 1))'

class Rogue
  def self.parse(tokens)
    tokens = tokens.scan /[()]|".*?"|[^\s()]+/ if tokens.is_a? String
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
    code = self.class.parse(code) if code.is_a? String
    @env = {
      :+ => lambda {|nums, _| nums.inject :+},
      :- => lambda {|nums, _| nums.inject :-},
      :* => lambda {|nums, _| nums.inject :*},
      :/ => lambda {|nums, _| nums.inject :/}
    }
    @result = code.map {|n| eval(n)}
  end

  def eval list, ctx=@env
    return list unless list.is_a?(Array) && list.length > 0
    func = eval list[0]
    return ctx[func].call(list[1..-1].map {|i| eval i},ctx) if ctx[func].is_a? Proc
    puts "error, function not found!"
    []
  end
end

puts Rogue.new(CODE).inspect