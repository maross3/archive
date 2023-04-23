# frozen_string_literal: true

class CircularQueue

  def enqueue(value)
    @tail = self.advance(@head) if @queue[@head] != nil
    @queue[@head] = value
    @head = self.advance(@head)
  end

  def dequeue
    element = @queue[@tail]
    @queue[@tail] = nil
    @tail = self.advance(@tail) if element != nil
    element
  end

  def initialize(size)
    @size = size
    @queue = Array.new(size)
    @head = 0
    @tail = 0
  end

  private

  attr_accessor :queue, :size, :head, :tail

  def advance(index)
    (index + 1) % @size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)

puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

p "new queue"
p "----------"
queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

p queue
queue.enqueue(5)
p queue
queue.enqueue(6)
p queue
queue.enqueue(7)
p queue
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil