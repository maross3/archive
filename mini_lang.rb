# frozen_string_literal: true

class MiniLang

  def initialize(program)
    @head = 0
    @program = program
    @stack = []
    @register = 0
  end

  def eval
    @program.split.each do |command|
      case command
      when 'PUSH' then push
      when 'ADD' then add
      when 'SUB' then lang_sub
      when 'MULT' then mult
      when 'DIV' then div
      when 'MOD' then mod
      when 'POP' then pop
      when 'PRINT' then lang_print
      else
        @register = command.to_i
        if command.to_s != @register.to_s
          puts "Invalid token: #{command}"
          break
        end
      end
    end
  end

  private

  def add
    @stack[@head - 1] += @register
    self.pop
  end

  def div
    @stack[@head - 1] = @register / @stack[@head - 1]
    self.pop
  end

  def mod
    @stack[@head - 1] = @register % @stack[@head - 1]
    self.pop
  end

  def mult
    @stack[@head - 1] *= @register
    self.pop
  end

  def push
    @stack[@head] = @register
    @head += 1
  end

  def pop
    @head -= 1
    @register = @stack[@head]
    @stack[@head] = nil
  end

  def lang_print
    puts @register if @register != nil
    puts 'Empty stack!' if @register == nil
  end

  def lang_sub
    @stack[@head - 1] = @register - @stack[@head - 1]
    self.pop
  end

  attr_accessor :stack, :register, :head

end
MiniLang.new('PRINT').eval
# 0

MiniLang.new('5 PUSH 3 MULT PRINT').eval
# 15

MiniLang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

MiniLang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

MiniLang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

MiniLang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

MiniLang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

MiniLang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

MiniLang.new('-3 PUSH 5 SUB PRINT').eval
# 8

MiniLang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)